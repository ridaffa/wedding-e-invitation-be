package handler

import (
	"errors"
	"wedding-e-invitation-be/customutils"
	"wedding-e-invitation-be/entity"
	e "wedding-e-invitation-be/sentinelerrors"

	"github.com/gin-gonic/gin"
)

func (h *Handler) Register(c *gin.Context) {
	var username string = c.GetString("user_username")
	if(username != "superadmin"){
		c.JSON(customutils.HandleBadRequest(e.ErrBadRequest))
		return
	}
	var user *entity.UserDTO
	err := c.ShouldBindJSON(&user)
	if err != nil {
		c.JSON(customutils.HandleBadRequest(e.ErrBadRequest))
		return
	}
	errs := customutils.Validate(user)
	if errs != nil {
		c.JSON(customutils.HandleBadRequest(errs[0]))
		return
	}
	resUser, err := h.userUsecase.Register(user)
	if err != nil {
		if err == e.ErrInternalServer {
			c.JSON(customutils.HandleInternalServerError())
			return
		}
		c.JSON(customutils.HandleBadRequest(err))
		return
	}
	c.JSON(customutils.HandleCreated(resUser))
}

func (h *Handler) Login(c *gin.Context) {
	var user *entity.UserDTO
	err := c.ShouldBindJSON(&user)
	if err != nil {
		c.JSON(customutils.HandleBadRequest(e.ErrBadRequest))
		return
	}
	errs := customutils.Validate(user)
	if errs != nil {
		c.JSON(customutils.HandleBadRequest(errs[0]))
		return
	}
	token, err := h.userUsecase.Login(user)
	if err != nil {
		if errors.Is(err, e.ErrInternalServer) {
			c.JSON(customutils.HandleInternalServerError())
			return
		}
		c.JSON(customutils.HandleBadRequest(err))
		return
	}
	c.JSON(customutils.HandleSuccess(token))
}

func (h *Handler) Find(c *gin.Context) {
	id := c.GetUint("user_id")
	user, err := h.userUsecase.FindById(id)
	if err != nil {
		if errors.Is(err, e.ErrInternalServer) {
			c.JSON(customutils.HandleInternalServerError())
			return
		}
		c.JSON(customutils.HandleBadRequest(err))
		return
	}
	c.JSON(customutils.HandleSuccess(user))
}
