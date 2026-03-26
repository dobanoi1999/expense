package main

import (
	"expense/configs"
	"expense/internal/router"
	"expense/pkg/database"
	"fmt"
	"log"
	"net/http"

	"github.com/gorilla/mux"
	httpSwagger "github.com/swaggo/http-swagger/v2"
)

//	@title			Expense Tracker API
//	@version		1.0
//	@description	Production-ready REST API with Clean Architecture
//	@termsOfService	http://swagger.io/terms/

//	@license.name	Apache 2.0
//	@license.url	http://www.apache.org/licenses/LICENSE-2.0.html

//	@host		localhost:9000
//	@BasePath	/api

//	@securityDefinitions.apikey	BearerAuth
//	@in							header
//	@name						Authorization

// @externalDocs.description	OpenAPI
// @externalDocs.url			https://swagger.io/resources/open-api/
func main() {
	cfg, err := configs.LoadConfig()
	if err != nil {
		log.Fatalf("Error loading config: %v", err)
	}

	database.ConnectDatabase(cfg)
	defer func() {
		pgsqlDB, _ := database.DB.DB()
		pgsqlDB.Close()
	}()

	mainRouter := mux.NewRouter()
	mainRouter.PathPrefix("/swagger/").Handler(httpSwagger.WrapHandler)

	router.SetupAllRoutes(mainRouter, database.DB)

	addr := fmt.Sprintf(":%v", cfg.ServerPort)
	log.Printf("🚀 Server starting on %s", addr)

	if err := http.ListenAndServe(addr, mainRouter); err != nil {
		log.Fatalf("Server failed: %v", err)
	}

}
