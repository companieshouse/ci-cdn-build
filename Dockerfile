FROM centos:7.6.1810

ARG ruby_install_version=0.7.0

ARG ruby_version=2.3.3

ENV LANG en_US.UTF-8

ARG nodejs_major_version=10

RUN yum install -y epel-release

RUN yum install -y gcc-c++ make bzip2 zip git

RUN yum clean all

RUN curl --silent --location https://rpm.nodesource.com/setup_${nodejs_major_version}.x | bash -

RUN yum install -y nodejs

RUN npm install -g grunt

RUN curl -L https://github.com/postmodern/ruby-install/archive/v${ruby_install_version}.tar.gz -o ruby-install-${ruby_install_version}.tar.gz

RUN tar -xvzf ruby-install-${ruby_install_version}.tar.gz

RUN cd ruby-install-${ruby_install_version} && make install

RUN cd ~ && rm -rf ruby-install-${ruby_install_version}

RUN ruby-install --system ruby ${ruby_version}

RUN gem install bundler

