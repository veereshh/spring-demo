FROM openjdk:11
ADD target/demo-0.0.1-SNAPSHOT.jar springboot-demo-project.jar
ENTRYPOINT ["java","-jar","springboot-demo-project.jar"]