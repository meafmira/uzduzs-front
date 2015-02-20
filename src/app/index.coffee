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
                        'geolocation',
                        'uiGmapgoogle-maps',
                        main.name ]
  .config ($stateProvider, $urlRouterProvider, $locationProvider) ->

    $locationProvider.html5Mode(true).hashPrefix('!')

    $urlRouterProvider.otherwise '/'

  .run ($location) ->
    mode = $location.search().__mode
    if mode?
      $.cookie('mode', mode)
      $location.search('__mode', null)
      location.reload()


  .config (RestangularProvider) ->
    mode = $.cookie('mode')
    switch mode
      when 'staging'
        RestangularProvider.setBaseUrl "https://usduzs-staging.herokuapp.com/api/v1"
      when 'local'
        RestangularProvider.setBaseUrl "http://kurs/api/v1"
      else
        RestangularProvider.setBaseUrl "https://usduzs.herokuapp.com/api/v1"

  .config (uiGmapGoogleMapApiProvider) ->
    uiGmapGoogleMapApiProvider.configure
      key: 'AIzaSyAf2DRqv-Ao9RfGNwF7a1QMIJ2LF_sleAA',
      v: '3.17',
      libraries: 'places'
