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
	refreshTokenUC := authUseCase.NewRefreshTokenUseCase(tokenService, refreshRepo)

	authHandler := handler.NewAuthHandler(registerUC, loginUC, refreshTokenUC)

	authRouter := mux.PathPrefix("/api/auth").Subrouter()
	authRouter.HandleFunc("/register", authHandler.Register).Methods(http.MethodPost)
	authRouter.HandleFunc("/login", authHandler.Login).Methods(http.MethodPost)
	authRouter.HandleFunc("/refresh", authHandler.RefreshToken).Methods(http.MethodPost)

	// authMiddleware := middleware.AuthMiddleware(tokenService)
	// authRouter.Use(authMiddleware)
}

func SetupAllRoutes(mux *mux.Router, db *gorm.DB, tokenService *security.TokenService) {
	setupAuthRoutes(mux, db, tokenService)
}
