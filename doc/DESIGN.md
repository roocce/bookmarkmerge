
# Analysis and Design

### Invocation forms

* Use one argument to specify the input file
  `bookmarkmerge input_file.html`

* Use one argument to specify the input directory
  `bookmarkmerge path/to/input/files/`

* Use more than one argument to specify first the output file path and then the input file(s) (many files)
  `bookmarkmerge path/to/output_file.html input1.html input2.html ...`

* Use more than one argument to specify the output file path and the input directory
  `bookmarkmerge path/to/output_file.html path/to/input/files/`



### File structure

*file header*
html
meta
title
h1

*elements*
dl (definition list)
	> dl (nested category)
    > dt (no closing tag)

dt (definition term)
	> h3 (category title)
	> a ('anchor', represents the actual bookmark)

*element attributes*
h3
  > FOLDED
  > ADD_DATE
  > LAST_MODIFIED
(pending research on PERSONAL_TOOLBAR_FOLDER and UNFILED_BOOKMARKS_FOLDER)

a
  > HREF
  > ADD_DATE
  >	LAST_MODIFIED
  > ICON
  > ICON_URI


### Data Structures
* *Mapfile*
    * ProcessedFiles
    * CurrentFile
    * Offset

* *Bookmark*
  * href (url)
  * added (date)
  * last_modified (date)
  * category (list) <- make this a single element

* *Category*
  * Parent category (folder)
  * added (date)
  * last_modified (date)


### Use Cases

A file is `processed` until all its bookmarks are read and categorized.
If the process is interrupted, write a file describing the status.
Upon running the script, check if there is a status file.
Proceed from where it left off the previous session.


new bookmarks, one category
Chromium (doesn't support tags)
* Software
  * Internet Explorer
  * Cortana
  * Safari
  * Siri
  * Chrome (mobile app)
  * Google Assistant

old bookmarks, rename category
new bookmarks, nested category
old bookmarks, uncategorized
Firefox
* Software
  * Mac
	* Safari (web browser)
	* Siri (assistant)
  * Linux
    * Epiphany (web browser)
	* Firefox (web browser)
* Software
  * Twitch Stream Manager
* Chrome (mobile, web browser)
* Google Assistant (assistant, mobile)


new bookmark, duplicate category
append tags
Firefox
* Mac
  * Safari (webkit)
* Linux
    * Epiphany (webkit)
	* Firefox (gecko)
* Software
  * OBS Studio

<!--
  old bookmarks, different categories
  Webkit (safari/epiphany)
  * Windows Software
	* url1
	* url2
  * Mac Software
	* url3
	* url4
  * Android apps
	* url5
	* url6
-->
  
