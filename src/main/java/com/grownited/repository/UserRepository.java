package com.grownited.repository;

import com.grownited.entity.UserEntity;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<UserEntity, Integer> {
    UserEntity findByEmail(String email);
    List<UserEntity> findByRole(String role);
    Optional<UserEntity> findByEmailAndOtp(String email, String otp);
}