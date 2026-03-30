package com.grownited.controller;

import com.grownited.entity.TaskEntity;
import com.grownited.entity.TaskUserEntity;
import com.grownited.entity.UserEntity;
import com.grownited.repository.ModuleRepository;
import com.grownited.repository.ProjectRepository;
import com.grownited.repository.TaskRepository;
import com.grownited.repository.TaskUserRepository;
import com.grownited.repository.TimeEntryRepository; // <-- added import
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/developer/tasks")
public class DeveloperTaskController {

    @Autowired
    private TaskUserRepository taskUserRepository;

    @Autowired
    private TaskRepository taskRepository;

    @Autowired
    private ModuleRepository moduleRepository;

    @Autowired
    private ProjectRepository projectRepository;

    @Autowired
    private TimeEntryRepository timeEntryRepository; // <-- added

    @GetMapping
    public String listMyTasks(HttpSession session, Model model) {
        UserEntity loggedInUser = (UserEntity) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        // 1. Get all task assignments for this developer
        List<TaskUserEntity> assignments = taskUserRepository.findByUserId(loggedInUser.getUserId());
        List<Integer> taskIds = assignments.stream()
                .map(TaskUserEntity::getTaskId)
                .collect(Collectors.toList());

        if (taskIds.isEmpty()) {
            model.addAttribute("tasksByStatus", new HashMap<>());
            model.addAttribute("pageTitle", "My Tasks");
            return "developer/tasks";
        }
        
        // 2. Fetch the actual tasks
        List<TaskEntity> tasks = taskRepository.findAllById(taskIds);

        // 3. Enrich with module/project names and verification flag
        List<Map<String, Object>> enrichedTasks = new ArrayList<>();
        for (TaskEntity task : tasks) {
            Map<String, Object> map = new HashMap<>();
            map.put("task", task);

            String moduleName = moduleRepository.findById(task.getModuleId())
                    .map(m -> m.getModuleName()).orElse("Unknown");
            map.put("moduleName", moduleName);

            String projectTitle = projectRepository.findById(task.getProjectId())
                    .map(p -> p.getTitle()).orElse("Unknown");
            map.put("projectTitle", projectTitle);

            // Check if this task has any unverified time entries
            boolean hasUnverified = timeEntryRepository.existsByTaskIdAndVerifiedFalse(task.getTaskId());
            map.put("hasUnverified", hasUnverified);

            enrichedTasks.add(map);
        }

        // 4. Group by task status
        Map<Integer, List<Map<String, Object>>> tasksByStatus = enrichedTasks.stream()
                .collect(Collectors.groupingBy(item -> ((TaskEntity) item.get("task")).getStatus()));

        model.addAttribute("tasksByStatus", tasksByStatus);
        model.addAttribute("pageTitle", "My Tasks");
        return "developer/tasks";
    }
}