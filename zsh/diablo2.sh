diablo2()
{
if [ $(hostname) = "tobi-yoga" ]; then
    sudo mount /opt/Diablo2/LOD-CD/diablo2-LoD.iso /mnt
    wine '/opt/Diablo2/Diablo II.exe' > /dev/null 2>&1 &
fi
}
