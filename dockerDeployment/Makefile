init:
	./up.sh

shutdown: 
	docker-compose down --volumes 

removeAllImages: 
	docker rmi -f $(shell docker images -q)