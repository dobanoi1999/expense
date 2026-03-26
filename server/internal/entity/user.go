package entity

import (
	"errors"
	"regexp"
	"time"
)

type User struct {
	ID           string
	Name         string
	Email        string
	PasswordHash string
	BaseCurrency string
	CreatedAt    time.Time
	UpdatedAt    time.Time
}

func NewUser(id, name, email, baseCurrency string) (*User, error) {
	user := &User{
		ID:           id,
		Name:         name,
		Email:        email,
		BaseCurrency: baseCurrency,
		CreatedAt:    time.Now(),
		UpdatedAt:    time.Now(),
	}
	if err := user.Validate(); err != nil {
		return nil, err
	}

	return user, nil
}

func (u *User) Validate() error {
	if u.Name == "" {
		return errors.New("name is required")
	}

	if u.Email == "" {
		return errors.New("email is required")
	}

	if err := u.validateEmail(); err != nil {
		return errors.New("invalid email format")
	}

	return nil
}

func (u *User) validateEmail() error {
	const emailRegex = `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$`
	re := regexp.MustCompile(emailRegex)

	if !re.MatchString(u.Email) {
		return errors.New("invalid email format")
	}

	return nil
}
