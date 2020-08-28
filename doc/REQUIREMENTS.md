# Bookmark Merge Requirements

run with the command:
`bookmarkmerge.py input='path/to/file/or/folder' output='path/to/file/or/folder'`

1. Scan unprocessed input file (or files in folder).
  1. Extract the bookmark data (i.e. url, title, tags and folder structure).
  2. Compare it with previously saved bookmark data.
  3. Save unique urls directly (benchmark RAM vs HDD).
  4. Append new (unique) tags to previously saved bookmark data.
  5. Record every duplicate's different folder locations.

2. Resume in case of user pausing or unexpectedly terminating.
  1. Mark (or keep track of) last scanned file and bookmark.

3. Show a folder hierarchy presenting all bookmark information.
  1. Highlight bookmarks that appear in more than one location.
  2. Navigate the different locations.
  3. Select a single location for the bookmark.
  4. Edit bookmark tags.
      
3. Write merged bookmark structure
  1. Build every bookmark as a HTML list element representation.
  2. Build the folder hierarchy as a HTML structure representation.
  3. Sandwich the HTML list between a header and a footer to complete the structure of('path/to/merged_bookmarks.html').
