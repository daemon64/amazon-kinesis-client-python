FROM centos:7
MAINTAINER Bishal Paul <bishal.paul@go-mmt.com>

RUN yum update -y

RUN yum install -y \
    java-1.8.0-openjdk \
    java-1.8.0-openjdk-devel \
    wget \
    tar \
    gcc \
    openssl-devel \
    bzip2-devel \
    make

# Install python the dirty way
WORKDIR /usr/src
RUN wget https://www.python.org/ftp/python/2.7.16/Python-2.7.16.tgz
RUN tar -xvzf Python-2.7.16.tgz
WORKDIR /usr/src/Python-2.7.16/
RUN ./configure --enable-optimizations
RUN make altinstall
# Install python pip
WORKDIR /

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python get-pip.py
RUN pip install --upgrade pip

RUN yum clean all

ENV BOOTSTRAP_SERVERS "default_value"
ENV CONSUMER_GROUP_ID "default_value"
ENV JAVA_PATH "default_value"
ENV STREAM_NAME "default_value"
ENV APPLICATION_NAME "PythonKCLSample"
ENV AWS_CREDENTIALS_PROVIDER "DefaultAWSCredentialsProviderChain"
ENV INITIAL_POSITION_IN_STREAM "TRIM_HORIZON"
ENV REGION_NNAME "ap-south-1"
ENV PUSH_TOPIC "default_value"

RUN mkdir code
COPY ./ code/

RUN pip install -r code/requirements.txt

WORKDIR /code/

RUN python setup.py download_jars
RUN python setup.py install


RUN chmod +x ./spinUp.sh

ENTRYPOINT ["/bin/bash", "-c", "./spinUp.sh"]