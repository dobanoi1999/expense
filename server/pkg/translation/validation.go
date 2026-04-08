package translation

import (
	"fmt"

	"github.com/go-playground/validator/v10"
)

var messages = map[string]map[string]string{
	"en": {
		"required": "The %s is required",
		"email":    "The %s must be a valid email address",
		"min":      "The %s must be at least %s characters",
		"max":      "The %s must not exceed %s characters",
		"oneof":    "The %s must be one of [%s]",
	},
}

type Translator struct {
	lang string
}

func NewTranslator(lang string) *Translator {
	return &Translator{
		lang: lang,
	}
}

func (t *Translator) getMessage(key string, params ...interface{}) string {
	if msg, ok := messages[t.lang][key]; ok {
		return fmt.Sprintf(msg, params...)
	}
	return key
}

func (t *Translator) Translate(err error) string {
	if validationErrors, ok := err.(validator.ValidationErrors); ok {
		e := validationErrors[0]
		if e.Param() != "" {
			return t.getMessage(e.Tag(), e.Field(), e.Param())
		}
		return t.getMessage(e.Tag(), e.Field())
	}
	return err.Error()
}
