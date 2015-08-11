FROM centos:centos7
MAINTAINER Jorge Gois <mail.jgois(at)gmail.com>

RUN yum -y install epel-release
RUN yum -y install openssh-server
RUN yum -y install pwgen

RUN echo 'root:password' | chpasswd

RUN rm -f /etc/ssh/ssh_host_ecdsa_key /etc/ssh/ssh_host_rsa_key && \
    ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_ecdsa_key && \
    ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key

RUN sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config
RUN sed -i "s/HostKey \/etc\/ssh\/ssh\_host\_ed25519\_key/ /g" /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN rm -f /etc/service/sshd/down

RUN mkdir -p /root/.ssh && \
    chmod 700 /root/.ssh && \
    touch /root/.ssh/authorized_keys && \
    chmod 600 /root/.ssh/authorized_keys

#ADD ~/.ssh/id_rsa.pub /root/.ssh/authorized_keys

#RUN cat ~/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
