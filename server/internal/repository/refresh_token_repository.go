package repository

import "expense/internal/entity"

type RefreshTokenRepository interface {
	Create(token entity.RefreshToken) error
	FindByToken(token string) (*entity.RefreshToken, error)
	FindTokenByUserID(userID string) (*entity.RefreshToken, error)
	RemoveToken(id string) error
	UpdateTokenByID(tokenUpdate entity.RefreshToken) error
}
