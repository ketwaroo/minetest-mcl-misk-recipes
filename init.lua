-- Unsolicited Crafting recipes.
-- 2023 (c) Ketwaroo

local craftitem_for_mod = {}

local function get_craftitem_for_horsearmor(mod,item)
    -- Find the very first item from this mod with a repair material
    for name, def2 in pairs(core.registered_items) do
        local mod2 = name:split(":")[1]
        local item2 = name:split(":")[2]
        if mod2 == mod and def2._repair_material then
            return def2._repair_material
        end
    end
    return nil
end

local function add_horse_armors_from_mods()
    for name, def in pairs(core.registered_items) do
        local mod = name:split(":")[1]
        local item = name:split(":")[2]
        -- exclude built-in MCL items
        if mod ~= "mcl_mobitems" and item and item:find("horse_armor") then
            local craftitem
            if craftitem_for_mod[mod] == nil then
                local response = get_craftitem_for_horsearmor(mod,item)
                craftitem_for_mod[mod] = response
            end
            -- check again, and if defined, then add a recipe
            local i = craftitem_for_mod[mod]
            if i then
                core.log("verbose","Setting recipe for " .. name .. " with craftitem " .. i)
                minetest.register_craft({
                    output = name,
                    recipe = {
                        { i, i, i },
                        { i, "mcl_mobitems:saddle", i },
                        { i, i, i },
                    }
                })
            end
        end
    end
end

minetest.register_on_mods_loaded(function()
    if minetest.get_modpath("mcl_mobitems") then
        if minetest.settings:get_bool("mcl_misk_recipes.enable_horse_stuff", true) then
            -- minetest.register_craft({
            -- 	output = "mcl_mobitems:leather_horse_armor",
            -- 	recipe = {
            -- 		{ "mcl_mobitems:leather", "",                     "mcl_mobitems:leather" },
            -- 		{ "mcl_mobitems:leather", "mcl_mobitems:leather", "mcl_mobitems:leather" },
            -- 		{ "mcl_mobitems:leather", "",                     "mcl_mobitems:leather" },
            -- 	}
            -- })

            minetest.register_craft({
                output = "mcl_mobitems:saddle",
                recipe = {
                    { "mcl_mobitems:leather", "mcl_mobitems:leather", "mcl_mobitems:leather" },
                    { "mcl_core:iron_nugget", "",                     "mcl_core:iron_nugget" },
                }
            })

            minetest.register_craft({
                output = "mcl_mobitems:iron_horse_armor",
                recipe = {
                    { "mcl_core:iron_nugget", "mcl_core:iron_nugget", "mcl_core:iron_nugget" },
                    { "mcl_core:iron_nugget", "mcl_mobitems:saddle",  "mcl_core:iron_nugget" },
                    { "mcl_core:iron_nugget", "mcl_core:iron_nugget", "mcl_core:iron_nugget" },
                }
            })

            minetest.register_craft({
                output = "mcl_mobitems:gold_horse_armor",
                recipe = {
                    { "mcl_core:gold_nugget", "mcl_core:gold_nugget", "mcl_core:gold_nugget" },
                    { "mcl_core:gold_nugget", "mcl_mobitems:saddle",  "mcl_core:gold_nugget" },
                    { "mcl_core:gold_nugget", "mcl_core:gold_nugget", "mcl_core:gold_nugget" },
                }
            })

            minetest.register_craft({
                output = "mcl_mobitems:diamond_horse_armor",
                recipe = {
                    { "mcl_core:diamond", "mcl_core:diamond",    "mcl_core:diamond" },
                    { "mcl_core:diamond", "mcl_mobitems:saddle", "mcl_core:diamond" },
                    { "mcl_core:diamond", "mcl_core:diamond",    "mcl_core:diamond" },
                }
            })

            if minetest.settings:get_bool("mcl_misk_recipes.enable_horse_stuff_from_mods", false) then
                add_horse_armors_from_mods()
            end
        end
    end

    -- heads
    -- disable by default, those are rare enough.
    if
        minetest.get_modpath("mcl_heads")
        and minetest.settings:get_bool("mcl_misk_recipes.enable_heads", false)
    then
        minetest.register_craft({
            output = "mcl_heads:zombie",
            recipe = {
                { "mcl_mobitems:rotten_flesh", "mcl_mobitems:rotten_flesh", "mcl_mobitems:rotten_flesh" },
                { "mcl_mobitems:spider_eye",   "",                          "mcl_mobitems:spider_eye" },
            }
        })
        -- minetest.register_craft({
        --     output = "mcl_heads:creeper",
        --     recipe = {
        --         { "mcl_mobitems:gunpowder", "mcl_mobitems:gunpowder", "mcl_mobitems:gunpowder" },
        --         { "mcl_mobitems:gunpowder", "",                       "mcl_mobitems:gunpowder" },
        --     }
        -- })
        minetest.register_craft({
            output = "mcl_heads:skeleton",
            recipe = {
                { "mcl_mobitems:bone", "mcl_mobitems:bone", "mcl_mobitems:bone" },
                { "mcl_mobitems:bone", "",                  "mcl_mobitems:bone" },
            }
        })
    end

    if
        minetest.get_modpath("mcl_jukebox")
        and minetest.settings:get_bool("mcl_misk_recipes.enable_jukebox_records", true)
    then
        -- to have different recipes for each record.

        local jukeboxRadomizer = {}

        for craftitem, _ in pairs(minetest.registered_craftitems) do
            if
            -- @todo it ain't much. and it's not very honest work either
            -- gives us plenty to work with though. but could still run out.
                (
                -- why no regular regular expressions lua?
                    string.match(craftitem, 'mcl_core')
                    or string.match(craftitem, 'mcl_dyes?')
                    or string.match(craftitem, 'bone_meal')
                    or string.match(craftitem, 'mcl_nether')
                    or string.match(craftitem, 'mcl_ocean')
                    or string.match(craftitem, 'mcl_mobitems')
                )
                and nil == string.match(craftitem, "enchanted")
            then
                table.insert(jukeboxRadomizer, craftitem)
            end
        end
        --print(dump(jukeboxRadomizer))
        local i = 1
        for key, _ in pairs(mcl_jukebox.registered_records) do
            local randCraftItem = jukeboxRadomizer[i] or ""
            i = i + 1
            minetest.register_craft({
                output = key,
                recipe = {
                    { randCraftItem,        "mcl_core:coal_lump", "mesecons:redstone" },
                    { "mcl_core:coal_lump", "mcl_core:paper",     "mcl_core:coal_lump" },
                    { "mesecons:redstone",  "mcl_core:coal_lump", randCraftItem },
                }
            })
        end
    end

    -- few extra dyes.
    -- there's probably some lore reason why those don't produce dyes.
    if
        minetest.get_modpath("mcl_dyes")
    then
        if minetest.get_modpath("mcl_cherry_blossom") then
            minetest.register_craft({
                output = "mcl_dyes:pink",
                recipe = { { "mcl_cherry_blossom:pink_petals" } },
            })
            -- could also do leaves -> dye but other mods may use leaves for something
        end

        if minetest.get_modpath("mcl_flowers") then
            -- @todo there was a blue flower that annoyingly didn't produce blue dye
            -- will add if found again.
            -- minetest.register_craft({
            --     output = "mcl_dyes:blue",
            --     recipe = {{"mcl_flowers:lapis"}},
            -- })
        end
    end
end)
