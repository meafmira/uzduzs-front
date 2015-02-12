class MainCtrl
  constructor: (@kurs, @Kurs, @localStorageService) ->
    @added = @localStorageService.get 'added'
    @today = moment().format('DD-MM-YYYY')
    @isAdded = false
    @addKurs =
      type: "sell"
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
    @Kurs.post(kurs).then =>
      if !(@added?) then @added = {}
      @added[kurs.type] = moment().format('YYYY MM DD')
      @localStorageService.set 'added', @added
      if kurs.type == 'sell'
        @isAddedSell = true
        @addKurs.type = 'buy'
      else
        @isAddedBuy = true
        @addKurs.type = 'sell'

  changeType: (type) ->
    @min = @kurs[type + 'Min']
    @max = @kurs[type + 'Max']
    @minlength = @min.toString().length
    @maxlength = @max.toString().length

MainCtrl.$inject = [ 'kurs', 'Kurs', 'localStorageService' ]

module.exports = MainCtrl
