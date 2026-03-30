package repository

import "expense/internal/entity"

type UserRepository interface {
	CreateUser(user *entity.User) error
	FindUserByEmail(email string) (*entity.User, error)
}
