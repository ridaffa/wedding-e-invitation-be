package config

import (
	"log"
	"os"
	"regexp"

	"github.com/joho/godotenv"
)

const projectDirName = "wedding-e-invitation-be"

func LoadEnv(key string) string {
	projectName := regexp.MustCompile(`^(.*` + projectDirName + `)`)
	currentWorkDirectory, _ := os.Getwd()
	rootPath := projectName.Find([]byte(currentWorkDirectory))

	err := godotenv.Load(string(rootPath) + `/.env`)
	if err != nil {
		log.Fatalf("Error loading .env file")
	}
	return os.Getenv(key)
}

var (
	DB_HOST     = LoadEnv("DB_HOST")
	DB_USER     = LoadEnv("DB_USER")
	DB_PASSWORD = LoadEnv("DB_PASSWORD")
	DB_NAME     = LoadEnv("DB_NAME")
	DB_PORT     = LoadEnv("DB_PORT")
)
