# go-bank

Simple Bank written with Golang, Postgres, Redis, Gin, gRPC, Docker, Kubernetes, AWS, CI/CD

## Tools Used

- [Golang](https://golang.org/)
- [PostgreSQL](https://www.postgresql.org/)
- [Docker](https://www.docker.com/)
- [TablePlus](https://tableplus.com/)
- [Golang-Migrate](https://github.com/golang-migrate/migrate)
- [sqlc](https://sqlc.dev/)
- [DBDiagram](https://dbdiagram.io/home)
- [Git](https://git-scm.com/)

## Languages

- [Golang](https://golang.org/)
- [SQL](https://en.wikipedia.org/wiki/SQL)
- [Markdown](https://en.wikipedia.org/wiki/Markdown)
- [Makefile](https://en.wikipedia.org/wiki/Makefile)
- [Dockerfile](https://en.wikipedia.org/wiki/Dockerfile)
- [Shell](https://en.wikipedia.org/wiki/Shell_script)
- [YAML](https://en.wikipedia.org/wiki/YAML)
- [JSON](https://en.wikipedia.org/wiki/JSON)
- [HTML](https://en.wikipedia.org/wiki/HTML)
- [CSS](https://en.wikipedia.org/wiki/CSS)
- [JavaScript](https://en.wikipedia.org/wiki/JavaScript)
- [TypeScript](https://en.wikipedia.org/wiki/TypeScript)
- [ReactJS](https://reactjs.org/)

## Deployment

- [Vanilla](ie. DigitalOcean, Linode, etc.)
- [AWS](https://aws.amazon.com/)

## How to run

### Docker

```bash
# Start the database
docker-compose up -d db

# Run the migrations
make migrate-up

# Start the server
make run
```

### Local

```bash
# Start the database
docker-compose up -d db

# Run the migrations
make migrate-up

# Start the server
make run
```

## How to test

```bash
# Run the tests
make test

# Run the tests with coverage
make test-coverage

# Run the tests with coverage and open the browser
make test-coverage-open
```

## How to build

```bash
# Build the binary
make build
```

## How to run the binary

```bash
# Run the binary
./bin/go-bank
```
