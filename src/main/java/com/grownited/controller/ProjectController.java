package com.grownited.controller;

import com.grownited.entity.ProjectEntity;
import com.grownited.repository.ProjectRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/admin/projects")
public class ProjectController {

    @Autowired
    private ProjectRepository projectRepository;

    @GetMapping
    public String getAllProjects(Model model) {
        List<ProjectEntity> projects = projectRepository.findAll();
        model.addAttribute("projects", projects);
        model.addAttribute("pageTitle", "Projects");
        return "admin/projects"; // <-- added "admin/"
    }

    @GetMapping("/new")
    public String showCreateForm(Model model) {
        model.addAttribute("project", new ProjectEntity());
        model.addAttribute("statuses", getProjectStatuses());
        model.addAttribute("pageTitle", "New Project");
        return "admin/project-form"; // <-- added "admin/"
    }

    @PostMapping("/save")
    public String save(@ModelAttribute("project") ProjectEntity project) {
        if (project.getTotalUtilizedHours() == null) {
            project.setTotalUtilizedHours(0.0);
        }
        projectRepository.save(project);
        return "redirect:/admin/projects";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Integer id, Model model) {
        Optional<ProjectEntity> projectOpt = projectRepository.findById(id);
        if (projectOpt.isPresent()) {
            model.addAttribute("project", projectOpt.get());
            model.addAttribute("statuses", getProjectStatuses());
            model.addAttribute("pageTitle", "Edit Project");
            return "admin/project-form"; // <-- added "admin/"
        }
        return "redirect:/admin/projects";
    }

    @PostMapping("/update/{id}")
    public String update(@PathVariable Integer id,
                         @ModelAttribute("project") ProjectEntity project) {
        project.setProjectId(id);
        projectRepository.save(project);
        return "redirect:/admin/projects";
    }

    @GetMapping("/view/{id}")
    public String view(@PathVariable Integer id, Model model) {
        Optional<ProjectEntity> projectOpt = projectRepository.findById(id);
        if (projectOpt.isPresent()) {
            model.addAttribute("project", projectOpt.get());
            model.addAttribute("pageTitle", "Project Details");
            return "admin/project-view"; // <-- added "admin/"
        }
        return "redirect:/admin/projects";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable Integer id) {
        projectRepository.deleteById(id);
        return "redirect:/admin/projects";
    }

    private List<ProjectStatus> getProjectStatuses() {
        return List.of(
                new ProjectStatus(1, "Not Started"),
                new ProjectStatus(2, "In Progress"),
                new ProjectStatus(3, "Completed"),
                new ProjectStatus(4, "On Hold")
        );
    }

    public static class ProjectStatus {
        private Integer id; private String name;
        public ProjectStatus(Integer id, String name) { this.id = id; this.name = name; }
        public Integer getId() { return id; }
        public String getName() { return name; }
    }
}