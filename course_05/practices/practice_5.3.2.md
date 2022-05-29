# Practice 5.3.2: Understanding the Best Practices of Kubernetes Cluster

Caltech | _Center for Technology & Management Education_ | Simpl¡Learn <br/>
Post Graduate Program in DevOps <br/>
PG DO - Configuration Management with Ansible and Terraform <br/>

- Assigned to: Antonio Salazar Gomez ([antonio.salazar@ymail.com](mailto:antonio.salazar@ymail.com))
- Updated on:  2022-05-29 
- Github repo: [gitansalaza/devops/course_05/practices/practice_5.3.2.md](https://github.com/gitansalaza/devops/blob/main/course_05/practices/practice_5.3.2.md)

# DESCRIPTION
**Objective**: Understand the best practices of kubernetes cluster configuration

**Tools required**: kubeadm, kubectl, kubelet, and etcd

**Prerequisites**: A Kubernetes cluster should be set up (Follow the steps of Lesson 4 Demo 1)

Steps to be followed:
1. Placing all the configuration files in the same directory
2. Creating a single configuration file for related objects
<br/>

# Solution
## 1. Placing all the configuration files in the same directory

    - Create a directory to place all the configuration files

    >```
    > mkdir configfiles
    >```

    - Change to the new configuration directory

    >```
    > cd configfiles
    >```


## 2. Creating a single configuration file for related objects

```
vi kubesample.yaml
```
```
apiVersion: v1
kind: Service
metadata:
  name: redis
  labels:
    app: hello
    tier: backend
    role: master
  spec:
    ports:
      - port: 6379
      targetPort: 80
  selector:
    app: redis
    tier: backend
    role: master
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: redis-master
  spec:
  selector:
    matchLabels:
      app: redis
      role: master
      tier: backend
  replicas: 1
  template:
    metadata:
      labels:
        app: redis
        role: master
        tier: backend
    spec:
      containers:
        - name: master
          image: redis
          resources:
            requests:
              cpu: 100m
              memory: 100Mi
           ports:
        - containerPort: 6379
---
apiVersion: v1kind: Service
metadata:
name: redis-slave
labels:
app: redis
tier: backend
role: slave
spec:
ports:
- port: 6379
selector:
app: redis
tier: backend
role: slave
---
apiVersion: apps/v1
kind: Deployment
metadata:
name: redis-slave
spec:
selector:
matchLabels:
app: redis
role: slavetier: backend
replicas: 2
template:
metadata:
labels:
app: redis
role: slave
tier: backend
spec:
containers:
- name: slave
image: gcr.io/google_samples/gb-redisslave:v1
resources:
requests:
cpu: 100m
memory: 100Mi
env:
- name: GET_HOSTS_FROM
value: dns
ports:
- containerPort: 6379
---
apiVersion: v1
kind: Servicemetadata:
name: frontend
labels:
app: kubesample
tier: frontend
spec:
# comment or delete the following line if you want to use a LoadBalancer
type: NodePort
# if your cluster supports it, uncomment the following to automatically create
# an external load-balanced IP for the frontend service.
# type: LoadBalancer
ports:
- port: 80
selector:
app: kubesample
tier: frontend
---
apiVersion: apps/v1
kind: Deployment
metadata:
name: frontend
spec:
selector:
matchLabels:app: kubesample
tier: frontend
replicas: 3
template:
metadata:
labels:
app: kubesample
tier: frontend
spec:
containers:
- name: php-redis
image: gcr.io/google-samples/gb-frontend:v4
resources:
requests:
cpu: 100m
memory: 100Mi
env:
- name: GET_HOSTS_FROM
value: dns
ports:
- containerPort: 80
```

# Log file
[](logs/) 
