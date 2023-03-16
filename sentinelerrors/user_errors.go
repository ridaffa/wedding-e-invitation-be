package sentinelerrors

import "errors"

var ErrUserNotFound = errors.New("user not found")
var ErrUserEmailAlreadyExist = errors.New("user email already exist")
var ErrUnableUpdateUser = errors.New("unable to update user")
var ErrUnableDeleteUser = errors.New("unable to delete user")
var ErrWrongPassword = errors.New("wrong password")
var ErrWrongOTP = errors.New("wrong otp")
