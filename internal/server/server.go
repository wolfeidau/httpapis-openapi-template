package server

import (
	"net/http"

	"github.com/labstack/echo/v4"
	"github.com/rs/zerolog/log"
)

type DocumentsAPI struct {
}

func NewDocumentsAPI() *DocumentsAPI {
	return &DocumentsAPI{}
}

// NewDocument create a document.
//
// (POST /2021-08-15/document)
func (da *DocumentsAPI) NewDocument(c echo.Context) error {
	ctx := c.Request().Context()

	log.Ctx(ctx).Info().Msg("NewDocument")

	return c.String(http.StatusCreated, `{"status":"ok"}`)
}
