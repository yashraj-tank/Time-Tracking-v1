package com.grownited.controller;

import com.grownited.entity.UserEntity;
import com.grownited.repository.UserRepository;
import com.grownited.services.MailerService;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;

@Controller
public class AuthController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    @Autowired
    private MailerService mailerService;
    
    @GetMapping("/")
    public String openlogin1() {
    	return "Login";
    }

    // Show signup page
    @GetMapping("/signup")
    public String showSignup() {
        return "Signup";
    }

    // Handle signup
    @PostMapping("/signup")
    public String doSignup(@RequestParam("firstName") String firstName,
                           @RequestParam("lastName") String lastName,
                           @RequestParam("email") String email,
                           @RequestParam("password") String password,
                           @RequestParam("gender") String gender,
                           @RequestParam("contactNum") String contactNum,
                           Model model) {
        // Check if email exists
        UserEntity existing = userRepository.findByEmail(email);
        if (existing != null) {
            model.addAttribute("error", "Email already registered!");
            return "Signup";
        }

        UserEntity user = new UserEntity();
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setEmail(email);
        user.setPassword(passwordEncoder.encode(password));
        user.setGender(gender);
        user.setContactNum(contactNum);
        user.setCreatedAt(LocalDate.now());
        user.setRole("DEVELOPER");           // Default role
        user.setActive(true);
        user.setOtp(null);
        user.setProfilePicURL(null);

        userRepository.save(user);

        mailerService.sendWelcomeMail(user);

        model.addAttribute("message", "Registration successful! Please login.");
        return "Login";
    }

    // Show login page
    @GetMapping("/login")
    public String showLogin() {
        return "Login";
    }

    // Handle login
    @PostMapping("/login")
    public String doLogin(@RequestParam("email") String email,
                          @RequestParam("password") String password,
                          HttpSession session,
                          Model model) {
        UserEntity user = userRepository.findByEmail(email);
        if (user == null) {
            model.addAttribute("error", "Email not found!");
            return "Login";
        }

        if (!passwordEncoder.matches(password, user.getPassword())) {
            model.addAttribute("error", "Incorrect password!");
            return "Login";
        }

        if (!user.getActive()) {
            model.addAttribute("error", "Account is inactive. Contact admin.");
            return "Login";
        }

        session.setAttribute("loggedInUser", user);

        // Role-based redirection
        String role = user.getRole();
        if ("ADMIN".equalsIgnoreCase(role)) {
            return "redirect:/admin/dashboard";
        } else if ("MANAGER".equalsIgnoreCase(role)) {
            return "redirect:/manager/dashboard";
        } else {
            // Default for developers/users
            return "redirect:/developer/dashboard";
        }
    }
    
 // Show forgot password form
    @GetMapping("/forgot-password")
    public String showForgotPassword() {
        return "ForgotPassword";
    }

    // Process forgot password: generate OTP, save, send email
    @PostMapping("/forgot-password")
    public String processForgotPassword(@RequestParam("email") String email, Model model) {
        UserEntity user = userRepository.findByEmail(email);
        if (user == null) {
            model.addAttribute("error", "Email not registered!");
            return "ForgotPassword";
        }

        // Generate 6-digit OTP
        String otp = String.valueOf((int) (Math.random() * 900000) + 100000);
        user.setOtp(otp);
        userRepository.save(user);

        // Send OTP email
        mailerService.sendOtpEmail(email, otp, user.getFirstName(), user.getLastName());

        model.addAttribute("email", email);
        return "VerifyOtp";
    }

    // Verify OTP
    @PostMapping("/verify-otp")
    public String verifyOtp(@RequestParam("email") String email,
                            @RequestParam("otp") String otp,
                            Model model) {
        UserEntity user = userRepository.findByEmail(email);
        if (user == null) {
            return "redirect:/forgot-password";
        }

        if (otp.equals(user.getOtp())) {
            model.addAttribute("email", email);
            return "ResetPassword";
        } else {
            model.addAttribute("error", "Invalid OTP. Please try again.");
            model.addAttribute("email", email);
            return "VerifyOtp";
        }
    }

    // Reset password
    @PostMapping("/reset-password")
    public String resetPassword(@RequestParam("email") String email,
                                @RequestParam("newPassword") String newPassword,
                                @RequestParam("confirmPassword") String confirmPassword,
                                Model model) {
        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("error", "Passwords do not match.");
            model.addAttribute("email", email);
            return "ResetPassword";
        }

        UserEntity user = userRepository.findByEmail(email);
        if (user == null) {
            return "redirect:/forgot-password";
        }

        user.setPassword(passwordEncoder.encode(newPassword));
        user.setOtp(null); // clear OTP after successful reset
        userRepository.save(user);

        model.addAttribute("success", "Password updated successfully. Please login.");
        return "Login";
    }

    // Logout
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}