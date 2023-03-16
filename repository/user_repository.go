package repository

import (
	"errors"
	"wedding-e-invitation-be/customutils"
	"wedding-e-invitation-be/entity"
	e "wedding-e-invitation-be/sentinelerrors"

	"github.com/jackc/pgconn"
	"gorm.io/gorm"
)

var perr *pgconn.PgError

type UserRepository interface {
	Create(userDTO *entity.UserDTO) (*entity.User, error)
	FindById(id uint) (*entity.User, error)
	FindByUsername(username string) (*entity.User, error)
	Update(id uint, user *entity.User) (*entity.User, error)
}

type userRepositoryImpl struct {
	db *gorm.DB
}

type UserRConfig struct {
	DB *gorm.DB
}

func NewUserRepository(cfg *UserRConfig) UserRepository {
	return &userRepositoryImpl{db: cfg.DB}
}

func (u *userRepositoryImpl) Create(userDTO *entity.UserDTO) (*entity.User, error) {
	user := &entity.User{}
	customutils.ConvertDTO(userDTO, user)
	user.Password = userDTO.Password
	resultUser := u.db.Model(&entity.User{}).Create(&user)
	if resultUser.Error != nil {
		errors.As(resultUser.Error, &perr)
		if perr.Code == "23505" {
			return nil, e.ErrUserEmailAlreadyExist
		}
		return nil, e.ErrInternalServer
	}
	return user, nil
}

func (u *userRepositoryImpl) FindById(id uint) (*entity.User, error) {
	var user *entity.User
	result := u.db.Preload("Wallet").Where("id = ?", id).First(&user)
	if result.Error != nil || result.RowsAffected == 0 {
		return nil, e.ErrUserNotFound
	}
	return user, nil
}

func (u *userRepositoryImpl) FindByUsername(username string) (*entity.User, error) {
	var user *entity.User
	result := u.db.Where("username = ?", username).First(&user)
	if result.Error != nil || result.RowsAffected == 0 {
		return nil, e.ErrUserNotFound
	}
	return user, nil
}

func (u *userRepositoryImpl) Update(id uint, user *entity.User) (*entity.User, error) {
	result := u.db.Where("id = ?", id).Save(user)
	if result.Error != nil || result.RowsAffected == 0 {
		return nil, e.ErrUnableUpdateUser
	}
	return user, nil
}
