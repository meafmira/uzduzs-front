module.exports =
  kurs: (Kurs, localStorageService) ->
    place = localStorageService.get 'place'
    if !(place?)
      place = value: null
    Kurs.get('', { place: place.value })

  places: (Kurs) ->
    Kurs.get('places').then (places) ->
      result = places.map (place) ->
        console.log place
        value: place.place
        label: place.place

      result.push
        value: null
        label: "все местоположения"

      result
