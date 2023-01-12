package repository

import (
	"net/http"
	"wedding-e-invitation-be/customutils"
	"wedding-e-invitation-be/entity"
	e "wedding-e-invitation-be/sentinelerrors"

	"github.com/google/uuid"

	"github.com/morkid/paginate"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
)

type GuestRepository interface {
	Create(guestDTO *entity.GuestDTO) (*entity.Guest, error)
	FindByUUID(uuid string) (*entity.Guest, error)
	FindAll() ([]*entity.Guest, error)
	Update(id uint, guest *entity.GuestDTO) (*entity.Guest, error)
	Delete(id uint) error
	Pagination(req *http.Request) (paginate.Page, error)
	ChangeVisitByUuid(guest *entity.Guest) error
}

type guestRepositoryImpl struct {
	db *gorm.DB
}

type GuestRConfig struct {
	DB *gorm.DB
}

func NewGuestRepository(cfg *GuestRConfig) GuestRepository {
	return &guestRepositoryImpl{db: cfg.DB}
}

func (g *guestRepositoryImpl) Create(guestDTO *entity.GuestDTO) (*entity.Guest, error) {
	guest := &entity.Guest{}
	customutils.ConvertDTO(guestDTO, guest)
	newUUID := uuid.New()
	guest.UUID = newUUID
	resultGuest := g.db.Model(&entity.Guest{}).Create(&guest)
	if resultGuest.Error != nil {
		return nil, e.ErrInternalServer

	}
	return guest, nil
}

func (g *guestRepositoryImpl) FindByUUID(uuid string) (*entity.Guest, error) {
	var guest entity.Guest
	result := g.db.Where("uuid = ?", uuid).First(&guest)
	if result.Error != nil || result.RowsAffected == 0 {
		return nil, e.ErrGuestNotFound
	}
	return &guest, nil
}

func (g *guestRepositoryImpl) FindAll() ([]*entity.Guest, error) {
	var guests []*entity.Guest
	result := g.db.Find(&guests)
	if result.Error != nil || result.RowsAffected == 0 {
		return nil, e.ErrGuestNotFound
	}
	return guests, nil
}

func (g *guestRepositoryImpl) Update(id uint, guest *entity.GuestDTO) (*entity.Guest, error) {
	var guestEntity = &entity.Guest{}
	customutils.ConvertDTO(guest, guestEntity)
	result := g.db.Model(guestEntity).Where("id = ?", id).Clauses(clause.Returning{}).Updates(guestEntity)
	if result.Error != nil {
		if result.RowsAffected == 0 {
			return nil, e.ErrGuestNotFound
		}
		return nil, e.ErrInternalServer
	}
	return guestEntity, nil
}

func (g *guestRepositoryImpl) Delete(id uint) error {
	result := g.db.Where("id = ?", id).Delete(&entity.Guest{})
	if result.Error != nil || result.RowsAffected == 0 {
		return e.ErrGuestNotFound
	}
	return nil
}

func (g *guestRepositoryImpl) Pagination(req *http.Request) (paginate.Page, error) {
	var guests []*entity.Guest
	model := g.db.Model(guests)
	pg := paginate.New()
	pages := pg.With(model).Request(req).Response(&[]*entity.Guest{})
	return pages, nil
}

func (g *guestRepositoryImpl) ChangeVisitByUuid(guest *entity.Guest) error {
	result := g.db.Model(guest).Where("uuid = ?", guest.UUID).Updates(guest)
	if result.Error != nil {
		if result.RowsAffected == 0 {
			return e.ErrGuestNotFound
		}
		return e.ErrInternalServer
	}
	return nil
}
