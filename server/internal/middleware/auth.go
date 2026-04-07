package middleware

import (
	"context"
	"expense/pkg/response"
	security "expense/pkg/scurity"
	"net/http"
	"strings"
)

func AuthMiddleware(tokenService *security.TokenService) func(http.Handler) http.Handler {
	return func(h http.Handler) http.Handler {
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			authHeader := r.Header.Get("Authorization")
			if authHeader == "" {
				response.ResponseError(w, http.StatusUnauthorized, "missing authorization header")
				return
			}

			parts := strings.Split(authHeader, " ")
			if len(parts) != 2 || parts[0] != "Bearer" {
				response.ResponseError(w, http.StatusUnauthorized, "invalid authorization header format")
				return
			}

			token := parts[1]

			claims, err := tokenService.VerifyToken(token)
			if err != nil {
				response.ResponseError(w, http.StatusUnauthorized, "invalid or expired token")
				return
			}

			userId, oke := claims["user_id"].(string)
			if !oke {
				response.ResponseError(w, http.StatusUnauthorized, "invalid token claims")
				return
			}

			ctx := r.Context()
			ctx = context.WithValue(ctx, "user_id", userId)
			r = r.WithContext(ctx)

			h.ServeHTTP(w, r)
		})
	}
}
