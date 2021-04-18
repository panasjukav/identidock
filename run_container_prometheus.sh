docker run -d --name prometheus -p 9090:9090 \
-v $(pwd)/prometheus.conf:/prometheus.conf \
--link cadvisor:cadvisor \
prom/prometheus --config.file=/prometheus.conf


docker run -d --name promdash -p 3000:3000 \
-v /var/prometheus:/var/prometheus \
-v /tmp/prom:/tmp/prom \
-e "DATABASE_URL=sqlite3:/var/prometheus/file.sqlite3" \
--link prometheus:prometheus \
prom/promdash

promdash:
  image: prom/promdash
  ports:
    - "3000:3000"
  environment:
    - DATABASE_URL=sqlite3:/var/prometheus/file.sqlite3
  volumes:
    - "/var/prometheus:/var/prometheus"
    - /tmp/prom:/tmp/prom
  links:
    - prometheus
