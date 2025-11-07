FROM eclipse-temurin:21

LABEL maintainer="hars30896@gmail.com"

WORKDIR /app

COPY target/DevopsPrac-0.0.1-SNAPSHOT.jar /app/DevopsPrac-0.0.1-SNAPSHOT.jar

ENTRYPOINT ["java", "-jar", "DevopsPrac-0.0.1-SNAPSHOT.jar"]
