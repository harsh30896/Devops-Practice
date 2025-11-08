# Deployment Guide: Microservices Architecture on Render

## Overview
This guide explains how to deploy your Spring Boot microservices architecture to Render.com.

## ✅ Yes, it's possible!
Render fully supports microservices architecture with:
- Multiple web services
- Private networking between services
- Environment variable management
- Zero-downtime deployments
- Infrastructure as Code (Blueprints)

## Prerequisites
1. A Render.com account (free tier available)
2. Your code pushed to a Git repository (GitHub, GitLab, or Bitbucket)
3. Docker installed locally (for testing)

## Deployment Options

### Option 1: Using Render Blueprint (Recommended)
This is the easiest way to deploy multiple microservices at once.

#### Steps:
1. **Push your code to GitHub/GitLab/Bitbucket**
   ```bash
   git add .
   git commit -m "Add Render deployment configuration"
   git push origin main
   ```

2. **Deploy via Render Dashboard:**
   - Go to [Render Dashboard](https://dashboard.render.com)
   - Click "New +" → "Blueprint"
   - Connect your repository
   - Render will automatically detect `render.yaml`
   - Review and deploy

3. **Or deploy via Render CLI:**
   ```bash
   # Install Render CLI
   npm install -g render-cli
   
   # Login
   render login
   
   # Deploy from render.yaml
   render deploy
   ```

### Option 2: Manual Deployment (Service by Service)

1. **Go to Render Dashboard** → "New +" → "Web Service"

2. **Connect your repository**

3. **Configure settings:**
   - **Name:** `devopsprac-api`
   - **Runtime:** Docker
   - **Dockerfile Path:** `./Dockerfile`
   - **Docker Context:** `.`
   - **Build Command:** (leave empty, Docker handles it)
   - **Start Command:** (leave empty, Docker handles it)

4. **Environment Variables:**
   - `PORT`: `8081` (Render will override this automatically)
   - `SPRING_PROFILES_ACTIVE`: `production`

5. **Health Check Path:** `/api/v1/test`

6. **Click "Create Web Service"**

## Adding More Microservices

To deploy multiple microservices:

### Method 1: Update render.yaml
Uncomment and modify the example service in `render.yaml`:
```yaml
- type: web
  name: devopsprac-user-service
  runtime: docker
  dockerfilePath: ./Dockerfile
  envVars:
    - key: PORT
      value: 8082
```

### Method 2: Create Separate Services
1. Create a new Web Service in Render Dashboard
2. Use the same repository but different:
   - Service name
   - Environment variables (different PORT)
   - Health check path

## Service Communication

### Private Networking
Services on Render can communicate via:
- **Private hostname:** `devopsprac-api.onrender.com` (internal)
- **Service discovery:** Use service names as hostnames

### Example: Service-to-Service Call
```java
// In another microservice
@Value("${api.service.url:http://devopsprac-api.onrender.com}")
private String apiServiceUrl;

// Make HTTP call
RestTemplate restTemplate = new RestTemplate();
String response = restTemplate.getForObject(
    apiServiceUrl + "/api/v1/test", 
    String.class
);
```

## Environment Variables

### Required Variables
- `PORT`: Automatically set by Render (don't override)
- `SPRING_PROFILES_ACTIVE`: `production` (recommended)

### Optional Variables
Add these in Render Dashboard → Environment:
- Database connections
- API keys
- Service URLs
- Feature flags

## Health Checks

Your service exposes a health check endpoint:
- **Path:** `/api/v1/test`
- **Method:** GET
- **Expected Response:** `"api is working fine"`

Render automatically monitors this endpoint.

## Scaling Microservices

### Free Tier
- 1 service per blueprint
- 750 hours/month
- Sleeps after 15 minutes of inactivity

### Paid Tiers
- Multiple services
- Always-on instances
- Auto-scaling
- Custom domains

## Monitoring & Logs

1. **View Logs:**
   - Render Dashboard → Your Service → Logs

2. **Metrics:**
   - CPU, Memory, Request rates
   - Available in Dashboard

3. **Alerts:**
   - Set up email/Slack notifications
   - Configure in Service Settings

## Troubleshooting

### Service won't start
- Check logs in Render Dashboard
- Verify Dockerfile builds locally: `docker build -t test .`
- Ensure PORT environment variable is used

### Health check failing
- Verify endpoint is accessible: `/api/v1/test`
- Check service logs for errors
- Ensure service starts before health check

### Service-to-service communication issues
- Use private hostnames (`.onrender.com`)
- Check environment variables are set correctly
- Verify services are in same region

## Best Practices

1. **Use Environment Variables**
   - Never hardcode secrets
   - Use Render's environment variable management

2. **Separate Services by Domain**
   - User Service
   - Product Service
   - Order Service
   - etc.

3. **Implement API Gateway** (Optional)
   - Deploy Kong on Render
   - Route requests to appropriate services
   - Handle authentication centrally

4. **Database per Service**
   - Each microservice should have its own database
   - Use Render PostgreSQL for each service

5. **Version Control**
   - Keep `render.yaml` in Git
   - Use branches for staging/production

## Cost Estimation

### Free Tier
- 1 web service
- 750 hours/month
- Good for development/testing

### Starter Plan ($7/month)
- Always-on service
- Custom domains
- Better for production

### Professional Plan ($25/month)
- Multiple services
- Auto-scaling
- Better performance

## Next Steps

1. ✅ Deploy your first service
2. ✅ Test the endpoint
3. ✅ Add more microservices as needed
4. ✅ Set up monitoring
5. ✅ Configure custom domains (optional)

## Support

- [Render Documentation](https://render.com/docs)
- [Render Community](https://community.render.com)
- [Spring Boot on Render](https://render.com/docs/deploy-spring-boot)

