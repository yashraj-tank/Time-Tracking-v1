package com.grownited.controller;

import com.grownited.entity.TaskUserEntity;
import com.grownited.entity.TaskEntity;
import com.grownited.entity.UserEntity;
import com.grownited.repository.TaskUserRepository;
import com.grownited.repository.TaskRepository;
import com.grownited.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
@RequestMapping("/admin/assignments")
public class AssignmentController {

    @Autowired
    private TaskUserRepository taskUserRepository;

    @Autowired
    private TaskRepository taskRepository;

    @Autowired
    private UserRepository userRepository;

    @GetMapping
    public String listAllAssignments(Model model) {
        List<TaskUserEntity> assignments = taskUserRepository.findAll();
        List<Map<String, Object>> enrichedList = new ArrayList<>();

        for (TaskUserEntity tu : assignments) {
            Map<String, Object> map = new HashMap<>();
            map.put("assignment", tu);

            // Get task title
            Optional<TaskEntity> taskOpt = taskRepository.findById(tu.getTaskId());
            map.put("taskTitle", taskOpt.map(TaskEntity::getTitle).orElse("Unknown"));

            // Get user name
            Optional<UserEntity> userOpt = userRepository.findById(tu.getUserId());
            map.put("userName", userOpt.map(u -> u.getFirstName() + " " + u.getLastName()).orElse("Unknown"));

            enrichedList.add(map);
        }

        model.addAttribute("assignments", enrichedList);
        model.addAttribute("pageTitle", "All Task Assignments");
        return "admin/global-assignments";
    }
}