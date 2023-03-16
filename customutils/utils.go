package customutils

import (
	"reflect"
)

func ConvertDTO(dto interface{}, entity interface{}) {
	newEntity := reflect.New(reflect.TypeOf(entity).Elem())
	n := reflect.ValueOf(entity).Elem()
	structType := reflect.TypeOf(dto)
	for i := 0; i < structType.Elem().NumField(); i++ {
		fieldName := structType.Elem().Field(i).Name
		value := reflect.ValueOf(dto).Elem().FieldByName(fieldName).Interface()
		if n.FieldByName(fieldName) != (reflect.Value{}) {
			newEntity.Elem().FieldByName(fieldName).Set(reflect.ValueOf(value))
		}
	}
	reflect.ValueOf(entity).Elem().Set(newEntity.Elem())
}
