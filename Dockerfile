ARG DEBIAN_FRONTEND=noninteractive

FROM ubuntu:24.04
RUN apt-get update \
&& apt-get dist-upgrade -y \
&& apt-get autoremove -y \
&& apt-get autoclean -y \
&& apt-get install -y \
sudo \
nano \
wget \
curl \
git \
build-essential \
gcc \
openjdk-21-jdk \
mono-complete \
python3 \
strace \
valgrind
RUN useradd -G sudo -m -d /home/olebj -s /bin/bash -p "$(openssl passwd -1 123)" olebj
USER olebj
WORKDIR /home/olebj
RUN mkdir hacking \
&& cd hacking \
&& curl -SL https://raw.githubusercontent.com/uia-worker/is105misc/master/sem01v24/pawned.sh > pawned.sh \
&& chmod 764 pawned.sh \
&& cd ..
RUN git config --global user.email "olebo@uia.no"\
&& git config --global user.name "oleols1" \
&& git config --global url."https://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:@github.com".insteadOf "https://github.com" \
&& mkdir -p github.com/oleols1
USER root
RUN curl -SL https://go.dev/dl/go1.21.7.linux-amd64.tar.gz \ | tar xvz -C /usr/local
USER olebj
SHELL ["/bin/bash", "-c"]
RUN mkdir -p $HOME/go/{src,bin}
ENV GOPATH="/home/olebj/go"
ENV PATH="${PATH}:${GOPATH}/bin:/usr/local/go/bin"
RUN curl --proto '=https' --tlsv1.3 https://sh.rustup.rs -sSf \
| sh -s -- -y
ENV PATH="${PATH}:${HOME}/.cargo/bin"