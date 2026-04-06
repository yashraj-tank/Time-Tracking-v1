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
	
	@Bean
	Cloudinary getCloudinary() {
		Map<String, String> config = new HashMap<>();
		config.put("cloud_name", "diyl3pgit");
		config.put("api_key", "585787524947233");
		config.put("api_secret", "Jtk5luHVI6g6Jm9MXSHFRxbQPMc");
		return new Cloudinary(config);
	}

}
