mainCtrl = require "./main.controller"
mainResolver = require "./main.resolver"
kursService = require "../../components/kurs.service"
mainDateCtrl = require "./main_date.controller"
mainDateResolver = require "./main_date.resolver"
mainGraphResolver = require "./main_graph.resolver"
mainGraphController = require "./main_graph.controller"

module.exports = angular.module "kurs.main", [ 'chart.js' ]

.config ($stateProvider) ->
  $stateProvider
    .state "main",
      url: "/",
      templateUrl: "app/main/main.html",
      controller: "MainCtrl as main"
      resolve: mainResolver

    .state "main.date",
      url: ":date"
      templateUrl: "app/main/date.html"
      controller: "MainDateCtrl as mainDate"
      resolve: mainDateResolver

    .state "main.graph",
      url: "chart/:period"
      templateUrl: "app/main/graph.html"
      controller: "MainGraphCtrl as mainGraph"
      resolve: mainGraphResolver


.controller "MainCtrl",  mainCtrl
.controller "MainDateCtrl", mainDateCtrl
.controller "MainGraphCtrl", mainGraphController
.factory    "Kurs", kursService
