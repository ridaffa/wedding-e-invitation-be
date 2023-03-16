package server

import (
	"wedding-e-invitation-be/customutils"
	"wedding-e-invitation-be/handler"
	middlewares "wedding-e-invitation-be/middlerwares"
	"wedding-e-invitation-be/usecase"

	"github.com/gin-gonic/gin"

	"github.com/gin-contrib/cors"
)

type RouterConfig struct {
	UserUsecase    usecase.UserUsecase
	GuestUsecase   usecase.GuestUsecase
	MessageUsecase usecase.MessageUsecase
}

func NewRouter(cfg *RouterConfig) *gin.Engine {
	router := gin.Default()

	router.Use(cors.New(cors.Config{
		AllowOrigins: []string{"*"},
		AllowMethods: []string{"POST", "PUT", "PATCH", "DELETE", "GET"},
		AllowHeaders: []string{"*"},
	}))

	router.NoRoute(func(c *gin.Context) {
		c.JSON(customutils.HandleNotFound())
	})

	h := handler.New(&handler.Config{
		UserUsecase:    cfg.UserUsecase,
		GuestUsecase:   cfg.GuestUsecase,
		MessageUsecase: cfg.MessageUsecase,
	})

	userSuperadmin := router.Group("/").Use(middlewares.Auth())
	{
		userSuperadmin.POST("/register", h.Register)
	}

	user := router.Group("/")
	{
		user.POST("/login", h.Login)
	}

	guest := router.Group("/guests")
	{
		guest.GET("/:uuid", h.FindByUUID)
		guest.PATCH("/:uuid", h.ChangeVisitByUuid)
	}
	guestPrivate := router.Group("/guests").Use(middlewares.Auth())
	{
		guestPrivate.POST("", h.Create)
		guestPrivate.GET("", h.FindAll)
		guestPrivate.PUT("/:id", h.Update)
		guestPrivate.DELETE("/:id", h.Delete)
		guestPrivate.GET("/search", h.Pagination)
	}
	message := router.Group("/messages")
	{
		message.POST("", h.CreateMessage)
		message.GET("", h.FindAllMessage)
		message.GET("/search", h.PaginationMessage)
	}
	return router
}
