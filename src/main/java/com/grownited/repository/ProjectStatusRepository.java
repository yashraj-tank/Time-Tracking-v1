package com.grownited.repository;

import com.grownited.entity.ProjectStatusEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProjectStatusRepository extends JpaRepository<ProjectStatusEntity, Integer> {  // ✅ Integer
    boolean existsByStatus(String status);  // ✅ matches field name "status" not "statusName"
}