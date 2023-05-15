#!/bin/bash

# Get the text from the clipboard
text=$(wl-paste)

# Translate the text
# $(trans -p "$text")
translation=$(trans :zh "$text")

# Wrap the translation at 80 characters
wrapped_translation=$(echo "$translation" | awk '
     BEGIN {width = 70}
     {
         if (length($0) > width) {
             split($0, a, " ");
             line = a[1];
             for (i = 2; i <= length(a); i++) {
                 if (length(line) + length(a[i]) > width) {
                     print line;
                     line = a[i];
                 } else {
                     line = line " " a[i];
                 }
             }
             print line;
         } else {
             print;
         }
}')

# Display the result with rofi
echo "$wrapped_translation" | rofi -dmenu -p "Translation"
