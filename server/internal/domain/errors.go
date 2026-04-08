package domain

// Custom error types
type AppError struct {
	Code    int
	Message string
	Err     error
}

func (e *AppError) Error() string {
	if e.Err != nil {
		return e.Message + ": " + e.Err.Error()
	}
	return e.Message
}

// Error constructors
func NewValidationError(message string) *AppError {
	return &AppError{
		Code:    400,
		Message: message,
	}
}

func NewAuthenticationError(message string) *AppError {
	return &AppError{
		Code:    401,
		Message: message,
	}
}

func NewNotFoundError(message string) *AppError {
	return &AppError{
		Code:    404,
		Message: message,
	}
}

func NewInternalError(err error) *AppError {
	return &AppError{
		Code:    500,
		Message: "Internal server error",
		Err:     err,
	}
}
