FROM logicp/ky_gui:develop

RUN pacman -Syu git flatbuffers base-devel qt5-base --noconfirm
RUN git clone https://github.com/StronglogicSolutions/ky_gui target
WORKDIR target
RUN ls -la .
RUN qmake ky_gui.pro -spec linux-g++ CONFIG+=debug CONFIG+=qml_debug && make