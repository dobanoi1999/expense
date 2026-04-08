package user

import (
	dto "expense/internal/dto/auth"
	"expense/internal/repository"
)

type UpdateUserUseCase struct {
	userRepo repository.UserRepository
}

func NewUpdateUserUseCase(userRepo repository.UserRepository) *UpdateUserUseCase {
	return &UpdateUserUseCase{userRepo}
}

func (u *UpdateUserUseCase) Excute(userId string, userRequest dto.UpdateUserRequest) (dto.UserResponse, error) {
	var userResponse dto.UserResponse

	userEntity, err := u.userRepo.FindUserById(userId)
	if err != nil {
		return userResponse, err
	}
	userEntity.Name = userRequest.Name
	userEntity.Currency = userRequest.Currency
	user, err := u.userRepo.UpdateUser(userId, userEntity)
	if err != nil {
		return userResponse, err
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
