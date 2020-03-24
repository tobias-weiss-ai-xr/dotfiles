diablo2()
{
cd ~/dotfiles/d2_save
git pull
if [ $(hostname) = "tobi-yoga" ]; then
    sudo mount /opt/Diablo2/LOD-CD/diablo2-LoD.iso /mnt
    wine '/opt/Diablo2/Diablo II.exe' > /dev/null 2>&1
fi
if [ $(hostname) = "ThinkPad.local.tobias-weiss.org" ]; then
    sudo mount /media/weiss/Windows8_OS/Diablo2_CDs/LOD/diablo2-LoD.iso /mnt
    wine '/media/weiss/Windows8_OS/Diablo2/Diablo II.exe' > /dev/null 2>&1
fi
}

save_d2()
{
cp /media/weiss/Windows8_OS/Diablo2/Save/* ~/dotfiles/d2_save
git commit -m "d2 save" && git push
~/gitfull.sh
}
