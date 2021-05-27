import random
import string

ASCIIINPUTFILENUMBER  = 2
BINARYINPUTFILENUMBER = 2
testFolder = "../db/test/"
LARGEPRIMENUMBER = 23768741896345550770650537601358309
MAXINPUTFILELENGTH = 300

def getRandomASCIIString(length):
    ascii_characters = string.ascii_letters + string.digits + string.punctuation
    plainText = ''.join(random.choice(ascii_characters) for i in range(length))
    return plainText

def getRandomBinaryString(length):
    plainText = b''.join(random.randint(0, 255).to_bytes(1,byteorder="big") for i in range(length))
    return plainText

def init():
	random.seed(LARGEPRIMENUMBER)

def writeOutputBinaryFile(index, data):
	with open(testFolder + 'input' + str(index), 'wb') as outfile: 
		outfile.write(data)

def writeOutputASCIIFile(index, data):
	with open(testFolder + 'input' + str(index), 'w') as outfile: 
		outfile.write(data)

def main():
	init()
	index=3
	for i in range(0, ASCIIINPUTFILENUMBER):
		writeOutputASCIIFile(index, getRandomASCIIString(random.randint(0, MAXINPUTFILELENGTH)))
		index+=1

	for i in range(0, BINARYINPUTFILENUMBER):
		writeOutputBinaryFile(index, getRandomBinaryString(random.randint(0, MAXINPUTFILELENGTH)))
		index+=1

	exit(0)

if __name__ == '__main__':
	main()