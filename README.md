# Shinobue Plugin for MuseScore 4
<img src="https://github.com/nebarnix/ShinobuePluginMuseScore4/blob/main/shinobue_notation_8hon/Shinobue_Notation.png" width="250">

A plugin to add Shinobue Notation text to your music for an 8-Hon choshi
(Other hon choshi can be added upon request)

This adds the text as the first lyrical position. If you want lyrics, then make sure they're in the second or greater (or add them AFTER the notation is added?)

Bonus: As the shinobue is a transposing instrument (it plays +1 octave up) it is neccesary to transpose the staff an octave if you wish to match the playback pitch with the instrument. The plugin checks the stafff position vs the MIDI pitch number, and uses this to correct for the transposition (in fact for any number of transposed octaves up or down). 

If notes are selected, only those will be labeled. If the notes exceed what is playable on a shinobue, a '?' will be added. 

Let's be honest - I have no idea what I'm doing. I adapted the Note Names 3.6 plugin provided with MuseScore 4.0.2-230651553 Windows 64-bit. Feel free to suggest improvements!

![image](https://github.com/nebarnix/ShinobuePluginMuseScore4/blob/main/Shinobue_Notation8_example.JPG)

