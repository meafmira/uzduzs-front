class MainCtrl
  constructor: (@kurs, @Kurs, @localStorageService, @places, @$state, geolocation, uiGmapGoogleMapApi, $scope, $q) ->
    @addKurs =
      type: "sell"
    uiGmapGoogleMapApi.then (maps) =>
      @map = new maps.Map($('<div></div>')[0])
      @autoCompleteService = new maps.places.AutocompleteService types: 'geocode'
      @placesService = new maps.places.PlacesService(@map)
      geolocation.getLocation().then (data) =>
        console.log data
        if data.coords?
          latLng = new maps.LatLng(data.coords.latitude, data.coords.longitude)
          @geocoder = new maps.Geocoder()
          @geocoder.geocode { 'latLng': latLng, region: 'uz'}, (results, status) =>
            if status == maps.GeocoderStatus.OK
              $scope.$apply =>
                @addKurs.place =
                  value: results[0].formatted_address
                  label: results[0].formatted_address
              console.log results
            else
              console.log "Geocode was not successful for the following reason: " + status

    @added = @localStorageService.get 'added'
    @today = moment().format('DD-MM-YYYY')
    @isAdded = false
    @mainPlace = (@localStorageService.get 'place') || { value: null, label: 'все местоположения' }
    if @added?
      today = moment()
      if @added.sell?
        sellAdded = moment @added.sell, 'YYYY MM DD'
        if today.date() == sellAdded.date() && today.month() == sellAdded.month() && today.year() == sellAdded.year()
          @isAddedSell = true
          @addKurs.type = 'buy'

      if @added.buy?
        buyAdded = moment @added.buy, 'YYYY MM DD'
        if today.date() == buyAdded.date() && today.month() == buyAdded.month() && today.year() == buyAdded.year()
          @isAddedBuy = true

    @changeType @addKurs.type

  add: (kurs) ->
    deferred = $q.defer()
    if @geocoder?
      @geocoder.geocode { 'address': kurs.place, region: 'uz'}, (results, status) =>
        if results[0]?
          deferred.resolve results[0]
        else
          deferred.resolve undefined

    deferred.promise.then (place) ->
      if place?
        kurs.lat = place.location.k
        kurs.lng = place.location.C
      @Kurs.post(kurs).then =>
        if !(@added?) then @added = {}
        @added[kurs.type] = moment().format('YYYY MM DD')
        @localStorageService.set 'added', @added
        if kurs.type == 'sell'
          @isAddedSell = true
          @addKurs.type = 'buy'
          @changeType @addKurs.type
        else
          @isAddedBuy = true
          @addKurs.type = 'sell'
          @changeType @addKurs.type

  changeType: (type) ->
    @min = @kurs[type + 'Min']
    @max = @kurs[type + 'Max']
    @minlength = @min.toString().length
    @maxlength = @max.toString().length

  editPlace: ->
    @isEditingPlace = true
    @mainPlace = null

  changePlace: ($item, $model, $number) ->
    @localStorageService.set 'place', $item
    @editPlace = false
    @$state.go @$state.$current, {}, { reload: true }

  inputPlace: ->
    if @addKurs.place? && @addKurs.place != '' && @autoCompleteService?
      @autoCompleteService.getQueryPredictions { input: @addKurs.place }, (predictions) =>
        @places = @places.filter (place) -> place.type != 'prediction'
        predictions.forEach (pred) =>
          @places.push { value: pred.description, label: pred.description, type: 'prediction' }

MainCtrl.$inject = [ 'kurs', 'Kurs', 'localStorageService', 'places', '$state', 'geolocation', 'uiGmapGoogleMapApi',
                     '$scope', '$q' ]

module.exports = MainCtrl
