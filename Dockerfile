FROM mcr.microsoft.com/java/jdk:17-windowsservercore-ltsc2019 AS build

WORKDIR /app
COPY . .

RUN choco install maven -y
RUN mvn clean install

FROM mcr.microsoft.com/java/jre:17-windowsservercore-ltsc2019

EXPOSE 8080

COPY --from=build /app/target/api-0.0.1-SNAPSHOT.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]