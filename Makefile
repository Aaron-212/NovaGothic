help:
	@echo "###"
	@echo "# Build targets for Nova Gothic"
	@echo "###"
	@echo
	@echo "  make build:  Builds the fonts and places them in the fonts/ directory"
	@echo "  make zip:  Zip all fonts into a zip"
	@echo

build: build.stamp

build.stamp: init.stamp
	fontmake -f src/NovaGothic.glyphspackage -o variable-cff2 --output-dir fonts/variable
	fontmake -i -f src/NovaGothic.glyphspackage -o otf-cff2 --output-dir fonts/static
	python misc/scripts/gen_woff2.py
	touch build.stamp

init: requirements.txt
	pip install -Ur requirements.txt
	touch init.stamp

zip: build.stamp
	cp -rf fonts NovaGothic
	zip -r NovaGothic.zip NovaGothic
	rm -rf NovaGothic

clean:
	rm -rf fonts
	rm build.stamp

update:
	pip install -Ur requirements.txt
