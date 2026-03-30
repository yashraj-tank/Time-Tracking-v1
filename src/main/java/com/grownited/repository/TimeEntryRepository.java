package com.grownited.repository;

import com.grownited.entity.TimeEntryEntity;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface TimeEntryRepository extends JpaRepository<TimeEntryEntity, Integer> {
		List<TimeEntryEntity> findByTaskId(Integer taskId);
	    List<TimeEntryEntity> findByUserId(Integer userId);
	    List<TimeEntryEntity> findByVerifiedFalse();
	    @Query("SELECT SUM(t.hours) FROM TimeEntryEntity t WHERE t.taskId = :taskId")
	    Double sumHoursByTaskId(@Param("taskId") Integer taskId);
	    boolean existsByTaskIdAndVerifiedFalse(Integer taskId);
	    @Query("SELECT COUNT(t) > 0 FROM TimeEntryEntity t WHERE t.taskId = :taskId AND t.verified = false")
	    boolean hasUnverifiedEntries(@Param("taskId") Integer taskId);
	    List<TimeEntryEntity> findByTaskIdIn(List<Integer> taskIds);
	    
}