//=============================================================================
//  MuseScore
//  Music Composition & Notation
//
//  Shinobue Plugin
//
//  Copyright (C) 2012 Werner Schweer
//  Copyright (C) 2013 - 2021 Joachim Schmitz
//  Copyright (C) 2014 Jörn Eichler
//  Copyright (C) 2020 Johan Temmerman
//  Copyright (C) 2023 Jasper Nance
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the GNU General Public License version 2
//  as published by the Free Software Foundation and appearing in
//  the file LICENCE.GPL
//=============================================================================

import QtQuick 2.2
import MuseScore 3.0

MuseScore {
   version: "1.0"
   description: "This plugin adds Shinobue fingers for the 8-hon Shinobue"
   title: "Shinobue Notation 8-Hon"
   categoryCode: "composing-arranging-tools"
   thumbnailName: "Shinobue_Notation.png"

   // Small note name size is fraction of the full font size.
   property real fontSizeMini: 0.7;

   function nameChord (notes, text, small) {
      var sep = "\n";   // change to "," if you want them horizontally (anybody?)
      var oct = "";
      var name;
      var correctPitch;
      var nullOffset = 45;
      var pitchVsLine;
      var octaveOffset; //for octave transposition since Fues play one register high
      for (var i = 0; i < notes.length; i++) {
         if (!notes[i].visible)
            continue // skip invisible notes
         if (text.text) // only if text isn't empty
            text.text = sep + text.text;
         if (small)
            text.fontSize *= fontSizeMini
         if (typeof notes[i].tpc === "undefined") // like for grace notes ?!?
            return
         //switch (notes[i].tpc) {
         pitchVsLine = (notes[i].pitch/(12.0/7.0)) + notes[i].line;
         octaveOffset = ((pitchVsLine - nullOffset)/7).toFixed();
         
         correctPitch = notes[i].pitch;
         correctPitch = correctPitch - 12*octaveOffset;
         switch (correctPitch) {         
            
            case 58: name = qsTranslate("InspectorAmbitus", ".七"); break;   //B♭
            case 59: name = qsTranslate("InspectorAmbitus", ".七メ"); break;   //B

            case 60: name = qsTranslate("InspectorAmbitus", "一"); break; //C4
            case 61: name = qsTranslate("InspectorAmbitus", "二メ"); break;   //
            case 62: name = qsTranslate("InspectorAmbitus", "二"); break; //D4
            case 63: name = qsTranslate("InspectorAmbitus", "三メ"); break;   //C
            case 64: name = qsTranslate("InspectorAmbitus", "三"); break; //E4
            case 65: name = qsTranslate("InspectorAmbitus", "四"); break; //F4            
            case 66: name = qsTranslate("InspectorAmbitus", "五メ"); break;   //
            case 67: name = qsTranslate("InspectorAmbitus", "五"); break; //G4
            case 68: name = qsTranslate("InspectorAmbitus", "六メ"); break;   //
            case 69: name = qsTranslate("InspectorAmbitus", "六"); break; //A4

            case 70: name = qsTranslate("InspectorAmbitus", "七メ"); break;   //
            case 71: name = qsTranslate("InspectorAmbitus", "七"); break; //B4
            case 72: name = qsTranslate("InspectorAmbitus", "1"); break;  //C5
            case 73: name = qsTranslate("InspectorAmbitus", "2メ"); break;   //
            case 74: name = qsTranslate("InspectorAmbitus", "2"); break;  //D5
            case 75: name = qsTranslate("InspectorAmbitus", "3メ"); break;  //
            case 76: name = qsTranslate("InspectorAmbitus", "3"); break; //E5
            case 77: name = qsTranslate("InspectorAmbitus", "4"); break; //F5
            case 78: name = qsTranslate("InspectorAmbitus", "5メ"); break;  //
            case 79: name = qsTranslate("InspectorAmbitus", "5"); break; //G5

            case 80: name = qsTranslate("InspectorAmbitus", "6メ"); break; //
			case 81: name = qsTranslate("InspectorAmbitus", "6"); break; //A5
			case 82: name = qsTranslate("InspectorAmbitus", "7メ"); break; //
			case 83: name = qsTranslate("InspectorAmbitus", "7"); break; //B5
			case 84: name = qsTranslate("InspectorAmbitus", "8"); break; //C6
			case 85: name = qsTranslate("InspectorAmbitus", "2メ."); break; //
			case 86: name = qsTranslate("InspectorAmbitus", "2."); break; //D6
			case 87: name = qsTranslate("InspectorAmbitus", "3メ."); break; //
			case 88: name = qsTranslate("InspectorAmbitus", "3"); break; //E6
			case 89: name = qsTranslate("InspectorAmbitus", "4."); break; //F6

			case 90: name = qsTranslate("InspectorAmbitus", "5メ."); break; //
			case 91: name = qsTranslate("InspectorAmbitus", "5."); break; //G6
			case 92: name = qsTranslate("InspectorAmbitus", "6メ."); break; //
			case 93: name = qsTranslate("InspectorAmbitus", "6."); break; //A6
			
            default: name = qsTr("?")   + text.text; break;
         }  // end switch tpc
         //name = qsTranslate("InspectorAmbitus", notes[i].line.toFixed());
         //name = qsTranslate("InspectorAmbitus", octaveOffset.toFixed());
         //name = qsTranslate("InspectorAmbitus", ((notes[i].pitch/(12.0/7.0) + notes[i].line)).toFixed(3));
         
         // octave, middle C being C4
         //oct = (Math.floor(notes[i].pitch / 12) - 1)
         // or
         //oct = (Math.floor(notes[i].ppitch / 12) - 1)
         // or even this, similar to the Helmholtz system but one octave up
         //var octaveTextPostfix = [",,,,,", ",,,,", ",,,", ",,", ",", "", "'", "''", "'''", "''''", "'''''"];
         //oct = octaveTextPostfix[Math.floor(notes[i].pitch / 12)];
         text.text = name + oct + text.text


      }  // end for note
   }

   function renderGraceNoteNames (cursor, list, text, small) {
      if (list.length > 0) {     // Check for existence.
         // Now render grace note's names...
         for (var chordNum = 0; chordNum < list.length; chordNum++) {
            // iterate through all grace chords
            var chord = list[chordNum];
            // Set note text, grace notes are shown a bit smaller
            nameChord(chord.notes, text, small)
            if (text.text)
               cursor.add(text)
            // X position the note name over the grace chord
            text.offsetX = chord.posX
            switch (cursor.voice) {
               case 1: case 3: text.placement = Placement.BELOW; break;
            }

            // If we consume a STAFF_TEXT we must manufacture a new one.
            if (text.text)
               text = newElement(Element.LYRICS);    // Make another STAFF_TEXT
         }
      }
      return text
   }

   onRun: {
      curScore.startCmd()

      var cursor = curScore.newCursor();
      var startStaff;
      var endStaff;
      var endTick;
      var fullScore = false;
      cursor.rewind(1);
      if (!cursor.segment) { // no selection
         fullScore = true;
         startStaff = 0; // start with 1st staff
         endStaff  = curScore.nstaves - 1; // and end with last
      } else {
         startStaff = cursor.staffIdx;
         cursor.rewind(2);
         if (cursor.tick === 0) {
            // this happens when the selection includes
            // the last measure of the score.
            // rewind(2) goes behind the last segment (where
            // there's none) and sets tick=0
            endTick = curScore.lastSegment.tick + 1;
         } else {
            endTick = cursor.tick;
         }
         endStaff = cursor.staffIdx;
      }
      console.log(startStaff + " - " + endStaff + " - " + endTick)

      for (var staff = startStaff; staff <= endStaff; staff++) {
         for (var voice = 0; voice < 4; voice++) {
            cursor.rewind(1); // beginning of selection
            cursor.voice    = voice;
            cursor.staffIdx = staff;

            if (fullScore)  // no selection
               cursor.rewind(0); // beginning of score
            while (cursor.segment && (fullScore || cursor.tick < endTick)) {
               if (cursor.element && cursor.element.type === Element.CHORD) {
                  var text = newElement(Element.LYRICS);      // Make a STAFF_TEXT

                  // First...we need to scan grace notes for existence and break them
                  // into their appropriate lists with the correct ordering of notes.
                  var leadingLifo = Array();   // List for leading grace notes
                  var trailingFifo = Array();  // List for trailing grace notes
                  var graceChords = cursor.element.graceNotes;
                  // Build separate lists of leading and trailing grace note chords.
                  if (graceChords.length > 0) {
                     for (var chordNum = 0; chordNum < graceChords.length; chordNum++) {
                        var noteType = graceChords[chordNum].notes[0].noteType
                        if (noteType === NoteType.GRACE8_AFTER || noteType === NoteType.GRACE16_AFTER ||
                              noteType === NoteType.GRACE32_AFTER) {
                           trailingFifo.unshift(graceChords[chordNum])
                        } else {
                           leadingLifo.push(graceChords[chordNum])
                        }
                     }
                  }

                  // Next process the leading grace notes, should they exist...
                  text = renderGraceNoteNames(cursor, leadingLifo, text, true)

                  // Now handle the note names on the main chord...
                  var notes = cursor.element.notes;
                  nameChord(notes, text, false);
                  if (text.text)
                     cursor.add(text);

                  switch (cursor.voice) {
                     case 1: case 3: text.placement = Placement.BELOW; break;
                  }

                  if (text.text)
                     text = newElement(Element.LYRICS) // Make another STAFF_TEXT object

                  // Finally process trailing grace notes if they exist...
                  text = renderGraceNoteNames(cursor, trailingFifo, text, true)
               } // end if CHORD
               cursor.next();
            } // end while segment
         } // end for voice
      } // end for staff

      curScore.endCmd()
      quit();
   } // end onRun
}
