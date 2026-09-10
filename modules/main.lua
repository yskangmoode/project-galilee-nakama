local nk = require("nakama")
local M = {}

function M.match_init(context, initial_state)
  return {}, 10, "galilee_capernaum_test"
end

function M.match_join_attempt(context, dispatcher, tick, state, presence, metadata)
  return state, true
end

function M.match_join(context, dispatcher, tick, state, presences)
  return state
end

function M.match_leave(context, dispatcher, tick, state, presences)
  return state
end

function M.match_loop(context, dispatcher, tick, state, messages)
  for _, message in ipairs(messages) do
    -- Relay only. A future server-authoritative movement policy replaces this.
    dispatcher.broadcast_message(message.op_code, message.data, nil, message.sender)
  end
  return state
end

function M.match_terminate(context, dispatcher, tick, state, grace_seconds)
  return state
end

nk.register_rpc(function(context, payload)
  local matches = nk.match_list(1, true, "galilee_capernaum_test", nil, nil, nil)
  local match_id = #matches > 0 and matches[1].match_id or nk.match_create("main")
  return nk.json_encode({ match_id = match_id })
end, "galilee_join_world")

return M
