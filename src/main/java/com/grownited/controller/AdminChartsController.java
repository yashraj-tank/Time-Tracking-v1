package com.grownited.controller;

import com.grownited.entity.ProjectEntity;
import com.grownited.repository.ProjectRepository;
import com.grownited.repository.TaskRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.List;

//TimeTrackingV1-0.0.1-SNAPSHOT.war
@Controller
@RequestMapping("/admin/charts")
public class AdminChartsController {

    @Autowired
    private TaskRepository taskRepository;

    @Autowired
    private ProjectRepository projectRepository;
    
    @GetMapping("/")
    public String openlogin() {
    	return "Login";
    }

    @GetMapping
    public String showCharts(Model model) {
        // 1. Task status data (bar chart)
        List<String> taskStatusLabels = List.of("Not Started", "In Progress", "Completed", "On Hold");
        List<Long> taskStatusData = List.of(
                taskRepository.countByStatus(1),
                taskRepository.countByStatus(2),
                taskRepository.countByStatus(3),
                taskRepository.countByStatus(4)
        );
        model.addAttribute("taskStatusLabels", taskStatusLabels);
        model.addAttribute("taskStatusData", taskStatusData);

        // 2. Project status data (pie chart)
        List<String> projectStatusLabels = List.of("Not Started", "In Progress", "Completed", "On Hold");
        List<Long> projectStatusData = List.of(
                projectRepository.countByProjectStatusId(1),
                projectRepository.countByProjectStatusId(2),
                projectRepository.countByProjectStatusId(3),
                projectRepository.countByProjectStatusId(4)
        );
        model.addAttribute("projectStatusLabels", projectStatusLabels);
        model.addAttribute("projectStatusData", projectStatusData);

        // 3. Tasks per project (horizontal bar chart)
        List<Object[]> taskCountByProject = taskRepository.countTasksByProject();
        List<String> projectNames = new ArrayList<>();
        List<Long> taskCounts = new ArrayList<>();
        for (Object[] row : taskCountByProject) {
            Integer projectId = (Integer) row[0];
            Long count = (Long) row[1];
            ProjectEntity project = projectRepository.findById(projectId).orElse(null);
            if (project != null) {
                projectNames.add(project.getTitle());
                taskCounts.add(count);
            }
        }
        model.addAttribute("projectNames", projectNames);
        model.addAttribute("taskCounts", taskCounts);

        model.addAttribute("pageTitle", "Analytics & Charts");
        return "admin/charts";
    }
}