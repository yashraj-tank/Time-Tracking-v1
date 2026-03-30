
package com.grownited.repository;

import com.grownited.entity.TaskEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface TaskRepository extends JpaRepository<TaskEntity, Integer> {
    List<TaskEntity> findByModuleId(Integer moduleId);
    // Count tasks by status
    long countByStatus(Integer status);
    
    List<TaskEntity> findByProjectIdIn(List<Integer> projectIds);
    
    @Query("SELECT t.projectId, COUNT(t) FROM TaskEntity t GROUP BY t.projectId")
    List<Object[]> countTasksByProject();
    
}