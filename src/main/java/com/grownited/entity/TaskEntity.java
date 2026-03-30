package com.grownited.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "task")
public class TaskEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer taskId;
    private Integer moduleId;
    private Integer projectId;
    private Integer status;
    private String title;
    private String description;
    private String docURL;
    private Double estimatedHours;
    private Double totalUtilizedHours;

    // Getters and Setters
    public Integer getTaskId() {
        return taskId;
    }

    public void setTaskId(Integer taskId) {
        this.taskId = taskId;
    }

    public Integer getModuleId() {
        return moduleId;
    }

    public void setModuleId(Integer moduleId) {
        this.moduleId = moduleId;
    }

    public Integer getProjectId() {
        return projectId;
    }

    public void setProjectId(Integer projectId) {
        this.projectId = projectId;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDocURL() {
        return docURL;
    }

    public void setDocURL(String docURL) {
        this.docURL = docURL;
    }

    public Double getEstimatedHours() {
        return estimatedHours;
    }

    public void setEstimatedHours(Double estimatedHours) {
        this.estimatedHours = estimatedHours;
    }

    public Double getTotalUtilizedHours() {
        return totalUtilizedHours;
    }

    public void setTotalUtilizedHours(Double totalUtilizedHours) {
        this.totalUtilizedHours = totalUtilizedHours;
    }
}