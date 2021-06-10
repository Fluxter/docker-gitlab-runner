FROM gitlab/gitlab-runner:ubuntu

##############################################
## GENERAL ###################################
##############################################
RUN apt update \
    && apt install -y curl unzip software-properties-common gnupg2 zip openjdk-8-jre-headless gradle --no-install-recommends

# Nice packages
RUN apt install -y sshpass ftp lftp

##############################################
## PHP #######################################
##############################################
# TODO!

##############################################
## NODE ######################################
##############################################
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt install -y nodejs
RUN npm install -g ionic cordova@8.1.1 @angular/cli@latest

##############################################
## ANDROID ###################################
##############################################
# Settings
ARG ANDROID_HOME="/opt/android-sdk"
ARG ANDROID_SDK_URL="https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip"
ARG GRADLE_VERSION=5.6.2


# ANDROID STUFF
ENV PATH="$PATH:${ANDROID_HOME}/"
ENV PATH="$PATH:${ANDROID_HOME}/tools"
ENV PATH="$PATH:${ANDROID_HOME}/tools/bin"
ENV PATH="$PATH:${ANDROID_HOME}/build-tools"
ENV PATH="$PATH:${ANDROID_HOME}/platforms"
ENV PATH="$PATH:${ANDROID_HOME}/platform-tools"
ENV ANDROID_HOME="${ANDROID_HOME}"
ENV ANDROID_SDK_URL="${ANDROID_SDK_URL}"
RUN mkdir ${ANDROID_HOME}/ -p
RUN wget -q ${ANDROID_SDK_URL} -O ${ANDROID_HOME}/files.zip
RUN unzip ${ANDROID_HOME}/files.zip -d $ANDROID_HOME/
RUN rm ${ANDROID_HOME}/files.zip

RUN mkdir ~/.android/avd -p \
    && echo $ANDROID_HOME \
    && yes | sdkmanager --licenses \
    && sdkmanager "platform-tools" \
    && sdkmanager "platforms;android-27" "build-tools;27.0.2" \
    && sdkmanager "platforms;android-28" "build-tools;28.0.2" \
    && sdkmanager "platforms;android-29" "build-tools;29.0.2" \
    && chmod 777 /opt/android-sdk
