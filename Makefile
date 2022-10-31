build:
	docker build --pull --rm -f "Dockerfile" -t chrony:latest "."

run:
	docker run --rm chrony

shell:
	docker run -it --rm chrony sh
