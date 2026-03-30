package com.grownited.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "project_status")
public class ProjectStatusEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer projectStatusId;

    private String status; // Values like "lead", "notStarted", "hold", "inProgress", "completed"

    // Getters and Setters
    public Integer getProjectStatusId() {
        return projectStatusId;
    }

    public void setProjectStatusId(Integer projectStatusId) {
        this.projectStatusId = projectStatusId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}