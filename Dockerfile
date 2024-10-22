FROM 416670754337.dkr.ecr.eu-west-2.amazonaws.com/ci-node-build-20

# Dependencies for running Ruby Sass.
RUN dnf install -y ruby-devel gcc-c++ && \
    dnf clean all
