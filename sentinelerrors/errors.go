package sentinelerrors

import "errors"

var ErrInternalServer = errors.New("internal server error")
var ErrBadRequest = errors.New("bad request")
var ErrUnauthorizhed = errors.New("unauthorized")
