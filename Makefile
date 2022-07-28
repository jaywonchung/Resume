.PHONY: resume

resume:
	sed -e "s/PHONE_NUMBER/+1 (xxx) xxx-xxxx/" -e "s/EMAIL_ADDRESS/xxxxxxxx@umich.edu/" resume.tex > _resume.tex
	latexmk -xelatex _resume.tex
	rm _resume.tex
	mv _resume.pdf resume.pdf

clean:
	rm *.aux *.fdb_latexmk *.fls *.log *.out *.pdf *.xdv
