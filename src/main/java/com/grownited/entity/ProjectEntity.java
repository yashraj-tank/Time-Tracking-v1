package com.grownited.entity;

import java.time.LocalDate;
import jakarta.persistence.*;

@Entity
@Table(name = "projects")
public class ProjectEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer projectId;
    private String title;
    private String description;
    private Integer projectStatusId;
    private String docURL;
    private Double estimatedHours;
    private Double totalUtilizedHours;
    private LocalDate projectStartDate;
    private LocalDate projectCompletionDate; // nullable

    // Getters and Setters
    public Integer getProjectId() {
        return projectId;
    }

    public void setProjectId(Integer projectId) {
        this.projectId = projectId;
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

    public Integer getProjectStatusId() {
        return projectStatusId;
    }

    public void setProjectStatusId(Integer projectStatusId) {
        this.projectStatusId = projectStatusId;
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

    public LocalDate getProjectStartDate() {
        return projectStartDate;
    }

    public void setProjectStartDate(LocalDate projectStartDate) {
        this.projectStartDate = projectStartDate;
    }

    public LocalDate getProjectCompletionDate() {
        return projectCompletionDate;
    }

    public void setProjectCompletionDate(LocalDate projectCompletionDate) {
        this.projectCompletionDate = projectCompletionDate;
    }
}