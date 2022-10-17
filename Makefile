.PHONY: resume

PHOME_NUMBER ?= +1 (xxx) xxx-xxxx
EMAIL_ADDRESS ?= xxx@umich.edu

resume:
	sed -e "s/PHONE_NUMBER/$(PHONE_NUMBER)/" -e "s/EMAIL_ADDRESS/$(EMAIL_ADDRESS)/" resume.tex > _resume.tex
	latexmk -xelatex _resume.tex
	rm _resume.tex
	mv _resume.pdf resume.pdf

clean:
	rm *.aux *.fdb_latexmk *.fls *.log *.out *.pdf *.xdv *.synctex.gz
