module.exports =
  kurses: (Kurs, $stateParams, localStorageService) ->
    place = localStorageService.get 'place'
    if !(place?)
      place = value: null

    date = $stateParams.date
    Kurs.get(date, { place: place.value }).then (kurses) ->
      kurses.map (kurs) ->
        kurs.type =
          switch kurs.type
            when "sell" then "Продажа"
            when "buy" then "Покупка"

        kurs
