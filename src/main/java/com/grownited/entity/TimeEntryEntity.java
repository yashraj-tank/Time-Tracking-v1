package com.grownited.entity;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "time_entries")
public class TimeEntryEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer timeEntryId;

    private Integer taskId;
    private Integer userId;
    private LocalDate entryDate;
    private Double hours;
    private String notes;
    private LocalDateTime createdAt;
    private Boolean verified = false; 
    
    
	public Integer getTimeEntryId() {
		return timeEntryId;
	}
	public void setTimeEntryId(Integer timeEntryId) {
		this.timeEntryId = timeEntryId;
	}
	public Integer getTaskId() {
		return taskId;
	}
	public void setTaskId(Integer taskId) {
		this.taskId = taskId;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public LocalDate getEntryDate() {
		return entryDate;
	}
	public void setEntryDate(LocalDate entryDate) {
		this.entryDate = entryDate;
	}
	public Double getHours() {
		return hours;
	}
	public void setHours(Double hours) {
		this.hours = hours;
	}
	public String getNotes() {
		return notes;
	}
	public void setNotes(String notes) {
		this.notes = notes;
	}
	public LocalDateTime getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}
	public Boolean getVerified() {
		return verified;
	}
	public void setVerified(Boolean verified) {
		this.verified = verified;
	}

    
    
}