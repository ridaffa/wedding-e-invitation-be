package customutils

import (
	"math/rand"

	"golang.org/x/crypto/bcrypt"
)

type HashUtils interface {
	HashAndSalt(pwd string) (string, error)
	ComparePassword(hashedPwd string, inputPwd string) bool
	GenerateOTP() int
}

type hashUtilsImpl struct{}

type HashUtilsConfig struct{}

func NewHashUtils(cfg *HashUtilsConfig) HashUtils {
	return &hashUtilsImpl{}
}

func (hu *hashUtilsImpl) HashAndSalt(pwd string) (string, error) {
	hash, err := bcrypt.GenerateFromPassword([]byte(pwd), bcrypt.MinCost)
	if err != nil {
		return "", err
	}
	return string(hash), nil
}

func (hu *hashUtilsImpl) ComparePassword(hashedPwd string, inputPwd string) bool {
	err := bcrypt.CompareHashAndPassword([]byte(hashedPwd), []byte(inputPwd))
	return err == nil
}

func (hu *hashUtilsImpl) GenerateOTP() int {
	otp := rand.Intn(9999-1000) + 1000
	return otp
}
