diablo2()
{
~/gitfull.sh
if [ $(hostname) = "tobi-yoga" ]; then
    sudo mount /opt/Diablo2/LOD-CD/diablo2-LoD.iso /mnt
    wine '/opt/Diablo2/Diablo II.exe' > /dev/null 2>&1 &
fi
if [ $(hostname) = "ThinkPad.local.tobias-weiss.org" ]; then
    sudo mount /media/weiss/Windows8_OS/Diablo2_CDs/LOD/diablo2-LoD.iso /mnt
    wine '/media/weiss/Windows8_OS/Diablo2/Diablo II.exe' > /dev/null 2>&1 &
fi
cp /media/weiss/Windows8_OS/Diablo2/ ~/dotfiles/d2_save
~/gitfull.sh
}
