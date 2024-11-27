

def setup():
    
    tonleiter(0,7)
    
'''
def draw():
    background(0,0,0)
'''

def tonleiter(startton, tonart):
    #[C, G, D, A, E, B, Fis, Cis, Gis, Dis, Ais, Ges, Des, As, Es, Bb, F]
    toene = ["C", "G", "D", "A", "E", "B", "Fis", "Cis", "Gis", "Dis", "Ais", "Ges", "Des", "As", "Es", "Bb", "F"]
    #[Moll-harmonisch, Moll-melodisch, Dorisch, Phrygisch, Lydisch, Mixolydisch, Aeolisch, Ionisch]
    tonarten = [[2,12,2,2,12,9,12],[2,12,2,2,2,2,12],[2,12,2,2,2,12,2],[12,2,2,2,12,2,2],[2,2,2,12,2,2,12],[2,2,12,2,2,12,2],[2,12,2,2,12,2,2],[2,2,12,2,2,2,12]]
    
    ton = startton
    for i in range(7):
        print toene[ton%17]
        ton += tonarten[tonart][i]
    print toene[startton]
