package com.grownited.controller;

import com.grownited.entity.ModuleEntity;
import com.grownited.entity.ProjectEntity;
import com.grownited.repository.ModuleRepository;
import com.grownited.repository.ProjectRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin/modules")
public class AdminModuleController {

    @Autowired
    private ModuleRepository moduleRepository;

    @Autowired
    private ProjectRepository projectRepository;

    @GetMapping
    public String listAllModules(Model model) {
        List<ModuleEntity> modules = moduleRepository.findAll();
        
        // Group modules by project title
        Map<String, List<Map<String, Object>>> modulesByProject = new HashMap<>();
        
        for (ModuleEntity m : modules) {
            String projectTitle = projectRepository.findById(m.getProjectId())
                    .map(ProjectEntity::getTitle).orElse("Unknown");
            
            Map<String, Object> moduleMap = new HashMap<>();
            moduleMap.put("module", m);
            moduleMap.put("projectTitle", projectTitle);
            
            modulesByProject.computeIfAbsent(projectTitle, k -> new ArrayList<>()).add(moduleMap);
        }
        
        model.addAttribute("modulesByProject", modulesByProject);
        model.addAttribute("pageTitle", "All Modules");
        return "admin/module-list";
    }
}