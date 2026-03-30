package com.grownited.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "module")
public class ModuleEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer moduleId;

    private String moduleName;

    // Foreign key to projects table – stored as simple Integer (manual handling later)
    @Column(name = "project_id")
    private Integer projectId;

    // Foreign key to status table (e.g., module_status) – stored as simple Integer
    @Column(name = "status")
    private Integer status;  // FK to status table

    private String description;
    private String docURL;
    private Double estimatedHours;
    private Double totalUtilizedHours;

    // Getters and Setters
    public Integer getModuleId() {
        return moduleId;
    }

    public void setModuleId(Integer moduleId) {
        this.moduleId = moduleId;
    }

    public String getModuleName() {
        return moduleName;
    }

    public void setModuleName(String moduleName) {
        this.moduleName = moduleName;
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