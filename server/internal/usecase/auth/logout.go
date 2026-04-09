package auth

import (
	"errors"
	"expense/internal/repository"

	"gorm.io/gorm"
)

type LogoutUseCase struct {
	refreshRepo repository.RefreshTokenRepository
}

func NewLogoutUseCase(refreshRepo repository.RefreshTokenRepository) *LogoutUseCase {
	return &LogoutUseCase{refreshRepo}
}

func (u *LogoutUseCase) Execute(userID string) error {
	token, err := u.refreshRepo.FindTokenByUserID(userID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil
		}
		return err
	}

	return u.refreshRepo.RemoveToken(token.ID)
}
