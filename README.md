# node-from-git

node-from-git is a Docker image that clones a Node.js project from git, installs and starts it.
It's a simple solution to dockerize your Node service or application. Both public and private git repositories are supported.

## Quick Start

Let's dockerize a small Node.js HTTP server that responds "Hello, world!" on port 8080. The source code of the server is available at `https://github.com/philipphenkel/node-hello-world.git`. Now pass the repository URL as an environment variable to the container as follows:

```console
docker run --rm -i -t -p 8080:8080 -e GIT_REPOSITORY=https://github.com/philipphenkel/node-hello-world.git henkel/docker-node-from-git:latest
```

That's it. At each start of container the specified git repository will be cloned. Afterwards `yarn install` and `yarn start` will be executed with `NODE_ENV=production`.


## Customized Start Command

`yarn start` is the image's default command and can be overwritten with your custom bash command sequence.  

The following Kubernetes yaml file installs, builds and serves an app using `yarn build && serve -s build`:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: talk-about-code
spec:
  selector:
    matchLabels:
      app: talk-about-code
  replicas: 1
  template:
    metadata:
      labels:
        app: talk-about-code
    spec:
      containers:
        - name: talk-about-code
          image: henkel/docker-node-from-git:latest
          ports:
          - containerPort: 5000
          args: ["yarn build && serve -s build"]
          env:
          - name: GIT_REPOSITORY
            value: "git@github.com:philipphenkel/talk-about-code.git"
          - name: GIT_BRANCH
            value: master
```

## Environment Variables

Variable | Description
-------- | -----------
`GIT_REPOSITORY` | The URL of the git repository, e.g. `GIT_REPOSITORY=https://github.com/philipphenkel/node-hello-world.git`
`GIT_BRANCH` | Specifies the branch or the tag to be checked out. Is `master` by default.
`GIT_SSH_KEY_BASE64` | Base64 encoded private SSH key for private read access to the git repository.


## License

Copyright (C) 2017-2018 Philipp Henkel

Licensed under the MIT License (MIT). See LICENSE file for more details.
