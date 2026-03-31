package model

import "time"

type User struct {
	ID           string `gorm:"primaryKey"`
	DisplayName  string
	AvatarUrl    string
	Email        string
	Locale       string
	PasswordHash string
	Currency     string
	IsActive     bool
	CreatedAt    time.Time
	UpdatedAt    time.Time
}
