# Docker 镜像可以从其他镜像继承。在本指南中，您将使用 Eclipse Temurin，这是最流行的官方映像之一，具有可构建的 JDK。
FROM eclipse-temurin:17-jdk-jammy
LABEL authors="matt liu"
# 若要在运行其余命令时简化操作，请设置映像的工作目录。这将指示 Docker 使用此路径作为所有后续命令的默认位置。通过执行此操作，您不必键入完整的文件路径，但可以使用基于工作目录的相对路径。
WORKDIR /app
# 加入Maven和Pom文件
COPY .mvn/ .mvn
COPY mvnw pom.xml ./
# 运行Maven
RUN ./mvnw dependency:resolve
# 加入源码
COPY src ./src
# 镜像在容器中运行的命令
CMD ["./mvnw", "spring-boot:run"]


# 让容器启动后立即显示系统的进程和资源使用情况。
ENTRYPOINT ["top", "-b"]