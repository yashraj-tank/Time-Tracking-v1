package com.grownited.repository;

import com.grownited.entity.TaskUserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface TaskUserRepository extends JpaRepository<TaskUserEntity, Integer> {  // ✅ Integer
    List<TaskUserEntity> findByTaskId(Integer taskId);    // ✅ matches field name taskId
    List<TaskUserEntity> findByUserId(Integer userId);    // ✅ matches field name userId
    List<TaskUserEntity> findByStatusId(Integer statusId); // ✅ matches field name statusId
}