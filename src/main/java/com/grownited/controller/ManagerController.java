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
@RequestMapping("/admin/managers")
public class ManagerController {

    @Autowired
    private UserRepository userRepository;

    @GetMapping
    public String listManagers(Model model) {
        List<UserEntity> managers = userRepository.findByRole("MANAGER");
        model.addAttribute("managers", managers);
        model.addAttribute("pageTitle", "Managers List");
        return "admin/managers";
    }
}