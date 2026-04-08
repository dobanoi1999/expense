package auth

import (
	"errors"
	"expense/internal/domain"
	dto "expense/internal/dto/auth"
	"expense/internal/repository"
	security "expense/pkg/scurity"
)

type RefreshTokenUseCase struct {
	tokenService           *security.TokenService
	refreshTokenRepository repository.RefreshTokenRepository
}

func NewRefreshTokenUseCase(tokenService *security.TokenService, refreshTokenRepository repository.RefreshTokenRepository) *RefreshTokenUseCase {
	return &RefreshTokenUseCase{tokenService, refreshTokenRepository}
}

func (uc *RefreshTokenUseCase) Excute(request dto.RefreshTokenRequest) (dto.TokenResponse, error) {
	var tokenResponse dto.TokenResponse
	claims, err := uc.tokenService.VerifyToken(request.RefreshToken)
	if err != nil {
		return tokenResponse, domain.NewInternalError(errors.New("invalid refresh token"))
	}

	userID, ok := claims["user_id"].(string)
	if !ok {
		return tokenResponse, domain.NewInternalError(errors.New("invalid token claims"))
	}
	dbToken, err := uc.refreshTokenRepository.FindByToken(request.RefreshToken)

	if err != nil {
		return tokenResponse, domain.NewNotFoundError("refresh token not found")
	}

	if !dbToken.IsValid() {
		return tokenResponse, domain.NewInternalError(errors.New("refresh token is invalid or expired"))
	}

	newAccessToken, err := uc.tokenService.GenerateToken(userID)
	if err != nil {
		return tokenResponse, err
	}

	tokenResponse = dto.TokenResponse{
		Token:     newAccessToken,
		ExpiresIn: 60 * 60,
		TokenType: "bearer",
	}
	return tokenResponse, nil
}
