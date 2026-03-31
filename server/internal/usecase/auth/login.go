package auth

import (
	"errors"
	dto "expense/internal/dto/auth"
	"expense/internal/repository"
	security "expense/pkg/scurity"
)

type LoginUseCase struct {
	userRepo     repository.UserRepository
	tokenService security.TokenService
}

func NewLoginUseCase(userRepo repository.UserRepository, tokenService security.TokenService) *LoginUseCase {
	return &LoginUseCase{userRepo, tokenService}
}

func (u *LoginUseCase) Excute(loginRequest dto.LoginRequest) (dto.UserResponse, string, error) {
	var userResponse dto.UserResponse
	user, err := u.userRepo.FindUserByEmail(loginRequest.Email)
	if err != nil {
		return userResponse, "", errors.New("invalid email or passowrd")
	}

	token, err := u.tokenService.GenerateToken(user.ID)
	if err != nil {
		return userResponse, "", err
	}
	userResponse = dto.UserResponse{
		ID:        user.ID,
		Name:      user.Name,
		Email:     user.Email,
		AvatarUrl: user.AvatarUrl,
		Currency:  user.Currency,
		CreatedAt: user.CreatedAt,
	}
	return userResponse, token, nil
}
