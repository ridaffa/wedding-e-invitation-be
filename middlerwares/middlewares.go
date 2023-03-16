package middlewares

import (
	"strings"
	"wedding-e-invitation-be/customutils"
	e "wedding-e-invitation-be/sentinelerrors"

	"github.com/gin-gonic/gin"
)

func Auth() gin.HandlerFunc {
	return func(context *gin.Context) {
		textAuthorization := context.GetHeader("Authorization")
		if textAuthorization == "" {
			context.JSON(customutils.HandleUnautorhized(e.ErrUnauthorizhed))
			context.Abort()
			return
		}
		tokenString := strings.Replace(textAuthorization, "Bearer ", "", 1)

		claims, err := customutils.ValidateTokenUser(tokenString)
		if err != nil {
			context.JSON(customutils.HandleUnautorhized(e.ErrUnauthorizhed))
			context.Abort()
			return
		}
		context.Set("user_id", claims.ID)
		context.Set("user_username", claims.Username)
		context.Next()
	}
}
