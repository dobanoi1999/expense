package dto

import "time"

type UserResponse struct {
	ID        string    `json:"id"`
	Name      string    `json:"name"`
	Email     string    `json:"email"`
	AvatarUrl string    `json:"avatar_url"`
	Currency  string    `json:"currency"`
	CreatedAt time.Time `json:"created_at"`
}

type UpdateUserRequest struct {
	Name     string `json:"name" validate:"required,min=2" example:"Nguyen Van A"`
	Currency string `json:"currency" validate:"oneof=VND USD" example:"VND"`
}

type UpdateAvatarRequest struct {
	AvatarUrl string `json:"avatar_url" validate:"required,url" example:"https://example.png"`
}
