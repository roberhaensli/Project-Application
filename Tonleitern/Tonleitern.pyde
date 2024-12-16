#Variable für ausgewählten Ton und Tonart
wunschTon = "C"
wunschTonart = "ionisch"

#Alle Töne nach Quintenzirkel sortiert
toene = ["C", "G", "D", "A", "E", "B", "Fis", "Cis", "Gis", "Dis", "Ais", "Ges", "Des", "As", "Es", "Bb", "F"]
tonartennamen = ["moll-harmonisch", "moll-melodisch", "dorisch", "phrygisch", "lydisch", "mixolydisch", "aeolisch", "ionisch"]


def setup():
    #Fenster erstellen
    size(900,600)

def draw():
    #Oberfläche zeichnen
    background(255,255,255)
    
    fill(0,0,0)
    textSize(30)
    text("Klicke einen Startton:", 40, 40)
    grid_toene(40,60,80)
    
    fill(0,0,0)
    textSize(30)
    text("Klicke eine Tonart:", 40, 280)
    grid_tonarten(40,300,80)
   
    fill(0,0,0)
    textSize(30)
    text(wunschTon + "   " + wunschTonart + ":", 40, 500)
    
    fill(255,0,0)
    textSize(70)
    text(tonleiter(), 40, 560)
    fill(255,255,255)


#Funktion welche die aktuell ausgewählte (Wunschton/Wunschtonart) Tonleiter generiert.
#Input: keine
#Output: Tonleiter als String
def tonleiter():
    outputText = ""
    
    tonart = 0
    startton = 0
    
    tonart = (tonartennamen.index(wunschTonart))
    startton = (toene.index(wunschTon))
    
    
    #[Moll-harmonisch, Moll-melodisch, Dorisch, Phrygisch, Lydisch, Mixolydisch, Aeolisch, Ionisch]
    tonarten = [[2,12,2,2,12,9,12],[2,12,2,2,2,2,12],[2,12,2,2,2,12,2],[12,2,2,2,12,2,2],[2,2,2,12,2,2,12],[2,2,12,2,2,12,2],[2,12,2,2,12,2,2],[2,2,12,2,2,2,12]]
    
    ton = startton
    for i in range(7):
        outputText += "  "
        outputText += toene[ton%17]
        ton += tonarten[tonart][i]
    outputText += "  "
    outputText += toene[startton]
    
    return outputText
    
    
#Funktion welche das Raster mit den auswählbaren Tönen zeichnet
#Input: X und Y Kooridnate oben links und Seitenlänge der Quadrate.
#Output: keine
def grid_toene(nullX, nullY, laenge):
    fill(255,255,255)
    toeneV = ["C", "Cis", "D", "Dis", "E", "F", "Fis", "G", "Gis", "A", "Bb", "B"]
    for i in range(6):
        for j in range(2):
            square(nullX + i * (laenge +10), nullY + j * (laenge +10), laenge)
            fill(0,0,0)
            textSize(50)
            text(toeneV[6*j+i], 5+ nullX + i * (laenge +10)  , 60+ nullY + j * (laenge +10))
            fill(255,255,255)


#Funktion welche das Raster mit den auswählbaren Tonarten zeichnet
#Input: X und Y Kooridnate oben links und Höhe der Rechtecke.
#Output: keine
def grid_tonarten(nullX, nullY, laenge):
    fill(255,255,255)
    for i in range(4):
        for j in range(2):
            rect(nullX + i * (laenge *2 +10), nullY + j * (laenge +10), laenge * 2, laenge)
            fill(0,0,0)
            textSize(20)
            text(tonartennamen[4*j+i], 10+ nullX + i * (laenge *2 +10), 40+ nullY + j * (laenge +10))
            fill(255,255,255)

#Funktion welche die Felder auswählt wenn man mit der Maus draufklickt
def mouseClicked():
    global wunschTon
    MatrixToene = [["C", "Cis", "D", "Dis", "E", "F"], ["Fis", "G", "Gis", "A", "Bb", "B"]]
    if mouseX >= 40 and mouseX <= 570 and mouseY >= 60 and mouseY <= 230:
        wunschTon = MatrixToene[(mouseY-60)/90] [(mouseX-40)/90]
        
    global wunschTonart
    MatrixTonarten = [["moll-harmonisch", "moll-melodisch", "dorisch", "phrygisch"], ["lydisch", "mixolydisch", "aeolisch", "ionisch"]]
    if mouseX >= 40 and mouseX <= 710 and mouseY >= 300 and mouseY <= 470:
        wunschTonart = MatrixTonarten[(mouseY-300)/90] [(mouseX-40)/170]
