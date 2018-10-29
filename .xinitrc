# Désactive beep system
xset b off

# Active la configuration d'xterm (pas sur)
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# Désactive le touchpad (nécessite synaptic)
synclient TouchpadOff=1

# rend les contour plus agréable (nécessaire pour que virtualbox ne freeze pas)
xcompmgr -c &

# resolution sur ecran VGA si ecran VGA branche
intern=LVDS-1
extern=VGA-1

if xrandr | grep "$extern disconnected"; then
   xrandr --output "$extern" --off --output "$intern" --auto --primary
else
   xrandr --output "$intern" --off --output "$extern" --auto --primary --left-of "$intern"
fi

setxkbmap -layout fr

# Lancement de Awesome
exec /usr/bin/awesome >> ~/.cache/awesome/stdout 2>> ~/.cache/awesome/stderr
