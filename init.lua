-- Unsolicited Crafting recipes.
-- 2023 (c) Ketwaroo

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
