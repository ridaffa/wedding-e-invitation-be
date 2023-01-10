package handler

import (
	"strconv"
	"wedding-e-invitation-be/customutils"
	"wedding-e-invitation-be/entity"
	e "wedding-e-invitation-be/sentinelerrors"

	"github.com/gin-gonic/gin"
)

func (h *Handler) Create(c *gin.Context) {
	var guest *entity.GuestDTO
	err := c.ShouldBindJSON(&guest)
	if err != nil {
		c.JSON(customutils.HandleBadRequest(e.ErrBadRequest))
		return
	}
	errs := customutils.Validate(guest)
	if errs != nil {
		c.JSON(customutils.HandleBadRequest(errs[0]))
		return
	}
	resGuest, err := h.guestUsecase.Create(guest)
	if err != nil {
		if err == e.ErrInternalServer {
			c.JSON(customutils.HandleInternalServerError())
			return
		}
		c.JSON(customutils.HandleBadRequest(err))
		return
	}
	c.JSON(customutils.HandleCreated(resGuest))
}

func (h *Handler) Update(c *gin.Context) {
	var idInt, err = strconv.Atoi(c.Param("id"))
	if err != nil {
		c.JSON(customutils.HandleBadRequest(e.ErrBadRequest))
		return
	}
	var id uint = uint(idInt)
	var guest *entity.GuestDTO
	err = c.ShouldBindJSON(&guest)
	if err != nil {
		c.JSON(customutils.HandleBadRequest(e.ErrBadRequest))
		return
	}
	errs := customutils.Validate(guest)
	if errs != nil {
		c.JSON(customutils.HandleBadRequest(errs[0]))
		return
	}
	resGuest, err := h.guestUsecase.Update(id, guest)
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

func (h *Handler) Delete(c *gin.Context) {
	var idInt, err = strconv.Atoi(c.Param("id"))
	if err != nil {
		c.JSON(customutils.HandleBadRequest(e.ErrBadRequest))
		return
	}
	var id uint = uint(idInt)
	err = h.guestUsecase.Delete(id)
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

func (h *Handler) FindByUUID(c *gin.Context) {
	var id string = c.Param("uuid")
	resGuest, err := h.guestUsecase.FindByUUID(id)
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

func (h *Handler) FindAll(c *gin.Context) {
	resGuest, err := h.guestUsecase.FindAll()
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

func (h *Handler) Pagination(c *gin.Context) {
	resGuest, err := h.guestUsecase.Pagination(c.Request)
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
