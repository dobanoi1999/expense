package implementation

import "gorm.io/gorm"

type GormUserImplemtion struct {
	db *gorm.DB
}

func NewGormUserImplement(db *gorm.DB) *GormUserImplemtion {
	return &GormUserImplemtion{db}
}
