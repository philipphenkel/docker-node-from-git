node-from-git
=============

node-from-git is a Docker image that clones a Node.js project from git, installs and starts it.
It's a simple solution to dockerize your Node service or application. Both public and private git repositories are supported.

Quick Start
-----------

Let's dockerize a small Node.js HTTP server that responds "Hello, world!" on port 8080. The source code of the server is available at `https://github.com/philipphenkel/node-hello-world.git`

```console
docker run --rm -i -t -p 8080:8080 -e GIT_REPOSITORY=https://github.com/philipphenkel/node-hello-world.git henkel/docker-node-from-git:latest
```

That's all. At each start of container the specified git repository will be cloned. Afterwards `yarn install` and `yarn start` will be executed with `NODE_ENV=production`.


Environment Variables
---------------------
Variable | Description
-------- | -----------
`GIT_REPOSITORY` | The URL of the git repository, e.g. `GIT_REPOSITORY=https://github.com/philipphenkel/node-hello-world.git`
`GIT_BRANCH` | Specifies the branch to be checked out. `master` by default.
`GIT_SSH_KEY_BASE64` | Base64 encoded private SSH key for private read access to the git repository.


License
-------

Copyright (C) 2017 Philipp Henkel

Licensed under the MIT License (MIT). See LICENSE file for more details.
