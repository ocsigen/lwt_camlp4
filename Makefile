.PHONY : build
build :
	jbuilder build --dev

.PHONY : install-for-packaging-test
install-for-packaging-test : clean
	opam pin add --yes --no-action lwt_camlp4 .
	opam reinstall --yes lwt_camlp4

.PHONY : packaging-test
packaging-test :
	ocamlfind opt -syntax camlp4o -package lwt,lwt_camlp4 -c test/user.ml
	ocamlfind opt -package lwt -linkpkg -o test/a.out test/user.cmx
	test/a.out
	rm -f test/*.cm* test/*.o test/*.obj test/a.out

.PHONY : clean
clean :
	jbuilder clean
