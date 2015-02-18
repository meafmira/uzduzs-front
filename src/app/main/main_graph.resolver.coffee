module.exports =
  data: (Kurs, $stateParams, localStorageService) ->
    place = localStorageService.get 'place'
    if !(place?)
      place = value: null

    period = $stateParams.period
    daysBack = switch period
      when "week" then 6
      when "month" then 29
    Kurs.all('day-averages').all(daysBack).getList({ place: place.value }).then (averages) ->
      labels = averages.filter((avg) -> avg.type == 'sell').map (avg) -> avg.day
      series = [ 'Покупка', 'Продажа' ]
      data = [
        averages.filter((avg) -> avg.type == 'buy').map (avg) -> avg.avgKurs
        averages.filter((avg) -> avg.type == 'sell').map (avg) -> avg.avgKurs
      ]

      { labels: labels, series: series, data: data }
