
--                            "id" bigserial PRIMARY KEY,
--                            "account_id" bigint NOT NULL,
--                            "amount" bigint NOT NULL,
--                            "created_at" timestamptz NOT NULL DEFAULT (now())

-- name: CreateEntry :one
INSERT INTO entries
(
    account_id,
    amount
)
VALUES
    ($1, $2)
RETURNING *;

-- name: GetEntry :one
SELECT * FROM entries WHERE id = $1 LIMIT 1;

-- name: ListEntry :many
SELECT * FROM entries
WHERE account_id = $1
ORDER BY id
LIMIT $2
OFFSET $3;

-- name: UpdateEntry :one
UPDATE entries
SET amount = $2
WHERE id = $1
RETURNING *;

-- name: DeleteEntry :exec
DELETE FROM entries WHERE id = $1;