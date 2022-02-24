sudo mkdir -p /usr/local/share/fonts/ttf
sudo cp *.ttf /usr/local/share/fonts/ttf/
fc-cache
fc-list | grep SS14
fc-list | grep Jost
