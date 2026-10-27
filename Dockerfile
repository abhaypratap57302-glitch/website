# Base image required by the project
FROM hshar/webapp

# Copy the website (index.html and the images folder) into the web server folder
ADD . /var/www/html

# The web server listens on port 80
EXPOSE 80
