mainCtrl = require "./main.controller"
mainResolver = require "./main.resolver"
kursService = require "../../components/kurs.service"

module.exports = angular.module "kurs.main", []

.config ($stateProvider) ->
  $stateProvider
    .state "main",
      url: "/",
      templateUrl: "app/main/main.html",
      controller: "MainCtrl as main"
      resolve: mainResolver

.controller "MainCtrl",  mainCtrl
.factory    "Kurs", kursService
