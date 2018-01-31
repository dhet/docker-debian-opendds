FROM debian

ENV OPENDDS_VERSION 3.12

RUN apt-get update && \
    apt-get install -y \
    curl \
		wget \
    g++ \
    make \
    perl-base \
    perl-modules \
    libdata-dumper-simple-perl && \
		cd /opt && \
    wget -qO- http://download.objectcomputing.com/OpenDDS/OpenDDS-${OPENDDS_VERSION}.tar.gz | tar xvz && \
		cd /opt/OpenDDS-${OPENDDS_VERSION} && \
    ./configure --prefix=/usr/local --no-tests && \
    make && \
    make install && \
		cp -a /opt/OpenDDS-${OPENDDS_VERSION}/ACE_wrappers/MPC /usr/local/share/ace/MPC && \
    cp -Lr /opt/OpenDDS-${OPENDDS_VERSION}/ACE_wrappers/lib/* /usr/local/lib && \
    rm -rf /opt/OpenDDS-${OPENDDS_VERSION}

ENV ACE_ROOT=/usr/local/share/ace \
    TAO_ROOT=/usr/local/share/tao \
    DDS_ROOT=/usr/local/share/dds \
    MPC_ROOT=/usr/local/share/ace/MPC \
    PATH=".:/usr/local/share/ace/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" 

WORKDIR /opt/workspace

