package repository

import "expense/internal/entity"

type RefreshTokenRepository interface {
	Create(token entity.RefreshToken) error
	FindByToken(token string) (*entity.RefreshToken, error)
}
