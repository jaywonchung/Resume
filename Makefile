.PHONY: resume cv common

PHOME_NUMBER ?= +1 (xxx) xxx-xxxx
EMAIL_ADDRESS ?= xxx@umich.edu

resume: common
	sed -e "s/PHONENUMBER/$(PHONENUMBER)/" -e "s/EMAILADDRESS/$(EMAILADDRESS)/" resume.tex > _resume.tex
	latexmk -xelatex _resume.tex
	rm _resume.tex
	mv _resume.pdf resume.pdf

cv: common
	sed -e "s/PHONENUMBER/$(PHONENUMBER)/" -e "s/EMAILADDRESS/$(EMAILADDRESS)/" cv.tex > _cv.tex
	latexmk -xelatex _cv.tex
	rm _cv.tex
	mv _cv.pdf cv.pdf

common:
	python scripts/update_open_source_metrics.py

clean:
	rm *.aux *.fdb_latexmk *.fls *.log *.out *.pdf *.xdv *.synctex.gz || true
