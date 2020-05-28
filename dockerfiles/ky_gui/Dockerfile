FROM logicp/ky_gui:1.0.0

RUN pacman -Syu git noto-fonts ffmpeg adobe-source-han-sans-kr-fonts --noconfirm
RUN git clone -b simplifyUi --single-branch https://github.com/StronglogicSolutions/ky_gui target

WORKDIR target

RUN ls -la .
RUN qmake ky_gui.pro -spec linux-g++ CONFIG+=debug CONFIG+=qml_debug && make
RUN mkdir /target/config
RUN mkdir -p assets/previews
RUN ln -sf /usr/share/zoneinfo/America/Toronto /etc/localtime

COPY config.json /target/config/config.json
COPY media/ascend.jpg /target/assets/ascend.jpg
COPY media/evil_crab.jpg /target/assets/evil_crab.jpg
COPY media/drive.mp4 /target/assets/drive.mp4

WORKDIR /