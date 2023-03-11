--                              "id" bigserial PRIMARY KEY,
--                              "from_account_id" bigint NOT NULL,
--                              "to_account_id" bigint NOT NULL,
--                              "amount" bigint NOT NULL,
--                              "created_at" timestamptz NOT NULL DEFAULT (now())

-- name: CreateTransfer :one
INSERT INTO transfers
(
    from_account_id,
    to_account_id,
    amount,
    created_at
)
VALUES
    ($1, $2, $3, $4)
RETURNING *;

-- name: GetTransfer :one
SELECT * FROM transfers WHERE id = $1 LIMIT 1;

-- name: ListTransferFromAccount :many
SELECT * FROM transfers
WHERE from_account_id = $1
ORDER BY id
LIMIT $2
    OFFSET $3;

-- name: ListTransferToAccount :many
SELECT * FROM transfers
WHERE to_account_id = $1
ORDER BY id
LIMIT $2
OFFSET $3;

-- name: UpdateTransfer :one
UPDATE transfers
SET amount = $2
WHERE id = $1
RETURNING *;

-- name: DeleteTransfer :exec
DELETE FROM transfers WHERE id = $1;