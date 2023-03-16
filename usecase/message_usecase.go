package usecase

import (
	"net/http"
	"wedding-e-invitation-be/entity"
	"wedding-e-invitation-be/repository"

	"github.com/morkid/paginate"
)

type MessageUsecase interface {
	Create(messageDTO *entity.MessageDTO) (*entity.Message, error)
	FindAll() ([]*entity.Message, error)
	Delete(id uint) error
	Pagination(req *http.Request) (*paginate.Page, error)
}

type messageUsecaseImpl struct {
	messageRepository repository.MessageRepository
}

type MessageUConfig struct {
	MessageRepository repository.MessageRepository
}

func NewMessageUsecase(cfg *MessageUConfig) MessageUsecase {
	return &messageUsecaseImpl{messageRepository: cfg.MessageRepository}
}

func (m *messageUsecaseImpl) Create(messageDTO *entity.MessageDTO) (*entity.Message, error) {
	message, err := m.messageRepository.Create(messageDTO)
	if err != nil {
		return nil, err
	}
	return message, nil
}

func (m *messageUsecaseImpl) FindAll() ([]*entity.Message, error) {
	messages, err := m.messageRepository.FindAll()
	if err != nil {
		return nil, err
	}
	return messages, nil
}

func (m *messageUsecaseImpl) Delete(id uint) error {
	err := m.messageRepository.Delete(id)
	if err != nil {
		return err
	}
	return nil
}

func (m *messageUsecaseImpl) Pagination(req *http.Request) (*paginate.Page, error) {
	page, err := m.messageRepository.Pagination(req)
	if err != nil {
		return nil, err
	}
	return page, nil
}
