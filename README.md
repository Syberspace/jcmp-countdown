JC-MP Countdown
==============

This is a little JC-MP Module which allows you to start a countdown for all players on the server

__Commands:__

_/countdown_ or _/cd_ - Starts the default countdown (10 seconds)  
_/cd <amount>_ or _/countdown <amount>_ - Starts a countdown for <amount> seconds  
_/cd stop_ or _/countdown stop_ - Stops the current countdown, can only be used by the player who started the countdown  
_/cd help_ or _/countdown help_ - Displays the available commands in chat  

All commands can also be viewed by pressing F5


__Installation__

_with git_
```
cd /path/to/your/server/scripts/
mkdir countdown
cd countdown
git pull https://github.com/Syberspace/jcmp-countdown.git
```

_without git_
```
cd /path/to/your/server/scripts
wget https://github.com/Syberspace/jcmp-countdown/archive/master.zip
unzip master.zip
rm master.zip
mv jcmp-countdown-master countdown
```


now you can load the module by typing `load countdown` into your server-console
