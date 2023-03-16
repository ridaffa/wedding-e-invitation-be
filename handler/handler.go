package handler

import "wedding-e-invitation-be/usecase"

type Handler struct {
	userUsecase    usecase.UserUsecase
	guestUsecase   usecase.GuestUsecase
	messageUsecase usecase.MessageUsecase
}

type Config struct {
	UserUsecase    usecase.UserUsecase
	GuestUsecase   usecase.GuestUsecase
	MessageUsecase usecase.MessageUsecase
}

func New(cfg *Config) *Handler {
	return &Handler{
		userUsecase:    cfg.UserUsecase,
		guestUsecase:   cfg.GuestUsecase,
		messageUsecase: cfg.MessageUsecase,
	}
}
