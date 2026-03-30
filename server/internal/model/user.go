package model

import "time"

type User struct {
	ID           string `gorm:"primaryKey"`
	Email        string
	PasswordHash string
	BaseCurrency string
	CreatedAt    time.Time
}
