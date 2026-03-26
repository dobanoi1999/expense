package auth

import (
	"expense/internal/repository"
)

type RegisterUseCase struct {
	userRep repository.UserRepository
}

func NewRegisterUseCase(userRep repository.UserRepository) *RegisterUseCase {
	return &RegisterUseCase{userRep}
}
