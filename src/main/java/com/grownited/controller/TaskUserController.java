package com.grownited.controller;

import com.grownited.entity.TaskUserEntity;
import com.grownited.entity.UserEntity;
import com.grownited.entity.TaskEntity;
import com.grownited.repository.TaskUserRepository;
import com.grownited.repository.UserRepository;
import com.grownited.repository.TaskRepository;
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
@RequestMapping("/admin/tasks/{taskId}/assignments")
public class TaskUserController {

    @Autowired
    private TaskUserRepository taskUserRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private TaskRepository taskRepository;

    // List all assignments for a specific task
    @GetMapping
    public String listAssignments(@PathVariable Integer taskId, Model model) {
        List<TaskUserEntity> assignments = taskUserRepository.findByTaskId(taskId);
        
        // Enrich with user names
        List<Map<String, Object>> assignmentList = new ArrayList<>();
        for (TaskUserEntity tu : assignments) {
            Map<String, Object> map = new HashMap<>();
            map.put("assignment", tu);
            Optional<UserEntity> userOpt = userRepository.findById(tu.getUserId());
            map.put("userName", userOpt.map(u -> u.getFirstName() + " " + u.getLastName()).orElse("Unknown"));
            assignmentList.add(map);
        }
        
        // Get task title for display
        Optional<TaskEntity> taskOpt = taskRepository.findById(taskId);
        model.addAttribute("task", taskOpt.orElse(null));
        model.addAttribute("assignments", assignmentList);
        model.addAttribute("taskId", taskId);
        model.addAttribute("pageTitle", "Task Assignments");
        return "admin/task-assignments";
    }

    // Show form to assign a user to this task
    @GetMapping("/new")
    public String showAssignForm(@PathVariable Integer taskId, Model model) {
        TaskUserEntity assignment = new TaskUserEntity();
        assignment.setTaskId(taskId);
        assignment.setAssignStatus(1); // default to assigned
        model.addAttribute("assignment", assignment);
        model.addAttribute("taskId", taskId);
        
        // List all users for dropdown
        List<UserEntity> users = userRepository.findAll();
        model.addAttribute("users", users);
        
        model.addAttribute("pageTitle", "Assign User to Task");
        return "admin/task-assignment-form";
    }

    // Save new assignment
    @PostMapping("/save")
    public String saveAssignment(@PathVariable Integer taskId,
                                 @ModelAttribute("assignment") TaskUserEntity assignment) {
        assignment.setTaskId(taskId);
        if (assignment.getUtitlizedHours() == null) {
            assignment.setUtitlizedHours(0.0);
        }
        taskUserRepository.save(assignment);
        return "redirect:/admin/tasks/" + taskId + "/assignments";
    }

    // Show form to edit an assignment
    @GetMapping("/edit/{assignmentId}")
    public String showEditForm(@PathVariable Integer taskId,
                               @PathVariable Integer assignmentId,
                               Model model) {
        Optional<TaskUserEntity> opt = taskUserRepository.findById(assignmentId);
        if (opt.isPresent()) {
            model.addAttribute("assignment", opt.get());
            model.addAttribute("taskId", taskId);
            
            // List users for dropdown
            List<UserEntity> users = userRepository.findAll();
            model.addAttribute("users", users);
            
            model.addAttribute("pageTitle", "Edit Assignment");
            return "admin/task-assignment-form";
        }
        return "redirect:/admin/tasks/" + taskId + "/assignments";
    }

    // Update assignment
    @PostMapping("/update/{assignmentId}")
    public String updateAssignment(@PathVariable Integer taskId,
                                   @PathVariable Integer assignmentId,
                                   @ModelAttribute("assignment") TaskUserEntity assignment) {
        assignment.setTaskUserId(assignmentId);
        assignment.setTaskId(taskId);
        taskUserRepository.save(assignment);
        return "redirect:/admin/tasks/" + taskId + "/assignments";
    }

    // Delete assignment
    @GetMapping("/delete/{assignmentId}")
    public String deleteAssignment(@PathVariable Integer taskId,
                                   @PathVariable Integer assignmentId) {
        taskUserRepository.deleteById(assignmentId);
        return "redirect:/admin/tasks/" + taskId + "/assignments";
    }
}