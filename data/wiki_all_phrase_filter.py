import sys
import codecs
from mafan import simplify, split_text
from textblob import TextBlob
def func(args):
    return 2*args
try:
    # Python 2
    xrange
except NameError:
    # Python 3, xrange is now named range
    xrange = range


def NoSeparator(name):
    for ch in ',;:()':
        if name.find(ch) != -1:
            return False
    return True

LANGUAGE = 'fr'

def Load(filename,  output_filename):
    candidate = set()
    for line in codecs.open(filename, 'r', 'utf-8'):
        tokens = line.strip().split('\t')
        for token in tokens[2:]:
            name = ':'.join(token.split(':')[:-2])

            if LANGUAGE == 'fr':
                name = simplify(''.join(name.split()))
                if NoSeparator(name):             
                   candidate.add(name.lower())

        name = tokens[0]
        name = simplify(''.join(name.split()))
        if LANGUAGE == 'fr':
            name = simplify(''.join(name.split()))
            #if NoSeparator(name):             
            #candidate.add(name.lower())

        candidate.add(name.lower())
    print (len(candidate))
    
    out = codecs.open(output_filename, 'w', 'utf-8')
    for name in candidate:
        out.write(name + '\n')
    out.close()
	
print('===========================================')
    
def main(argv):
    global LANGUAGE
    i = 0
    while i < len(argv):
        if argv[i] == '-lang':
            LANGUAGE = argv[i + 1]
            i += 1
        else:
            print ('Unknown Parameter =', argv[i])
        i += 1

    INPUT_FILENAME = LANGUAGE + '/entities'
    #STOPWORDS = LANGUAGE + '/stopwords.txt'
    OUTPUT_FILENAME = LANGUAGE + '/wiki_all.txt'
	
    #stopwords = LoadStopWords(STOPWORDS)
    Load(INPUT_FILENAME, OUTPUT_FILENAME)
print('===========================================')
if __name__ == "__main__":
    double_args = func(sys.argv)
    main(double_args)
    print("In mymodule:",double_args)
print('===========================================')	