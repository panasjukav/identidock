FROM python:3.8

RUN groupadd -r uwsgi && useradd -r -g uwsgi uwsgi

RUN pip install --upgrade pip
RUN pip install flask uwsgi requests redis
WORKDIR /app
COPY app /app
COPY cmd.sh /

EXPOSE 9090 9191
USER uwsgi

CMD ["/cmd.sh"]