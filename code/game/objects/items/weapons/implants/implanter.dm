/obj/item/weapon/implanter
	name = "implanter"
	desc = "A sterile automatic implant injector."
	icon = 'icons/obj/items.dmi'
	icon_state = "implanter0"
	item_state = "syringe_0"
	throw_speed = 3
	throw_range = 5
	w_class = 2.0
	origin_tech = "materials=1;biotech=3;programming=2"
	materials = list(MAT_METAL=600, MAT_GLASS=200)
	var/obj/item/weapon/implant/imp = null


/obj/item/weapon/implanter/update_icon()
	if(imp)
		icon_state = "implanter1"
		origin_tech = imp.origin_tech
	else
		icon_state = "implanter0"
		origin_tech = initial(origin_tech)


/obj/item/weapon/implanter/attack(mob/living/carbon/M, mob/user)
	if(!iscarbon(M))
		return
	if(user && imp)
		if(M.head && (M.head.flags & THICKMATERIAL))
			user << "<span class='warning'>[M]'s [M.head.name] is in the way! Take it off first!</span>"
			return
		M.visible_message("<span class='warning'>[user] is attemping to implant [M].</span>")

		var/turf/T = get_turf(M)
		if(T && (M == user || do_after(user, 50)))
			if(user && M && (get_turf(M) == T) && src && imp)
				if(M.head && (M.head.flags & THICKMATERIAL))
					return
				if(imp.implant(M, user))
					user << "<span class='notice'>You implant the implant into [M].</span>"
					M.visible_message("[user] has implanted [M].", "<span class='notice'>[user] implants you with the implant.</span>")
					imp = null
					update_icon()

/obj/item/weapon/implanter/attackby(obj/item/weapon/W, mob/user, params)
	..()
	if(istype(W, /obj/item/weapon/pen))
		var/t = stripped_input(user, "What would you like the label to be?", name, null)
		if(user.get_active_hand() != W)
			return
		if(!in_range(src, user) && loc != user)
			return
		if(t)
			name = "implanter ([t])"
		else
			name = "implanter"

/obj/item/weapon/implanter/New()
	..()
	spawn(1)
		update_icon()

/obj/item/weapon/implanter/loyalty
	name = "implanter-loyalty"

/obj/item/weapon/implanter/loyalty/New()
	imp = new /obj/item/weapon/implant/loyalty(src)
	..()
	update_icon()


/obj/item/weapon/implanter/explosive
	name = "implanter-explosive"

/obj/item/weapon/implanter/explosive/New()
	imp = new /obj/item/weapon/implant/explosive(src)
	..()
	update_icon()


/obj/item/weapon/implanter/adrenalin
	name = "implanter (adrenalin)"

/obj/item/weapon/implanter/adrenalin/New()
	imp = new /obj/item/weapon/implant/adrenalin(src)
	..()


/obj/item/weapon/implanter/emp
	name = "implanter (EMP)"

/obj/item/weapon/implanter/emp/New()
	imp = new /obj/item/weapon/implant/emp(src)
	..()

/obj/item/weapon/implanter/chemminer
	name = "implanter-Stimulant"

/obj/item/weapon/implanter/chemminer/New()
	imp = new /obj/item/weapon/implant/chemminer(src)
	..()
