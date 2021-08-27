.PHONY: resume

resume:
	sed -e "s/PHONE_NUMBER/+82 10-0000-0000/" -e "s/EMAIL_ADDRESS/email@null.ac.kr/" resume.tex > _resume.tex
	latexmk -xelatex _resume.tex
	rm _resume.tex
	mv _resume.pdf resume.pdf

clean:
	rm *.aux *.fdb_latexmk *.fls *.log *.out *.pdf *.xdv
