package entity

import (
	"github.com/google/uuid"
	"gorm.io/gorm"
)

type Guest struct {
	gorm.Model  `json:"-"`
	ID          uint      `gorm:"primaryKey" json:"id"`
	Fullname    string    `json:"fullname"`
	Email       string    `json:"email"`
	PhoneNumber string    `json:"phone_number"`
	Address     string    `json:"address"`
	Visit       bool      `json:"visit"`
	UUID        uuid.UUID `json:"uuid"`
}

type GuestDTO struct {
	Fullname    string `json:"fullname" validate:"required,min=6,max=50"`
	Email       string `json:"email" validate:"omitempty,min=6,max=20"`
	PhoneNumber string `json:"phonenumber" validate:"omitempty,min=10,max=13,numeric"`
	Address     string `json:"address" validate:"omitempty,min=3,max=50"`
}

type GuestPagination struct {
}
