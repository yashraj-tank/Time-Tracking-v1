package com.grownited.controller;

import com.grownited.repository.ProjectRepository;
import com.grownited.repository.ModuleRepository;
import com.grownited.repository.TaskRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminDashboardController {

    @Autowired
    private ProjectRepository projectRepository;

    @Autowired
    private ModuleRepository moduleRepository;

    @Autowired
    private TaskRepository taskRepository;

    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        // Total counts
        long projectCount = projectRepository.count();
        long moduleCount = moduleRepository.count();
        long taskCount = taskRepository.count();

        model.addAttribute("projectCount", projectCount);
        model.addAttribute("moduleCount", moduleCount);
        model.addAttribute("taskCount", taskCount);

        // Task status counts (assuming status codes: 1=Not Started, 2=In Progress, 3=Completed, 4=On Hold)
        Map<String, Long> statusCounts = new HashMap<>();
        statusCounts.put("Not Started", taskRepository.countByStatus(1));
        statusCounts.put("In Progress", taskRepository.countByStatus(2));
        statusCounts.put("Completed", taskRepository.countByStatus(3));
        statusCounts.put("On Hold", taskRepository.countByStatus(4));

        model.addAttribute("statusCounts", statusCounts);

        return "admin/dashboard"; // JSP path
    }
}