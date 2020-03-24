diablo2()
{
if [ $(hostname) = "tobi-yoga" ]; then
    sudo mount /opt/Diablo2/LOD-CD/diablo2-LoD.iso /mnt
    cd '/opt/Diablo2/Mod PlugY/'
    wine '/opt/Diablo2/Mod PlugY/PlugY.exe' > /dev/null 2>&1
fi
if [ $(hostname) = "ThinkPad.local.tobias-weiss.org" ]; then
    cd '/media/weiss/Windows8_OS/Diablo2/Mod PlugY'
    sudo mount /media/weiss/Windows8_OS/Diablo2_CDs/LOD/diablo2-LoD.iso /mnt
    wine '/media/weiss/Windows8_OS/Diablo2/Mod PlugY/PlugY.exe' > /dev/null 2>&1
    echo "Don't forget t osave characters"
    echo "run save_d2"
fi
}

save_d2()
{
cp '/media/weiss/Windows8_OS/Diablo2/Save/*' ~/dotfiles/d2_save
cd ~/dotfiles
git commit -m "d2 save" && git push
git push
}

restore_d2()
{
cd ~/dotfiles
git pull
if [ $(hostname) = "tobi-yoga" ]; then
    cp ~/dotfiles/d2_save/* '/opt/Diablo2/Diablo2/Save/' 
fi
if [ $(hostname) = "ThinkPad.local.tobias-weiss.org" ]; then
    cp ~/dotfiles/d2_save/* '/media/weiss/Windows8_OS/Diablo2/Save/' 

fi
}
