package com.grownited.controller;

import com.grownited.entity.ModuleEntity;
import com.grownited.repository.ModuleRepository;
import com.grownited.repository.ProjectRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/admin/projects/{projectId}/modules")
public class ModuleController {

    @Autowired
    private ModuleRepository moduleRepository;

    @Autowired
    private ProjectRepository projectRepository;

    @GetMapping
    public String listModules(@PathVariable Integer projectId, Model model) {
        List<ModuleEntity> modules = moduleRepository.findByProjectId(projectId);
        model.addAttribute("modules", modules);
        model.addAttribute("projectId", projectId);
        model.addAttribute("pageTitle", "Modules for Project #" + projectId);
        return "admin/project-modules"; // was "admin/project-modules"
    }

    @GetMapping("/new")
    public String showCreateForm(@PathVariable Integer projectId, Model model) {
        ModuleEntity module = new ModuleEntity();
        module.setProjectId(projectId);
        model.addAttribute("module", module);
        model.addAttribute("projectId", projectId);
        model.addAttribute("statuses", getModuleStatuses());
        model.addAttribute("pageTitle", "Add Module");
        return "admin/module-form"; // was "admin/module-form"
    }

    @PostMapping("/save")
    public String save(@PathVariable Integer projectId,
                       @ModelAttribute("module") ModuleEntity module) {
        if (module.getTotalUtilizedHours() == null) {
            module.setTotalUtilizedHours(0.0);
        }
        module.setProjectId(projectId);
        moduleRepository.save(module);
        return "redirect:/admin/projects/" + projectId + "/modules";
    }

    @GetMapping("/edit/{moduleId}")
    public String showEditForm(@PathVariable Integer projectId,
                               @PathVariable Integer moduleId,
                               Model model) {
        Optional<ModuleEntity> moduleOpt = moduleRepository.findById(moduleId);
        if (moduleOpt.isPresent()) {
            model.addAttribute("module", moduleOpt.get());
            model.addAttribute("projectId", projectId);
            model.addAttribute("statuses", getModuleStatuses());
            model.addAttribute("pageTitle", "Edit Module");
            return "admin/module-form"; // was "admin/module-form"
        }
        return "redirect:/admin/projects/" + projectId + "/modules";
    }

    @PostMapping("/update/{moduleId}")
    public String update(@PathVariable Integer projectId,
                         @PathVariable Integer moduleId,
                         @ModelAttribute("module") ModuleEntity module) {
        module.setModuleId(moduleId);
        module.setProjectId(projectId);
        moduleRepository.save(module);
        return "redirect:/admin/projects/" + projectId + "/modules";
    }

    @GetMapping("/view/{moduleId}")
    public String view(@PathVariable Integer projectId,
                       @PathVariable Integer moduleId,
                       Model model) {
        Optional<ModuleEntity> moduleOpt = moduleRepository.findById(moduleId);
        if (moduleOpt.isPresent()) {
            model.addAttribute("module", moduleOpt.get());
            model.addAttribute("projectId", projectId);
            model.addAttribute("pageTitle", "Module Details");
            return "admin/module-view"; // was "admin/module-view"
        }
        return "redirect:/admin/projects/" + projectId + "/modules";
    }

    @GetMapping("/delete/{moduleId}")
    public String delete(@PathVariable Integer projectId,
                         @PathVariable Integer moduleId) {
        moduleRepository.deleteById(moduleId);
        return "redirect:/admin/projects/" + projectId + "/modules";
    }

    private List<ModuleStatus> getModuleStatuses() {
        return List.of(
                new ModuleStatus(1, "Not Started"),
                new ModuleStatus(2, "In Progress"),
                new ModuleStatus(3, "Completed"),
                new ModuleStatus(4, "On Hold")
        );
    }

    public static class ModuleStatus {
        private Integer id; private String name;
        public ModuleStatus(Integer id, String name) { this.id = id; this.name = name; }
        public Integer getId() { return id; }
        public String getName() { return name; }
    }
}