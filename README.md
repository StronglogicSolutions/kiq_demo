## Demonstration of KIQ platform

1. Clone repo
2. `docker-compose up`

### Mac users

Do the following to run the KY_GUI client:
```
IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
docker run -it --network host -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$IP:0 kiq_demo_ky_gui /target/./ky_gui 127.0.0.1 9009 test
```
