FROM ubuntu:20.04

RUN apt-get -y update && \
        apt-get -y install openssh-server

RUN mkdir /run/sshd


# Create a user account named 'user' and unlock it
RUN useradd user -d /home/user \
      && sed -i -e's/^user:!!:/user:\*:/' /etc/shadow \
      && mkdir -p /home/user/.ssh \
      && touch /home/user/.ssh/authorized_keys \
      && chmod 700 /home/user/.ssh \
      && chmod 600 /home/user/.ssh/authorized_keys \
      && chown -R user:user /home/user/.ssh

EXPOSE 22

COPY run.sh /run.sh

CMD ["/run.sh"]
