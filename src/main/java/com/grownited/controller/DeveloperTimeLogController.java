package com.grownited.controller;

import com.grownited.entity.TimeEntryEntity;
import com.grownited.entity.TaskEntity;
import com.grownited.entity.UserEntity;
import com.grownited.repository.TaskRepository;
import com.grownited.repository.TimeEntryRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Controller
@RequestMapping("/developer/tasks")
public class DeveloperTimeLogController {

    @Autowired
    private TimeEntryRepository timeEntryRepository;

    @Autowired
    private TaskRepository taskRepository;

    @GetMapping("/{taskId}/log")
    public String showLogForm(@PathVariable Integer taskId, Model model, HttpSession session) {
        UserEntity user = (UserEntity) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/login";
        }

        TaskEntity task = taskRepository.findById(taskId).orElse(null);
        if (task == null) {
            return "redirect:/developer/tasks";
        }

        model.addAttribute("taskId", taskId);
        model.addAttribute("taskTitle", task.getTitle());
        model.addAttribute("userId", user.getUserId());
        model.addAttribute("pageTitle", "Log Time");
        return "developer/log-effort";
    }

    @PostMapping("/{taskId}/log")
    public String logTime(@PathVariable Integer taskId,
                          @RequestParam Double hours,
                          @RequestParam LocalDate entryDate,
                          @RequestParam(required = false) String notes,
                          HttpSession session) {
        UserEntity user = (UserEntity) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/login";
        }

        TimeEntryEntity entry = new TimeEntryEntity();
        entry.setTaskId(taskId);
        entry.setUserId(user.getUserId());
        entry.setHours(hours);
        entry.setEntryDate(entryDate);
        entry.setNotes(notes);
        entry.setCreatedAt(LocalDateTime.now());
        entry.setVerified(false);  // default to unverified
        timeEntryRepository.save(entry);
        
        return "redirect:/developer/tasks";
    }
}