package com.grownited.repository;

import com.grownited.entity.ProjectUserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface ProjectUserRepository extends JpaRepository<ProjectUserEntity, Integer> {  // ✅ Integer
    List<ProjectUserEntity> findByProjectId(Integer projectId);  // ✅ matches field name
    List<ProjectUserEntity> findByUserId(Integer userId);        // ✅ matches field name
    List<ProjectUserEntity> findByProjectIdIn(List<Integer> projectIds);
}