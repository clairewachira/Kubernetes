Drug Dispensing System – Kubernetes Deployment
This project demonstrates how to containerize, deploy, and expose a Drug Dispensing System web application using Docker, Kubernetes, MySQL and Ingress.

Technologies Used
Docker
Kubernetes (via Docker Desktop)
MySQL
Persistent Volumes
Ingress NGINX Controller
PHP & Apache Web Server (XAMPP stack)

PROJECT STRUCTURE
project/
├── Dockerfile
├── KUBERNETES/
│   ├── deployment.yaml
│   ├── drugdispensing-service.yaml
│   ├── mysql-deployment.yaml
│   ├── service.yaml
│   ├── drugdispensing-ingress.yaml
└── app/        
Setup Steps
 Part 1: Containerize Your App
 1.Create a Dockerfile for the PHP application
 2.Build Docker image:
    docker build -t drugdispensing-app .

    
 Part 2: Create Deployment & Service
1.Create drugdispensing-deployment.yaml with app=drugdispensing.
2.Expose it using a service drugdispensing-service.yaml on port 80.
Apply:
kubectl apply -f k8s/drugdispensing-deployment.yaml
kubectl apply -f k8s/drugdispensing-service.yaml

 Part 3: Add MySQL Database
1.Create mysql-deployment.yaml using image mysql:5.7.
2.Set environment variables for MYSQL_ROOT_PASSWORD, MYSQL_DATABASE, etc.
3.Expose it using mysql-service.yaml.
Apply:
kubectl apply -f k8s/mysql-deployment.yaml
kubectl apply -f k8s/mysql-service.yaml
4.Make sure your app connects using: mysql
                                   DB_USER=root
                                   DB_PASSWORD=yourpassword

![Screenshot 2025-05-15 101140](https://github.com/user-attachments/assets/77274ebd-23e7-46c7-9306-3856025df395)

Part 4: Expose App Using Ingress
1.Install ingress-nginx controller:
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.10.1/deploy/static/provider/cloud/deploy.yaml
2.Create drugdispensing-ingress.yaml
3.Update your /etc/hosts or C:\Windows\System32\drivers\etc\hosts:
127.0.0.1 drugdispensing.local
Port forward:
kubectl port-forward -n ingress-nginx service/ingress-nginx-controller 8080:80
Access in browser:
http://drugdispensing.local:8080

  


 
