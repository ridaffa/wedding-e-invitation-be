package customutils

type HandlerResponse struct {
	Data    interface{} `json:"data,omitempty"`
	Message string      `json:"message,omitempty"`
	Code    string      `json:"code,omitempty"`
}

func HandleBadRequest(e error) (int, *HandlerResponse) {
	return 400, &HandlerResponse{Message: e.Error(), Code: "BAD_REQUEST"}
}

func HandleInternalServerError() (int, *HandlerResponse) {
	return 500, &HandlerResponse{Message: "there is an error in server", Code: "INTERNAL_SERVER_ERROR"}
}

func HandleSuccess(data interface{}) (int, *HandlerResponse) {
	return 200, &HandlerResponse{Data: data}
}

func HandleCreated(data interface{}) (int, *HandlerResponse) {
	return 201, &HandlerResponse{Data: data}
}

func HandleUnautorhized(e error) (int, *HandlerResponse) {
	return 401, &HandlerResponse{Message: e.Error()}
}

func HandleNotFound() (int, *HandlerResponse) {
	return 404, &HandlerResponse{Message: "page not found"}
}
