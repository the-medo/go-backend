DB_URL=postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable

rm-postgres:
	docker stop postgres15
	docker rm postgres15

postgres:
	docker run --name postgres15 --network go-backend-network -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:15-alpine

createdb:
	docker exec -it postgres15 createdb --username=root --owner=root simple_bank

wait-for-createdb:
	timeout 4

dropdb:
	docker exec -it postgres15 dropdb simple_bank

migrateup:
	migrate -path db/migration -database "$(DB_URL)" -verbose up

migrateup1:
	migrate -path db/migration -database "$(DB_URL)" -verbose up 1

migratedown:
	migrate -path db/migration -database "$(DB_URL)" -verbose down

migratedown1:
	migrate -path db/migration -database "$(DB_URL)" -verbose down 1

sqlc-generate:
	docker run --rm -v "C:\Users\Medo\OneDrive\Desktop\Projects\go-backend:/src" -w /src kjconroy/sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/the-medo/go-backend/db/sqlc Store

db_docs:
	dbdocs password --set secret --project simple_bank

db_schema:
	dbml2sql --postgres -o doc/schema.sql doc/db.dbml

proto_win:
	del /Q pb\*.pb.go
	protoc --proto_path=proto --go_out=pb --go_opt=paths=source_relative --go-grpc_out=pb --go-grpc_opt=paths=source_relative proto/*.proto

proto_linux:
	rm -f pb/*.pb.go
	protoc --proto_path=proto --go_out=pb --go_opt=paths=source_relative --go-grpc_out=pb --go-grpc_opt=paths=source_relative proto/*.proto

evans:
	evans --host localhost --port 9090 -r repl

prepare: rm-postgres postgres wait-for-createdb createdb wait-for-createdb migrateup

.PHONY: rm-postgres createdb dropdb postgres migrateup migratedown sqlc-generate test mock migrateup1 migratedown1 db_docs db_schema proto_win proto_linux evans