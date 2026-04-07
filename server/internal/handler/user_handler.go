package handler

import (
	userUseCase "expense/internal/usecase/user"
	"expense/pkg/response"
	"net/http"
)

type UserHandler struct {
	userUC *userUseCase.ProfileUseCase
}

func NewUserHandler(userUC *userUseCase.ProfileUseCase) *UserHandler {
	return &UserHandler{userUC}
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
		response.ResponseError(w, http.StatusBadRequest, "can not format user id")
		return
	}

	user, err := h.userUC.Excute(userID.(string))
	if err != nil {
		response.ResponseError(w, http.StatusBadRequest, err.Error())
		return
	}

	response.ResponseSuccess(w, http.StatusOK, user)
}
