local function match_init(context, initial_state)
  return { state = {}, tick_rate = 10, label = "galilee_capernaum_test" }
end

local function match_join_attempt(context, dispatcher, tick, state, presence, metadata)
  return state, true
end

local function match_join(context, dispatcher, tick, state, presences)
  return state
end

local function match_leave(context, dispatcher, tick, state, presences)
  return state
end

local function match_loop(context, dispatcher, tick, state, messages)
  for _, message in ipairs(messages) do
    dispatcher.broadcast_message(message.op_code, message.data, nil, message.sender)
  end
  return state
end

local function match_terminate(context, dispatcher, tick, state, grace_seconds)
  return state
end

nk.register_match("galilee_capernaum_test", match_init, match_join_attempt, match_join,
  match_leave, match_loop, match_terminate)

nk.register_rpc(function(context, payload)
  local matches = nk.match_list(1, true, "galilee_capernaum_test", nil, nil)
  local match_id = #matches > 0 and matches[1].match_id or nk.match_create("galilee_capernaum_test")
  return nk.json_encode({ match_id = match_id })
end, "galilee_join_world")
