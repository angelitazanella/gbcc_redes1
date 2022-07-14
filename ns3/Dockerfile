FROM ubuntu:22.04

# General dependencies
RUN apt-get update && apt-get install -y \
  install build-essential \
  libsqlite3-dev \
  libboost-all-dev \
  libssl-dev \
  git \
  python3-setuptools \
  castxml \
  install \
  gir1.2-goocanvas-2.0 \
  gir1.2-gtk-3.0 \
  libgirepository1.0-dev \
  python3-dev \
  python3-gi \
  python3-gi-cairo \
  python3-pip \
  python3-pygraphviz \
  python3-pygccxml \
  g++ \
  pkg-config \
  sqlite3 \
  qt5-default \
  mercurial \
  ipython3 \
  openmpi-bin \
  openmpi-common \
  openmpi-doc \
  libopenmpi-dev \
  autoconf \
  cvs \
  bzr \
  unrar \
  gdb \
  valgrind \
  uncrustify \
  doxygen \
  graphviz \
  imagemagick \
  python3-sphinx \
  dia \
  tcpdump \
  libxml2 \
  libxml2-dev \
  cmake \
  libc6-dev \
  libc6-dev-i386 \
  libclang-6.0-dev \
  llvm-6.0-dev automake

RUN pip3 install kiwi

# NS-3

# Create working directory
RUN mkdir -p /usr/ns3
WORKDIR /usr

# Fetch NS-3 source
RUN wget http://www.nsnam.org/release/ns-allinone-3.33.tar.bz2
RUN tar -xf ns-allinone-3.33.tar.bz2

# Configure and compile NS-33 
RUN cd ns-allinone-3.33 && ./build.py --enable-examples --enable-tests

RUN ln -s /usr/ns-allinone-3.33/ns-3.33/ /usr/ns3/

# Cleanup
RUN apt-get clean && \
  rm -rf /var/lib/apt && \
  rm /usr/ns-allinone-3.26.tar.bz2