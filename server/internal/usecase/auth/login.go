package auth

import (
	"errors"
	dto "expense/internal/dto/auth"
	"expense/internal/entity"
	"expense/internal/repository"
	security "expense/pkg/scurity"
	"time"

	"github.com/google/uuid"
)

type LoginUseCase struct {
	userRepo         repository.UserRepository
	refreshTokenRepo repository.RefreshTokenRepository
	tokenService     *security.TokenService
}

func NewLoginUseCase(userRepo repository.UserRepository, refreshTokenRepo repository.RefreshTokenRepository, tokenService *security.TokenService) *LoginUseCase {
	return &LoginUseCase{userRepo, refreshTokenRepo, tokenService}
}

func (u *LoginUseCase) Excute(loginRequest dto.LoginRequest) (dto.UserResponse, dto.TokenResponse, error) {
	var userResponse dto.UserResponse
	var TokenResponse dto.TokenResponse
	user, err := u.userRepo.FindUserByEmail(loginRequest.Email)
	if err != nil {
		return userResponse, TokenResponse, errors.New("invalid email or passowrd")
	}

	if err := user.ComparePassword(loginRequest.Password); err != nil {
		return userResponse, TokenResponse, errors.New("invalid email or passowrd")
	}

	token, err := u.tokenService.GenerateToken(user.ID)
	if err != nil {
		return userResponse, TokenResponse, err
	}

	refreshToken, err := u.tokenService.GenerateFreshToken(user.ID)
	if err != nil {
		return userResponse, TokenResponse, err
	}

	tokenEntity := entity.RefreshToken{
		ID:        uuid.NewString(),
		UserID:    user.ID,
		TokenHash: refreshToken,
		ExpiresAt: time.Now().AddDate(0, 0, 7),
	}

	if err := u.refreshTokenRepo.Create(tokenEntity); err != nil {
		return userResponse, TokenResponse, err
	}

	userResponse = dto.UserResponse{
		ID:        user.ID,
		Name:      user.Name,
		Email:     user.Email,
		AvatarUrl: user.AvatarUrl,
		Currency:  user.Currency,
		CreatedAt: user.CreatedAt,
	}

	TokenResponse = dto.TokenResponse{
		Token:        token,
		RefreshToken: refreshToken,
		ExpiresIn:    60 * 60,
		TokenType:    "bearer",
	}

	return userResponse, TokenResponse, nil
}
