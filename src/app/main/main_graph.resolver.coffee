module.exports =
  data: (Kurs) ->
    Kurs.all('day-averages').getList().then (averages) ->
      labels = averages.filter((avg) -> avg.type == 'sell').map (avg) -> avg.day
      series = [ 'Покупка', 'Продажа' ]
      data = [
        averages.filter((avg) -> avg.type == 'buy').map (avg) -> avg.avgKurs
        averages.filter((avg) -> avg.type == 'sell').map (avg) -> avg.avgKurs
      ]

      { labels: labels, series: series, data: data }
