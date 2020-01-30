FROM ubuntu:14.04.5

# Install some core software
RUN apt-get update && apt-get install -y wget g++ make \
    apt-transport-https software-properties-common curl git libssl-dev libcurl4-gnutls-dev vim locales \
    && rm -rf /var/lib/apt/lists/*

# Set up the components needed for format support for cdo
RUN apt-get update && apt-get install -y \
    nco netcdf-bin libhdf5-dev zlib1g-dev libjasper-dev libnetcdf-dev libgrib-api-dev \
    && rm -rf /var/lib/apt/lists/*

# Install cdo from source, so that we get other format support
WORKDIR /tmp
RUN wget https://code.mpimet.mpg.de/attachments/download/16435/cdo-1.9.3.tar.gz -O /tmp/cdo-1.9.3.tar.gz \
    && tar -xzvf cdo-1.9.3.tar.gz \
    && cd /tmp/cdo-1.9.3 \
    && ./configure --enable-netcdf4 --enable-zlib --with-netcdf=/usr/ --with-hdf5=/usr/ --with-grib_api=/usr/ \
    && make \
    && make install \
    && rm -rf /tmp/*

RUN locale-gen fr_FR.UTF-8
ENV LANG fr_FR.UTF-8
ENV LANGUAGE fr_FR:en
ENV LC_ALL fr_FR.UTF-8

RUN sh -c 'echo "deb https://cloud.r-project.org/bin/linux/ubuntu trusty-cran35/" >> /etc/apt/sources.list'
RUN gpg --keyserver keyserver.ubuntu.com --recv-key E298A3A825C0D65DFD57CBB651716619E084DAB9
RUN gpg -a --export E298A3A825C0D65DFD57CBB651716619E084DAB9 | sudo apt-key add -

RUN apt-get update \
        && apt-get install -y --no-install-recommends \
                r-base \
                r-base-dev \
                r-recommended \
        && echo 'options(repos = c(CRAN = "https://cloud.r-project.org"), download.file.method = "libcurl")' >> /etc/R/Rprofile.site \
        && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /data && chmod 777 /data
WORKDIR /data

COPY env.R /data/
COPY ncdf4.helpers.tar.gz /data/
COPY libxml2-dev.deb /data/
RUN dpkg -i libxml2-dev.deb
RUN Rscript env.R


RUN apt-get update && apt-get install -y python-pip python-dev build-essential \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir code \
    && mkdir hdfs \
    && mkdir code/out \
    && mkdir code/le_correcteur \
    && mkdir code/eurocordex_VELIZY \
    && mkdir code/observations_VELIZY

RUN pip install hdfs

ENV HDFSCLI_CONFIG /data/hdfs
ENV HDFSCLI_CONFIG /data/hdfs/.hdfscli.cfg

COPY hdfscli.cfg /data/hdfs/.hdfscli.cfg
COPY hdfs_list.py /data/code/
COPY run.sh /data/code/

WORKDIR /data/code/

CMD ["bash", "run.sh"]








