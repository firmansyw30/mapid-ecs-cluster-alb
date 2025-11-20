# Project Architecture

This repository documents my cluster while working as a DevOps Engineer at MAPID. Since previously using VM based on lightsail with many downtime.
My approach is to design scalable and maintanable infrastructure.  

---

## 📐 Architecture Overview

The system is designed with the following principles:
- **Scalability**: Components can grow independently without bottlenecks.
- **Security**: IAM policies and least-privilege access are enforced.
- **Observability**: Metrics, logs, and alerts are centralized for actionable insights.
- **Cost Optimization**: Resources are provisioned efficiently to balance performance and expenses.

---

## 🖼️ Architecture Diagram

![Architecture Diagram](https://image2url.com/images/1763631958987-7bc8c626-f46f-4ca4-8dca-02c76240087a.png)

---

## ⚙️ Key Components

- **DNS Management (Route 53)**  
  Provides domain resolution and stability, replacing Elastic IPs for cost efficiency.

- **Compute Layer (EC2 / Spot Instances)**  
  Optimized for performance and cost, with fallback strategies for reliability.

- **Observability Stack (Grafana + Prometheus)**  
  Enables monitoring, alerting, and actionable dashboards for system health.

- **Automation**  
  Infrastructure tasks (DNS updates, alerting workflows) are automated for consistency and reduced manual overhead.

---

## 🚀 Getting Started

1. Clone this repository:
   ```bash
   git clone https://github.com/your-org/your-repo.git
