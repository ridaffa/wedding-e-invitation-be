package usecase

import (
	"net/http"
	"wedding-e-invitation-be/entity"
	"wedding-e-invitation-be/repository"

	"github.com/morkid/paginate"
)

type GuestUsecase interface {
	Create(guestDTO *entity.GuestDTO) (*entity.Guest, error)
	FindAll() ([]*entity.Guest, error)
	FindByUUID(uuid string) (*entity.Guest, error)
	Update(id uint, guest *entity.GuestDTO) (*entity.Guest, error)
	Delete(id uint) error
	Pagination(req *http.Request) (paginate.Page, error)
}

type guestUsecaseImpl struct {
	guestRepository repository.GuestRepository
}

type GuestUConfig struct {
	GuestRepository repository.GuestRepository
}

func NewGuestUsecase(cfg *GuestUConfig) GuestUsecase {
	return &guestUsecaseImpl{guestRepository: cfg.GuestRepository}
}

func (g *guestUsecaseImpl) Create(guestDTO *entity.GuestDTO) (*entity.Guest, error) {
	return g.guestRepository.Create(guestDTO)
}

func (g *guestUsecaseImpl) FindByUUID(uuid string) (*entity.Guest, error) {
	return g.guestRepository.FindByUUID(uuid)
}

func (g *guestUsecaseImpl) FindAll() ([]*entity.Guest, error) {
	return g.guestRepository.FindAll()
}

func (g *guestUsecaseImpl) Update(id uint, guest *entity.GuestDTO) (*entity.Guest, error) {
	return g.guestRepository.Update(id, guest)
}

func (g *guestUsecaseImpl) Delete(id uint) error {
	return g.guestRepository.Delete(id)
}

func (g *guestUsecaseImpl) Pagination(req *http.Request) (paginate.Page, error) {
	return g.guestRepository.Pagination(req)
}
