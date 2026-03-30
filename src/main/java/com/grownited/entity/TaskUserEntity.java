package com.grownited.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "task_user")
public class TaskUserEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer taskUserId;

    private Integer userId;         // FK to users table
    private Integer taskId;         // FK to tasks table
    private Integer assignStatus;   // 1: assigned, 2: revoked
    private Integer statusId;       // FK to task status table (or similar)
    private Double utitlizedHours;  // hours utilized by user on this task

    // Getters and Setters
    public Integer getTaskUserId() {
        return taskUserId;
    }

    public void setTaskUserId(Integer taskUserId) {
        this.taskUserId = taskUserId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getTaskId() {
        return taskId;
    }

    public void setTaskId(Integer taskId) {
        this.taskId = taskId;
    }

    public Integer getAssignStatus() {
        return assignStatus;
    }

    public void setAssignStatus(Integer assignStatus) {
        this.assignStatus = assignStatus;
    }

    public Integer getStatusId() {
        return statusId;
    }

    public void setStatusId(Integer statusId) {
        this.statusId = statusId;
    }

    public Double getUtitlizedHours() {
        return utitlizedHours;
    }

    public void setUtitlizedHours(Double utitlizedHours) {
        this.utitlizedHours = utitlizedHours;
    }
}