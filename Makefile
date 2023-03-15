rm-postgres:
	docker stop postgres15
	docker rm postgres15

postgres:
	docker run --name postgres15 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:15-alpine

createdb:
	docker exec -it postgres15 createdb --username=root --owner=root simple_bank

wait-for-createdb:
	timeout 4

dropdb:
	docker exec -it postgres15 dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down

sqlc-generate:
	docker run --rm -v "C:\Users\Medo\OneDrive\Desktop\Projects\go-backend:/src" -w /src kjconroy/sqlc generate

test:
	go test -v -cover ./...

prepare: rm-postgres postgres wait-for-createdb createdb wait-for-createdb migrateup

.PHONY: rm-postgres createdb dropdb postgres migrateup migratedown sqlc-generate test