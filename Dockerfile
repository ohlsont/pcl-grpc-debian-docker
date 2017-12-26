FROM grpc/cxx

# PCL
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
      make cmake build-essential git \
      libeigen3-dev \
      libflann-dev \
      libusb-1.0-0-dev \
      libvtk6-qt-dev \
      libpcap-dev \
      libboost-all-dev \
      libproj-dev \
      && rm -rf /var/lib/apt/lists/*

RUN git config --global http.sslVerify false && \
    git clone --branch pcl-1.8.1 --depth 1 https://github.com/PointCloudLibrary/pcl.git pcl-trunk

RUN cd pcl-trunk && \
    mkdir build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release ..

RUN cd pcl-trunk && cd build && \
    make -j 1 && make install && \
    make clean

RUN ldconfig

#Other code
