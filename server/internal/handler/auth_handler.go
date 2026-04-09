package handler

import (
	"encoding/json"
	dto "expense/internal/dto/auth"
	authUseCase "expense/internal/usecase/auth"
	"expense/pkg/response"
	customValidator "expense/pkg/validator"
	"net/http"
)

type AuthHandler struct {
	registerUC     *authUseCase.RegisterUseCase
	loginUC        *authUseCase.LoginUseCase
	refreshTokenUC *authUseCase.RefreshTokenUseCase
	logoutUseCase  *authUseCase.LogoutUseCase
}

func NewAuthHandler(registerUC *authUseCase.RegisterUseCase, loginUC *authUseCase.LoginUseCase, refreshTokenUC *authUseCase.RefreshTokenUseCase, logoutUseCase *authUseCase.LogoutUseCase) *AuthHandler {
	return &AuthHandler{registerUC, loginUC, refreshTokenUC, logoutUseCase}
}

// Register godoc
//
//	@Summary		Đăng ký tài khoản
//	@Description	Tạo mới người dùng với email, password
//	@Tags			Auth
//	@Accept			json
//	@Produce		json
//	@Param			request	body		dto.RegisterRequest	true	"Thông tin đăng ký"
//	@Success		201		{object}	response.Response{data=dto.MessageResponse}
//	@Failure		400		{object}	response.Response
//	@Failure		500		{object}	response.Response
//	@Router			/auth/register [post]
func (h *AuthHandler) Register(w http.ResponseWriter, r *http.Request) {
	var input dto.RegisterRequest
	if err := json.NewDecoder(r.Body).Decode(&input); err != nil {
		response.ResponseError(w, http.StatusBadRequest, err)
		return
	}

	if err := h.registerUC.Execute(input); err != nil {
		response.ResponseError(w, http.StatusBadRequest, err)
		return
	}

	response.ResponseSuccess(w, http.StatusCreated, dto.MessageResponse{
		Message: "user registed successfully",
	})

}

// Login godoc
//
//	@Summary		Đăng nhập
//	@Tags			Auth
//	@Accept			json
//	@Produce		json
//	@Param			request	body		dto.LoginRequest true	"Thông tin đăng nhập"
//	@Success		201		{object}	response.Response{data=dto.LoginResponse}
//	@Failure		400		{object}	response.Response
//	@Failure		500		{object}	response.Response
//	@Router			/auth/login [post]
func (h *AuthHandler) Login(w http.ResponseWriter, r *http.Request) {
	var input dto.LoginRequest
	if err := json.NewDecoder(r.Body).Decode(&input); err != nil {
		response.ResponseError(w, http.StatusBadRequest, err)
		return
	}

	if err := customValidator.ValidateStruct(input); err != nil {
		response.ResponseError(w, http.StatusBadRequest, err)
		return
	}

	userResponse, tokenResponse, err := h.loginUC.Execute(input)
	if err != nil {
		response.ResponseError(w, http.StatusInternalServerError, err)
		return
	}

	response.ResponseSuccess(w, http.StatusCreated, dto.LoginResponse{
		Tokens: tokenResponse,
		User:   userResponse,
	})

}

// RefreshToken godoc
//
//	@Summary		Get access token
//	@Tags			Auth
//	@Accept			json
//	@Produce		json
//	@Param			request	body		dto.RefreshTokenRequest	true	"create access token"
//	@Success		201		{object}	response.Response{data=dto.TokenResponse}
//	@Failure		400		{object}	response.Response
//	@Failure		500		{object}	response.Response
//	@Router			/auth/refresh [post]
func (h *AuthHandler) RefreshToken(w http.ResponseWriter, r *http.Request) {
	var input dto.RefreshTokenRequest

	if err := json.NewDecoder(r.Body).Decode(&input); err != nil {
		response.ResponseError(w, http.StatusBadRequest, err)
		return
	}

	if err := customValidator.ValidateStruct(input); err != nil {
		response.ResponseError(w, http.StatusBadRequest, err)
		return
	}

	tokenResponse, err := h.refreshTokenUC.Execute(input)
	if err != nil {
		response.ResponseError(w, http.StatusBadRequest, err)
		return
	}

	response.ResponseSuccess(w, http.StatusCreated, tokenResponse)
}

// Logout godoc
//
//	@Summary		Logout
//	@Tags			Auth
//	@Accept			json
//	@Produce		json
//	@Security		BearerAuth
//	@Success		200		{object}	response.Response{dto.MesssageResponse}
//	@Failure		400		{object}	response.Response
//	@Failure		500		{object}	response.Response
//	@Router			/auth/logout [post]
func (h *AuthHandler) Logout(w http.ResponseWriter, r *http.Request) {
	userID := r.Context().Value("user_id")
	if err := h.logoutUseCase.Execute(userID.(string)); err != nil {
		response.ResponseError(w, http.StatusBadRequest, err)
		return
	}

	response.ResponseSuccess(w, http.StatusCreated, dto.MessageResponse{
		Message: "logout successfully",
	})
}
