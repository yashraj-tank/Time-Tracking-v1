package com.grownited.controller;

import com.grownited.entity.UserEntity;
import com.grownited.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/admin/developers")
public class DeveloperController {

    @Autowired
    private UserRepository userRepository;

    @GetMapping
    public String listDevelopers(Model model) {
        List<UserEntity> developers = userRepository.findByRole("DEVELOPER");
        model.addAttribute("developers", developers);
        model.addAttribute("pageTitle", "Developers List");
        return "admin/developers";
    }
}