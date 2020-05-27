## Demonstration of KIQ platform

1. Clone repo
2. `docker-compose up`

### Mac users

#### Enable file sharing in Docker
1. Go to docker preferences
2. Share the path where you've cloned this repo
3. Restart docker

[XQuartz info taken from here](https://gist.github.com/paul-krohn/e45f96181b1cf5e536325d1bdee6c949)
#### Set up XQuartz
1. Launch XQuartz. Under the XQuartz menu, select Preferences
2. Go to the security tab and ensure "Allow connections from network clients" is checked.
3. Restart XQuartz.

Do the following to run the KY_GUI client:
```
IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
docker run -it --network host -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$IP:0 kiq_demo_ky_gui /target/./ky_gui 127.0.0.1 9009 test
```
