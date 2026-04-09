package user

import (
	"errors"
	dto "expense/internal/dto/auth"
	"expense/internal/repository"
)

type ProfileUseCase struct {
	userRepo repository.UserRepository
}

func NewProfileUseCase(userRepo repository.UserRepository) *ProfileUseCase {
	return &ProfileUseCase{userRepo}
}

func (u *ProfileUseCase) Execute(userID string) (dto.UserResponse, error) {
	var userResponse dto.UserResponse
	user, err := u.userRepo.FindUserById(userID)
	if err != nil {
		return userResponse, err
	}

	if !user.IsActive {
		return userResponse, errors.New("account has been blocked")
	}

	return dto.UserResponse{
		ID:        user.ID,
		Name:      user.Name,
		Email:     user.Email,
		AvatarUrl: user.AvatarUrl,
		Currency:  user.Currency,
		CreatedAt: user.CreatedAt,
	}, nil

}
