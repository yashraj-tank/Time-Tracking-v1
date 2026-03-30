package com.grownited.controller;

import com.grownited.entity.TaskEntity;
import com.grownited.entity.TaskUserEntity;
import com.grownited.entity.UserEntity;
import com.grownited.repository.ModuleRepository;
import com.grownited.repository.ProjectRepository;
import com.grownited.repository.TaskRepository;
import com.grownited.repository.TaskUserRepository;
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
import java.util.Optional;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/manager/tasks")
public class ManagerTaskController {

    @Autowired
    private TaskUserRepository taskUserRepository;

    @Autowired
    private TaskRepository taskRepository;

    @Autowired
    private ModuleRepository moduleRepository;

    @Autowired
    private ProjectRepository projectRepository;

    @GetMapping
    public String listMyAssignedTasks(HttpSession session, Model model) {
        UserEntity loggedInUser = (UserEntity) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        // 1. Get all task assignments for this manager (user)
        List<TaskUserEntity> assignments = taskUserRepository.findByUserId(loggedInUser.getUserId());
        List<Integer> taskIds = assignments.stream()
                .map(TaskUserEntity::getTaskId)
                .collect(Collectors.toList());

        if (taskIds.isEmpty()) {
            model.addAttribute("tasksByStatus", new HashMap<>());
            model.addAttribute("pageTitle", "My Tasks");
            return "manager/tasks";
        }

        // 2. Fetch the actual tasks
        List<TaskEntity> tasks = taskRepository.findAllById(taskIds);

        // 3. Enrich with module and project names
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

            enrichedTasks.add(map);
        }

        // 4. Group by task status
        Map<Integer, List<Map<String, Object>>> tasksByStatus = enrichedTasks.stream()
                .collect(Collectors.groupingBy(item -> ((TaskEntity) item.get("task")).getStatus()));

        model.addAttribute("tasksByStatus", tasksByStatus);
        model.addAttribute("pageTitle", "My Tasks");
        return "manager/tasks";
    }
}