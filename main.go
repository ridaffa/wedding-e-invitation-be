package main

import (
	"log"
	"wedding-e-invitation-be/db"
	"wedding-e-invitation-be/server"
)

// @title           Swagger Example API
// @version         1.0
// @description     This is a sample server celler server.
// @termsOfService  http://swagger.io/terms/

// @contact.name   API Support
// @contact.url    http://www.swagger.io/support
// @contact.email  support@swagger.io

// @license.name  Apache 2.0
// @license.url   http://www.apache.org/licenses/LICENSE-2.0.html

// @host      localhost:8080
// @BasePath  /api/v1

// @securityDefinitions.basic  BasicAuth
func main() {
	err := db.Connect()
	if err != nil {
		log.Println("Failed to connect DB", err)
	}
	server.Init()
}
