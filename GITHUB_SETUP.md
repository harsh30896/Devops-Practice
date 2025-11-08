# GitHub Setup Guide - Monorepo

## 🚀 Quick Steps to Push Multiple Microservices to One Repository

### Step 1: Initialize Git (if not already done)

```bash
# Check if git is initialized
git status

# If not initialized, run:
git init
```

### Step 2: Add Remote Repository

```bash
# Replace with your GitHub repository URL
git remote add origin https://github.com/yourusername/your-repo-name.git

# Or if remote already exists, verify it:
git remote -v
```

### Step 3: Stage All Files

```bash
# Add all files including the new services directory
git add .

# Check what will be committed
git status
```

### Step 4: Commit Changes

```bash
git commit -m "Setup monorepo: Add api-service, user-service, and order-service"
```

### Step 5: Push to GitHub

```bash
# First time push
git push -u origin main

# Subsequent pushes
git push origin main
```

## 📦 What Gets Pushed

Your repository structure on GitHub will be:

```
your-repo/
├── services/
│   ├── api-service/
│   │   ├── src/
│   │   ├── pom.xml
│   │   ├── Dockerfile
│   │   └── ...
│   ├── user-service/
│   │   ├── src/
│   │   ├── pom.xml
│   │   ├── Dockerfile
│   │   └── ...
│   └── order-service/
│       ├── src/
│       ├── pom.xml
│       ├── Dockerfile
│       └── ...
├── render.yaml
├── README.md
├── MONOREPO.md
└── .gitignore
```

## 🔄 Adding a New Microservice Later

### 1. Create the service directory and files
```bash
mkdir -p services/payment-service/src/main/java/com/paymentservice
# ... create your service files
```

### 2. Update render.yaml
Add the new service configuration to `render.yaml`

### 3. Commit and push
```bash
git add services/payment-service/
git add render.yaml
git commit -m "Add payment-service microservice"
git push origin main
```

## ✅ Verify on GitHub

After pushing, check your GitHub repository:
1. Go to `https://github.com/yourusername/your-repo-name`
2. You should see:
   - `services/` directory
   - `render.yaml` file
   - All service subdirectories

## 🎯 Render Deployment

Once pushed to GitHub:

1. **Go to Render Dashboard:**
   - Visit [dashboard.render.com](https://dashboard.render.com)

2. **Create Blueprint:**
   - Click "New +" → "Blueprint"
   - Connect your GitHub repository
   - Render will detect `render.yaml`

3. **Deploy:**
   - Review the services (api-service, user-service, order-service)
   - Click "Apply"
   - Render will deploy all 3 services automatically!

## 🔍 Troubleshooting

### "Repository not found"
- Check your repository URL
- Verify you have push access
- Make sure the repository exists on GitHub

### "Nothing to commit"
- Check if files are already committed
- Verify `.gitignore` isn't excluding your files
- Check `git status`

### Render can't find services
- Verify `render.yaml` paths are correct
- Check that `dockerContext` points to the right directory
- Ensure Dockerfiles exist in each service directory

## 📝 Git Commands Cheat Sheet

```bash
# Check status
git status

# Add all changes
git add .

# Commit
git commit -m "Your message"

# Push
git push origin main

# Pull latest changes
git pull origin main

# View commit history
git log

# Create a new branch
git checkout -b feature/new-service
```

## 🎉 Success!

Once pushed, your monorepo is ready for:
- ✅ Multiple microservices in one repository
- ✅ Independent service development
- ✅ Single deployment configuration
- ✅ Easy service-to-service communication

