# E-Commerce React App

This repository contains a Dockerized React e-commerce application with separate environments for development and production. The app is deployed using Docker containers and monitored for health status.

---

## Repository

- GitHub Repo: [https://github.com/jpprakash4260/e-commerce-react-app.git](https://github.com/jpprakash4260/e-commerce-react-app.git)

---

## Docker Images

- Development Image: [jprakash2306/e-commerce-react-dev](https://hub.docker.com/repository/docker/jprakash2306/e-commerce-react-dev/general)
- Production Image: [jprakash2306/e-commerce-react-prod](https://hub.docker.com/repository/docker/jprakash2306/e-commerce-react-prod/general)

---

## Deployed Application URLs

- Production Site: [http://13.233.76.27:80](http://13.233.76.27:80)
- Development Site: [http://13.233.76.27:81](http://13.233.76.27:81)

---

## Features

- Separate dev and prod environments running on ports 81 and 80 respectively.
- Dockerized React app using Nginx to serve static files.
- CI/CD pipeline to build, push Docker images, and deploy containers based on branch.
- Monitoring and alerting setup with Prometheus, Alertmanager, and Grafana.

---

## How to Run

Clone the repo and use the provided Docker images or build your own:

```bash
# For development
docker run -d -p 81:80 jprakash2306/e-commerce-react-dev:latest

# For production
docker run -d -p 80:80 jprakash2306/e-commerce-react-prod:latest
