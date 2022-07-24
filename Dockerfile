FROM tomcat
#test
COPY /target/*.war /usr/local/tomcat/webapps/
