FROM kasmweb/core-ubuntu-jammy:1.11.0
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME
######### Customize Container Here ###########

# Change Background to hacker
COPY assets/mr-robot-wallpaper.png  /usr/share/extra/backgrounds/bg_default.png

# Install VScode
COPY ./src/ubuntu/install/vs_code $INST_SCRIPTS/vs_code/
RUN bash $INST_SCRIPTS/vs_code/install_vs_code.sh  && rm -rf $INST_SCRIPTS/vs_code/

RUN apt update
RUN apt -y upgrade
RUN apt -y install neofetch htop nano
RUN apt -y autoremove

######### End Customizations ###########
RUN chown 1001:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME
# Applying dark theme
COPY assets/xsettings.xml  /home/kasm-user/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml
RUN chown -R 1001:0 $HOME
