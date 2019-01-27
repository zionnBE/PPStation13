/datum/emote/living/carbon/human/poop
	key = "poop"
	key_third_person = "poops"

/datum/emote/living/carbon/human/poop/run_emote(mob/living/carbon/human/user, params)

	var/mutable_appearance/shiddoverlay = mutable_appearance('ppstation/icons/poo.dmi')
	shiddoverlay.icon_state = "Shitoverlay"

	message = "poops."
	var/shiddsound = 'ppstation/sound/shidd.ogg'

	if(user.stat != CONSCIOUS)
		to_chat(user, "<span class='warning'>You can't poop while unconscious!</span>")
		return

	if(user.nutrition < NUTRITION_LEVEL_STARVING)
		to_chat(user, "<span class='warning'>You're too hungry to poop!</span>")
		return

	if((user.w_uniform != null) || (user.wear_suit != null && (user.wear_suit.body_parts_covered & GROIN)))
		user.nutrition = user.nutrition - 75
		to_chat(user, "<span class='warning'>You poop yourself!</span>")

		if(!user.shidded) // one layer at a time
			user.add_overlay(shiddoverlay)
			user.shidded = TRUE

		playsound(user, shiddsound, 50, 1, 5)

		new/obj/effect/decal/cleanable/poopdirt(user.loc)
		return



	else

		for(var/obj/structure/toilet/M in get_turf(user))
			if(M.open == TRUE)
				user.nutrition = user.nutrition - 75
				to_chat(user, "<span class='notice'>You take a peaceful dump into the toilet.</span>")
				playsound(user, shiddsound, 30, 1, 5)
				return

		for(var/mob/living/M in get_turf(user))
			if(M == user)
				continue
			else
				M.apply_damage(10,"brute","chest")
				user.log_message("pooped on [key_name(M)]", LOG_ATTACK)
				user.visible_message("<span class='warning'><b>[user]</b> poops on <b>[M]</b>!</span>", "<span class='warning'>You poop on <b>[M]</b>!</span>")

				if(ishuman(M))
					var/mob/living/carbon/human/H = M
					if(!H.shidded) // one layer at a time
						H.add_overlay(shiddoverlay)
						H.shidded = TRUE

		if(user.mind.assigned_role == "Clown")
			//Special clown poop
			user.nutrition = user.nutrition - 75
			new/obj/effect/decal/cleanable/poopdecal/clown(user.loc)

			//Special clown poo code here

			message = pick(	"drops a glitter bomb.",
							"makes a happy mistake.",
							"leaves a present!")


			playsound(user, shiddsound, 50, 1, 5)
			user.visible_message("<b>[user]</b> [message]")

			return

		var/obj/item/organ/butt/B = user.getorgan(/obj/item/organ/butt)
		if(!B)
			//Liquid/spray poop
			message = pick(	"lets loose the juice.",
							"rains hell.",
							"opens the rear valve.",
							"blasts a torrent of diarrhea.",
							"sends for Agent Brown.",
							"brews some hot chocolate.",
							"activates the Mexican jet propulsion!",
							"makes an upside-down hot fudge sundae.",
							"serves hot chili.",
							"serves drippy doo-doo.",
							"splashes some bum gravy.",
							"sprays feces.")

			user.nutrition = user.nutrition - 30
			new/obj/effect/decal/cleanable/poopdecal/liquid(user.loc)

		else
			//Normal poop

			if(user.nutrition > 300)

				message = pick(	"fards and shids.",
								"makes a big poo poo.",
								"makes a poo poo of epic proportions.",
								"fires the rear mortar.",
								"lays cable.",
								"releases massive cargo.",
								"cooks some sausage.",
								"curls some pipe.",
								"drops a brown trout.",
								"makes a core dump.",
								"makes a special delivery.",
								"makes a deposit at the porcelain bank.",
								"saws off a log.",
								"snaps a log.",
								"voids the bowels.",
								"drops a log.")

				user.nutrition = user.nutrition - 75
				new/obj/effect/decal/cleanable/poopdecal(user.loc)

			else

				message = pick(	"fards and shids.",
								"makes a poo poo!",
								"fires the rear guns.",
								"composts.",
								"fertrilizes the station!",
								"opens the cargo hold.",
								"carpet bombs.",
								"bombs the floor.",
								"plants some corn.",
								"releases the barbarians at the gate.",
								"builds a dookie castle!",
								"downloads some brownware.",
								"draws mud.",
								"makes room for lunch.",
								"voids the bowels.",
								"releases a boulder.")

				user.nutrition = user.nutrition - 50
				new/obj/effect/decal/cleanable/poopdecal/pellets(user.loc)


		playsound(user, shiddsound, 50, 1, 5)
		user.visible_message("<b>[user]</b> [message]")