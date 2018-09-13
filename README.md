# k8s-test

A sample application developed to test k8s.

It is a basic Flask HTTP server having two routes:

- The main route `/` has to be considered the 'main' application. It does return a simple 'Hello World' message
- The `/health` route is the healthcheck route used by K8S to verify if the application is responsive. It has been structured to return with an HTTP 500 error after 60 seconds, simulating the application to be unresponsive

## Available commands

To simplify the usage of the application, a convenient `Makefile` is available.
Available commands are:

- `make build`: builds and tags the Docker image
- `make push`: pushes the Docker image to Docker hub
- `make build-and-push`: build & pushes the image in a single command
- `make run`: executes the application on the local Kubernetes cluster
- `make stop`: stops and removes the application from Kubernetes cluster

`build`, `push`, `build-and-push` and `run` commands do support a `VERSION` environment variable, which should be used to specify a version of the application to build and run.

Example:

`VERSION=2.0 make build-and-push` will build and push the application with the tag `2.0`.