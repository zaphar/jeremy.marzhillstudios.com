content := $(wildcard content/*.md themes/even/sass/*.scss themes/even/static/* themes/even/templates/*.html themes/even/templates/categories/*.html  themes/even/templates/shortcodes/*.html themes/even/templates/tags/*.html public/static/pdf/*.pdf public/static/img/*)
build: content/.built static/pdf/resume-jeremy-wall.pdf

all: build deploy

content/.built: $(content) static/pdf/resume-jeremy-wall.pdf
	nix-shell -p zola --command "zola build -o public/"
	touch content/.built

resume: static/pdf/resume-jeremy-wall.pdf

static/pdf/resume-jeremy-wall.pdf: resume/resume.sil resume/resume.lua
	mkdir -p static/pdf/
	mkdir -p ~/.local/share/fonts
	cp resume/.fonts/* ~/.local/share/fonts/
	nix-shell -p sile --command "sile --debug classes -o $@ resume/resume.sil"

publish: build
	cd public
	gsutil -m rsync -d -r public gs://jeremy.marzhillstudios.com/

clean:
	rm -f content/.built
	rm -rf generated/*
