
.PHONY: all clean

all: gmm7550-vcard.png

clean:
	rm -f *.png

%-vcard.png: %.vcard
	qrencode -o $@ -r $< -t png -s 5 -d 300
