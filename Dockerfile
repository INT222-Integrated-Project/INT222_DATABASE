FROM mysql
COPY ./productcase ./productcase
ENV MYSQL_ROOT_PASSWORD=myprojectcase
EXPOSE 3306