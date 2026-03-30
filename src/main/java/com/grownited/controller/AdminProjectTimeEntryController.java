package com.grownited.controller;

import com.grownited.entity.ProjectTimeEntryEntity;
import com.grownited.repository.ProjectRepository;
import com.grownited.repository.ProjectTimeEntryRepository;
import com.grownited.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
@RequestMapping("/admin/project-time-entries")
public class AdminProjectTimeEntryController {

    @Autowired
    private ProjectTimeEntryRepository projectTimeEntryRepository;

    @Autowired
    private ProjectRepository projectRepository;

    @Autowired
    private UserRepository userRepository;

    @GetMapping
    public String listProjectTimeEntries(@RequestParam(required = false) Boolean showAll, Model model) {
        List<ProjectTimeEntryEntity> entries;
        if (showAll != null && showAll) {
            entries = projectTimeEntryRepository.findAll();
        } else {
            entries = projectTimeEntryRepository.findByVerifiedFalse();
        }

        // Enrich with project title and user name
        List<Map<String, Object>> enrichedEntries = new ArrayList<>();
        for (ProjectTimeEntryEntity entry : entries) {
            Map<String, Object> map = new HashMap<>();
            map.put("entry", entry);

            // Project title
            projectRepository.findById(entry.getProjectId()).ifPresent(project ->
                    map.put("projectTitle", project.getTitle())
            );

            // User name
            userRepository.findById(entry.getUserId()).ifPresent(user ->
                    map.put("userName", user.getFirstName() + " " + user.getLastName())
            );

            enrichedEntries.add(map);
        }

        model.addAttribute("entries", enrichedEntries);
        model.addAttribute("pageTitle", "Project Time Logs");
        model.addAttribute("showAll", showAll != null && showAll);
        return "admin/project-time-entries";
    }

    @PostMapping("/verify/{id}")
    public String verifyEntry(@PathVariable Integer id) {
        Optional<ProjectTimeEntryEntity> opt = projectTimeEntryRepository.findById(id);
        if (opt.isPresent()) {
            ProjectTimeEntryEntity entry = opt.get();
            entry.setVerified(true);
            projectTimeEntryRepository.save(entry);
        }
        return "redirect:/admin/project-time-entries";
    }
}