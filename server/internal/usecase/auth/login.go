package auth

import (
	"expense/internal/domain"
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

func (u *LoginUseCase) Execute(loginRequest dto.LoginRequest) (dto.UserResponse, dto.TokenResponse, error) {
	var userResponse dto.UserResponse
	var TokenResponse dto.TokenResponse

	user, err := u.userRepo.FindUserByEmail(loginRequest.Email)
	if err != nil {
		return userResponse, TokenResponse, domain.NewAuthenticationError("email or password is not valid")
	}

	if err := user.ComparePassword(loginRequest.Password); err != nil {
		return userResponse, TokenResponse, domain.NewAuthenticationError("email or password is not valid")
	}

	token, err := u.tokenService.GenerateToken(user.ID)
	if err != nil {
		return userResponse, TokenResponse, err
	}

	var refreshToken string
	dbToken, err := u.refreshTokenRepo.FindTokenByUserID(user.ID)

	if err != nil && dbToken == nil {
		refreshToken, err = u.createNewRefreshToken(user.ID)
		if err != nil {
			return userResponse, TokenResponse, err
		}
	} else if dbToken.IsExpired() || dbToken.Revoked {
		refreshToken, err = u.tokenService.GenerateFreshToken(user.ID)
		if err != nil {
			return userResponse, TokenResponse, err
		}

		tokenEntity := entity.RefreshToken{
			ID:        dbToken.ID,
			UserID:    dbToken.UserID,
			TokenHash: refreshToken,
			ExpiresAt: time.Now().AddDate(0, 0, 7),
			Revoked:   false,
		}

		if err := u.refreshTokenRepo.UpdateTokenByID(tokenEntity); err != nil {
			return userResponse, TokenResponse, err
		}

	} else {
		refreshToken = dbToken.TokenHash
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

func (u *LoginUseCase) createNewRefreshToken(userId string) (string, error) {
	refreshToken, err := u.tokenService.GenerateFreshToken(userId)
	if err != nil {
		return "", err
	}

	tokenEntity := entity.RefreshToken{
		ID:        uuid.NewString(),
		UserID:    userId,
		TokenHash: refreshToken,
		ExpiresAt: time.Now().Add(time.Hour * 1),
	}

	if err := u.refreshTokenRepo.Create(tokenEntity); err != nil {
		return "", err
	}
	return refreshToken, nil
}
