#!/bin/bash

# Create necessary directories
mkdir -p apps/web/src/app
mkdir -p apps/web/src/components
mkdir -p apps/web/src/lib
mkdir -p apps/api/src/controllers
mkdir -p apps/api/src/middleware
mkdir -p apps/api/src/routes
mkdir -p apps/api/src/utils
mkdir -p apps/api/src/lib
mkdir -p packages/common/src

# Install dependencies
pnpm install

# Initialize Prisma
cd apps/api
pnpm prisma generate
cd ../..

# Start development environment
docker-compose up -d

# Wait for services to be ready
echo "Waiting for services to be ready..."
sleep 10

# Run database migrations
cd apps/api
pnpm prisma migrate dev --name init
cd ../..

echo "Project initialization complete!"
echo "You can now start the development servers:"
echo "1. Frontend: cd apps/web && pnpm dev"
echo "2. Backend: cd apps/api && pnpm dev" 