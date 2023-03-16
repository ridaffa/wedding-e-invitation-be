package server

import (
	"log"
	"wedding-e-invitation-be/customutils"
	"wedding-e-invitation-be/db"
	"wedding-e-invitation-be/repository"
	"wedding-e-invitation-be/usecase"

	"github.com/gin-gonic/gin"
)

func createRouter() *gin.Engine {
	userRepository := repository.NewUserRepository(
		&repository.UserRConfig{
			DB: db.Get(),
		},
	)

	guestRepository := repository.NewGuestRepository(
		&repository.GuestRConfig{
			DB: db.Get(),
		},
	)

	messageRepository := repository.NewMessageRepository(
		&repository.MessageRConfig{
			DB: db.Get(),
		},
	)

	userUsecase := usecase.NewUserUsecase(
		&usecase.UserUConfig{
			UserRepository: userRepository,
			HashUtils:      customutils.NewHashUtils(&customutils.HashUtilsConfig{}),
			AuthUtils:      customutils.NewAuthUtils(&customutils.AuthUtilsConfig{}),
		})

	guestUsecase := usecase.NewGuestUsecase(
		&usecase.GuestUConfig{
			GuestRepository: guestRepository,
		},
	)

	messageUsecase := usecase.NewMessageUsecase(
		&usecase.MessageUConfig{
			MessageRepository: messageRepository,
		},
	)

	return NewRouter(&RouterConfig{
		UserUsecase:    userUsecase,
		GuestUsecase:   guestUsecase,
		MessageUsecase: messageUsecase,
	})
}

func Init() {
	r := createRouter()
	err := r.Run()
	if err != nil {
		log.Println("error while running server", err)
		return
	}
}
