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

COPY testCertProj.jar /var/www/html/testCertProj.jar

#CMD "/usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java -jar /var/www/html/testProj.jar"

# Copy chromedriver command
#COPY /usr/bin/chromedriver /usr/bin/chromedriver
#RUN chmod +x /usr/bin/chromedriver

#
#COPY selenium-server-standalone-3.13.0.jar /var/www/selenium

# Install facebook/php-webdriver
#RUN composer require facebook/webdriver
