package handler

import "wedding-e-invitation-be/usecase"

type Handler struct {
	userUsecase  usecase.UserUsecase
	guestUsecase usecase.GuestUsecase
}

type Config struct {
	UserUsecase  usecase.UserUsecase
	GuestUsecase usecase.GuestUsecase
}

func New(cfg *Config) *Handler {
	return &Handler{
		userUsecase:  cfg.UserUsecase,
		guestUsecase: cfg.GuestUsecase,
	}
}
