package handler

import (
	"encoding/json"
	dto "expense/internal/dto/auth"
	authUseCase "expense/internal/usecase/auth"
	"expense/pkg/response"
	"net/http"
)

type AuthHandler struct {
	registerUC     *authUseCase.RegisterUseCase
	loginUC        *authUseCase.LoginUseCase
	refreshTokenUC *authUseCase.RefreshTokenUseCase
}

func NewAuthHandler(registerUC *authUseCase.RegisterUseCase, loginUC *authUseCase.LoginUseCase, refreshTokenUC *authUseCase.RefreshTokenUseCase) *AuthHandler {
	return &AuthHandler{registerUC, loginUC, refreshTokenUC}
}

// Register godoc
//
//	@Summary		Đăng ký tài khoản
//	@Description	Tạo mới người dùng với email, password
//	@Tags			Auth
//	@Accept			json
//	@Produce		json
//	@Param			request	body		dto.RegisterRequest	true	"Thông tin đăng ký"
//	@Success		201		{object}	response.Response{data=dto.MesssageResponse}
//	@Failure		400		{object}	response.Response
//	@Failure		500		{object}	response.Response
//	@Router			/auth/register [post]
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

// Login godoc
//
//	@Summary		Đăng nhập
//	@Tags			Auth
//	@Accept			json
//	@Produce		json
//	@Param			request	body		dto.LoginRequest	true	"Thông tin đăng nhập"
//	@Success		201		{object}	response.Response{data=dto.LoginResponse}
//	@Failure		400		{object}	response.Response
//	@Failure		500		{object}	response.Response
//	@Router			/auth/login [post]
func (h *AuthHandler) Login(w http.ResponseWriter, r *http.Request) {
	var input dto.LoginRequest
	if err := json.NewDecoder(r.Body).Decode(&input); err != nil {
		response.ResponseError(w, http.StatusBadRequest, err.Error())
		return
	}

	userResponse, tokenResponse, err := h.loginUC.Excute(input)
	if err != nil {
		response.ResponseError(w, http.StatusBadRequest, err.Error())
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
	var request dto.RefreshTokenRequest

	if err := json.NewDecoder(r.Body).Decode(&request); err != nil {
		response.ResponseError(w, http.StatusBadRequest, err.Error())
		return
	}

	tokenReponse, err := h.refreshTokenUC.Excute(request)
	if err != nil {
		response.ResponseError(w, http.StatusBadRequest, err.Error())
		return
	}

	response.ResponseSuccess(w, http.StatusCreated, tokenReponse)
}
