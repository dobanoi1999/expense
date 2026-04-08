package customValidator

import (
	"expense/internal/domain"
	"expense/pkg/translation"

	"github.com/go-playground/validator/v10"
	validateV10 "github.com/go-playground/validator/v10"
)

var validate *validateV10.Validate

func init() {
	validate = validateV10.New()
}

func ValidateStruct(input any) error {
	validate := validator.New()
	if err := validate.Struct(input); err != nil {
		translator := translation.NewTranslator("en")
		return domain.NewValidationError(translator.Translate(err))
	}
	return nil
}
