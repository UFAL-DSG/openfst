FROM      ubuntu:14.04
MAINTAINER Ondrej Platek <oplatek@ufal.mff.cuni.cz>

#
# Install PyKaldi.
#

# Prerequesities
RUN apt-get update
RUN apt-get install -y build-essential git wget

WORKDIR /app
RUN git clone https://github.com/UFAL-DSG/openfst/
WORKDIR /app/openfst
RUN ./configure --prefix=`pwd`/../docker_ubuntu1404-openfst --enable-static --enable-shared --enable-far --enable-ngram-fsts CXX=g++ LIBS="-ldl"
RUN make install

WORKDIR /app/
RUN tar cvzf docker_ubuntu1404-openfst.tar.gz  docker_ubuntu1404-openfst
RUN echo "On ubuntu 14.04 you have to set just LD_LIBRARY_PATH or use ldconfig or copy to system folder
to start using openfst/lib. Similarly for headers (include), and binaries (bin)"
