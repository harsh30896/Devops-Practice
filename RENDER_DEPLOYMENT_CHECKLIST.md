# Render Deployment Checklist & Verification

## 🔍 Service Configuration Verification

### Expected Service URLs (from render.yaml)

1. **API Service**
   - Name: `devopsprac-api`
   - Expected URL: `https://devopsprac-api.onrender.com`
   - Health Check: `/api/v1/test`
   - Endpoints:
     - `GET /api/v1/test` → "api is working fine"
     - `GET /api/v1/health` → "API Service is running"

2. **User Service**
   - Name: `devopsprac-user-service`
   - Expected URL: `https://devopsprac-user-service.onrender.com`
   - Health Check: `/api/v1/users/health`
   - Endpoints:
     - `GET /api/v1/users/health` → "User Service is running"
     - `GET /api/v1/users` → "List of users"

3. **Order Service**
   - Name: `devopsprac-order-service`
   - Expected URL: `https://devopsprac-order-service.onrender.com`
   - Health Check: `/api/v1/orders/health`
   - Endpoints:
     - `GET /api/v1/orders/health` → "Order Service is running"
     - `GET /api/v1/orders` → "List of orders"

## ✅ Code Verification Status

### All Services - Code Structure
- ✅ All services use standard `@SpringBootApplication` (auto component scanning)
- ✅ All controllers use `@RestController` and `@RequestMapping`
- ✅ All services compile successfully
- ✅ Dockerfiles are correctly configured
- ✅ Application properties use `${PORT:default}` pattern

### API Service
- ✅ Controller: `TestApi.java` with `/api/v1/test` and `/api/v1/health`
- ✅ Main class: `DevopsPracApplication.java`
- ✅ Port: 8081 (or PORT env var)

### User Service
- ✅ Controller: `UserController.java` with `/api/v1/users` endpoints
- ✅ Main class: `UserServiceApplication.java`
- ✅ Port: 8082 (or PORT env var)

### Order Service
- ✅ Controller: `OrderController.java` with `/api/v1/orders` endpoints
- ✅ Main class: `OrderServiceApplication.java`
- ✅ Port: 8083 (or PORT env var)

## 🚀 Deployment Steps

### Step 1: Verify Render Dashboard
1. Go to [Render Dashboard](https://dashboard.render.com)
2. Check if all 3 services are listed:
   - `devopsprac-api`
   - `devopsprac-user-service`
   - `devopsprac-order-service`

### Step 2: Deploy via Blueprint (if not deployed)
1. Click "New +" → "Blueprint"
2. Connect repository: `harsh30896/Devops-Practice`
3. Render will detect `render.yaml`
4. Review all 3 services
5. Click "Apply"

### Step 3: Manual Redeploy (if services exist but outdated)
For each service:
1. Go to service → "Manual Deploy" → "Deploy latest commit"
2. Wait for build to complete
3. Check logs for errors

### Step 4: Get Actual Service URLs
1. In Render Dashboard, click each service
2. Find the "Service URL" (e.g., `https://devopsprac-api.onrender.com`)
3. Update `test-apis.sh` with actual URLs

## 🧪 Testing

### Run Test Script
```bash
# Test with default URLs
./test-apis.sh

# Or test with custom URLs
./test-apis.sh \
  https://your-api-service.onrender.com \
  https://your-user-service.onrender.com \
  https://your-order-service.onrender.com
```

### Manual Testing
```bash
# API Service
curl https://devopsprac-api.onrender.com/api/v1/test
curl https://devopsprac-api.onrender.com/api/v1/health

# User Service
curl https://devopsprac-user-service.onrender.com/api/v1/users/health
curl https://devopsprac-user-service.onrender.com/api/v1/users

# Order Service
curl https://devopsprac-order-service.onrender.com/api/v1/orders/health
curl https://devopsprac-order-service.onrender.com/api/v1/orders
```

## 🔧 Troubleshooting

### Issue: 404 Not Found
**Possible Causes:**
- Service not deployed yet
- Wrong URL (check Render dashboard for actual URL)
- Service is sleeping (free tier - wake it up by making a request)
- Code not deployed (redeploy needed)

**Solution:**
1. Check Render dashboard for service status
2. Verify the actual service URL
3. Check deployment logs for errors
4. Redeploy if needed

### Issue: Service Not Starting
**Check:**
1. Render logs for startup errors
2. Docker build logs
3. Application properties configuration
4. Port configuration (should use PORT env var)

### Issue: Endpoints Not Found
**Check:**
1. Controller package matches main application package structure
2. `@RestController` annotation is present
3. `@RequestMapping` and `@GetMapping` are correct
4. Service logs show "Started [Service]Application"

## 📝 Current Status

- ✅ Code is correct and compiles
- ⚠️ Deployment may be outdated (needs redeploy)
- ⚠️ Other services may not be deployed yet
- ✅ Test script ready to use

## 🎯 Next Actions

1. **Check Render Dashboard** - Verify all services are deployed
2. **Get Actual URLs** - Note the real service URLs from Render
3. **Redeploy if Needed** - Deploy latest commit for each service
4. **Run Test Script** - Use `./test-apis.sh` with actual URLs
5. **Verify Endpoints** - All endpoints should return 200 status

