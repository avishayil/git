FROM phusion/baseimage:master-arm

LABEL Avishay Bar <avishay.il@gmail.com>

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN apt update && \
    apt install -y git openssh-server

RUN echo "deb https://dl.bintray.com/sobolevn/deb git-secret main" | sudo tee -a /etc/apt/sources.list && \
    wget -qO - https://api.bintray.com/users/sobolevn/keys/gpg/public.key | sudo apt-key add - && \
    apt update && sudo apt-get install git-secret -y

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME /git
WORKDIR /git

ENTRYPOINT ["git"]
CMD ["--help"]
