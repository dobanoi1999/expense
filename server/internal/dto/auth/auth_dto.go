package dto

type RegisterRequest struct {
	Name     string `json:"name" binding:"required,min=2"`
	Email    string `json:"email" binding:"required,email"`
	Password string `json:"passowrd" binding:"required,min=6"`
}

type MesssageResponse struct {
	Message string `json:"message"`
}
