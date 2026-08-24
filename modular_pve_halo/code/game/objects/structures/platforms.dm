/*
 * Platforms
 */
/obj/structure/platform
	name = "platform"
	desc = "A square metal surface resting on four legs."
	icon = 'icons/obj/structures/props/platforms.dmi'
	icon_state = "platform"
	climbable = TRUE
	anchored = TRUE
	density = TRUE
	throwpass = TRUE //You can throw objects over this, despite its density.
	layer = OBJ_LAYER
	breakable = FALSE
	flags_atom = ON_BORDER
	unacidable = TRUE
	unslashable = TRUE
	climb_delay = CLIMB_DELAY_SHORT
	projectile_coverage = PROJECTILE_COVERAGE_NONE

/obj/structure/platform/stair_cut
	icon_state = "platform_stair"//icon will be honked in all dirs except (1), that's because the behavior breaks if it ain't (1)
	dir = 1
/obj/structure/platform/stair_cut/alt
	icon_state = "platform_stair_alt"
	dir = 1


/obj/structure/platform/Initialize()
	. = ..()
	var/image/I = image(icon, src, "platform_overlay", LADDER_LAYER, dir)//ladder layer puts us just above weeds.
	switch(dir)
		if(SOUTH)
			layer = ABOVE_MOB_LAYER+0.1
			I.pixel_y = -16
		if(NORTH)
			I.pixel_y = 16
		if(EAST)
			I.pixel_x = 16
			layer = ABOVE_MOB_LAYER+0.1
		if(WEST)
			I.pixel_x = -16
			layer = ABOVE_MOB_LAYER+0.1
	overlays += I

/obj/structure/platform/initialize_pass_flags(datum/pass_flags_container/PF)
	..()
	if (PF)
		PF.flags_can_pass_all = PASS_OVER

/obj/structure/platform/Collided(atom/movable/AM)
	if(ismob(AM))
		do_climb(AM)
	..()

/obj/structure/platform/BlockedPassDirs(atom/movable/mover, target_dir)
	var/obj/structure/S = locate(/obj/structure) in get_turf(mover)
	if(S && S.climbable && !(S.flags_atom & ON_BORDER) && climbable && isliving(mover)) //Climbable objects allow you to universally climb over others
		return NO_BLOCKED_MOVEMENT

	return ..()

/obj/structure/platform/ex_act()
	return

/obj/structure/platform/attackby(obj/item/W, mob/user)
	. = ..()
	if(user.pulling)
		if(!can_climb(user))
			return
		user.visible_message(SPAN_WARNING("[user] starts dragging \the [user.pulling] onto \the [src]"),\
		SPAN_WARNING("You start dragging \the [user.pulling] onto \the [src]."))
		if(!do_after(user, 3 SECONDS * user.get_skill_duration_multiplier(SKILL_FIREMAN), INTERRUPT_ALL, BUSY_ICON_HOSTILE, user.pulling, INTERRUPT_MOVED, BUSY_ICON_HOSTILE))
			return
		if(user.pulling)
			if(!can_climb(user))
				return
			var/turf/move_to_turf = get_step(get_turf(src), dir)
			user.visible_message(SPAN_WARNING("[user] finishes dragging \the [user.pulling] onto \the [src]"),\
			SPAN_WARNING("You finish dragging \the [user.pulling] onto \the [src]."))
			user.pulling.forceMove(move_to_turf)

/obj/structure/platform_decoration
	name = "platform"
	desc = "A square metal surface resting on four legs."
	icon = 'icons/obj/structures/props/platforms.dmi'
	icon_state = "platform_deco"
	anchored = TRUE
	density = FALSE
	throwpass = TRUE
	layer = OBJ_LAYER
	breakable = FALSE
	flags_atom = ON_BORDER
	unacidable = TRUE
	unslashable = TRUE

/obj/structure/platform_decoration/Initialize()
	. = ..()
	switch(dir)
		if (NORTH)
			layer = ABOVE_MOB_LAYER+0.2
		if (SOUTH)
			layer = ABOVE_MOB_LAYER+0.2
		if (SOUTHEAST)
			layer = ABOVE_MOB_LAYER+0.2
		if (SOUTHWEST)
			layer = ABOVE_MOB_LAYER+0.2

/obj/structure/platform_decoration/initialize_pass_flags(datum/pass_flags_container/PF)
	..()
	if (PF)
		PF.flags_can_pass_all = PASS_OVER

/obj/structure/platform_decoration/ex_act()
	return


// ||COVENANT||

/obj/structure/platform/covenant
	name = "Raised Nanolaminate Platform"
	desc = "A raised piece of nanolaminate metal. You could probably climb it."
	icon = '/icons/halo/obj/structures/props/cov_platforms.dmi'
	icon_state = "cov_platform"

/obj/structure/platform_decoration/covenant
	name = "Raised Nanolaminate Corner"
	desc = "A rounded corner of nanolaminate."
	icon = '/icons/halo/obj/structures/props/cov_platforms.dmi'
	icon_state = "cov_platform_deco"

/obj/structure/platform_decoration/covenant/alt
	icon_state = "cov_platform_deco_alt"
