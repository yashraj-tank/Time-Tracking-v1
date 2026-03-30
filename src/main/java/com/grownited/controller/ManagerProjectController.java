package com.grownited.controller;

import com.grownited.entity.ProjectEntity;
import com.grownited.entity.ProjectUserEntity;
import com.grownited.entity.UserEntity;
import com.grownited.repository.ProjectRepository;
import com.grownited.repository.ProjectTimeEntryRepository; // import
import com.grownited.repository.ProjectUserRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/manager/projects")
public class ManagerProjectController {

    @Autowired
    private ProjectUserRepository projectUserRepository;

    @Autowired
    private ProjectRepository projectRepository;

    @Autowired
    private ProjectTimeEntryRepository projectTimeEntryRepository; // <-- added

    // List all projects assigned to the logged-in manager, with verification status
    @GetMapping
    public String listMyProjects(HttpSession session, Model model) {
        UserEntity loggedInUser = (UserEntity) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        // Get projects assigned to this manager
        List<ProjectUserEntity> assignments = projectUserRepository.findByUserId(loggedInUser.getUserId());
        List<Integer> projectIds = assignments.stream()
                .map(ProjectUserEntity::getProjectId)
                .collect(Collectors.toList());

        List<ProjectEntity> projects = projectRepository.findAllById(projectIds);

        // Build list of maps with project and verification flag
        List<Map<String, Object>> projectsWithStatus = new ArrayList<>();
        for (ProjectEntity project : projects) {
            Map<String, Object> map = new HashMap<>();
            map.put("project", project);
            boolean hasUnverified = projectTimeEntryRepository.existsByProjectIdAndVerifiedFalse(project.getProjectId());
            map.put("hasUnverifiedProjectLogs", hasUnverified);
            projectsWithStatus.add(map);
        }

        model.addAttribute("projectsWithStatus", projectsWithStatus);
        model.addAttribute("pageTitle", "My Projects");
        return "manager/projects"; // JSP at /WEB-INF/views/manager/projects.jsp
    }

    // Placeholder for viewing a single project (optional)
    @GetMapping("/view/{id}")
    public String viewProject(@PathVariable Integer id, Model model) {
        // You can implement later to show project details with modules/tasks
        return "redirect:/manager/projects";
    }
}