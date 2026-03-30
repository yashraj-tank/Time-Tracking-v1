package com.grownited.controller;

import com.grownited.entity.UserEntity;
import com.grownited.repository.UserRepository;
import com.grownited.services.CloudinaryService; // we'll create this service
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Optional;

@Controller
@RequestMapping("/developer")
public class DeveloperProfileController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private CloudinaryService cloudinaryService;

    @GetMapping("/profile")
    public String viewProfile(HttpSession session, Model model) {
        UserEntity user = (UserEntity) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/login";
        }
        model.addAttribute("user", user);
        model.addAttribute("pageTitle", "My Profile");
        return "developer/profile-view";
    }

    @GetMapping("/profile/edit")
    public String editProfileForm(HttpSession session, Model model) {
        UserEntity user = (UserEntity) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/login";
        }
        model.addAttribute("user", user);
        model.addAttribute("pageTitle", "Edit Profile");
        return "developer/profile-edit";
    }

    @PostMapping("/profile/update")
    public String updateProfile(@RequestParam("firstName") String firstName,
                                @RequestParam("lastName") String lastName,
                                @RequestParam("email") String email,
                                @RequestParam("gender") String gender,
                                @RequestParam("contactNum") String contactNum,
                                @RequestParam(value = "profilePic", required = false) MultipartFile file,
                                HttpSession session) throws IOException {
        UserEntity user = (UserEntity) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/login";
        }

        // Update basic fields
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setEmail(email);
        user.setGender(gender);
        user.setContactNum(contactNum);

        // Handle profile picture upload
        if (file != null && !file.isEmpty()) {
            String imageUrl = cloudinaryService.uploadFile(file);
            user.setProfilePicURL(imageUrl);
        }

        userRepository.save(user);
        // Update session with modified user
        session.setAttribute("loggedInUser", user);

        return "redirect:/developer/profile";
    }
}