package customutils

import (
	"errors"
	"time"
	"wedding-e-invitation-be/config"
	"wedding-e-invitation-be/entity"

	"github.com/golang-jwt/jwt/v4"
)

type AuthUtils interface {
	GenerateAccessTokenUser(user *entity.User) (string, error)
}

type authUtilsImpl struct{}

type AuthUtilsConfig struct{}

func NewAuthUtils(cfg *AuthUtilsConfig) AuthUtils {
	return &authUtilsImpl{}
}

type userClaims struct {
	Username string `json:"username"`
	ID    uint   `json:"id"`
	jwt.StandardClaims
}

func (a *authUtilsImpl) GenerateAccessTokenUser(user *entity.User) (string, error) {
	claims := &userClaims{
		Username: user.Username,
		ID:    user.ID,
		StandardClaims: jwt.StandardClaims{
			Issuer:    config.LoadEnv("APPLICATION_NAME"),
			IssuedAt:  time.Now().Unix(),
			ExpiresAt: time.Now().Add(time.Hour * time.Duration(5)).Unix(),
		},
	}
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	hmacSampleSecret := config.LoadEnv("SECRET_JWT_KEY")
	tokenString, err := token.SignedString([]byte(hmacSampleSecret))
	if err != nil {
		return "", err
	}
	return tokenString, nil
}

func ValidateTokenUser(signedToken string) (*userClaims, error) {
	token, err := jwt.ParseWithClaims(
		signedToken,
		&userClaims{},
		func(token *jwt.Token) (interface{}, error) {
			return []byte(config.LoadEnv("SECRET_JWT_KEY")), nil
		},
	)
	if err != nil {
		return nil, err
	}
	claims, ok := token.Claims.(*userClaims)
	if !ok {
		err = errors.New("couldn't parse claims")
		return nil, err
	}
	if claims.ExpiresAt < time.Now().Local().Unix() {
		err = errors.New("token expired")
		return nil, err
	}
	return claims, nil
}
