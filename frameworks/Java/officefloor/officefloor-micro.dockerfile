FROM maven:3.6.1-jdk-11-slim as maven
WORKDIR /officefloor
COPY src src
WORKDIR /officefloor/src/woof_benchmark_micro
RUN mvn -q clean package

FROM openjdk:11.0.3-jre-slim
WORKDIR /officefloor
COPY --from=maven /officefloor/src/woof_benchmark_micro/target/woof_benchmark_micro-1.0.0.jar server.jar
CMD ["java", "-server", "-Xms2g", "-Xmx2g", "-XX:+UseNUMA", "-Dhttp.port=8080", "-Dhttp.server.name=OF", "-Dhttp.date.header=true", "-jar", "server.jar"]
