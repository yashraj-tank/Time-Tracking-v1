package com.grownited.controller;

import com.grownited.entity.ProjectEntity;
import com.grownited.entity.ProjectTimeEntryEntity;
import com.grownited.entity.UserEntity;
import com.grownited.repository.ProjectRepository;
import com.grownited.repository.ProjectTimeEntryRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Controller
@RequestMapping("/manager/projects")
public class ManagerProjectTimeLogController {

    @Autowired
    private ProjectRepository projectRepository;

    @Autowired
    private ProjectTimeEntryRepository projectTimeEntryRepository;

    @GetMapping("/{projectId}/log")
    public String showLogForm(@PathVariable Integer projectId, Model model, HttpSession session) {
        UserEntity user = (UserEntity) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/login";
        }

        ProjectEntity project = projectRepository.findById(projectId).orElse(null);
        if (project == null) {
            return "redirect:/manager/projects";
        }

        model.addAttribute("projectId", projectId);
        model.addAttribute("projectTitle", project.getTitle());
        model.addAttribute("pageTitle", "Log Time for Project");
        return "manager/project-log";
    }

    @PostMapping("/{projectId}/log")
    public String logTime(@PathVariable Integer projectId,
                          @RequestParam Double hours,
                          @RequestParam LocalDate entryDate,
                          @RequestParam(required = false) String notes,
                          HttpSession session) {
        UserEntity user = (UserEntity) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/login";
        }

        ProjectTimeEntryEntity entry = new ProjectTimeEntryEntity();
        entry.setProjectId(projectId);
        entry.setUserId(user.getUserId());
        entry.setHours(hours);
        entry.setEntryDate(entryDate);
        entry.setNotes(notes);
        entry.setCreatedAt(LocalDateTime.now());
        entry.setVerified(false); // default unverified
        projectTimeEntryRepository.save(entry);

        return "redirect:/manager/projects";
    }
}