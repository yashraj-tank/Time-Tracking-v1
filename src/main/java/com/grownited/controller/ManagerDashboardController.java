package com.grownited.controller;

import com.grownited.entity.ProjectEntity;
import com.grownited.entity.ProjectUserEntity;
import com.grownited.entity.UserEntity;
import com.grownited.repository.ProjectRepository;
import com.grownited.repository.ProjectUserRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/manager")
public class ManagerDashboardController {

    @Autowired
    private ProjectUserRepository projectUserRepository;

    @Autowired
    private ProjectRepository projectRepository;

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        // Get logged-in user
        UserEntity loggedInUser = (UserEntity) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        // Find all project assignments for this manager
        List<ProjectUserEntity> assignments = projectUserRepository.findByUserId(loggedInUser.getUserId());
        List<Integer> projectIds = assignments.stream()
                .map(ProjectUserEntity::getProjectId)
                .collect(Collectors.toList());

        // Fetch the actual project details
        List<ProjectEntity> assignedProjects = projectRepository.findAllById(projectIds);

        // Counts (optional)
        long totalProjects = assignedProjects.size();
        long inProgress = assignedProjects.stream().filter(p -> p.getProjectStatusId() == 2).count(); // assuming 2 = In Progress
        long completed = assignedProjects.stream().filter(p -> p.getProjectStatusId() == 3).count();   // 3 = Completed
        long notStarted = assignedProjects.stream().filter(p -> p.getProjectStatusId() == 1).count();  // 1 = Not Started

        model.addAttribute("assignedProjects", assignedProjects);
        model.addAttribute("totalProjects", totalProjects);
        model.addAttribute("inProgress", inProgress);
        model.addAttribute("completed", completed);
        model.addAttribute("notStarted", notStarted);
        model.addAttribute("pageTitle", "Manager Dashboard");

        return "manager/dashboard"; // JSP at /WEB-INF/views/manager/dashboard.jsp
    }
}