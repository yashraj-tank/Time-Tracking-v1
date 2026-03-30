package com.grownited.controller;

import com.grownited.entity.*;
import com.grownited.repository.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/manager/time-entries")
public class ManagerTimeEntryController {

    @Autowired
    private ProjectUserRepository projectUserRepository;

    @Autowired
    private TaskRepository taskRepository;

    @Autowired
    private TimeEntryRepository timeEntryRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ProjectRepository projectRepository; // to fetch project titles

    @GetMapping
    public String listTimeEntries(HttpSession session, Model model,
                                  @RequestParam(required = false) Boolean showAll) {
        UserEntity loggedInUser = (UserEntity) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        // 1. Get projects managed by this manager
        List<ProjectUserEntity> managerProjects = projectUserRepository.findByUserId(loggedInUser.getUserId());
        List<Integer> projectIds = managerProjects.stream()
                .map(ProjectUserEntity::getProjectId)
                .collect(Collectors.toList());

        if (projectIds.isEmpty()) {
            model.addAttribute("entries", new ArrayList<>());
            model.addAttribute("pageTitle", "Time Logs");
            return "manager/time-entries";
        }

        // 2. Get all tasks in those projects
        List<TaskEntity> tasks = taskRepository.findByProjectIdIn(projectIds);
        List<Integer> taskIds = tasks.stream()
                .map(TaskEntity::getTaskId)
                .collect(Collectors.toList());

        if (taskIds.isEmpty()) {
            model.addAttribute("entries", new ArrayList<>());
            model.addAttribute("pageTitle", "Time Logs");
            return "manager/time-entries";
        }

        // 3. Get time entries for those tasks
        List<TimeEntryEntity> allEntries = timeEntryRepository.findByTaskIdIn(taskIds);

        // 4. Filter based on showAll parameter
        List<TimeEntryEntity> entries;
        if (showAll != null && showAll) {
            entries = allEntries;
        } else {
            entries = allEntries.stream()
                    .filter(entry -> !entry.getVerified()) // unverified only
                    .collect(Collectors.toList());
        }

        // 5. Enrich entries with task title, user name, project title
        List<Map<String, Object>> enrichedEntries = new ArrayList<>();
        for (TimeEntryEntity entry : entries) {
            Map<String, Object> map = new HashMap<>();
            map.put("entry", entry);

            // Task details
            TaskEntity task = taskRepository.findById(entry.getTaskId()).orElse(null);
            if (task != null) {
                map.put("taskTitle", task.getTitle());
                // Project title
                projectRepository.findById(task.getProjectId())
                        .ifPresent(p -> map.put("projectTitle", p.getTitle()));
            } else {
                map.put("taskTitle", "Unknown");
                map.put("projectTitle", "Unknown");
            }

            // User details
            userRepository.findById(entry.getUserId()).ifPresent(user ->
                    map.put("userName", user.getFirstName() + " " + user.getLastName())
            );

            enrichedEntries.add(map);
        }

        model.addAttribute("entries", enrichedEntries);
        model.addAttribute("pageTitle", "Time Logs");
        model.addAttribute("showAll", showAll != null && showAll);
        return "manager/time-entries";
    }

    @PostMapping("/verify/{id}")
    public String verifyEntry(@PathVariable Integer id) {
        Optional<TimeEntryEntity> opt = timeEntryRepository.findById(id);
        if (opt.isPresent()) {
            TimeEntryEntity entry = opt.get();
            entry.setVerified(true);
            timeEntryRepository.save(entry);
        }
        return "redirect:/manager/time-entries";
    }
}