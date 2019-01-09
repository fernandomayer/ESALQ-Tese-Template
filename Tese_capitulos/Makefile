Tese.pdf: Tese.tex referencias/bibliografia.bib template/Template_Tese.sty pre-textual/TodasInformações.tex pre-textual/Agradecimentos.tex pre-textual/Biografia.tex pre-textual/Dedicatoria.tex pre-textual/Epigrafe.tex pre-textual/ListaAbreviaturas.tex pre-textual/ListaSimbolos.tex pre-textual/Resumo.tex textual/Introdução.tex textual/MatMet.tex textual/Resultados.tex textual/Discussão.tex pos-textual/Anexos.tex pos-textual/Apêndices.tex
	xelatex Tese.tex
	# O sinal de "menos" é para ignorar erros e prosseguir
	# Eles não são importantes no caso do bibtex
	-bibtex Tese.aux
	xelatex Tese.tex
	xelatex Tese.tex
	rm *.aux *.bbl *.blg *.log *.toc *.lof *.lot
