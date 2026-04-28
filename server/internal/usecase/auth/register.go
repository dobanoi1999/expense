package auth

import (
	"expense/internal/domain"
	dto "expense/internal/dto/auth"
	"expense/internal/entity"
	"expense/internal/repository"

	"github.com/google/uuid"
)

type RegisterUseCase struct {
	userRep repository.UserRepository
}

func NewRegisterUseCase(userRep repository.UserRepository) *RegisterUseCase {
	return &RegisterUseCase{userRep}
}

func (u *RegisterUseCase) Execute(input dto.RegisterRequest) error {
	userEntity, err := entity.NewUser(uuid.NewString(), input.Name, input.Email, "VND", "", true)
	if err != nil {
		return err
	}
	if err := userEntity.SetPassword(input.Password); err != nil {
		return err
	}

	user, err := u.userRep.FindUserByEmail(input.Email)
	if err == nil && user != nil {
		return domain.NewValidationError("email already exits")
	}
	if err := u.userRep.CreateUser(userEntity); err != nil {
		return err
	}
	return nil
}
