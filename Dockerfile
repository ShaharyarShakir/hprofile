FROM openjdk:11  AS builder
RUN apt-get update && apt-get install -y maven
COPY ./ vprofile-project
RUN cd vprofile-project && mvn  install

FROM tomcat:0-jre11
LABEL "Project"="VProfile"
LABEL "Author"="shaharyar"
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=builder /vprofile-project/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
