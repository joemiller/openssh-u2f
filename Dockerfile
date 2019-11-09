FROM centos:8

RUN dnf install -y \
      gcc \
      git \
      autoconf \
      zlib-devel \
      openssl-devel \
      make

WORKDIR /src

RUN groupadd -g 74 -r sshd \
      && useradd -c "Privilege-separated SSH" -u 74 -g sshd -s /sbin/nologin -r -d /var/empty/sshd sshd

RUN git clone https://github.com/openssh/openssh-portable \
      && cd openssh-portable \
      && autoreconf \
      && ./configure --prefix /usr/local/openssh-u2f \
      && make -j$(nproc) \
      && make install

# Create a user account named 'user' and unlock it
RUN useradd user -d /home/user \
      && sed -i -e's/^user:!!:/user:\*:/' /etc/shadow \
      && mkdir /home/user/.ssh \
      && touch /home/user/.ssh/authorized_keys \
      && chmod 700 /home/user/.ssh \
      && chmod 600 /home/user/.ssh/authorized_keys \
      && chown -R user:user /home/user/.ssh

EXPOSE 22

COPY run.sh /run.sh

CMD ["/run.sh"]
