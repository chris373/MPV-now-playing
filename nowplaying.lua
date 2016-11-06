function col(s, fg, bg)
	c = ''
	n = ''
	if fg == -1 and bg == -1 then
		return n .. s 
	elseif bg == -1 then
		return c .. fg .. s 
	else
		return c .. fg .. "," .. bg .. s 
	end
end

function write_now_playing_to_clipboard()
	filename = mp.get_property("filename")

	pos = mp.get_property("time-pos")
	posstr = os.date("!%X",pos)
	dur = mp.get_property("duration")
	durstr =  os.date("!%X",dur)
	perc = pos/dur
	pcount = perc * 20
	bars = col("[", -1, -1)
	for i=0, 20 do
		if i <= pcount then
			bars = bars .. col("|", 9, -1)	
		else
			bars = bars .. col("|", 4, -1)	
		end		
	end
	bars = bars .. col("]", -1, -1) 
	nowplaying = "/me is now watching " ..  filename .. " " .. bars .. " " .. posstr .. "/" .. durstr .. " " .. col("MPV", 13, -1)
	os.execute("echo '" .. nowplaying .. "' | xclip -selection clipboard")
end

mp.add_key_binding("n", "now_playing", write_now_playing_to_clipboard)

