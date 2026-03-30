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
@RequestMapping("/developer")
public class DeveloperDashboardController {

    @Autowired
    private TaskUserRepository taskUserRepository;

    @Autowired
    private TaskRepository taskRepository;

    @Autowired
    private ModuleRepository moduleRepository;

    @Autowired
    private ProjectRepository projectRepository;

    @Autowired
    private ProjectUserRepository projectUserRepository;

    @Autowired
    private UserRepository userRepository;

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        UserEntity loggedInUser = (UserEntity) session.getAttribute("loggedInUser");
        if (loggedInUser == null) return "redirect:/login";

        // 1. Get tasks assigned to this developer
        List<TaskUserEntity> taskAssignments = taskUserRepository.findByUserId(loggedInUser.getUserId());
        List<Integer> taskIds = taskAssignments.stream()
                .map(TaskUserEntity::getTaskId)
                .collect(Collectors.toList());

        // Map: Manager -> List of enriched task maps
        Map<UserEntity, List<Map<String, Object>>> tasksByManager = new LinkedHashMap<>();

        if (!taskIds.isEmpty()) {
            List<TaskEntity> tasks = taskRepository.findAllById(taskIds);
            for (TaskEntity task : tasks) {
                // Enrich task with module and project names
                Map<String, Object> taskMap = new HashMap<>();
                taskMap.put("task", task);
                String moduleName = moduleRepository.findById(task.getModuleId())
                        .map(ModuleEntity::getModuleName).orElse("Unknown");
                taskMap.put("moduleName", moduleName);
                String projectTitle = projectRepository.findById(task.getProjectId())
                        .map(ProjectEntity::getTitle).orElse("Unknown");
                taskMap.put("projectTitle", projectTitle);

                // Get managers for this task's project
                List<UserEntity> managers = getManagersForProject(task.getProjectId());
                if (managers.isEmpty()) {
                    // Tasks with no manager go under a "null" key
                    tasksByManager.computeIfAbsent(null, k -> new ArrayList<>()).add(taskMap);
                } else {
                    for (UserEntity manager : managers) {
                        tasksByManager.computeIfAbsent(manager, k -> new ArrayList<>()).add(taskMap);
                    }
                }
            }
        }

        // 2. Get all managers of projects the developer is part of (for the "Your Managers" section)
        List<ProjectUserEntity> devProjectAssignments = projectUserRepository.findByUserId(loggedInUser.getUserId());
        List<Integer> projectIds = devProjectAssignments.stream()
                .map(ProjectUserEntity::getProjectId)
                .collect(Collectors.toList());
        Set<UserEntity> allManagers = new HashSet<>();
        for (Integer pid : projectIds) {
            allManagers.addAll(getManagersForProject(pid));
        }

        // 3. Prepare status map
        Map<Integer, String> statusMap = new HashMap<>();
        statusMap.put(1, "Not Started");
        statusMap.put(2, "In Progress");
        statusMap.put(3, "Completed");
        statusMap.put(4, "On Hold");

        // 4. Add attributes to the model
        model.addAttribute("allManagers", allManagers);
        model.addAttribute("tasksByManager", tasksByManager);
        model.addAttribute("statusMap", statusMap);
        model.addAttribute("pageTitle", "Developer Dashboard");
        return "developer/dashboard";
    }

    // Helper method to get managers for a given project
    private List<UserEntity> getManagersForProject(Integer projectId) {
        List<ProjectUserEntity> assignments = projectUserRepository.findByProjectId(projectId);
        return assignments.stream()
                .map(ProjectUserEntity::getUserId)
                .map(userId -> userRepository.findById(userId).orElse(null))
                .filter(Objects::nonNull)
                .filter(u -> "MANAGER".equalsIgnoreCase(u.getRole()))
                .collect(Collectors.toList());
    }
}