package handler

import (
	authUseCase "expense/internal/usecase/auth"
	"net/http"
)

type AuthHandler struct {
	registerUC *authUseCase.RegisterUseCase
}

func NewAuthHandler(registerUC *authUseCase.RegisterUseCase) *AuthHandler {
	return &AuthHandler{registerUC}
}

func (h *AuthHandler) Register(w http.ResponseWriter, r *http.Request) {

}
