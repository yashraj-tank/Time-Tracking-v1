package com.grownited.repository;

import com.grownited.entity.ModuleEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ModuleRepository extends JpaRepository<ModuleEntity, Integer> {
    List<ModuleEntity> findByProjectId(Integer projectId);
}