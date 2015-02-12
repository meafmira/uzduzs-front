class MainCtrl
  constructor: (@kurs, @Kurs, @localStorageService) ->
    added = @localStorageService.get 'added'
    @today = moment().format('DD-MM-YYYY')
    @isAdded = false
    @addKurs =
      type: "sell"
    @changeType "sell"
    if added?
      dateAdded = moment added, 'YYYY MM DD'
      today = moment()
      if today.date() == dateAdded.date() && today.month() == dateAdded.month() && today.year() == dateAdded.year()
        @isAdded = true

  add: (kurs) ->
    @Kurs.post(kurs).then =>
      @localStorageService.set 'added', moment().format('YYYY MM DD')
      @isAdded = true

  changeType: (type) ->
    @min = @kurs[type + 'Min']
    @max = @kurs[type + 'Max']
    @minlength = @min.toString().length
    @maxlength = @max.toString().length

MainCtrl.$inject = [ 'kurs', 'Kurs', 'localStorageService' ]

module.exports = MainCtrl
