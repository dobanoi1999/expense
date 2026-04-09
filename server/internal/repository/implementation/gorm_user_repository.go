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
		IsActive:     user.IsActive,
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
		Email:        user.Email,
		AvatarUrl:    user.AvatarUrl,
		CreatedAt:    user.CreatedAt,
		UpdatedAt:    user.UpdatedAt,
	}, nil
}

func (r *GormUserRepository) FindUserById(id string) (*entity.User, error) {
	var user model.User
	if err := r.db.Where("id = ?", id).Where("is_active = ?", true).First(&user).Error; err != nil {
		return nil, err
	}

	return &entity.User{
		ID:           user.ID,
		Name:         user.DisplayName,
		PasswordHash: user.PasswordHash,
		Currency:     user.Currency,
		Email:        user.Email,
		AvatarUrl:    user.AvatarUrl,
		IsActive:     user.IsActive,
		CreatedAt:    user.CreatedAt,
		UpdatedAt:    user.UpdatedAt,
	}, nil
}

func (r *GormUserRepository) UpdateUser(userId string, userData *entity.User) (*entity.User, error) {
	userDb := model.User{
		ID:          userData.ID,
		DisplayName: userData.Name,
		AvatarUrl:   userData.AvatarUrl,
		Currency:    userData.Currency,
		Email:       userData.Email,
		IsActive:    userData.IsActive,
	}

	if err := r.db.Updates(&userDb).Error; err != nil {
		return nil, err
	}

	return &entity.User{
		ID:           userDb.ID,
		Name:         userDb.DisplayName,
		PasswordHash: userDb.PasswordHash,
		Currency:     userDb.Currency,
		Email:        userDb.Email,
		AvatarUrl:    userDb.AvatarUrl,
		IsActive:     userDb.IsActive,
		CreatedAt:    userDb.CreatedAt,
		UpdatedAt:    userDb.UpdatedAt,
	}, nil
}

func (r *GormUserRepository) UpdateAvatar(userId string, avatarUrl string) error {
	if err := r.db.Model(&model.User{}).Where("id = ?", userId).Update("avatar_url", avatarUrl).Error; err != nil {
		return err
	}

	return nil
}
