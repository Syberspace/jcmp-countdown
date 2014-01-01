jcmp-countdown
==============

JC-MP Countdown

This is a little JC-MP Module which allows you to start a countdown for all players on the server

__Commands:__
```
/countdown or /cd - Starts the default countdown (10 seconds)
/cd <amount> - Starts a countdown for <amount> seconds
/cd stop or /countdown stop - Stops the current countdown, can only be used by the player who started the countdown
/cd help or /countdown help - Displays the available commands in chat
```
All commands can also be viewed by pressing F5


[This script requires CommandManager by Ahrotahntee](http://www.jc-mp.com/forums/index.php/topic,3364.0.html)

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
