package com;

import java.util.HashMap;
import java.util.Map;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.cloudinary.Cloudinary;

@SpringBootApplication
public class TimeTrackingV1Application {

	public static void main(String[] args) {
		SpringApplication.run(TimeTrackingV1Application.class, args);
	}
	
	@Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
	

	
}
