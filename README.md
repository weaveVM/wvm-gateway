![logo](https://raw.githubusercontent.com/weaveVM/.github/main/profile/bg.png)

## About
This repository is an implementation of the [ar-io-node](https://github.com/ar-io/ar-io-node) gateway's codebase, offering a tailored implementation designed to provide the weaveVM (WVM) with scalability and high-performance access to the Permaweb.

## Dev Workflow

```console
yarn install // install dependencies

yarn db:migrate up // initialize the SQLite DB

yarn lint:check // run lint check

yarn test // run the tests

yarn start

```

Starting at an arbitrary block (only works immediately after initial DB
migration):

`START_HEIGHT=888888 yarn start`

## Dev Docs

## Docker

### Standalone AR.IO Node

You can run the ar.io gateway as a standalone docker container:

```shell
docker build . -t ar-io-core:latest
docker run -p 4000:4000 -v ar-io-data:/app/data ar-io-core:latest
```

To run with a specified start height (sets height on first run only):

```shell
docker run -e START_HEIGHT=800000 -v $PWD/data/:/app/data ar-io-core:latest
```

### Envoy & AR.IO Node

You can also run [Envoy] along side an `ar.io` node via [Docker Compose]. Envoy
will proxy routes to `arweave.net` not yet implemented in the ar.io node.

```shell
docker compose up --build
```

or:

```shell
docker-compose up --build
```

Once running, requests can be directed to Envoy server at `localhost:3000`.

## Credits
This repository is an implementation of the [ar-io-node codebase](https://github.com/ar-io/ar-io-node) and is licensed under the [GNU License](./LICENSE)