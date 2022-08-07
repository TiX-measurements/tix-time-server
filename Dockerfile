FROM openjdk:8u342-oraclelinux8 AS build

WORKDIR /root/

COPY . .
RUN ./gradlew fatJar

# ----- final image ------

FROM amazoncorretto:8u342-alpine3.15-jre

WORKDIR /root/tix-time-server

COPY --from=build /root/build/libs/tix-time-server-all-*.jar tix-time-server.jar

EXPOSE 4500/udp 8080/tcp
CMD ["java", "-jar", "./tix-time-server.jar"]
