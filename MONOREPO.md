# Monorepo Guide: Multiple Microservices in One Repository

## 📁 Repository Structure

```
DevopsPrac/
├── services/
│   ├── api-service/          # Main API service
│   │   ├── src/
│   │   ├── pom.xml
│   │   ├── Dockerfile
│   │   └── mvnw
│   ├── user-service/         # User management service
│   │   ├── src/
│   │   ├── pom.xml
│   │   ├── Dockerfile
│   │   └── mvnw
│   └── order-service/        # Order management service
│       ├── src/
│       ├── pom.xml
│       ├── Dockerfile
│       └── mvnw
├── render.yaml               # Render deployment configuration
├── .gitignore
└── README.md
```

## 🚀 How It Works

### 1. **Single Repository, Multiple Services**
Each microservice lives in its own subdirectory under `services/`:
- `services/api-service/` - Your main API
- `services/user-service/` - User management
- `services/order-service/` - Order management

### 2. **Independent Services**
Each service has:
- ✅ Its own `pom.xml` (Maven configuration)
- ✅ Its own `Dockerfile` (containerization)
- ✅ Its own source code (`src/` directory)
- ✅ Its own port configuration
- ✅ Its own application properties

### 3. **Deployment on Render**
The `render.yaml` file tells Render:
- Where each service is located (`dockerContext`)
- Which Dockerfile to use (`dockerfilePath`)
- What port each service uses
- Health check endpoints

## 📤 Pushing to GitHub

### Initial Setup

1. **Initialize Git (if not already done):**
   ```bash
   git init
   git remote add origin https://github.com/yourusername/your-repo-name.git
   ```

2. **Add all files:**
   ```bash
   git add .
   git commit -m "Initial commit: Monorepo with multiple microservices"
   git push -u origin main
   ```

### Adding New Microservices

1. **Create a new service directory:**
   ```bash
   mkdir -p services/product-service/src/main/java/com/productservice
   mkdir -p services/product-service/src/main/resources
   ```

2. **Copy template files:**
   - Copy `pom.xml` from another service
   - Update `artifactId` and `name` in `pom.xml`
   - Create `Dockerfile` (copy from another service)
   - Create your Java source files
   - Create `application.properties`

3. **Update `render.yaml`:**
   ```yaml
   - type: web
     name: devopsprac-product-service
     runtime: docker
     dockerfilePath: ./services/product-service/Dockerfile
     dockerContext: ./services/product-service
     envVars:
       - key: PORT
         value: 8084
   ```

4. **Commit and push:**
   ```bash
   git add services/product-service/
   git add render.yaml
   git commit -m "Add product-service microservice"
   git push origin main
   ```

## 🔄 How Render Deploys from Monorepo

### Render's Monorepo Support

Render automatically:
1. **Detects subdirectories** - Each service in `render.yaml` points to its subdirectory
2. **Builds independently** - Each service builds in its own Docker context
3. **Deploys separately** - Each service gets its own URL and resources
4. **Manages dependencies** - Services can communicate via private networking

### Deployment Process

1. **Push to GitHub:**
   ```bash
   git push origin main
   ```

2. **Render detects changes:**
   - Render watches your repository
   - When `render.yaml` changes, it redeploys affected services

3. **Each service builds:**
   - Render uses `dockerContext` to build from the correct directory
   - Each service builds independently
   - No conflicts between services

4. **Services go live:**
   - Each service gets its own URL:
     - `https://devopsprac-api.onrender.com`
     - `https://devopsprac-user-service.onrender.com`
     - `https://devopsprac-order-service.onrender.com`

## 🔗 Service-to-Service Communication

### Option 1: Using Render's Private Network

Services can call each other using Render's private hostnames:

```java
// In user-service, calling api-service
@Value("${api.service.url:https://devopsprac-api.onrender.com}")
private String apiServiceUrl;

@Autowired
private RestTemplate restTemplate;

public String callApiService() {
    return restTemplate.getForObject(
        apiServiceUrl + "/api/v1/test", 
        String.class
    );
}
```

### Option 2: Environment Variables

Set service URLs in `render.yaml`:

```yaml
envVars:
  - key: API_SERVICE_URL
    value: https://devopsprac-api.onrender.com
  - key: USER_SERVICE_URL
    value: https://devopsprac-user-service.onrender.com
```

Then use in your code:

```java
@Value("${API_SERVICE_URL}")
private String apiServiceUrl;
```

## 📝 Creating a New Microservice

### Step-by-Step Guide

1. **Create directory structure:**
   ```bash
   mkdir -p services/payment-service/src/main/java/com/paymentservice/controller
   mkdir -p services/payment-service/src/main/resources
   ```

2. **Create `pom.xml`:**
   ```xml
   <artifactId>payment-service</artifactId>
   <name>Payment Service</name>
   ```

3. **Create `Dockerfile`:**
   ```dockerfile
   FROM maven:3.9.9-eclipse-temurin-21 AS builder
   WORKDIR /app
   COPY pom.xml .
   COPY src ./src
   RUN mvn clean package -DskipTests
   
   FROM eclipse-temurin:21
   WORKDIR /app
   COPY --from=builder /app/target/*.jar /app/app.jar
   EXPOSE 8084
   ENTRYPOINT ["java", "-jar", "app.jar"]
   ```

4. **Create `application.properties`:**
   ```properties
   spring.application.name=payment-service
   server.port=${PORT:8084}
   ```

5. **Create main application class:**
   ```java
   package com.paymentservice;
   
   @SpringBootApplication
   public class PaymentServiceApplication {
       public static void main(String[] args) {
           SpringApplication.run(PaymentServiceApplication.class, args);
       }
   }
   ```

6. **Add to `render.yaml`:**
   ```yaml
   - type: web
     name: devopsprac-payment-service
     runtime: docker
     dockerfilePath: ./services/payment-service/Dockerfile
     dockerContext: ./services/payment-service
     envVars:
       - key: PORT
         value: 8084
     healthCheckPath: /api/v1/payments/health
   ```

7. **Commit and push:**
   ```bash
   git add services/payment-service/
   git add render.yaml
   git commit -m "Add payment-service"
   git push origin main
   ```

## 🎯 Best Practices

### 1. **Naming Convention**
- Service directories: `kebab-case` (e.g., `user-service`)
- Render service names: `devopsprac-{service-name}`
- Java packages: `com.{servicename}`

### 2. **Port Management**
- Use different ports for each service (8081, 8082, 8083, etc.)
- Render will override with `PORT` environment variable
- Keep ports in `application.properties` for local development

### 3. **Independent Development**
- Each service can be developed independently
- Changes to one service don't affect others
- Each service has its own build process

### 4. **Version Control**
- Commit all services together
- Use meaningful commit messages
- Tag releases if needed

### 5. **Testing Locally**
```bash
# Test api-service
cd services/api-service
mvn spring-boot:run

# Test user-service (in another terminal)
cd services/user-service
mvn spring-boot:run
```

## 🔍 Troubleshooting

### Service won't deploy
- ✅ Check `dockerContext` path in `render.yaml`
- ✅ Verify `Dockerfile` exists in service directory
- ✅ Ensure `pom.xml` is correct
- ✅ Check Render logs for build errors

### Services can't communicate
- ✅ Use full Render URLs (`.onrender.com`)
- ✅ Set environment variables in `render.yaml`
- ✅ Check service names match in URLs

### Build fails
- ✅ Verify Java version matches (21)
- ✅ Check Maven dependencies
- ✅ Review Dockerfile syntax
- ✅ Check Render build logs

## 📊 Current Services

| Service | Directory | Port | Health Check | URL |
|---------|-----------|------|--------------|-----|
| API Service | `services/api-service/` | 8081 | `/api/v1/test` | `devopsprac-api.onrender.com` |
| User Service | `services/user-service/` | 8082 | `/api/v1/users/health` | `devopsprac-user-service.onrender.com` |
| Order Service | `services/order-service/` | 8083 | `/api/v1/orders/health` | `devopsprac-order-service.onrender.com` |

## 🚀 Quick Start

1. **Push to GitHub:**
   ```bash
   git add .
   git commit -m "Setup monorepo with microservices"
   git push origin main
   ```

2. **Deploy on Render:**
   - Go to [dashboard.render.com](https://dashboard.render.com)
   - Click "New +" → "Blueprint"
   - Connect your GitHub repository
   - Render will detect `render.yaml`
   - Click "Apply" to deploy all services

3. **Access your services:**
   - API: `https://devopsprac-api.onrender.com/api/v1/test`
   - Users: `https://devopsprac-user-service.onrender.com/api/v1/users`
   - Orders: `https://devopsprac-order-service.onrender.com/api/v1/orders`

## 📚 Additional Resources

- [Render Monorepo Documentation](https://render.com/docs/monorepo-support)
- [Render Multi-Service Architecture](https://render.com/docs/multi-service-architecture)
- [Spring Boot Documentation](https://spring.io/projects/spring-boot)

