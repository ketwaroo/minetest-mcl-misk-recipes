Unsolicited Crafting Reipes for Mineclonia
==========================================

This is a companion mod for [k_recyclebin](https://content.minetest.net/packages/ketwaroo/k_recyclebin/)

And no it's not a typo. `misk` instead of `misc` to keep up the `k` naming theme of my mods and to avoid collisions in case someone else comes up with an actually useful list of miscellaneous recipes in the future.

### But, Why?

In `mineclonia`, and other minecraft clones, there are many items that can be found in the wild that cannot be crafted.

For example, saddles and various horse armors.

If you are using the recycle bin in `k_recyclebin`, it sets a damper on things to discover that you cannot break down those items and have to resort to having a lava pool in your back yard, use them as really inadequate fuel sources, or even toss em down a chasm somewhere.

It is a limited use mod but it adds the options to get some useful materials out of these misc items.

### Recipes included

These are best guess recipes. I've taken some liberties here.

 * Saddle `mcl_mobitems:saddle`
 * ~~leather horse armor~~ doesn't exist in mineclonia right now. It should though. Will investigate later if bored.
 * Iron Horse Armor `mcl_mobitems:iron_horse_armor`
 * Golden Horse Armor `mcl_mobitems:gold_horse_armor`
 * Diamond Horse Armor `mcl_mobitems:diamond_horse_armor`
 * Various records `mcl_jukebox:record_*` (see notes below)
 * A few rare heads (disabled by default)
 * Cherry blossom pink petals -> pink dye.

Check settings for this mod to enable/disable a few things.

## IMPORTANT

### Mineclone 2 not technically supported.

Mineclone 2/5 not supported. I don't have those installed locally, at least for now. I prefer the cherry blossom biomes of Mineclonia way more, and so should you. Many of the item names are shared between those minecraft clones so it may work to some extent. Supply a pull request if something is broken on your end in Mineclone 2.

### Jukebox records (and other randomness)

Some items like vinyl records never had any business being craftable. To be able to differentiate between each record, some random craft item is used in each recipe. Because I'm lazy and there's nothing you can do to stop me, the randomness is programmatic and determined at load time. So each time you create a server, the recipe for each record can be different from last time.

Currently limited to music records but there may be other non craftables that will use the same strategy.
