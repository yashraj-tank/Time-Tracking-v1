package com.grownited.entity;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "project_time_entries")
public class ProjectTimeEntryEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer projectTimeEntryId;

    private Integer projectId;
    private Integer userId;
    private LocalDate entryDate;
    private Double hours;
    private String notes;
    private LocalDateTime createdAt;
    private Boolean verified = false;
    
	public Integer getProjectTimeEntryId() {
		return projectTimeEntryId;
	}
	public void setProjectTimeEntryId(Integer projectTimeEntryId) {
		this.projectTimeEntryId = projectTimeEntryId;
	}
	public Integer getProjectId() {
		return projectId;
	}
	public void setProjectId(Integer projectId) {
		this.projectId = projectId;
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