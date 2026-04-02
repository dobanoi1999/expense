package router

import (
	"expense/internal/handler"
	"expense/internal/repository/implementation"
	authUseCase "expense/internal/usecase/auth"
	security "expense/pkg/scurity"
	"net/http"

	"github.com/gorilla/mux"
	"gorm.io/gorm"
)

func setupAuthRoutes(mux *mux.Router, db *gorm.DB, tokenService *security.TokenService) {
	userRepo := implementation.NewGormUserImplement(db)
	refreshRepo := implementation.NewGormRefreshtokenImplement(db)

	registerUC := authUseCase.NewRegisterUseCase(userRepo)
	loginUC := authUseCase.NewLoginUseCase(userRepo, refreshRepo, tokenService)

	authHandler := handler.NewAuthHandler(registerUC, loginUC)

	authRouter := mux.PathPrefix("/api/auth").Subrouter()
	authRouter.HandleFunc("/register", authHandler.Register).Methods(http.MethodPost)
	authRouter.HandleFunc("/login", authHandler.Login).Methods(http.MethodPost)
}

func SetupAllRoutes(mux *mux.Router, db *gorm.DB, tokenService *security.TokenService) {
	setupAuthRoutes(mux, db, tokenService)
}
