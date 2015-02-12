mainCtrl = require "./main.controller"
mainResolver = require "./main.resolver"
kursService = require "../../components/kurs.service"
mainDateCtrl = require "./main_date.controller"
mainDateResolver = require "./main_date.resolver"

module.exports = angular.module "kurs.main", []

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

.controller "MainCtrl",  mainCtrl
.controller "MainDateCtrl", mainDateCtrl
.factory    "Kurs", kursService
