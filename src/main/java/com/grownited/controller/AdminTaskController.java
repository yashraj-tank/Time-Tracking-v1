package com.grownited.controller;

import com.grownited.entity.ModuleEntity;
import com.grownited.entity.ProjectEntity;
import com.grownited.entity.TaskEntity;
import com.grownited.repository.ModuleRepository;
import com.grownited.repository.ProjectRepository;
import com.grownited.repository.TaskRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/admin/tasks")
public class AdminTaskController {

    @Autowired
    private TaskRepository taskRepository;

    @Autowired
    private ModuleRepository moduleRepository;

    @Autowired
    private ProjectRepository projectRepository;

    @GetMapping
    public String listAllTasks(Model model) {
        List<TaskEntity> tasks = taskRepository.findAll();
        List<Map<String, Object>> taskList = new ArrayList<>();
        for (TaskEntity t : tasks) {
            Map<String, Object> map = new HashMap<>();
            map.put("task", t);
            String moduleName = moduleRepository.findById(t.getModuleId())
                    .map(ModuleEntity::getModuleName).orElse("Unknown");
            map.put("moduleName", moduleName);
            String projectTitle = projectRepository.findById(t.getProjectId())
                    .map(ProjectEntity::getTitle).orElse("Unknown");
            map.put("projectTitle", projectTitle);
            taskList.add(map);
        }
        // Group by task status
        Map<Integer, List<Map<String, Object>>> tasksByStatus = taskList.stream()
                .collect(Collectors.groupingBy(item -> ((TaskEntity)item.get("task")).getStatus()));
        model.addAttribute("tasksByStatus", tasksByStatus);
        model.addAttribute("pageTitle", "All Tasks");
        return "admin/task-list2";
    }
}