package entity

import (
	"errors"
	"regexp"
	"time"

	"golang.org/x/crypto/bcrypt"
)

type User struct {
	ID           string
	Name         string
	Email        string
	PasswordHash string
	Currency     string
	CreatedAt    time.Time
	UpdatedAt    time.Time
}

func NewUser(id, name, email, currency string) (*User, error) {
	user := &User{
		ID:        id,
		Name:      name,
		Email:     email,
		Currency:  currency,
		CreatedAt: time.Now(),
		UpdatedAt: time.Now(),
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

func (u *User) SetPassword(plainPassword string) error {
	if len(plainPassword) < 6 {
		return errors.New("Password must be at least 6 characters")
	}
	hashPw, err := bcrypt.GenerateFromPassword([]byte(plainPassword), bcrypt.DefaultCost)
	if err != nil {
		return err
	}

	u.PasswordHash = string(hashPw)
	return nil
}

func (u *User) ComparePassword(plainPassword string) error {
	if err := bcrypt.CompareHashAndPassword([]byte(u.PasswordHash), []byte(plainPassword)); err != nil {
		return err
	}
	return nil
}
