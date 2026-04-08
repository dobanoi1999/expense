package response

import (
	"encoding/json"
	"expense/internal/domain"
	"net/http"
)

type Response struct {
	Data  any `json:"data,omitempty"`
	Error any `json:"error,omitempty"`
}

func ResponseSuccess(w http.ResponseWriter, status int, payload any) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(status)

	response := Response{
		Data: payload,
	}
	json.NewEncoder(w).Encode(response)
}

func HandleError(err error) (int, string) {
	switch e := err.(type) {
	case *domain.AppError:
		return e.Code, e.Message
	default:
		return http.StatusInternalServerError, "Internal server error"
	}
}

func ResponseError(w http.ResponseWriter, status int, err error) {
	code, msg := HandleError(err)

	response := Response{
		Error: msg,
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(code)
	json.NewEncoder(w).Encode(response)
}
