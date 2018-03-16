# Network Security
Spring 2018 <br />
Lecturer: Shiuhpyng Shieh <br />

## RSA Encryption standard

* Asymmetric encryption standard.
This encryption standard mainly focus on prime factorisation
更多資訊可以參考[外星人的筆記]()
### Course project1. Chosen cipher attack
* Will post report after the session of this homework ends.

## DES Encryption standard
* An encryption algorithm use round, permutation shift and XOR operation to generate the ciphertext.
* Divide the plaintext into 64-bit-long in size for each if the block, and use the same length key for encryption(actually the key is not in the same length since there are 8 bits used for the parity-checking during the encryption)
![Screenshot](AES_youtube.png)
[Image src](https://www.youtube.com/watch?v=Sy0sXa73PZA)
[DES Briefly introduction](https://chaomengyang.wordpress.com/2008/02/08/des-vs-3des-vs-aes/)
* Prone to brute force attack since the key space is too small to guarantee the safe area, so the safer 3-DES algorithm is used nowadays.
* 16rounds are needed for the encryption process
* The encryption and decryption are run under the same algorithm but they are in the reverse order with each other
* This is a model based on the [Fiestel model](https://zh.wikipedia.org/wiki/%E8%B4%B9%E6%96%AF%E5%A6%A5%E5%AF%86%E7%A0%81), namely for the encryption and decryption they use the same function but in the reversed order.

## From DES to 3DES
* DES is not so secure since the key is 56bits long, which is quite prone to BF cryptanalysis
* 3DES lengthens the key of DES (56 * 3 = 168), doing DES 3 times to make the encryption safer.

![Screenshot](DES_procedure.png) <br />
* Please feel free to refer to my classmate's [note](https://hackmd.io/AhM957LCSuCMNzq0b5c1fw#Cryptography) for more information

## AES Encryption standard
* Make a better encryption of 3DES, namely evolve from 3DES for a stronger and faster encryption algorithm.
* AES is still the same as the DES in the category of block cipher encryption, but the block size of AES is 128 bits, doubled of the DES encryption.
* 10 Rounds of encryption again and again is needed.
![Screenshot](AES_procedure.png)  <br /> Image source from textbook
One grey-coloured box is the one "round" of the encryption in AES<br />
Each of the round we take the preceding round's output as the input of this round and do the encryption again, with the following 4 tasks to be done<br />
1.The **Substitution Bytes** is to use the non-linear transform to let the input transformed with a "Affine transformation", making the encryption robust and hard to be cracked<br />
2.The **Shift Rows(Bit transposition)** is shifting the data, to rearrange the text, for row i we shift i-1 times to the left.<br />
![Screenshot](AES_shiftrows.png)
<br /> Image source from wikipedia <br />
3.The **Mix Columns** is a linear transform under the mod multiplication <br />
4.The **Add Round Key** is let the input XOR with the Key in the current state. (Rijndael key generator solution,which is a subkey in each round, which we can be seen from the image provided above that Key(16 bytes and expand to match for each round, divided into 10 subkeys for 10 operations in AES encryption))<br />
5.After the aforementioned four steps are done, go to the next encryption box. The operation is bytewise<br />

## The truly random number and pseudo random number
* Applications of the random number
1.RSA pub-key generation and other pub-key algorithms.<br />
2.Session key for encryption in system such as Wi-Fi, e-mail<br />
![Screenshot](CSPRNG.png)
<br /> Image source from wikipedia <br />

* The following 2 criteria are used to validate a sequence is random.
1.Uniform distribution: The each element in the seed of random number must take the same proportion of being taken out.<br />
2.Independence: A sequence cannot be inferred from the other sequence, strictly and absolutely.<br />

## Block cipher vs Stream cipher

* Stream cipher: Change the encryption key from time to time, and each time the two part(sender-receiver) can generate the same random key s.t. they can encrypt and decrypt the same message.
The key of such encryption algorithm should have a extremely large period and as random as possible, o.w. it is crack-prone.<br />
In order to guard the BF attack, the longer key is preferred (However there is a trade-off b/w speed and security.)
![Screenshot](SCD.png)
As we can see the sender and receiver generate the same key for encryption and decryption.
Image source from textbook <br />
* RC4 Algorithm
1.An algorithm with changeable key length encryption. <br />
2.SSL TLS WEP WPA use this encryption algorithm<br />
3.Easy to implement in both HW ans SW, but terminated in 2015 due to attack<br />

RC4 Encryption procedure <br />
1.Shuffle the key, make it randomised.
```cpp
for i from 0 to 255
     S[i] := i
 endfor
 j := 0
 for( i=0 ; i<256 ; i++)
     j := (j + S[i] + key[i mod keylength]) % 256 //randomly take the new j and swap, make a permutation
     swap values of S[i] and S[j]
 endfor
```
2.Get even more shuffle data, each time for a input byte, locate the i and j value by take the value in the key, XOR the inputByte with the key (since the reverse of XOR operation is itself, once we insert the ciphertext we'll get plaintext, and converse is true as well.)
```cpp
i := 0
j := 0
while GeneratingOutput:
    i := (i + 1) mod 256   //a
    j := (j + S[i]) mod 256 //b
    swap values of S[i] and S[j]  //c
    k := inputByte ^ S[(S[i] + S[j]) % 256] //XOR operation suit for this case. Reverse operation also works
    output K
endwhile
```

2.
* Block cipher: Use the same key for the text, and divide the text into blocks, processing ONE BLOCK for each time. Processing procedure including shift position, substitute text to let the plaintext look similar, however, generating the
totally different ciphertext for cryptographically secure. <br />

The AES(128 bits per block), DES(64 bits per block), 3DES(64 bits per block) are lie in this category.<br />

* 5 Block modes for the block cipher, defined by NIST USA. Intended to use for the symmetric cipher.
1.Electronic Code Book where Encryption:  ciphertext[i] = code_book[plaintext[i]] just. Need a decryptor to do reversed tasks.<br />
2.Cipher Block Chaining, take the step i's ciphertext XOR with next step's plaintext and encrypt again. **If there is a bit error in the ciphertext, it will cause the decryption of plaintext i and plaintext i+1 error since they are chained together from step to step.**<br />
![Screenshot](CBCmode.png) <br />
3.Cipher FeedBack , only the encryptor is needed, 2 times of encryption is equivalent to decryption.<br />
![Screenshot](CFBmode.png) <br />
4.CounTeR , use the counter directly for the key of encryption. Can be processed parallelly since each block can be processed with its counter and independent with other blocks, random access is suitable as well. And use the same key for decryption due to the properties of XOR operation, once the ciphertext XOR key ---> plaintext is decrypted.<br />
The CTR mode is both HW and SW efficiency (parallelism are able to implemented in both CPU and compiler, OS ...etc). <br/>
What's more, the preprocessing can be done as well, even without the presence of the plaintext, we can still generate the required key and the next task is just let plaintext XOR key ---> ciphertext.

5.Output FeedBack similar too Cipher FeedBack, take the ciphertext from previous round and encrypt again<br />

[Useful reference site ,MUST READ!!!](http://morris821028.github.io/2015/03/21/security-block-ciphers/#%E5%8A%A0%E5%AF%86%E8%A8%AD%E8%A8%88%E5%9F%BA%E7%A4%8E%E5%8E%9F%E5%89%87)

**All the pics , images credits to the original author, I only use it for the education purpose, please DO NOT distribute**
