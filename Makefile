content := $(wildcard content/*.md themes/even/sass/*.scss themes/even/static/* themes/even/templates/*.html themes/even/templates/categories/*.html  themes/even/templates/shortcodes/*.html themes/even/templates/tags/*.html)
build: content/.built

all: build deploy

content/.built: $(content)
	zola build -o public/
	touch content/.built

publish: build
	cd public
	gsutil -m rsync -d -r public gs://jeremy.marzhillstudios.com/

clean:
	rm -f content/.built
	rm -rf generated/*
