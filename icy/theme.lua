--[[

	Icy Awesome WM theme
	github.com/NatTupper

--]]

local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local os    = { getenv = os.getenv }

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/icy"
theme.wallpaper                                 = theme.dir .. "/wall.png"
theme.font                                      = "DejaVu Sans 10"
theme.fg_normal                                 = "#D4D4D4"
theme.fg_focus                                  = "#0081FF"
theme.fg_urgent                                 = "#00A6FF"
theme.bg_normal                                 = "#151515"
theme.bg_focus                                  = "#313131"
theme.bg_urgent                                 = "#151515"
theme.border_width                              = 1
theme.border_normal                             = "#3F3F3F"
theme.border_focus                              = "#7F7F7F"
theme.border_marked                             = "#CC9393"
theme.tasklist_bg_focus                         = "#151515"
theme.titlebar_bg_focus                         = theme.bg_focus
theme.titlebar_bg_normal                        = theme.bg_normal
theme.titlebar_fg_focus                         = theme.fg_focus
theme.menu_height                               = 24
theme.menu_width                                = 140
theme.awesome_launcher                          = theme.dir .. "/icons/awesome.png"
theme.menu_submenu_icon                         = theme.dir .. "/icons/submenu.png"
theme.taglist_squares_sel                       = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"
theme.layout_tile                               = theme.dir .. "/icons/tile.png"
theme.layout_tileleft                           = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.dir .. "/icons/tiletop.png"
theme.layout_max                                = theme.dir .. "/icons/max.png"
theme.layout_floating                           = theme.dir .. "/icons/floating.png"
theme.widget_ac                                 = theme.dir .. "/icons/ac.png"
theme.widget_battery                            = theme.dir .. "/icons/battery.png"
theme.widget_battery_low                        = theme.dir .. "/icons/battery_low.png"
theme.widget_battery_empty                      = theme.dir .. "/icons/battery_empty.png"
theme.widget_mem                                = theme.dir .. "/icons/mem.png"
theme.widget_cpu                                = theme.dir .. "/icons/cpu.png"
theme.widget_temp                               = theme.dir .. "/icons/temp.png"
theme.widget_net                                = theme.dir .. "/icons/net.png"
theme.widget_hdd                                = theme.dir .. "/icons/hdd.png"
theme.widget_music                              = theme.dir .. "/icons/note.png"
theme.widget_music_on                           = theme.dir .. "/icons/note_on.png"
theme.widget_vol                                = theme.dir .. "/icons/vol.png"
theme.widget_vol_low                            = theme.dir .. "/icons/vol_low.png"
theme.widget_vol_no                             = theme.dir .. "/icons/vol_no.png"
theme.widget_vol_mute                           = theme.dir .. "/icons/vol_mute.png"
theme.widget_mail                               = theme.dir .. "/icons/mail.png"
theme.widget_mail_on                            = theme.dir .. "/icons/mail_on.png"
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true
theme.useless_gap                               = 0
theme.titlebar_close_button_focus               = theme.dir .. "/icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal              = theme.dir .. "/icons/titlebar/close_normal.png"
theme.titlebar_ontop_button_focus_active        = theme.dir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active       = theme.dir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = theme.dir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = theme.dir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active       = theme.dir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = theme.dir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = theme.dir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = theme.dir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active     = theme.dir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = theme.dir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = theme.dir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = theme.dir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active    = theme.dir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = theme.dir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.dir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/titlebar/maximized_normal_inactive.png"

local markup = lain.util.markup
local separators = lain.util.separators

-- Textclock
local clockicon = wibox.widget.imagebox(theme.widget_clock)
local clock = awful.widget.watch(
	"date +'%a %d %b %R'", 60,
	function(widget, stdout)
		widget:set_markup(" " .. markup.font(theme.font, stdout))
	end
)

-- Calendar
theme.cal = lain.widget.calendar({
	attach_to = { clock },
	notification_preset = {
		font = theme.font,
		fg   = theme.fg_normal,
		bg   = theme.bg_normal
	}
})

-- ALSA volume
local volicon = wibox.widget.imagebox()
theme.volume = lain.widget.alsa({
	notification_preset = { font = theme.font, fg = theme.fg_normal },
	settings = function()
		if volume_now.status == "off" then
			volicon:set_image(theme.widget_vol_mute)
		elseif tonumber(volume_now.level) == 0 then
			volicon:set_image(theme.widget_vol_no)
		elseif tonumber(volume_now.level) <= 50 then
			volicon:set_image(theme.widget_vol_low)
		else
			volicon:set_image(theme.widget_vol)
		end

		widget:set_markup(markup.font(theme.font, volume_now.level .. "%"))
	end
})
volicon:buttons(awful.util.table.join (
		awful.button({}, 1, function()
			awful.spawn.with_shell(string.format("%s -e alsamixer", awful.util.terminal))
		end),
		awful.button({}, 2, function()
			awful.spawn(string.format("%s set %s 100%%", theme.volume.cmd, theme.volume.channel))
			theme.volume.update()
		end),
		awful.button({}, 3, function()
			awful.spawn(string.format("%s set %s toggle", theme.volume.cmd, theme.volume.togglechannel or theme.volume.channel))
			theme.volume.update()
		end),
		awful.button({}, 4, function()
			awful.spawn(string.format("%s set %s 1%%+", theme.volume.cmd, theme.volume.channel))
			theme.volume.update()
		end),
		awful.button({}, 5, function()
			awful.spawn(string.format("%s set %s 1%%-", theme.volume.cmd, theme.volume.channel))
			theme.volume.update()
		end)
))

-- MPD
local musicplr = awful.util.terminal .. " -e ncmpcpp"
local mpdicon = wibox.widget.imagebox(theme.widget_music)
mpdicon:buttons(awful.util.table.join(
	awful.button({}, 1, function ()
		awful.spawn.with_shell(musicplr)
	end)
))
theme.mpd = lain.widget.mpd({
	settings = function()
		if mpd_now.state == "play" then
			artist = mpd_now.artist .. "  "
			title  = mpd_now.title  .. ""
			mpdicon:set_image(theme.widget_music_on)
		elseif mpd_now.state == "pause" then
			artist = "mpd "
			title  = "paused "
		else
			artist = ""
			title  = ""
			mpdicon:set_image(theme.widget_music)
		end

		widget:set_markup(markup.font(theme.font, markup(theme.fg_focus, artist) .. title))
	end
})

local mylauncher = awful.widget.button({ image = theme.awesome_launcher })
mylauncher:connect_signal("button::press", function() awful.util.mymainmenu:toggle() end)

-- MEM
local memicon = wibox.widget.imagebox(theme.widget_mem)
local mem = lain.widget.mem({
	settings = function()
		widget:set_markup(markup.font(theme.font, mem_now.used .. "MB"))
	end
})

-- CPU
local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local cpu = lain.widget.cpu({
	settings = function()
		widget:set_markup(markup.font(theme.font, cpu_now.usage .. "%"))
	end
})

-- Coretemp
local tempicon = wibox.widget.imagebox(theme.widget_temp)
local temp = lain.widget.temp({
	settings = function()
		widget:set_markup(markup.font(theme.font, coretemp_now .. "°C"))
	end
})

-- / fs
local fsicon = wibox.widget.imagebox(theme.widget_hdd)
theme.fs = lain.widget.fs({
	options  = "--exclude-type=tmpfs",
	notification_preset = { fg = theme.fg_normal, bg = theme.bg_normal, font = theme.font },
	settings = function()
		widget:set_markup(markup.font(theme.font, fs_now.used .. "%"))
	end
})

-- Battery
local baticon = wibox.widget.imagebox(theme.widget_battery)
local bat = lain.widget.bat({
	settings = function()
		if bat_now.status ~= "N/A" then
			if bat_now.ac_status == 1 then
				widget:set_markup(markup.font(theme.font, "AC"))
				baticon:set_image(theme.widget_ac)
				return
			elseif not bat_now.perc and tonumber(bat_now.perc) <= 5 then
				baticon:set_image(theme.widget_battery_empty)
			elseif not bat_now.perc and tonumber(bat_now.perc) <= 15 then
				baticon:set_image(theme.widget_battery_low)
			else
				baticon:set_image(theme.widget_battery)
			end
			widget:set_markup(markup.font(theme.font, bat_now.perc .. "%"))
		else
			widget:set_markup(markup.font(theme.font, "AC"))
			baticon:set_image(theme.widget_ac)
		end
	end
})

-- Net
local neticon = wibox.widget.imagebox(theme.widget_net)
local net = lain.widget.net({
	settings = function()
		widget:set_markup(markup.font(theme.font,
						markup("#7AC82E", net_now.received)
						.. " / " ..
						markup("#46A8C3", net_now.sent)))
	end
})

-- Systray
local mysystray = wibox.widget.systray()
mysystray:set_base_size(16)

-- Separators
local spr	 = wibox.widget.textbox('  ')

function theme.at_screen_connect(s)
	-- Quake application
	s.quake = lain.util.quake({ app = awful.util.terminal })

	-- If wallpaper is a function, call it with the screen
	local wallpaper = theme.wallpaper
	if type(wallpaper) == "function" then
		wallpaper = wallpaper(s)
	end
	gears.wallpaper.maximized(wallpaper, s, true)

	-- Tags
	awful.tag(awful.util.tagnames, s, awful.layout.layouts)

	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()
	-- Create an imagebox widget which will contains an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(awful.util.table.join(
						awful.button({ }, 1, function () awful.layout.inc( 1) end),
						awful.button({ }, 3, function () awful.layout.inc(-1) end),
						awful.button({ }, 4, function () awful.layout.inc( 1) end),
						awful.button({ }, 5, function () awful.layout.inc(-1) end)))
	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

	-- Create the top wibox
	s.mytopwibox = awful.wibar({ position = "top", screen = s, height = 24, bg = theme.bg_normal, fg = theme.fg_normal })

	-- Add widgets to the top wibox
	s.mytopwibox:setup {
		layout = wibox.layout.align.horizontal,
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			s.mytaglist,
			s.mypromptbox,
			spr,
		},
		spr,
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			wibox.container.margin(mysystray, 0, 0, 4),
			spr,
			mpdicon,
			theme.mpd.widget,
			spr,
			volicon,
			theme.volume.widget,
			spr,
			memicon,
			mem.widget,
			spr,
			cpuicon,
			cpu.widget,
			spr,
			tempicon,
			temp.widget,
			spr,
			fsicon,
			theme.fs.widget,
			spr,
			baticon,
			bat.widget,
			spr,
			neticon,
			net.widget,
			spr,
			clock,
			spr,
		},
	}

	-- Create the bottom wibox
	s.mybotwibox = awful.wibar({ position = "bottom", screen = s, height = 24, bg = theme.bg_normal, fg = theme.fg_normal })

	-- Add widgets to the bottom wibox
	s.mybotwibox:setup {
		layout = wibox.layout.align.horizontal,
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			mylauncher,
		},
		s.mytasklist, -- Middle widget
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			s.mylayoutbox,
		},
	}
end

return theme
