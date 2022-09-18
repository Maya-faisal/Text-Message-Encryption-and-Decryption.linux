
while [ true ]
do

# ASK THE USER WHAT TO DO

echo "Enter (E) for encryption or (D) for decryption" 
read cryption

if [ "$cryption" = E -o "$cryption" = e ]
then
echo "Please input the name of the plain text file"
read filename

# CHECK IF THE FILE EXIST

if [ ! -e "$filename" -o ! -f "$filename" ]
then
echo "file not found !"
break
fi

echo 

# GET THE TEXT FROM THE FILE

s=`cat "$filename"`

echo "file text : "
cat "$filename"
echo

# CONVERT LETTERS TO LOWERCASE

s=$(echo "$s" | tr '[A-Z]' '[a-z]')

# CHECK IF THEIR IS A non-alphabet CHAR

if [[ "${s}" =~ [^a-z" "] ]]; 
then
echo " The file contains non-alphabet characters ! "
break
fi

sum=0
nwords=0
i=0
len=${#s}
max=0

# READ CHAR BY CHAR 

while [ "$i" -le "$len" ]
do

  l=$(echo "${s:$i:1}")
  i=$(( i + 1 ))

# CALCULATE THE SUM%256 AND FIND THE MAX TO GET THE KEY

  case "$l"
  in
  
   a ) sum=$((sum + 1));;
   b ) sum=$((sum + 2));;
   c ) sum=$((sum + 3));;
   d ) sum=$((sum + 4));;
   e ) sum=$((sum + 5));;
   f ) sum=$((sum + 6));;
   g ) sum=$((sum + 7));;
   h ) sum=$((sum + 8));;
   i ) sum=$((sum + 9));;
   j ) sum=$((sum + 10));;
   k ) sum=$((sum + 11));;
   l ) sum=$((sum + 12));;
   m ) sum=$((sum + 13));;
   n ) sum=$((sum + 14));;
   o ) sum=$((sum + 15));;
   p ) sum=$((sum + 16));;
   q ) sum=$((sum + 17));;
   r ) sum=$((sum + 18));;
   s ) sum=$((sum + 19));;
   t ) sum=$((sum + 20));;
   u ) sum=$((sum + 21));;
   v ) sum=$((sum + 22));;
   w ) sum=$((sum + 23));;
   x ) sum=$((sum + 24));;
   y ) sum=$((sum + 25));;
   z ) sum=$((sum + 26));;
  " ") nwords=$((nwords+1))
       mod=$((sum%256))
       printf " sum (%d) mod (256) for word #%d is : %d \n" $sum $nwords $mod
       
       sum=0;
       
       if [ "$max" -le "$mod" ]
       then
          max=$(("$mod"))
          
       else
         continue   
       fi   
    
       ;;

  esac
  
done

echo
echo "Key is : " $max
echo

# CONVERT THE KEY TO 8-BIT BINARY

echo "key in 8-bit binary :  "

stringB=""

b=$((1 << 7))
    
while [ "$b" -gt 0 ]
do

if [ $((max&b)) -ne 0 ]
then
stringB+="1"

else
stringB+="0"
fi

b=$(("$b"/2))

done

echo "$stringB"      

# ASK THE USER FOR THE CIPHER FILE
  
echo
echo "please enter the name of the cipher text file"
read ci

echo

# CHECK IF THE CIPHER FILE EXIST

if [ ! -e "$ci" -o ! -f "$ci" ]
then
echo "file not found !"
break
fi

# GET THE ASCII CODE OF EACH LETTER

j=0
ascii=""

while [ "$j" -le "$len" ]
do

  ll=$(echo "${s:$j:1}")
  j=$(( j + 1 ))

  case "$ll"
  in
  
   a ) ascii="01100001";;
   b ) ascii="01100010";;
   c ) ascii="01100011";;
   d ) ascii="01100100";;
   e ) ascii="01100101";;
   f ) ascii="01100110";;
   g ) ascii="01100111";;
   h ) ascii="01101000";;
   i ) ascii="01101001";;
   j ) ascii="01101010";;
   k ) ascii="01101011";;
   l ) ascii="01101100";;
   m ) ascii="01101101";;
   n ) ascii="01101110";;
   o ) ascii="01101111";;
   p ) ascii="01110000";;
   q ) ascii="01110001";;
   r ) ascii="01110010";;
   s ) ascii="01110011";;
   t ) ascii="01110100";;
   u ) ascii="01110101";;
   v ) ascii="01110110";;
   w ) ascii="01110111";;
   x ) ascii="01111000";;
   y ) ascii="01111001";;
   z ) ascii="01111010";;
   " ") ascii="00100000";;

  esac
    
# XOR THE ASCII CODE WITH THE KEY
          
xor=""
k=0 

while [ "$k" -lt 8 ]
do

x1=$(echo "${ascii:$k:1}")
x2=$(echo "${stringB:$k:1}")

k=$(( k + 1 ))

if [ "$x1" = "$x2" ]
then
xor+="0"

else
xor+="1"

fi
done

# SWAP THE FIRST 4 BIT WITH THE LAST 4 AND PRINT IT ON THE CIPHER FILE

echo -n "${xor:(-4)}${xor:0:4}" >> "$ci"

done


# SWAP THE FIRST 4 BIT WITH THE LAST 4 OF THE KEY AND IT TO THE END OF THE CIPHER FILE

echo -n "${stringB:(-4)}${stringB:0:4}" >> "$ci"

echo "cipher text is generated on the cipher file"
echo " Encryption is done :) "
echo

#--------------------------------------------------------

elif [ "$cryption" = D -o "$cryption" = d ]
then
echo "Please input the name of the cipher text file"
read cipher

if [ ! -e "$cipher" -o ! -f "$cipher" ]
then
echo "file not found !"
break
fi

echo

# GET THE BITS

bits=`cat "$cipher"`

# GET THE LAST 8-BITS TO FIND THE KEY

last=${bits:(-8)}

echo "The key in binary is : "

# SWAP THE FIRST 4 BITS WITH THE LAST 4 

echo "${last:(-4)}${last:0:4}"
echo


echo "input the name of the plain text file"
read plain

if [ ! -e "$plain" -o ! -f "$plain" ]
then
echo "file not found !"
break
fi

echo

# GET THE ORIGINAL

m=0
leN=${#bits}

#MINUS 8 TO GET RID FROM THE KEY PART
leN=$((leN-8))

# GET EACH 8 BITS TOGETHER

while [ "$m" -le "$leN" ]
do

lll=$(echo "${bits:$m:8}")
m=$(( m + 8 ))

#SWAP

new="${lll:(-4)}${lll:0:4}"
  
# XOR WITH THE KEY  
xorr=""
p=0 

while [ "$p" -lt 8 ]
do

xx1=$(echo "${new:$p:1}")
xx2=$(echo "${stringB:$p:1}")

p=$(( p + 1 ))

if [ "$xx1" = "$xx2" ]
then
xorr+="0"

else
xorr+="1"

fi
done

  case "$xorr"
  in
  
   "01100001") echo -n "a" >> "$plain";;
   "01100010") echo -n "b" >> "$plain";;
   "01100011") echo -n "c" >> "$plain";;
   "01100100") echo -n "d" >> "$plain";;
   "01100101") echo -n "e" >> "$plain";;
   "01100110") echo -n "f" >> "$plain";;
   "01100111") echo -n "g" >> "$plain";;
   "01101000") echo -n "h" >> "$plain";;
   "01101001") echo -n "i" >> "$plain";;
   "01101010") echo -n "j" >> "$plain";;
   "01101011") echo -n "k" >> "$plain";;
   "01101100") echo -n "l" >> "$plain";;
   "01101101") echo -n "m" >> "$plain";;
   "01101110") echo -n "n" >> "$plain";;
   "01101111") echo -n "o" >> "$plain";;
   "01110000") echo -n "p" >> "$plain";;
   "01110001") echo -n "q" >> "$plain";;
   "01110010") echo -n "r" >> "$plain";;
   "01110011") echo -n "s" >> "$plain";;
   "01110100") echo -n "t" >> "$plain";;
   "01110101") echo -n "u" >> "$plain";;
   "01110110") echo -n "v" >> "$plain";;
   "01110111") echo -n "w" >> "$plain";;
   "01111000") echo -n "x" >> "$plain";;
   "01111001") echo -n "y" >> "$plain";;
   "01111010") echo -n "z" >> "$plain";;
   "00100000") echo -n " " >> "$plain";;

  esac

done

echo "Result : "
cat "$plain"
echo
echo


echo "Plain text is generated on the plain file"
echo " Decryption is done :) "
echo

else
echo "invalid choice ! "
break

fi
done
