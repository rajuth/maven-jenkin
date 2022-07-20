FROM tomcat9
COPY /target/*.war /usr/local/tomcat/webapps/
