package com.orderservice.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class OrderController {

    @GetMapping("/api/v1/orders/health")
    public String healthCheck() {
        return "Order Service is running";
    }

    @GetMapping("/api/v1/orders")
    public String getOrders() {
        return "List of orders";
    }
    
    @GetMapping("/")
    public String root() {
        return "Order Service is running - Root endpoint";
    }
}

