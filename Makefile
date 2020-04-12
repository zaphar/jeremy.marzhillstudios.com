build: content/.built

all: build deploy

content/.built: 
	zola build -o public/
	touch content/.built

deploy: build
	cd public
	gsutil -m rsync -d -r public gs://jeremy.marzhillstudios.com/

clean:
	rm -f content/.built
	rm -rf generated/*
