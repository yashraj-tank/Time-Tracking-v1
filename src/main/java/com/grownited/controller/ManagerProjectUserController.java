package com.grownited.controller;

import com.grownited.entity.*;
import com.grownited.repository.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/manager/project-users")  // URL remains same for simplicity, but content changes
public class ManagerProjectUserController {

    @Autowired
    private ProjectUserRepository projectUserRepository;

    @Autowired
    private TaskRepository taskRepository;

    @Autowired
    private ModuleRepository moduleRepository;

    @Autowired
    private ProjectRepository projectRepository;

    @GetMapping
    public String listInProgressTasks(HttpSession session, Model model) {
        UserEntity loggedInUser = (UserEntity) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        // 1. Get all projects assigned to this manager
        List<ProjectUserEntity> managerAssignments = projectUserRepository.findByUserId(loggedInUser.getUserId());
        List<Integer> projectIds = managerAssignments.stream()
                .map(ProjectUserEntity::getProjectId)
                .collect(Collectors.toList());

        if (projectIds.isEmpty()) {
            model.addAttribute("tasks", new ArrayList<>());
            model.addAttribute("pageTitle", "In Progress Tasks");
            return "manager/in-progress-tasks"; // new JSP name
        }

        // 2. Fetch tasks from those projects that have status = 2 (In Progress)
        List<TaskEntity> allTasks = taskRepository.findByProjectIdIn(projectIds);
        List<TaskEntity> inProgressTasks = allTasks.stream()
                .filter(task -> task.getStatus() != null && task.getStatus() == 2)
                .collect(Collectors.toList());

        // 3. Enrich tasks with module and project names
        List<Map<String, Object>> enrichedTasks = new ArrayList<>();
        for (TaskEntity task : inProgressTasks) {
            Map<String, Object> map = new HashMap<>();
            map.put("task", task);
            String moduleName = moduleRepository.findById(task.getModuleId())
                    .map(ModuleEntity::getModuleName).orElse("Unknown");
            map.put("moduleName", moduleName);
            String projectTitle = projectRepository.findById(task.getProjectId())
                    .map(ProjectEntity::getTitle).orElse("Unknown");
            map.put("projectTitle", projectTitle);
            enrichedTasks.add(map);
        }

        model.addAttribute("tasks", enrichedTasks);
        model.addAttribute("pageTitle", "In Progress Tasks");
        return "manager/in-progress-tasks"; // new JSP
    }
}