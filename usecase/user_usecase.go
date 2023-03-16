package usecase

import (
	"wedding-e-invitation-be/customutils"
	"wedding-e-invitation-be/entity"
	"wedding-e-invitation-be/repository"
	e "wedding-e-invitation-be/sentinelerrors"
)

type UserUsecase interface {
	Login(userDTO *entity.UserDTO) (string, error)
	Register(userDTO *entity.UserDTO) (*entity.User, error)
	FindById(id uint) (*entity.User, error)
}

type userUsecaseImpl struct {
	userRepository repository.UserRepository
	hashUtils      customutils.HashUtils
	authUtils      customutils.AuthUtils
}

type UserUConfig struct {
	UserRepository repository.UserRepository
	HashUtils      customutils.HashUtils
	AuthUtils      customutils.AuthUtils
}

func NewUserUsecase(cfg *UserUConfig) UserUsecase {
	return &userUsecaseImpl{userRepository: cfg.UserRepository, hashUtils: cfg.HashUtils, authUtils: cfg.AuthUtils}
}

func (uc *userUsecaseImpl) Login(userDTO *entity.UserDTO) (string, error) {
	user, err := uc.userRepository.FindByUsername(userDTO.Username)
	if err != nil {
		return "", e.ErrUserNotFound
	}

	if !uc.hashUtils.ComparePassword(user.Password, userDTO.Password) {
		return "", e.ErrWrongPassword
	}
	token, err := uc.authUtils.GenerateAccessTokenUser(user)
	if err != nil {
		return "", e.ErrInternalServer
	}
	return token, nil
}

func (uc *userUsecaseImpl) Register(userDTO *entity.UserDTO) (*entity.User, error) {
	newPassword, err := uc.hashUtils.HashAndSalt(userDTO.Password)
	if err != nil {
		return nil, e.ErrInternalServer
	}
	userDTO.Password = newPassword
	return uc.userRepository.Create(userDTO)
}

func (uc *userUsecaseImpl) FindById(id uint) (*entity.User, error) {
	return uc.userRepository.FindById(id)
}
