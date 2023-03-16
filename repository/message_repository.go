package repository

import (
	"net/http"
	"wedding-e-invitation-be/customutils"
	"wedding-e-invitation-be/entity"
	e "wedding-e-invitation-be/sentinelerrors"

	"github.com/morkid/paginate"
	"gorm.io/gorm"
)

type MessageRepository interface {
	Create(messageDTO *entity.MessageDTO) (*entity.Message, error)
	FindAll() ([]*entity.Message, error)
	Delete(id uint) error
	Pagination(req *http.Request) (*paginate.Page, error)
}

type messageRepositoryImpl struct {
	db *gorm.DB
}

type MessageRConfig struct {
	DB *gorm.DB
}

func NewMessageRepository(cfg *MessageRConfig) MessageRepository {
	return &messageRepositoryImpl{db: cfg.DB}
}

func (m *messageRepositoryImpl) Create(messageDTO *entity.MessageDTO) (*entity.Message, error) {
	message := &entity.Message{}
	customutils.ConvertDTO(messageDTO, message)
	resultMessage := m.db.Model(&entity.Message{}).Create(&message)
	if resultMessage.Error != nil {
		return nil, e.ErrInternalServer
	}
	return message, nil
}

func (m *messageRepositoryImpl) FindAll() ([]*entity.Message, error) {
	var messages []*entity.Message
	result := m.db.Order("created_at desc").Find(&messages)
	if result.Error != nil {
		return nil, e.ErrInternalServer
	}
	return messages, nil
}

func (m *messageRepositoryImpl) Delete(id uint) error {
	result := m.db.Delete(&entity.Message{}, id)
	if result.Error != nil {
		return e.ErrInternalServer
	}
	return nil
}

func (m *messageRepositoryImpl) Pagination(req *http.Request) (*paginate.Page, error) {
	var messages []*entity.Message
	model := m.db.Order("created_at desc").Model(messages)
	pg := paginate.New()
	pages := pg.With(model).Request(req).Response(&[]*entity.Message{})
	return &pages, nil
}
