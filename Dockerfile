# Use Nginx base image to serve static files
FROM nginx:alpine

# Copy built React files to Nginx public directory
COPY build/ /usr/share/nginx/html

# Configure Nginx for SPA routing
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
