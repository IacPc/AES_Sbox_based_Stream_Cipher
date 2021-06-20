import random
import string

ASCIIINPUTFILENUMBER  = 5
BINARYINPUTFILENUMBER = 2
TESTFOLDER = "../db/test/"
LARGEPRIMENUMBER = 23768741896345550770650537601358309
MAXINPUTFILELENGTH = 300

def getRandomASCIIString(length):
    ascii_characters = string.ascii_letters + string.digits + string.punctuation
    plainText = ''.join(random.choice(ascii_characters) for i in range(length))
    return plainText

def init():
	random.seed(LARGEPRIMENUMBER)

def writeOutputASCIIFile(index, data):
	with open(TESTFOLDER + 'input' + str(index) + ".txt", 'w') as outfile: 
		outfile.write(data)

def main():
	init()
	
	for i in range(0, ASCIIINPUTFILENUMBER):
		writeOutputASCIIFile(i, getRandomASCIIString(random.randint(0, MAXINPUTFILELENGTH)))

	exit(0)

if __name__ == '__main__':
	main()

