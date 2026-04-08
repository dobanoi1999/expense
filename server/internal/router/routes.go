package router

import (
	"expense/internal/handler"
	"expense/internal/middleware"
	"expense/internal/repository/implementation"
	authUseCase "expense/internal/usecase/auth"
	userUseCase "expense/internal/usecase/user"
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
	logoutUC := authUseCase.NewLogoutUseCase(refreshRepo)

	authHandler := handler.NewAuthHandler(registerUC, loginUC, refreshTokenUC, logoutUC)

	authRouter := mux.PathPrefix("/api/auth").Subrouter()
	authRouter.HandleFunc("/register", authHandler.Register).Methods(http.MethodPost)
	authRouter.HandleFunc("/login", authHandler.Login).Methods(http.MethodPost)
	authRouter.HandleFunc("/refresh", authHandler.RefreshToken).Methods(http.MethodPost)

	authMiddleware := middleware.AuthMiddleware(tokenService)

	protectedAuthRouter := authRouter.PathPrefix("").Subrouter()
	protectedAuthRouter.Use(authMiddleware)
	protectedAuthRouter.HandleFunc("/logout", authHandler.Logout).Methods(http.MethodPost)
}

func setupUserRoutes(mux *mux.Router, db *gorm.DB, tokenService *security.TokenService) {
	userRepo := implementation.NewGormUserImplement(db)

	profileUserUC := userUseCase.NewProfileUseCase(userRepo)
	updateUserUC := userUseCase.NewUpdateUserUseCase(userRepo)

	userHandler := handler.NewUserHandler(profileUserUC, updateUserUC)

	authRouter := mux.PathPrefix("/api/users").Subrouter()
	authMiddleware := middleware.AuthMiddleware(tokenService)
	authRouter.Use(authMiddleware)
	authRouter.HandleFunc("/me", userHandler.GetProfile).Methods(http.MethodGet)
	authRouter.HandleFunc("/me", userHandler.UpdateUser).Methods(http.MethodPut)
}

func SetupAllRoutes(mux *mux.Router, db *gorm.DB, tokenService *security.TokenService) {
	setupAuthRoutes(mux, db, tokenService)
	setupUserRoutes(mux, db, tokenService)
}
