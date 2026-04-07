package dto

import "time"

type RegisterRequest struct {
	Name     string `json:"name" binding:"required,min=2" example:"Nguyen Van A"`
	Email    string `json:"email" binding:"required,email" example:"nguyenvana@gmail.com"`
	Password string `json:"password" binding:"required,min=6" example:"123456"`
}

type LoginRequest struct {
	Email    string `json:"email" binding:"required,email" example:"ntdbna1@gmail.com"`
	Password string `json:"password" binding:"required,min=6" example:"123456"`
}

type UserResponse struct {
	ID        string    `json:"id"`
	Name      string    `json:"name"`
	Email     string    `json:"email"`
	AvatarUrl string    `json:"avatar_url"`
	Currency  string    `json:"currency"`
	CreatedAt time.Time `json:"created_at"`
}

type TokenResponse struct {
	RefreshToken string `json:"refresh_token"`
	Token        string `json:"token"`
	ExpiresIn    int64  `json:"expires_in"`
	TokenType    string `json:"token_type"`
}

type LoginResponse struct {
	Tokens TokenResponse `json:"tokens"`
	User   UserResponse  `json:"user"`
}

type MesssageResponse struct {
	Message string `json:"message"`
}

type RefreshTokenRequest struct {
	RefreshToken string `json:"refresh_token"`
}
