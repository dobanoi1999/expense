package entity

import "time"

type RefreshToken struct {
	ID        string
	UserID    string
	TokenHash string
	Revoked   bool
	ExpiresAt time.Time
}

func (rt *RefreshToken) IsExpired() bool {
	return time.Now().After(rt.ExpiresAt)
}

func (rt *RefreshToken) IsValid() bool {
	return !rt.Revoked && !rt.IsExpired()
}
