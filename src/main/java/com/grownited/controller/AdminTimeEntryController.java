package com.grownited.controller;

import com.grownited.entity.TimeEntryEntity;
import com.grownited.repository.ProjectRepository;
import com.grownited.repository.TaskRepository;
import com.grownited.repository.TimeEntryRepository;
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
@RequestMapping("/admin/time-entries")
public class AdminTimeEntryController {

    @Autowired
    private TimeEntryRepository timeEntryRepository;

    @Autowired
    private TaskRepository taskRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ProjectRepository projectRepository; // <-- added for project titles

    // List all time entries (or only unverified)
    @GetMapping
    public String listTimeEntries(@RequestParam(required = false) Boolean showAll, Model model) {
        List<TimeEntryEntity> entries;
        if (showAll != null && showAll) {
            entries = timeEntryRepository.findAll();
        } else {
            entries = timeEntryRepository.findByVerifiedFalse(); // default: show only unverified
        }

        // Enrich entries with task title, project title, and user name
        List<Map<String, Object>> enrichedEntries = new ArrayList<>();
        for (TimeEntryEntity entry : entries) {
            Map<String, Object> map = new HashMap<>();
            map.put("entry", entry);

            // Task and project details
            taskRepository.findById(entry.getTaskId()).ifPresent(task -> {
                map.put("taskTitle", task.getTitle());
                // Project title
                projectRepository.findById(task.getProjectId())
                        .ifPresent(project -> map.put("projectTitle", project.getTitle()));
            });

            // User name
            userRepository.findById(entry.getUserId()).ifPresent(user ->
                    map.put("userName", user.getFirstName() + " " + user.getLastName())
            );

            enrichedEntries.add(map);
        }

        model.addAttribute("entries", enrichedEntries);
        model.addAttribute("pageTitle", "Time Logs");
        model.addAttribute("showAll", showAll != null && showAll);
        return "admin/time-entries";
    }

    // Verify a single time entry
    @PostMapping("/verify/{id}")
    public String verifyEntry(@PathVariable Integer id) {
        Optional<TimeEntryEntity> opt = timeEntryRepository.findById(id);
        if (opt.isPresent()) {
            TimeEntryEntity entry = opt.get();
            entry.setVerified(true);
            timeEntryRepository.save(entry);
        }
        return "redirect:/admin/time-entries";
    }
}