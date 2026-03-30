package handler

import (
	"encoding/json"
	dto "expense/internal/dto/auth"
	authUseCase "expense/internal/usecase/auth"
	"expense/pkg/response"
	"net/http"
)

type AuthHandler struct {
	registerUC *authUseCase.RegisterUseCase
}

func NewAuthHandler(registerUC *authUseCase.RegisterUseCase) *AuthHandler {
	return &AuthHandler{registerUC}
}

func (h *AuthHandler) Register(w http.ResponseWriter, r *http.Request) {
	var input dto.RegisterRequest
	if err := json.NewDecoder(r.Body).Decode(&input); err != nil {
		response.ResponseError(w, http.StatusBadRequest, err.Error())
		return
	}

	if err := h.registerUC.Excute(input); err != nil {
		response.ResponseError(w, http.StatusBadRequest, err.Error())
		return
	}

	response.ResponseSuccess(w, http.StatusCreated, dto.MesssageResponse{
		Message: "user registed sucessfully",
	})

}
