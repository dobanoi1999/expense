package dto

type RegisterRequest struct {
	Name     string `json:"name" validate:"required,min=2" example:"Nguyen Van A"`
	Email    string `json:"email" validate:"required,email" example:"nguyenvana@gmail.com"`
	Password string `json:"password" validate:"required,min=6" example:"123456"`
}

type LoginRequest struct {
	Email    string `json:"email" validate:"required,email" example:"ntdbna1@gmail.com"`
	Password string `json:"password" validate:"required,min=6" example:"123456"`
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

type MessageResponse struct {
	Message string `json:"message"`
}

type RefreshTokenRequest struct {
	RefreshToken string `json:"refresh_token"`
}
