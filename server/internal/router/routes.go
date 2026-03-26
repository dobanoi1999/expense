package router

import (
	"expense/internal/handler"
	"expense/internal/repository/implementation"
	authUseCase "expense/internal/usecase/auth"
	"net/http"

	"github.com/gorilla/mux"
	"gorm.io/gorm"
)

func SetupAllRoutes(mux *mux.Router, db *gorm.DB) {
	userRepo := implementation.NewGormUserImplement(db)

	registerUC := authUseCase.NewRegisterUseCase(userRepo)

	authHandler := handler.NewAuthHandler(registerUC)

	authRouter := mux.PathPrefix("/api/auth").Subrouter()
	authRouter.HandleFunc("/register", authHandler.Register).Methods(http.MethodPost)
}
