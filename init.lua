dofile_once("data/scripts/perks/perk_utilities.lua")
dofile_once("data/scripts/perks/perk.lua")
dofile_once("data/scripts/perks/perk_list.lua")

function OnPlayerSpawned(player)
  if GlobalsGetValue("start_with_any_perks.new_game", "0") == "1" then return end
  GlobalsSetValue("start_with_any_perks.new_game", "1")

  local x, y = EntityGetTransform(player)
  for _, perk in ipairs(perk_list) do
    local amount = ModSettingGet("start_with_any_perks." .. perk.id)

    local kind = type(amount)
    if kind == "boolean" then
      amount = amount and 1 or 0
    elseif kind == "string" then
      amount = amount == "" and 0 or tonumber(amount)
    elseif kind ~= "number" then
      amount = 0
    end

    for _ = 1, amount do
      perk_pickup(nil, player, perk.id, false, false, true)
    end
  end
end
