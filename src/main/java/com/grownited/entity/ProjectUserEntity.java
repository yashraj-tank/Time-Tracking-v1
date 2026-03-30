package com.grownited.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "project_user")
public class ProjectUserEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer projectUserId;

    private Integer userId;     // FK to users table
    private Integer projectId;  // FK to projects table
    private Integer assignStatus; // 1: assigned, 2: revoked

    // Getters and Setters
    public Integer getProjectUserId() {
        return projectUserId;
    }

    public void setProjectUserId(Integer projectUserId) {
        this.projectUserId = projectUserId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getProjectId() {
        return projectId;
    }

    public void setProjectId(Integer projectId) {
        this.projectId = projectId;
    }

    public Integer getAssignStatus() {
        return assignStatus;
    }

    public void setAssignStatus(Integer assignStatus) {
        this.assignStatus = assignStatus;
    }
}