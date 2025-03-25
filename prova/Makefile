clean:
	@find . -xdev -iname \*~    -print -delete
	@find . -xdev -iname \*.aux -print -delete
	@find . -xdev -iname \*.log -print -delete
	-rm -f texput.log
	-rm -f *.log *.lot *.lof
	-rm -f *.toc *.bbl *.blg
	-rm -f *.acr *.smb *.glo
	-rm -f *.acn *.alg *.ist *.out
	-rm -f *.glsdefs*.fls *.fdb_latexmk *.synctex*
	
purge: clean
	@rm -f *.pdf

save: clean
	-mv *.pdf 2024/	

prova:
	./compila.sh 2024/$(filename).tex
	-mv *.pdf 2024/
	$(MAKE) clean
