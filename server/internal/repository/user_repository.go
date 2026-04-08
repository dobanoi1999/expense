package repository

import "expense/internal/entity"

type UserRepository interface {
	CreateUser(user *entity.User) error
	FindUserByEmail(email string) (*entity.User, error)
	FindUserById(id string) (*entity.User, error)
	UpdateUser(userId string, userData *entity.User) (*entity.User, error)
}
