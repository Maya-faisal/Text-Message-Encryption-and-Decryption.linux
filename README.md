# Text Encryption and Decryption Script

This shell script allows users to encrypt and decrypt text using a simple XOR operation. It offers a basic encryption algorithm and can handle lowercase alphabetic characters.

## Usage

- Run the script and choose between encryption (E) or decryption (D).
- Provide the appropriate filenames when prompted.
- Follow the on-screen instructions to complete the encryption or decryption process.

## Encryption Process

- Prompts the user to input the name of the plaintext file to encrypt.
- Converts plaintext letters to lowercase.
- Calculates the encryption key based on the sum modulo 256 of each word.
- Converts the key to 8-bit binary.
- XORs each letter in the plaintext with the encryption key to generate ciphertext.

## Decryption Process

- Prompts the user to input the name of the ciphertext file to decrypt.
- Retrieves the decryption key from the last 8 bits of the ciphertext.
- Converts the key to 8-bit binary.
- XORs each block of ciphertext with the decryption key to retrieve the original plaintext.

## Note

- This script is intended for educational purposes and should not be used for secure encryption.
