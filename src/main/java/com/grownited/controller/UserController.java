package com.grownited.controller;

import com.grownited.entity.UserEntity;
import com.grownited.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@Controller
@RequestMapping("/admin/users")
public class UserController {

    @Autowired
    private UserRepository userRepository;

    @GetMapping("/view/{id}")
    public String viewUser(@PathVariable Integer id, Model model) {
        Optional<UserEntity> opt = userRepository.findById(id);
        model.addAttribute("user", opt.orElse(null));
        model.addAttribute("pageTitle", "User Details");
        return "admin/user-view";
    }

    @GetMapping("/edit/{id}")
    public String editUserForm(@PathVariable Integer id, Model model) {
        Optional<UserEntity> opt = userRepository.findById(id);
        model.addAttribute("user", opt.orElse(null));
        model.addAttribute("pageTitle", "Edit User");
        return "admin/user-form";
    }

    @PostMapping("/update/{id}")
    public String updateUser(@PathVariable Integer id, @ModelAttribute UserEntity updatedUser) {
        // Fetch existing user to preserve password and other fields not in form
        UserEntity existing = userRepository.findById(id).orElse(null);
        if (existing != null) {
            // Update only allowed fields
            existing.setFirstName(updatedUser.getFirstName());
            existing.setLastName(updatedUser.getLastName());
            existing.setEmail(updatedUser.getEmail());
            existing.setGender(updatedUser.getGender());
            existing.setContactNum(updatedUser.getContactNum());
            existing.setRole(updatedUser.getRole());
            existing.setActive(updatedUser.getActive());
            // Do not update password, createdAt, etc.
            userRepository.save(existing);
        }
        return "redirect:/admin/developers"; // or back to the user's list (developers for now)
    }

    @GetMapping("/toggle/{id}")
    public String toggleActive(@PathVariable Integer id) {
        Optional<UserEntity> opt = userRepository.findById(id);
        if (opt.isPresent()) {
            UserEntity user = opt.get();
            user.setActive(!user.getActive());
            userRepository.save(user);
        }
        return "redirect:/admin/developers";
    }
}