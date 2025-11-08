# DevopsPrac - Microservices Monorepo

A Spring Boot microservices architecture deployed on Render.com, organized as a monorepo.

## 🏗️ Architecture

This repository contains multiple microservices, each in its own subdirectory:

- **api-service** - Main API service
- **user-service** - User management microservice
- **order-service** - Order management microservice

## 📁 Repository Structure

```
DevopsPrac/
├── services/
│   ├── api-service/          # Main API service
│   ├── user-service/         # User management service
│   └── order-service/        # Order management service
├── render.yaml               # Render deployment configuration
└── README.md
```

## 🚀 Quick Start

### Local Development

1. **Run a service:**
   ```bash
   cd services/api-service
   mvn spring-boot:run
   ```

2. **Access the service:**
   - API: http://localhost:8081/api/v1/test
   - User Service: http://localhost:8082/api/v1/users
   - Order Service: http://localhost:8083/api/v1/orders

### Deployment to Render

1. **Push to GitHub:**
   ```bash
   git add .
   git commit -m "Deploy microservices"
   git push origin main
   ```

2. **Deploy via Render Dashboard:**
   - Go to [dashboard.render.com](https://dashboard.render.com)
   - Click "New +" → "Blueprint"
   - Connect your repository
   - Render will auto-detect `render.yaml`
   - Click "Apply"

3. **Services will be available at:**
   - API: `https://devopsprac-api.onrender.com/api/v1/test`
   - User Service: `https://devopsprac-user-service.onrender.com/api/v1/users`
   - Order Service: `https://devopsprac-order-service.onrender.com/api/v1/orders`

## 📖 Documentation

- **[MONOREPO.md](./MONOREPO.md)** - Complete guide on monorepo structure and adding new services
- **[DEPLOYMENT.md](./DEPLOYMENT.md)** - Detailed deployment instructions

## 🛠️ Tech Stack

- **Java 21**
- **Spring Boot 3.5.7**
- **Maven**
- **Docker**
- **Render.com** (Hosting)

## 📝 Adding a New Microservice

See [MONOREPO.md](./MONOREPO.md) for detailed instructions on adding new microservices to this monorepo.

## 🔗 Service Endpoints

### API Service
- `GET /api/v1/test` - Health check

### User Service
- `GET /api/v1/users/health` - Health check
- `GET /api/v1/users` - Get users

### Order Service
- `GET /api/v1/orders/health` - Health check
- `GET /api/v1/orders` - Get orders

## 📄 License

This is a demo project for DevOps practice.

