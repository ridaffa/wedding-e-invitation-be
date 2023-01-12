package handler

import (
	"strconv"
	"wedding-e-invitation-be/customutils"
	"wedding-e-invitation-be/entity"
	e "wedding-e-invitation-be/sentinelerrors"

	"github.com/gin-gonic/gin"
)

func (h *Handler) CreateMessage(c *gin.Context) {
	var message *entity.MessageDTO
	err := c.ShouldBindJSON(&message)
	if err != nil {
		c.JSON(customutils.HandleBadRequest(e.ErrBadRequest))
		return
	}
	errs := customutils.Validate(message)
	if errs != nil {
		c.JSON(customutils.HandleBadRequest(errs[0]))
		return
	}
	resMessage, err := h.messageUsecase.Create(message)
	if err != nil {
		if err == e.ErrInternalServer {
			c.JSON(customutils.HandleInternalServerError())
			return
		}
		c.JSON(customutils.HandleBadRequest(err))
		return
	}
	c.JSON(customutils.HandleCreated(resMessage))
}

func (h *Handler) FindAllMessage(c *gin.Context) {
	messages, err := h.messageUsecase.FindAll()
	if err != nil {
		if err == e.ErrInternalServer {
			c.JSON(customutils.HandleInternalServerError())
			return
		}
		c.JSON(customutils.HandleBadRequest(err))
		return
	}
	c.JSON(customutils.HandleSuccess(messages))
}

func (h *Handler) DeleteMessage(c *gin.Context) {
	var idInt, err = strconv.Atoi(c.Param("id"))
	if err != nil {
		c.JSON(customutils.HandleBadRequest(e.ErrBadRequest))
		return
	}
	var id uint = uint(idInt)
	err = h.messageUsecase.Delete(id)
	if err != nil {
		if err == e.ErrInternalServer {
			c.JSON(customutils.HandleInternalServerError())
			return
		}
		c.JSON(customutils.HandleBadRequest(err))
		return
	}
	c.JSON(customutils.HandleSuccess(nil))
}

func (h *Handler) PaginationMessage(c *gin.Context) {
	resGuest, err := h.messageUsecase.Pagination(c.Request)
	if err != nil {
		if err == e.ErrInternalServer {
			c.JSON(customutils.HandleInternalServerError())
			return
		}
		c.JSON(customutils.HandleBadRequest(err))
		return
	}
	c.JSON(customutils.HandleSuccess(resGuest))
}
