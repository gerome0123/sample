#= require ./../module

stateDefineFactory = ->
  stateDefine = (self) ->
    self.states = {}

    self.applyState = (state_id, opts = {}) ->
      state = self.states[state_id] or {}
      if state? and (state.at or 0) < Date.now()
        self.states[state_id] = angular.extend state, opts, at: Date.now()
      self.states[state_id]

    self.stateOf =  (state_id) ->
      state = self.states[state_id]
      if state? then state else self.applyState(state_id)

    self.toggleStateOf = (id, key) ->
      state = self.stateOf(id)
      if key?
        state[key] = if state[key] then false else true
      else if state.active
        self.diactiveStateOf(id)
      else
        self.activateStateOf(id)

    self.activateStateOf = (id) ->
      self.applyState id, active: true

    self.diactiveStateOf = (id) ->
      self.applyState id, active: false

    self.stateClass = (id) ->
      state = self.stateOf(id)
      classes = []
      for key, val of state
        classes.push(key) if val
      classes.join(" ")

angular
  .module "CommonApp"
  .factory "StateDefine", stateDefineFactory