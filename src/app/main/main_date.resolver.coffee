module.exports =
  kurses: (Kurs, $stateParams) ->
    date = $stateParams.date
    Kurs.get(date).then (kurses) ->
      kurses.map (kurs) ->
        kurs.type =
          switch kurs.type
            when "sell" then "Продажа"
            when "buy" then "Покупка"

        kurs
