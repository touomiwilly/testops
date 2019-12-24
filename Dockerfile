FROM devopsedu/webapp

# Run an update
RUN apt-get update

# Install curl
RUN apt-get install -y curl
RUN apt-get install -y git
RUN apt-get install -y wget
RUN apt-get install -y unzip

# Install php
# RUN apt-get install -y php7.2-cli php-curl php-zip php-mbstring

# Install java 8 (will be used for selenium tests)
RUN apt-get install -y openjdk-8-jdk openjdk-8-jre

# Create the tree /var/www/selenium/php-webriver
# RUN mkdir -p /var/www/selenium/php-webdriver

# Copy our project files into /var/www/selenium
RUN rm -f /var/www/html/*
RUN git clone https://github.com/touomiwilly/testops.git /var/www/html

# Copy the selenium framework for php inside /var/www/selenium
#COPY php-webdriver /var/www/selenium/php-webdriver

RUN wget https://chromedriver.storage.googleapis.com/2.41/chromedriver_linux64.zip
RUN unzip chromedriver_linux64.zip
RUN mv chromedriver /usr/bin/chromedriver
RUN chown root:root /usr/bin/chromedriver
RUN chmod +x /usr/bin/chromedriver

# Install google chrome: https://gist.github.com/phith0n/9a5f36ec91d3dd0736e86b6cd10959b4
RUN export CHROME_BIN=/usr/bin/google-chrome
RUN export DISPLAY=:99.0
RUN apt-get update
RUN apt-get install -y libappindicator1 fonts-liberation libasound2 libgconf-2-4 libnspr4 libxss1 libnss3 xdg-utils
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome*.deb

COPY testCertProj.jar /var/www/html/testCertProj.jar

CMD "java -jar /var/www/html/testProj.jar"

# Copy chromedriver command
#COPY /usr/bin/chromedriver /usr/bin/chromedriver
#RUN chmod +x /usr/bin/chromedriver

#
#COPY selenium-server-standalone-3.13.0.jar /var/www/selenium

# Install facebook/php-webdriver
#RUN composer require facebook/webdriver
