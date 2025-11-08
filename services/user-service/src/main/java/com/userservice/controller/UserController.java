package com.userservice.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/users")
public class UserController {

    @GetMapping("/health")
    public String healthCheck() {
        return "User Service is running";
    }

    @GetMapping
    public String getUsers() {
        return "List of users";
    }
}

