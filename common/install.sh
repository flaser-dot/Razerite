  
ui_print " "
ui_print "    *******************************************"
ui_print "
  ╔═══╗╔═══╗╔════╗╔═══╗╔═══╗╔══╗╔════╗╔═══╗
  ║╔═╗║║╔═╗║╚══╗═║║╔══╝║╔═╗║╚╣─╝║╔╗╔╗║║╔══╝
  ║╚═╝║║║─║║──╔╝╔╝║╚══╗║╚═╝║─║║─╚╝║║╚╝║╚══╗
  ║╔╗╔╝║╚═╝║─╔╝╔╝─║╔══╝║╔╗╔╝─║║───║║──║╔══╝
  ║║║╚╗║╔═╗║╔╝═╚═╗║╚══╗║║║╚╗╔╣─╗──║║──║╚══╗
  ╚╝╚═╝╚╝─╚╝╚════╝╚═══╝╚╝╚═╝╚══╝──╚╝──╚═══╝
  "
ui_print "    *******************************************"
ui_print "    *             VERSION 2.6                *"
ui_print "    *******************************************"
ui_print "    * By LordVicky, RKBDI, Jaymin & MarcAnt01 *"
ui_print "    *******************************************"
ui_print " "
ui_print " "
ui_print "|S|t|a|r|t|i|n|g| |I|n|s|t|a|l|l|a|t|i|o|n|"
ui_print ""

#RazerCortex Installation:

ui_print "****************************"
ui_print "*   Install RazerCortex?   *"
ui_print "*                          *"
ui_print "*VolUp = Yes, VolDown = No.*"
ui_print "****************************"

if $VKSEL; then
  ui_print ""
  ui_print "Installing RazerCortex..."
  mkdir -p $MODPATH/system/app/RazerCortex
  mv $MODPATH/Apps/RazerCortex $MODPATH/system/app
else 
  ui_print ""
  ui_print "Skipping RazerCortex...."
  rm -rf $MODPATH/system/app/RazerCortex
fi
ui_print ""

#Razer Walls Installation:

ui_print "****************************"
ui_print "*   Install Razer Walls    *"
ui_print "*    and Live Wallpaper?   *"
ui_print "*VolUp = Yes, VolDown = No.*"
ui_print "****************************"

if $VKSEL; then   
  ui_print ""  
  ui_print "Instaling RazerWalls..."   
  mkdir -p $MODPATH/system/priv-app/RazerWalls
  mkdir -p $MODPATH/system/priv-app/RazerLiveWall  
  mv $MODPATH/Apps/RazerWalls $MODPATH/system/priv-app
  mv $MODPATH/Apps/RazerLiveWall $MODPATH/system/priv-app
else 
  ui_print ""      
  ui_print "Skipping RazerWalls and Live Wallpaper..."   
  rm -rf $MODPATH/Apps/RazerWalls 
  rm -rf $MODPATH/Apps/RazerLiveWall

fi

ui_print "Note: You can find the live wall in Wallpaper<LiveWallpapers<"

#Razer Services Installation:

ui_print "*******************************************"
ui_print "*   Install Razer Services? (Recommended) *"
ui_print "*                                         *"
ui_print "*      VolUp = Yes, VolDown = No.         *"
ui_print "*******************************************"

if $VKSEL; then
  ui_print ""
  ui_print "Instaling Razer Serivces..."
  mkdir -p $MODPATH/system/priv-app/RazerServices
  mv $MODPATH/Apps/RazerServices $MODPATH/system/priv-app
else 
  ui_print "" 
  ui_print "Skipping RazerServices..."
  rm -rf $MODPATH/Apps/RazerServices
fi

ui_print ""

#Razer Permissions Installation:

ui_print "**********************************************"
ui_print "*   Install Razer Permissions? (Recommended) *"
ui_print "*                                            *"
ui_print "*       VolUp = Yes, VolDown = No.           *"
ui_print "**********************************************"

if $VKSEL; then
  ui_print ""
  ui_print "Installing Razer Permissions..."
  mkdir -p $MODPATH/etc/permissions
  mv $MODPATH/etc/permissions $MODPATH/etc/product
else 
  ui_print "Skipping Razer Permissions..."
  rm -rf $MODPATH/etc
fi

ui_print ""

#Razer Boot Animation isntallation:
ui_print "**********************************"
ui_print "*   Install Razer Bootanimation? *"
ui_print "*                                *"
ui_print "*   VolUp = Yes, VolDown = No.   *"
ui_print "**********************************"
if $VKSEL; then
  ui_print ""
  ui_print "Downloading Razer Bootanimation...This will take a while..."
  mkdir -p $MODPATH/Bootanimation
  curl -L -k -o $MODPATH/Bootanimation/bootanimation.zip https://github.com/LordVicky/Razerite_Files/raw/master/bootanimation.zip
  ui_print ""
  ui_print "Downloading complete. Commencing Installation..."
  
#Sony Bootanimation Script:

#Mount functions, to monut /oem in sony devices. Thanks a ton to: (https://github.com/ironydelerium)

is_mounted_rw() {
  cat /proc/mounts | grep -q " `readlink -f $1` " | grep -q " rw," 2>/dev/null
  return $?
}

mount_rw() {
  mount -o remount,rw $1
  DID_MOUNT_RW=$1
}

unmount_rw() {
  if [ "x$DID_MOUNT_RW" = "x$1" ]; then
    mount -o remount,ro $1
  fi
}
# is_mounted script thanks to (https://github.com/skittles9823)
if [ -d /oem/media ]; then
      is_mounted " /oem" || mount /oem
      is_mounted_rw " /oem" || mount_rw /oem
      is_mounted " /oem/media" || mount /oem/media
      is_mounted_rw " /oem/media" || mount_rw /oem/media
      mv /oem/media/bootanimation.zip /oem/media/bootanimation/bootanimation.zip
      cp_ch $MODPATH/Bootanimation/bootanimation.zip $MODPATH/oem/media
fi

#Andoird 10 Multiple bootanimation support script:
for i in /system/media/*bootanimation*; do
    cp_ch $MODPATH/Bootanimation/bootanimation.zip $MODPATH/$i
  if [ -f /system/media/bootanimation-dark.zip ]; then
    cp_ch $MODPATH/Bootanimation/bootanimation.zip $MODPATH/system/media/bootanimation-dark.zip
  fi
done

  for d in /system/product/media/*bootanimation*; do
    cp_ch $MODPATH/Bootanimation/bootanimation.zip $MODPATH/$d
    if [ -f /system/product/media/bootanimation-dark.zip ]; then
      cp_ch $MODPATH/Bootanimation/bootanimation.zip $MODPATH/system/product/media/bootanimation-dark.zip
    fi
  done
  ui_print ""
  ui_print "Bootanimation Installation complete"
else rm -r $MODPATH/Bootanimation/bootanimation.zip

fi

#Razer Media Sound Installation:

ui_print "********************************************"
ui_print "*   Install Razer UI sounds and Ringtones? *"
ui_print "*                                          *"
ui_print "*      VolUp = Yes, VolDown = No.          *"
ui_print "********************************************"

if $VKSEL; then
  ui_print ""
  ui_print "Installing Razer UI Sound and Ringtones..."
  if [ -d /system/media/audio ]; then
    cp_ch -r $MODPATH/Media/audio $MODPATH/system/media/audio
  elif [ -d /system/product/media/audio ]; then
    cp_ch -r $MODPATH/Media/audio $MODPATH/system/product/media/audio
  fi
else 
  ui_print "Skipping UI Sounds and Ringtones..."
  rm -rf $MODPATH/Media/audio
fi



ui_print "
░░░░▓
░░░▓▓
░░█▓▓█
░██▓▓██
░░██▓▓██
░░░██▓▓██
░░░░██▓▓██
░░░░░██▓▓██
░░░░██▓▓██
░░░██▓▓██
░░██▓▓██
░██▓▓██
░░██▓▓██
░░░██▓▓██
░░░░██▓▓██
░░░░░██▓▓██
░░░░██▓▓██
░░░██▓▓██
░░██▓▓██
░██▓▓██
░░██▓▓██
░░░██▓▓██
░░░░██▓▓██
░░░░░██▓▓██
░░░░██▓▓██
░░░██▓▓██
░░██▓▓██
░██▓▓██
░░██▓▓██
░░░██▓▓██
░░░░██▓▓██
░░░░░██▓▓██
░░░░██▓▓██
░░░██▓▓██
░░██▓▓██
░██▓▓██
░░██▓▓██
░░░██▓▓██
░░░░██▓▓██
░░░░░██▓▓██
░░░░██▓▓██
░░░██▓▓██
░░██▓▓██
░██▓▓██
░░██▓▓██
░░░██▓▓██
░░░░██▓▓██
░░░░░██▓▓██
░░░░██▓▓██
░░░██▓▓██
░░██▓▓██
░░██▓▓██
░░██▓▓██
░░██▓▓██
░  ██▓▓██
░░██▓▓██
░░░██▓▓███
░░░░██▓▓████
░░░░░██▓▓█████
░░░░░░██▓▓██████
░░░░░░███▓▓███████
░░░░░████▓▓████████
░░░░█████▓▓█████████
░░░█████░░░█████●███
░░████░░░░░░░███████
░░███░░░░░░░░░██████
░░██░░░░░░░░░░░████
░░░░░░░░░░░░░░░░███
░░░░░░░░░░░░░░░░

            
              By Gamers.
              For Gamers.
"
