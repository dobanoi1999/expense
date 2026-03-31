connectString =postgres://postgres:root@127.0.0.1:5432/expense?sslmode=disable
# chạy migrate lên hết
migrate-up:
	migrate -path migrations -database "$(connectString)" up

# rollback xuống 1 step
migrate-down:
	migrate -path migrations -database "$(connectString)" down 1

# force version (dùng khi migrate lỗi kẹt version)
migrate-force:
	migrate -path migrations -database "$(connectString)" force 1

# tạo file migration mới
new-migration:
	@if [ -z "$(name)" ]; then \
		echo "❌ Please provide a migration name: make new-migration name=create_users_table"; \
		exit 1; \
	fi
	migrate create -ext sql -dir migrations -seq $(name)
doc:
	swag init -g ./cmd/http/main.go -o ./docs
