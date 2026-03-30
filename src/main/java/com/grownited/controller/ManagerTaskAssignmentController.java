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
@RequestMapping("/manager/task-assignments")
public class ManagerTaskAssignmentController {

    @Autowired
    private ProjectUserRepository projectUserRepository;

    @Autowired
    private TaskRepository taskRepository;

    @Autowired
    private ModuleRepository moduleRepository;

    @Autowired
    private ProjectRepository projectRepository;

    @Autowired
    private TaskUserRepository taskUserRepository;

    @Autowired
    private UserRepository userRepository;

    @GetMapping
    public String listTaskAssignments(HttpSession session, Model model) {
        UserEntity loggedInUser = (UserEntity) session.getAttribute("loggedInUser");
        if (loggedInUser == null) return "redirect:/login";

        // 1. Get all projects assigned to this manager
        List<ProjectUserEntity> managerAssignments = projectUserRepository.findByUserId(loggedInUser.getUserId());
        List<Integer> projectIds = managerAssignments.stream()
                .map(ProjectUserEntity::getProjectId)
                .collect(Collectors.toList());

        if (projectIds.isEmpty()) {
            model.addAttribute("taskAssignments", new ArrayList<>());
            model.addAttribute("pageTitle", "Task Assignments");
            return "manager/task-assignments";
        }

        // 2. Get all tasks in those projects
        List<TaskEntity> tasks = taskRepository.findByProjectIdIn(projectIds);

        // 3. For each task, get its assigned users (from TaskUser)
        List<Map<String, Object>> taskAssignments = new ArrayList<>();
        for (TaskEntity task : tasks) {
            List<TaskUserEntity> assignments = taskUserRepository.findByTaskId(task.getTaskId());
            List<UserEntity> assignedUsers = assignments.stream()
                    .map(ta -> userRepository.findById(ta.getUserId()).orElse(null))
                    .filter(Objects::nonNull)
                    .collect(Collectors.toList());

            if (!assignedUsers.isEmpty()) {
                Map<String, Object> map = new HashMap<>();
                map.put("task", task);
                map.put("assignedUsers", assignedUsers);
                // Add module and project names
                String moduleName = moduleRepository.findById(task.getModuleId())
                        .map(ModuleEntity::getModuleName).orElse("Unknown");
                map.put("moduleName", moduleName);
                String projectTitle = projectRepository.findById(task.getProjectId())
                        .map(ProjectEntity::getTitle).orElse("Unknown");
                map.put("projectTitle", projectTitle);
                taskAssignments.add(map);
            }
        }

        model.addAttribute("taskAssignments", taskAssignments);
        model.addAttribute("pageTitle", "Task Assignments");
        return "manager/task-assignments";
    }
}