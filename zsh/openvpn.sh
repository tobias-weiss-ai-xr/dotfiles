openvpn_start_and_watch()
{
if [ $(hostname) = "tobi-yoga" ]; then
    sudo systemctl start openvpn-client@client.service; sudo watch systemctl status openvpn-client@client.service
fi
if [ $(hostname) = "ThinkPad.local.tobias-weiss.org" ]; then
    sudo systemctl start openvpn@client && sudo watch systemctl status openvpn@client
fi
}
