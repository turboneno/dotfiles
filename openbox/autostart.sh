numlockx on &
ivman &
conky &
conky -c /home/moreno/.conkyrc2 &
feh --bg-scale ~/.wallpapers/wallpaper.jpg &
#xcompmgr -cC -t-3 -l-5 -r5 &
# Just in case some random app calls on Nautilus, lets set some safeguards to minimise the impact:
# Disable Nautilus desktop, because we really really do not want it!
gconftool-2 -s -t bool /apps/nautilus/preferences/show_desktop false &
# Do not let Nautilus set the background, because we really really do not want this either.
gconftool-2 -s -t bool /desktop/gnome/background/draw_background false &
# Make Nautilus use spatial mode, should start-up quicker.
gconftool-2 -s -t bool /apps/nautilus/preferences/always_use_browser false &
# Make Nautilus show the advanced permissions dialog -- if it has to start, lets at least make it usable :) 
gconftool-2 -s -t bool /apps/nautilus/preferences/show_advanced_permissions true &
# And finally...
# ...start dropbox daemon, but give it a minute so we can establish a net connection.
(sleep 60s && ~/.dropbox-dist/dropboxd) &
#chromium-browser &
#firefox &
