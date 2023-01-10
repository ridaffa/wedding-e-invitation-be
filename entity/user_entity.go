package entity

import (
	"gorm.io/gorm"
)

type User struct {
	gorm.Model `json:"-"`
	ID         uint   `gorm:"primaryKey" json:"id"`
	Username   string `json:"username"`
	Password   string `json:"-"`
}

type UserDTO struct {
	Username string `json:"Username,omitempty" validate:"required,min=6,max=20"`
	Password string `json:"password" validate:"required,min=6,max=20"`
}
