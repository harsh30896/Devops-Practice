package com.DevopsPrac.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
public class TestApi {

    @GetMapping("/test")
    public String testingController(){
        return "api is working fine";
    }

}
