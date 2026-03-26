expense-tracker-api/
├── cmd/http/
│ └── main.go
├── internal/
│ ├── entity/ ← Entities: Pure business logic
│ │ ├── user.go
│ │ ├── expense.go
│ │ └── category.go
│ ├── usecase/ ← Use Cases: Business rules orchestration
│ │ ├── auth/
│ │ │ ├── register.go
│ │ │ ├── login.go
│ │ │ └── interfaces.go
│ │ └── expense/
│ │ ├── create_expense.go
│ │ └── interfaces.go
│ ├── repository/ ← Repository: Data access abstraction
│ │ ├── user_repository.go
│ │ ├── expense_repository.go
│ │ └── implementations/
│ │ ├── gorm_user.go
│ │ └── gorm_expense.go
│ ├── handler/ ← Handlers: HTTP entry points
│ │ ├── auth_handler.go
│ │ └── expense_handler.go
│ ├── dto/ ← DTOs: Request/Response objects
│ │ ├── auth_dto.go
│ │ └── expense_dto.go
│ ├── presenter/ ← Presenter: Format output
│ │ ├── auth_presenter.go
│ │ └── expense_presenter.go
│ ├── middleware/ ← Middleware: Cross-cutting concerns
│ │ ├── auth_middleware.go
│ │ └── logger_middleware.go
│ ├── router/ ← Routes: Wiring & dependency injection
│ │ └── routes.go
│ └── model/ ← DB Models: Database schema only
│ ├── user.go
│ └── expense.go
├── pkg/
│ ├── database/
│ ├── response/
│ ├── security/
│ ├── logger/
│ └── errors/
└── configs/
