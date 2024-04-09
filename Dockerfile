FROM centos:7.6.1810

ARG bundler_version=2.0.2
ARG ruby_install_version=0.7.0
ARG ruby_version=2.3.3
ARG nodejs_major_version=10

ENV LANG en_US.UTF-8

RUN yum install -y epel-release && \
    yum install -y gcc-c++ make bzip2 zip git && \
    yum clean all

RUN curl -L https://rpm.nodesource.com/setup_${nodejs_major_version}.x | bash - && \
    yum install -y nodejs && \
    npm install -g grunt

RUN curl -L https://github.com/postmodern/ruby-install/archive/v${ruby_install_version}.tar.gz -o ruby-install-${ruby_install_version}.tar.gz && \
    tar -xvzf ruby-install-${ruby_install_version}.tar.gz && \
    make -C ruby-install-${ruby_install_version} install && \
    ruby-install --system ruby ${ruby_version} && \
    rm -rf ruby-install-${ruby_install_version}

RUN gem install bundler -v ${bundler_version}

RUN rpm --import http://yum-repository.platform.aws.chdev.org/RPM-GPG-KEY-platform-noarch && \
    yum install -y yum-utils && \
    yum-config-manager --add-repo http://yum-repository.platform.aws.chdev.org/platform-noarch.repo && \
    yum install -y platform-tools-common-1.0.6 && \
    yum clean all
