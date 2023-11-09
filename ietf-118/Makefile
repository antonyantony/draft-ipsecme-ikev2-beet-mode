all: antony-ietf-118-slides.pdf

antony-ietf-118-slides.pdf: slides.md
	pandoc -t beamer $< -o $@

pull:
	rsync -aPv laya-a:/home/a/git/beet/ietf-118/* .
