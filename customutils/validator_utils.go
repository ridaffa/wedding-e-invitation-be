package customutils

import (
	"fmt"

	"github.com/go-playground/locales/en"
	ut "github.com/go-playground/universal-translator"
	"github.com/go-playground/validator/v10"
	enTranslations "github.com/go-playground/validator/v10/translations/en"
)

var validate = validator.New()
var english = en.New()
var uni = ut.New(english, english)
var trans, _ = uni.GetTranslator("en")
var _ = enTranslations.RegisterDefaultTranslations(validate, trans)

func Validate(target interface{}) (errs []error) {
	err := validate.Struct(target)
	if err == nil {
		return nil
	}
	validatorErrs := err.(validator.ValidationErrors)
	for _, e := range validatorErrs {
		translatedErr := fmt.Errorf(e.Translate(trans))
		errs = append(errs, translatedErr)
	}
	return errs
}
