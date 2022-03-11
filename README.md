# database-course

4 лаба, бд logistic
как запустить:
docker-compose up -d
docker exec -it database-server bash
./migrations/run-migration path-to-migrations-dir up
example: ./migrations/run-migration migrations/logistic up
