package user

import (
	dto "expense/internal/dto/auth"
	"expense/internal/repository"
)

type UpdateAvatarUseCase struct {
	userRepo repository.UserRepository
}

func NewUpdateAvatarUseCase(userRepo repository.UserRepository) *UpdateAvatarUseCase {
	return &UpdateAvatarUseCase{userRepo}
}

func (u *UpdateAvatarUseCase) Execute(userId string, input dto.UpdateAvatarRequest) error {
	return u.userRepo.UpdateAvatar(userId, input.AvatarUrl)
}
