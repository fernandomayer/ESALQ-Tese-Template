Tese.pdf: Tese.tex \
	referencias/bibliografia.bib template/Template_Tese.sty \
	pre-textual/*.tex \
	textual/*.tex \
	pos-textual/*.tex

	xelatex Tese.tex
	# O sinal de "menos" é para ignorar erros e prosseguir
	# Eles não são importantes no caso do bibtex
	-bibtex Tese1
	-bibtex Tese2
	-bibtex Tese3
	xelatex Tese.tex
	xelatex Tese.tex
	xelatex Tese.tex
	rm *.aux *.bbl *.blg *.log *.toc
