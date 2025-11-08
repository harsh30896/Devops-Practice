#!/bin/bash

# API Testing Script for Microservices
# Usage: ./test-apis.sh [api-url] [user-service-url] [order-service-url]

echo "=========================================="
echo "  Microservices API Testing Script"
echo "=========================================="
echo ""

# Default URLs (update these with your actual Render URLs)
API_URL="${1:-https://devops-practice-xovf.onrender.com}"
USER_SERVICE_URL="${2:-https://devopsprac-user-service.onrender.com}"
ORDER_SERVICE_URL="${3:-https://devopsprac-order-service.onrender.com}"

echo "Testing URLs:"
echo "  API Service: $API_URL"
echo "  User Service: $USER_SERVICE_URL"
echo "  Order Service: $ORDER_SERVICE_URL"
echo ""
echo "=========================================="
echo ""

# Function to test endpoint
test_endpoint() {
    local url=$1
    local name=$2
    local expected_status=${3:-200}
    
    echo "Testing: $name"
    echo "  URL: $url"
    
    response=$(curl -s -w "\nHTTP_STATUS:%{http_code}" "$url")
    http_status=$(echo "$response" | grep "HTTP_STATUS" | cut -d: -f2)
    body=$(echo "$response" | sed '/HTTP_STATUS/d')
    
    if [ "$http_status" == "$expected_status" ]; then
        echo "  ✅ Status: $http_status (Expected: $expected_status)"
        echo "  Response: $body"
        echo ""
        return 0
    else
        echo "  ❌ Status: $http_status (Expected: $expected_status)"
        echo "  Response: $body"
        echo ""
        return 1
    fi
}

# Test API Service
echo "=== API Service Tests ==="
test_endpoint "$API_URL/api/v1/test" "API Test Endpoint"
test_endpoint "$API_URL/api/v1/health" "API Health Endpoint"
echo ""

# Test User Service
echo "=== User Service Tests ==="
test_endpoint "$USER_SERVICE_URL/api/v1/users/health" "User Service Health"
test_endpoint "$USER_SERVICE_URL/api/v1/users" "User Service List"
echo ""

# Test Order Service
echo "=== Order Service Tests ==="
test_endpoint "$ORDER_SERVICE_URL/api/v1/orders/health" "Order Service Health"
test_endpoint "$ORDER_SERVICE_URL/api/v1/orders" "Order Service List"
echo ""

echo "=========================================="
echo "Testing Complete!"
echo "=========================================="

