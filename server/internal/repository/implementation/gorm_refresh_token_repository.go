package implementation

import (
	"expense/internal/entity"
	"expense/internal/model"

	"gorm.io/gorm"
)

type GormRefreshTokenRepository struct {
	db *gorm.DB
}

func NewGormRefreshtokenImplement(db *gorm.DB) *GormRefreshTokenRepository {
	return &GormRefreshTokenRepository{db}
}

func (rt *GormRefreshTokenRepository) Create(token entity.RefreshToken) error {
	dbToken := &model.RefreshToken{
		ID:        token.ID,
		UserID:    token.UserID,
		TokenHash: token.TokenHash,
		ExpiresAt: token.ExpiresAt,
		Revoked:   token.Revoked,
	}

	if err := rt.db.Create(dbToken).Error; err != nil {
		return err
	}

	return nil
}

func (rt *GormRefreshTokenRepository) FindByToken(token string) (*entity.RefreshToken, error) {
	var dbToken model.RefreshToken

	if err := rt.db.Where("token= ?", token).First(&dbToken).Error; err != nil {
		return nil, err
	}

	return &entity.RefreshToken{
		ID:        dbToken.ID,
		UserID:    dbToken.UserID,
		TokenHash: dbToken.TokenHash,
		ExpiresAt: dbToken.ExpiresAt,
		Revoked:   dbToken.Revoked,
	}, nil
}
