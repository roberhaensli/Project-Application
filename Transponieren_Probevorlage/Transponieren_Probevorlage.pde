// Globale Variablen
String[] allNotes = {"C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"}; // Chromatische Skala
HashMap<String, int[]> scalesMap = new HashMap<String, int[]>(); // Tonleiter-Intervalle
String inputText = "";  // Benutzereingabe
String outputText = ""; // Ausgabeantwort
String currentKey = "C";  // Aktueller Grundton
String currentMode = "major";  // Aktueller Modus (Dur als Standard)

// Akkordtypen (Dur, Moll, vermindert)
String[] chordTypes = {"maj", "min", "min", "maj", "maj", "min", "dim"};

void setup() {
  size(1000, 800);
  // Hintergrundfarbe auf pastellviolett setzen
  background(204, 153, 255);
  
  // Initialisiere Tonleitern mit Interval-Schritten
  scalesMap.put("major", new int[] {2, 2, 1, 2, 2, 2, 1});      // Ionisch (Dur)
  scalesMap.put("minor", new int[] {2, 1, 2, 2, 1, 2, 2});      // Äolisch (natürlich Moll)
  scalesMap.put("dorian", new int[] {2, 1, 2, 2, 2, 1, 2});     // Dorisch
  scalesMap.put("phrygian", new int[] {1, 2, 2, 2, 1, 2, 2});   // Phrygisch
  scalesMap.put("lydian", new int[] {2, 2, 2, 1, 2, 2, 1});     // Lydisch
  scalesMap.put("mixolydian", new int[] {2, 2, 1, 2, 2, 1, 2}); // Mixolydisch
  scalesMap.put("locrian", new int[] {1, 2, 2, 1, 2, 2, 2});    // Lokrisch
}

void draw() {
  // Hintergrundfarbe auf pastellviolett setzen
  background(204, 153, 255); // Pastellviolett
  
  // Text: "Wie kann ich Ihnen heute helfen?"
  fill(0);
  textAlign(LEFT);
  textSize(20);
  text("Wie kann ich Ihnen heute helfen?", 20, 40);
  
  // Textfeld zur Anzeige der Benutzereingabe
  fill(0);
  textAlign(LEFT);
  textSize(16);
  text("Eingabe: " + inputText, 20, 80);
  
  // Ausgabe der Berechnungen basierend auf der Eingabe
  textAlign(LEFT);
  text(outputText, 20, 120);
}

// Funktion zur Erzeugung einer Tonleiter
String[] getScale(String root, String mode) {
  int rootIndex = indexOf(root, allNotes);
  if (rootIndex == -1) {
    return new String[] {"Fehler: Ungültige Note"};
  }
  int[] intervals = scalesMap.get(mode);
  if (intervals == null) {
    return new String[] {"Fehler: Ungültiger Modus"};
  }
  String[] scale = new String[7];
  int noteIndex = rootIndex;
  
  for (int i = 0; i < 7; i++) {
    scale[i] = allNotes[noteIndex % 12];
    noteIndex += intervals[i];
  }
  
  return scale;
}

// Transposition einer Tonleiter
String[] transposeScale(String[] scale, String targetRoot) {
  int targetIndex = indexOf(targetRoot, allNotes);
  int originalRootIndex = indexOf(scale[0], allNotes);
  int interval = targetIndex - originalRootIndex;
  
  String[] transposedScale = new String[7];
  
  for (int i = 0; i < scale.length; i++) {
    int noteIndex = (indexOf(scale[i], allNotes) + interval + 12) % 12;
    transposedScale[i] = allNotes[noteIndex];
  }
  
  return transposedScale;
}

// Extrahiert Stufen und gibt die entsprechenden Akkorde/Noten zurück
String getDegrees(String[] scale, int[] degrees) {
  String result = "Tonleiter: " + join(scale, " ") + "\n\n";
  result += "Stufen:\n";
  
  for (int i = 0; i < degrees.length; i++) {
    int degree = degrees[i] - 1;  // Umwandlung in Array-Index (0 basiert)
    result += "Stufe " + degrees[i] + ": " + scale[degree] + " " + chordTypes[degree] + "\n";
  }
  
  return result;
}

// Hilfsfunktion, um den Index einer Note in der chromatischen Skala zu finden
int indexOf(String note, String[] arr) {
  for (int i = 0; i < arr.length; i++) {
    if (arr[i].equals(note)) {
      return i;
    }
  }
  return -1;  // Falls Note nicht gefunden wurde
}

// Textverarbeitung der Benutzereingabe
void keyPressed() {
  if (key == '\n') {
    // Textverarbeitung bei Eingabeabschluss (Enter-Taste)
    processInput(inputText);
    inputText = "";  // Leeren des Eingabefeldes nach der Verarbeitung
  } else if (key == BACKSPACE) {
    if (inputText.length() > 0) {
      inputText = inputText.substring(0, inputText.length() - 1);
    }
  } else {
    inputText += key;
  }
}

// Verarbeitung der Benutzereingabe
void processInput(String input) {
  String[] words = split(input, ' ');
  
  // Variablen für die Tonart, Modus, Transposition und Stufen
  String key = "C";
  String mode = "major";
  boolean transpose = false;
  String targetKey = "";
  int[] requestedDegrees = new int[] {};
  boolean showChords = false;
  
  // Durchlaufe alle Wörter der Eingabe und analysiere die Anfrage
  for (int i = 0; i < words.length; i++) {
    // Überprüfen auf Tonleiter
    if (words[i].matches("[A-Ga-g](#|b)?")) {
      key = words[i].toUpperCase();
    }
    
    // Überprüfen auf Modus (z.B. "Dur", "Moll")
    if (words[i].equalsIgnoreCase("moll")) {
      mode = "minor";
    } else if (words[i].equalsIgnoreCase("dorisch")) {
      mode = "dorian";
    } else if (words[i].equalsIgnoreCase("phrygisch")) {
      mode = "phrygian";
    } else if (words[i].equalsIgnoreCase("lydisch")) {
      mode = "lydian";
    } else if (words[i].equalsIgnoreCase("mixolydisch")) {
      mode = "mixolydian";
    } else if (words[i].equalsIgnoreCase("lokrisch")) {
      mode = "locrian";
    } else if (words[i].equalsIgnoreCase("dur")) {
      mode = "major";
    }
    
    // Überprüfen auf spezielle Stufen
    if (words[i].matches("\\d")) {
      requestedDegrees = append(requestedDegrees, int(words[i]));
    }
    
    // Überprüfen auf Akkorde
    if (words[i].equalsIgnoreCase("akkorde")) {
      showChords = true;
    }
    
    // Überprüfen auf Transposition
    if (words[i].equalsIgnoreCase("in")) {
      transpose = true;
      targetKey = words[i+1].toUpperCase();
    }
  }
  
  // Erzeuge die angefragte Tonleiter
  String[] scale = getScale(key, mode);
  
  // Falls Transposition angefragt wurde
  if (transpose) {
    scale = transposeScale(scale, targetKey);
  }
  
  // Verarbeite die Stufen oder Akkorde
  if (requestedDegrees.length > 0) {
    outputText = getDegrees(scale, requestedDegrees);
  } else if (showChords) {
    outputText = "Tonleiter: " + join(scale, " ") + "\n\n";
    outputText += "Akkorde:\n";
    for (int i = 0; i < 7; i++) {
      outputText += "Akkord " + (i+1) + ": " + scale[i] + " " + chordTypes[i] + "\n";
    }
  } else {
    outputText = "Tonleiter: " + join(scale, " ");
  }
}

// Funktion zur Darstellung der Notenlinien und Noten
void displayNoteTable(String[] notes) {
  textSize(16);
  fill(0);
  text("Notentabelle:", 20, height - 60);
  
  int xOffset = 20;
  int yOffset = height - 40;
  int noteSpacing = 30;
  
  // Zeichne Notenlinien
  for (int i = 0; i < 5; i++) {
    line(xOffset, yOffset - i * 10, xOffset + 300, yOffset - i * 10);
  }
  
  // Zeichne Noten
  for (int i = 0; i < notes.length; i++) {
    text(notes[i], xOffset + i * noteSpacing, yOffset - 20);
  }
}
