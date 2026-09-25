# Remove default Tomcat apps (optional, for a clean slate)
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR file into the Tomcat webapps directory
# Rename it to ROOT.war for root path deployment
COPY target/TrainBook-1.0.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# Expose default Tomcat port
EXPOSE 8080

# Start Tomcat (default CMD in base image)
CMD ["catalina.sh", "run"]
