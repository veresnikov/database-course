# database-course

4 лаба, бд logistic

## как запустить:

1) docker-compose up -d
2) docker exec -it database-server bash
3) ./migrations/run-migration path-to-migrations-dir up

example: ./migrations/run-migration migrations/logistic up
