package com.grownited.services;

import java.nio.charset.StandardCharsets;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.grownited.entity.UserEntity;

import jakarta.mail.internet.MimeMessage;

@Service
public class MailerService {

    @Autowired
    private JavaMailSender javaMailSender;

    @Autowired
    private ResourceLoader resourceLoader;

    public void sendWelcomeMail(UserEntity user) {
        MimeMessage message = javaMailSender.createMimeMessage();

        Resource resource = resourceLoader.getResource("classpath:templates/WelcomeMailTemplate.html");

        try {
            String html = new String(resource.getInputStream().readAllBytes(), StandardCharsets.UTF_8);

            MimeMessageHelper helper;

            String body = html.replace("${name}", user.getFirstName() + " " + user.getLastName())
                    .replace("${loginUrl}", "http://localhost:8080/login")
                    .replace("${companyName}", "Time Tracking App");

            helper = new MimeMessageHelper(message, true);
            helper.setTo(user.getEmail());
            helper.setSubject("Welcome to the Time Tracking App!");
            helper.setText(body, true);

            javaMailSender.send(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public void sendOtpEmail(String email, String otp, String firstName, String lastName) {
        MimeMessage message = javaMailSender.createMimeMessage();
        Resource resource = resourceLoader.getResource("classpath:templates/OtpEmailTemplate.html");
        try {
            String html = new String(resource.getInputStream().readAllBytes(), StandardCharsets.UTF_8);
            String body = html.replace("${name}", firstName + " " + lastName)
                    .replace("${otp}", otp)
                    .replace("${companyName}", "Time Tracking App");
            MimeMessageHelper helper = new MimeMessageHelper(message, true);
            helper.setTo(email);
            helper.setSubject("Password Reset OTP");
            helper.setText(body, true);
            javaMailSender.send(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}