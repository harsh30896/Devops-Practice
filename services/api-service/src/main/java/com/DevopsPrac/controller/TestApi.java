package com.DevopsPrac.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
@RequestMapping("/api/v1")
public class TestApi {

    @GetMapping("/test")
    public String testingController(){
        return "api is working fine";
    }
    
    @GetMapping("/health")
    public String healthCheck(){
        return "API Service is running";
    }

}
