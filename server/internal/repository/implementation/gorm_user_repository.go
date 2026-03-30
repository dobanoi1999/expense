package implementation

import (
	"expense/internal/entity"
	"expense/internal/model"

	"gorm.io/gorm"
)

type GormUserRepository struct {
	db *gorm.DB
}

func NewGormUserImplement(db *gorm.DB) *GormUserRepository {
	return &GormUserRepository{db}
}

func (r *GormUserRepository) CreateUser(user *entity.User) error {
	dbUser := &model.User{
		ID:           user.ID,
		Email:        user.Email,
		PasswordHash: user.PasswordHash,
		BaseCurrency: user.BaseCurrency,
		CreatedAt:    user.CreatedAt,
	}

	if err := r.db.Create(dbUser).Error; err != nil {
		return err
	}
	return nil
}
