package entity

import (
	"time"

	"gorm.io/gorm"
)

type Message struct {
	gorm.Model `json:"-"`
	ID         uint      `gorm:"primaryKey" json:"id"`
	CreatedAt  time.Time `json:"created_at"`

	GuestUuid   string `json:"guest_uuid"`
	DisplayName string `json:"display_name"`
	Message     string `gorm:"foreignKey:GuestUuid" json:"message"`
}

type MessageDTO struct {
	GuestUuid   string `json:"guest_uuid" validate:"required"`
	DisplayName string `json:"display_name" validate:"required,min=1,max=50"`
	Message     string `json:"message" validate:"required,min=1,max=200"`
}
