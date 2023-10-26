DB_URL=postgresql://root:secret@localhost:5432/go-bank?sslmode=disable

# connectes to AWS SecretsManager to obtain the variables (JSON), convert and save them as app.env file
sync-env:
	aws secretsmanager get-secret-value --secret-id go-bank --query SecretString --output text | jq 'to_entries|map("\(.key)=\(.value)")|.[]' -r > app.env

# build docker image
docker:
	docker build -t go-bank .

# create docker network
network:
	docker network create bank-network

# run postgres container
postgres:
	docker run --name postgres --network bank-network -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:14-alpine

# run mysql container
mysql:
	docker run --name mysql8 -p 3306:3306  -e MYSQL_ROOT_PASSWORD=secret -d mysql:8

# creates the database
createdb:
	docker exec -it postgres createdb --username=root --owner=root go-bank

# drops the database
dropdb:
	docker exec -it postgres dropdb go-bank

# runs the migrations
migrateup:
	migrate -path db/migration -database "$(DB_URL)" -verbose up

migrateup1:
	migrate -path db/migration -database "$(DB_URL)" -verbose up 1

migratedown:
	migrate -path db/migration -database "$(DB_URL)" -verbose down

migratedown1:
	migrate -path db/migration -database "$(DB_URL)" -verbose down 1

new_migration:
	migrate create -ext sql -dir db/migration -seq $(name)

# generates the documentation
db_docs:
	dbdocs build doc/db.dbml

# generates the schema
db_schema:
	dbml2sql --postgres -o doc/schema.sql doc/db.dbml

# generates the sqlc code
sqlc:
	sqlc generate

# runs the tests
test:
	go test -v -cover -short ./...

# runs the server
server:
	go run main.go

# generates the mocks
mock:
	mockgen -package mockdb -destination db/mock/store.go go-bank/db/sqlc Store
	mockgen -package mockwk -destination worker/mock/distributor.go go-bank/worker TaskDistributor

# generates the proto files
proto:
	rm -f pb/*.go
	rm -f doc/swagger/*.swagger.json
	protoc --proto_path=proto --go_out=pb --go_opt=paths=source_relative \
	--go-grpc_out=pb --go-grpc_opt=paths=source_relative \
	--grpc-gateway_out=pb --grpc-gateway_opt=paths=source_relative \
	--openapiv2_out=doc/swagger --openapiv2_opt=allow_merge=true,merge_file_name=go-bank \
	proto/*.proto
	statik -src=./doc/swagger -dest=./doc

# runs the evans cli
evans:
	evans --host localhost --port 9090 -r repl

# runs the redis container
redis:
	docker run --name redis -p 6379:6379 -d redis:7-alpine

.PHONY: sync-env docker network postgres createdb dropdb migrateup migratedown migrateup1 migratedown1 new_migration db_docs db_schema sqlc test server mock proto evans redis
