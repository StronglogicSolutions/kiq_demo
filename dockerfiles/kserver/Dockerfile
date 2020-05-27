FROM logicp/kserver:1.0.0

ENV TZ="America/Toronto"
# Get target application
RUN git clone https://github.com/StronglogicSolutions/kserver target
# Build
RUN cd target && git submodule sync && git submodule update --init && BUILD_ENV=CIRCLECI cmake . && make
# Copy config
COPY config.ini /target/config/config.ini
# Copy postgres config
COPY postgresql.conf /postgresql.conf
# Copy execution script for running tasks
COPY execute_script.sh /target/config/execute_script.sh
# Copy example apps
ADD apps/task_test /target/apps/task_test
ADD apps/concurrent_calls /target/apps/concurrent_calls
# Build examples
WORKDIR /target/apps/task_test
RUN g++ main.cpp -o task_test
WORKDIR /target/apps/concurrent_calls
RUN g++ main.cpp -o concurrent_calls
# Create data directory
RUN mkdir /target/data
WORKDIR /