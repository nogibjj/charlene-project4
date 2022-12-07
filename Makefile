install:
	pip install --upgrade pip &&\
		pip install -r requirements.txt

test:
	echo "Not implemented yet"
	#python -m pytest -vv test_*.py

build:
	#build container
	docker build -t deploy-fastapi .

run:
	#run docker
	docker run -p 127.0.0.1:8080:8080 11a4cf733e93

deploy:
	#deploy
	aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 012818259982.dkr.ecr.us-east-1.amazonaws.com
	docker build -t 706proj4 .
	docker tag 706proj4:latest 012818259982.dkr.ecr.us-east-1.amazonaws.com/706proj4:latest
	docker push 012818259982.dkr.ecr.us-east-1.amazonaws.com/706proj4:latest

format:	
	black *.py src/*.py

lint:
	pylint --disable=R,C --ignore-patterns=test_.*?py *.py mylib/*.py

refactor: format lint

all: install lint deploy
