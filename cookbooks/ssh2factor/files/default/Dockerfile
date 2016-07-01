FROM phusion/baseimage

CMD ["/sbin/my_init", "--enable-insecure-key"]

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN rm -f /etc/service/sshd/down && /etc/my_init.d/00_regen_ssh_host_keys.sh

RUN apt-get update && \
    apt-get install libpam-google-authenticator --yes && \
    echo "auth required pam_google_authenticator.so" >> /etc/pam.d/sshd && \
    sed -i -e 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config && \
    sed -i -e 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config && \
    sed -i -e 's/#PasswordAuthentication no/PasswordAuthentication no/g' /etc/ssh/sshd_config && \
    sed -i -e 's/UsePAM no/UsePAM yes/g' /etc/ssh/sshd_config && \
    sed -i -e 's/#UsePAM yes/UsePAM yes/g' /etc/ssh/sshd_config && \
    echo "AuthenticationMethods publickey,keyboard-interactive" >> /etc/ssh/sshd_config && \
    sed -i -e 's/#@include common-auth/@include common-auth/g' /etc/pam.d/sshd && \
    sed -i -e 's/@include common-auth/#@include common-auth/g' /etc/pam.d/sshd

RUN echo "#!/bin/sh \n google-authenticator --time-based --disallow-reuse --force --no-rate-limit --window-size=21 --secret=/root/.google_authenticator" > /etc/my_init.d/generate_secret_key &&  \
    chmod +x /etc/my_init.d/generate_secret_key