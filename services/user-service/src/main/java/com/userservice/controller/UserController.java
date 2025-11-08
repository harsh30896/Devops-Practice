package com.userservice.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class UserController {

    @GetMapping("/api/v1/users/health")
    public String healthCheck() {
        return "User Service is running";
    }

    @GetMapping("/api/v1/users")
    public String getUsers() {
        return "List of users";
    }
    
    @GetMapping("/")
    public String root() {
        return "User Service is running - Root endpoint";
    }
}

