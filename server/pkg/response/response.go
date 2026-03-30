package response

import (
	"encoding/json"
	"net/http"
)

type Response struct {
	Data  any    `json:"data,omitempty"`
	Error string `json:"error,omitempty"`
}

func ResponseSuccess(w http.ResponseWriter, status int, payload any) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(status)

	response := Response{
		Data: payload,
	}
	json.NewEncoder(w).Encode(response)
}

func ResponseError(w http.ResponseWriter, status int, message string) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(status)

	response := Response{
		Error: message,
	}
	json.NewEncoder(w).Encode(response)
}
