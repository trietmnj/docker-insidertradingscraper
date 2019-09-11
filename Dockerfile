FROM python:3.7.4-slim-buster

WORKDIR /root/Projects/

# MSSQL ODBC adapter
RUN apt-get update &&\
    apt-get install -y gnupg curl g++
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update &&\
    ACCEPT_EULA=Y apt-get install -y msodbcsql17 unixodbc-dev

RUN apt-get install -y git vim cron
RUN git clone https://github.com/trietnguyenjhu/datsup
RUN git clone https://github.com/trietnguyenjhu/dbadapter
RUN git clone https://github.com/trietnguyenjhu/insidertradingscraper

COPY copy/settings.ini /root/Projects/insidertradingscraper/settings.ini
RUN pip install -r insidertradingscraper/requirements.txt
