package handler

import (
	"encoding/json"
	"errors"
	dto "expense/internal/dto/auth"
	userUseCase "expense/internal/usecase/user"
	"expense/pkg/response"
	customValidator "expense/pkg/validator"
	"net/http"
)

type UserHandler struct {
	profileUserUC *userUseCase.ProfileUseCase
	updateUserUC  *userUseCase.UpdateUserUseCase
}

func NewUserHandler(profileUserUC *userUseCase.ProfileUseCase, updateUserUC *userUseCase.UpdateUserUseCase) *UserHandler {
	return &UserHandler{profileUserUC, updateUserUC}
}

// Me godoc
//
//	@Summary		Get user profile
//	@Tags			Users
//	@Accept			json
//	@Produce		json
//	@Security		BearerAuth
//	@Success		201		{object}	response.Response{data=dto.UserResponse}
//	@Failure		400		{object}	response.Response
//	@Failure		500		{object}	response.Response
//	@Router			/users/me [get]
func (h UserHandler) GetProfile(w http.ResponseWriter, r *http.Request) {
	userID := r.Context().Value("user_id")
	if _, oke := userID.(string); !oke {
		response.ResponseError(w, http.StatusBadRequest, errors.New("can not format user id"))
		return
	}

	user, err := h.profileUserUC.Excute(userID.(string))
	if err != nil {
		response.ResponseError(w, http.StatusBadRequest, err)
		return
	}

	response.ResponseSuccess(w, http.StatusOK, user)
}

// Update godoc
//
//	@Summary		Update user profile
//	@Tags			Users
//	@Accept			json
//	@Produce		json
//	@Security		BearerAuth
//	@Param			request	body		dto.UpdateUserRequest true	"Thông tin user"
//	@Success		201		{object}	response.Response{data=dto.UserResponse}
//	@Failure		400		{object}	response.Response
//	@Failure		500		{object}	response.Response
//	@Router			/users/me [put]
func (h UserHandler) UpdateUser(w http.ResponseWriter, r *http.Request) {
	userID := r.Context().Value("user_id")
	if _, oke := userID.(string); !oke {
		response.ResponseError(w, http.StatusBadRequest, errors.New("can not format user id"))
		return
	}

	var input dto.UpdateUserRequest
	if err := json.NewDecoder(r.Body).Decode(&input); err != nil {
		response.ResponseError(w, http.StatusBadRequest, err)
		return
	}

	if err := customValidator.ValidateStruct(input); err != nil {
		response.ResponseError(w, http.StatusBadRequest, err)
		return
	}

	user, err := h.updateUserUC.Excute(userID.(string), input)
	if err != nil {
		response.ResponseError(w, http.StatusBadRequest, err)
		return
	}

	response.ResponseSuccess(w, http.StatusOK, user)
}
