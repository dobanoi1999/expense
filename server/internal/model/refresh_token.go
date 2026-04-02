package model

import "time"

type RefreshToken struct {
	ID        string `gorm:"primaryKey"`
	UserID    string `gorm:"index"`
	TokenHash string `gorm:"index,uniqueIndex"`
	Revoked   bool
	ExpiresAt time.Time
	CreatedAt time.Time
}
