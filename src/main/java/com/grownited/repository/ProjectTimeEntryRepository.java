package com.grownited.repository;

import com.grownited.entity.ProjectTimeEntryEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ProjectTimeEntryRepository extends JpaRepository<ProjectTimeEntryEntity, Integer> {
    List<ProjectTimeEntryEntity> findByProjectId(Integer projectId);
    List<ProjectTimeEntryEntity> findByVerifiedFalse();
    List<ProjectTimeEntryEntity> findByUserId(Integer userId);
    boolean existsByProjectIdAndVerifiedFalse(Integer projectId);
}