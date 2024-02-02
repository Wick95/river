# 使用Eclipse Temurin作为基础镜像
FROM eclipse-temurin:17-jdk-jammy

LABEL authors="matt liu"

# 设置工作目录
WORKDIR /app

# 复制Maven和pom.xml文件
COPY .mvn/ .mvn
COPY mvnw pom.xml ./

# 运行Maven解析依赖
RUN ./mvnw dependency:resolve

# 复制源代码
COPY src ./src

# 构建应用
RUN ./mvnw package -DskipTests

# 复制构建的jar文件到/app.jar
RUN cp target/*.jar /app.jar

# 设置容器启动时运行的命令
COPY start.sh /start.sh
RUN chmod +x /start.sh
ENTRYPOINT ["/start.sh"]