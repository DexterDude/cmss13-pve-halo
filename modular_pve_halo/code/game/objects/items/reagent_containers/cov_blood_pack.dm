#define BLOOD_BAG_INJECTING 1
#define BLOOD_BAG_TAKING 0

/obj/item/reagent_container/blood/covenant
	name = "nanolaminate blood case"
	desc = "A nanolaminate case designed to store blood at cold temperatures. On one end of it is an attachment point that heats the blood before it enters the flexible IV tube."
	icon_state = "covbloodpack"
	icon = 'icons/halo/obj/items/cov_medical.dmi'

/obj/item/reagent_container/blood/covenant/update_icon()
	var/percent = floor((reagents.total_volume / volume) * 100)
	overlays = null
	underlays = null

	if(reagents && reagents.total_volume)
		var/image/filling = image('icons/halo/obj/items/chemistry.dmi', src, "[icon_state]10")

		switch(percent)
			if(1 to 9) filling.icon_state = "[icon_state]10"
			if(10 to 19) filling.icon_state = "[icon_state]20"
			if(20 to 29) filling.icon_state = "[icon_state]30"
			if(30 to 39) filling.icon_state = "[icon_state]40"
			if(40 to 49) filling.icon_state = "[icon_state]50"
			if(50 to 59) filling.icon_state = "[icon_state]60"
			if(60 to 69) filling.icon_state = "[icon_state]70"
			if(70 to 79) filling.icon_state = "[icon_state]80"
			if(80 to 89) filling.icon_state = "[icon_state]90"
			if(90 to INFINITY) filling.icon_state = "[icon_state]100"

		filling.color = mix_color_from_reagents(reagents.reagent_list)
		underlays += filling

/obj/item/reagent_container/blood/covenant/sangheili
	name = "(sangheili) nanolaminate blood case"
	desc = "A nanolaminate case designed to store blood at cold temperatures. On one end of it is an attachment point that heats the blood before it enters the flexible IV tube. Intended for sangheili blood."
	bag_initial_reagents = list("sangheiliblood" = 300)

/obj/item/reagent_container/blood/covenant/ruuhtian
	name = "(ruuhtian) nanolaminate blood case"
	desc = "A nanolaminate case designed to store blood at cold temperatures. On one end of it is an attachment point that heats the blood before it enters the flexible IV tube. Intended for ruuhtian blood."
	bag_initial_reagents = list("ruuhtianblood" = 300)

/obj/item/reagent_container/blood/covenant/unggoy
	name = "(unggoy) nanolaminate blood case"
	desc = "A nanolaminate case designed to store blood at cold temperatures. On one end of it is an attachment point that heats the blood before it enters the flexible IV tube. Intended for unggoy blood."
	bag_initial_reagents = list("unggoyblood" = 300)

/obj/item/reagent_container/blood/covenant/saline
	name = "nanolaminate saline case"
	desc = "A nanolaminate case designed to store saline at cold temperatures. On one end of it is an attachment point that heats the blood before it enters the flexible IV tube."
	bag_initial_reagents = list("saline" = 300)

#undef BLOOD_BAG_INJECTING
#undef BLOOD_BAG_TAKING
