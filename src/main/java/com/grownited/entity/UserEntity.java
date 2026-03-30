package com.grownited.entity;

import java.time.LocalDate;
import jakarta.persistence.*;

@Entity
@Table(name = "users")
public class UserEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer userId;

    private String firstName;
    private String lastName;
    private String email;
    private String password;
    private LocalDate createdAt;
    private String role;          // e.g., "ADMIN", "USER"
    private String gender;
    private String contactNum;
    private String profilePicURL;
    private String otp;            // or Integer depending on your need
    private Boolean active;        // true/false
    
    // Getters and Setters 
    
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public LocalDate getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(LocalDate createdAt) {
		this.createdAt = createdAt;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getContactNum() {
		return contactNum;
	}
	public void setContactNum(String contactNum) {
		this.contactNum = contactNum;
	}
	public String getProfilePicURL() {
		return profilePicURL;
	}
	public void setProfilePicURL(String profilePicURL) {
		this.profilePicURL = profilePicURL;
	}
	public String getOtp() {
		return otp;
	}
	public void setOtp(String otp) {
		this.otp = otp;
	}
	public Boolean getActive() {
		return active;
	}
	public void setActive(Boolean active) {
		this.active = active;
	}
    
    
}