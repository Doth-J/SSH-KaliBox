# Kali Linux latest
FROM kalilinux/kali-rolling

USER root
# Updates, upgrade, autoremove and clean
RUN apt -y update && DEBIAN_FRONTEND=noninteractive apt -y dist-upgrade && apt -y autoremove && apt clean

# Common and useful tools
RUN apt -y install curl wget git net-tools traceroute pciutils ssh nano

WORKDIR /box
COPY init.sh /box/init.sh

# If you are using Windows, uncomment below
RUN sed -i 's/\r$//' /box/init.sh

EXPOSE 22

ENTRYPOINT [ "/box/init.sh" ]
