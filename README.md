# Play-Fair-Cipher
Neat implementation of Play Fair Cipher in Swift

"The Playfair cipher or Playfair square or Wheatstone-Playfair cipher is a manual symmetric encryption technique and was the first literal digram substitution cipher. The scheme was invented in 1854 by Charles Wheatstone, but bears the name of Lord Playfair for promoting its use.
The technique encrypts pairs of letters (bigrams or digrams) instead of single letters."
-Wikipedia

## Input
Key: CRYPT  
Message: MEETATBACK

## Output
#### Key Matrix
C R Y P T  
A B D E F  
G H I K L  
M N O Q S  
U V W X Z  

#### Message Pairs
("M", "E"), ("E", "T"), ("A", "T"), ("B", "A"), ("C", "K")

#### Cipher
QAFPFCDBPG

#### Decipher
MEETATBACK
