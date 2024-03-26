# Example to-do List Application

This repository is a simple to-do list manager that runs on Node.js.

## Getting started

Download [Docker Desktop](https://www.docker.com/products/docker-desktop) for Mac or Windows. Docker Compose will be automatically installed. 
On Linux, make sure you have the latest version of [Compose](https://docs.docker.com/compose/install/).

## Clone the repository

Open a terminal and clone this sample application.

```
 git clone https://github.com/dockersamples/todo-list-app
```

## Run the app

Navigate into the todo-list-app directory:

```
docker compose up -d --build
```

The to-do list app will be running at http://localhost:3000.

 
When you run this command, you should see an output like this:

```
[+] Running 4/4
✔ app 3 layers [⣿⣿⣿]      0B/0B            Pulled           7.1s
  ✔ e6f4e57cc59e Download complete                          0.9s
  ✔ df998480d81d Download complete                          1.0s
  ✔ 31e174fedd23 Download complete                          2.5s
[+] Running 2/4
  ⠸ Network todo-list-app_default           Created         0.3s
  ⠸ Volume "todo-list-app_todo-mysql-data"  Created         0.3s
  ✔ Container todo-list-app-app-1           Started         0.3s
  ✔ Container todo-list-app-mysql-1         Started         0.3s


