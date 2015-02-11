main = require "./main"

angular.module "kurs", ['ngAnimate',
                        'ngCookies',
                        'ngTouch',
                        'ngSanitize',
                        'restangular',
                        'ui.router',
                        'ui.bootstrap',
                        'angular-loading-bar',
                        'LocalStorageModule',
                        main.name ]
  .config ($stateProvider, $urlRouterProvider, $locationProvider) ->

    $locationProvider.html5Mode(true).hashPrefix('!')

    $urlRouterProvider.otherwise '/'

  .config (RestangularProvider) ->
    RestangularProvider.setBaseUrl "https://usduzs.herokuapp.com/api/v1"
