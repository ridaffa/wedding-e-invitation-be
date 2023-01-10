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
	UserUsecase  usecase.UserUsecase
	GuestUsecase usecase.GuestUsecase
}

func NewRouter(cfg *RouterConfig) *gin.Engine {
	router := gin.Default()

	router.Use(cors.New(cors.Config{
		AllowOrigins: []string{"*"},
		AllowMethods: []string{"POST", "PUT", "PATCH", "DELETE", "GET"},
		AllowHeaders: []string{"Content-Type,access-control-allow-origin, access-control-allow-headers, Authorization"},
	}))

	router.NoRoute(func(c *gin.Context) {
		c.JSON(customutils.HandleNotFound())
	})

	h := handler.New(&handler.Config{
		UserUsecase:  cfg.UserUsecase,
		GuestUsecase: cfg.GuestUsecase,
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
	}
	guestPrivate := router.Group("/guests").Use(middlewares.Auth())
	{
		guestPrivate.POST("", h.Create)
		guestPrivate.GET("", h.FindAll)
		guestPrivate.PUT("/:id", h.Update)
		guestPrivate.DELETE("/:id", h.Delete)
		guestPrivate.GET("/search", h.Pagination)
	}
	return router
}
