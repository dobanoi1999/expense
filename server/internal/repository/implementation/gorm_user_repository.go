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
		DisplayName:  user.Name,
		Email:        user.Email,
		PasswordHash: user.PasswordHash,
		Currency:     user.Currency,
		CreatedAt:    user.CreatedAt,
	}

	if err := r.db.Create(dbUser).Error; err != nil {
		return err
	}
	return nil
}

func (r *GormUserRepository) FindUserByEmail(email string) (*entity.User, error) {
	var user model.User
	err := r.db.Where("email = ?", email).First(&user).Error
	if err != nil {
		return nil, err
	}

	return &entity.User{
		ID:           user.ID,
		Name:         user.DisplayName,
		PasswordHash: user.PasswordHash,
		Currency:     user.Currency,
		CreatedAt:    user.CreatedAt,
	}, nil
}
