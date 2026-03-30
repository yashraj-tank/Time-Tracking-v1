package com.grownited.controller;

import com.grownited.entity.ProjectEntity;
import com.grownited.entity.ProjectUserEntity;
import com.grownited.entity.UserEntity;
import com.grownited.repository.ProjectRepository;
import com.grownited.repository.ProjectUserRepository;
import com.grownited.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/admin/project-managers")
public class ProjectManagerAssignmentController {

    @Autowired
    private ProjectRepository projectRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ProjectUserRepository projectUserRepository;

    // Show assignment page
    @GetMapping
    public String showAssignmentPage(Model model) {
        List<ProjectEntity> projects = projectRepository.findAll();
        List<UserEntity> managers = userRepository.findByRole("MANAGER");

        Map<Integer, List<Integer>> assignedMap = new HashMap<>();
        for (ProjectEntity project : projects) {
            List<ProjectUserEntity> assignments = projectUserRepository.findByProjectId(project.getProjectId());
            List<Integer> managerIds = assignments.stream()
                    .map(ProjectUserEntity::getUserId)
                    .collect(Collectors.toList());
            assignedMap.put(project.getProjectId(), managerIds);
        }

        model.addAttribute("projects", projects);
        model.addAttribute("managers", managers);
        model.addAttribute("assignedMap", assignedMap);
        model.addAttribute("pageTitle", "Assign Projects to Managers");
        return "admin/project-manager-assign";
    }

    // Handle form submission
    @PostMapping("/assign")
    public String assignProjects(@RequestParam Map<String, String> allParams) {
        for (Map.Entry<String, String> entry : allParams.entrySet()) {
            String key = entry.getKey();
            if (key.startsWith("project_")) {
                Integer projectId = Integer.parseInt(key.substring(8));
                String value = entry.getValue();
                // Clear existing assignments for this project
                List<ProjectUserEntity> existing = projectUserRepository.findByProjectId(projectId);
                projectUserRepository.deleteAll(existing);
                if (value != null && !value.isEmpty()) {
                    String[] managerIds = value.split(",");
                    for (String midStr : managerIds) {
                        Integer managerId = Integer.parseInt(midStr);
                        ProjectUserEntity pue = new ProjectUserEntity();
                        pue.setProjectId(projectId);
                        pue.setUserId(managerId);
                        projectUserRepository.save(pue);
                    }
                }
            }
        }
        return "redirect:/admin/project-managers";
    }
}