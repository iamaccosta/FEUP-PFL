# FEUP PFL Project 1 - polynomials

This project is a small program to calculate different functions with polynomials. <br>
Done for the subject of PFL at FEUP.

## Main Functionalities

### The module consists of 4 main function:

> #### **POLYNOMIAL NORMALIZATION** <br>
> - NAME: <br>
> &nbsp; normPoli - normalize polynomial
> - SYNOPSIS: <br>
> &nbsp; normPoli [polynomial string]
> - DESCRIPTION: <br>
> &nbsp; Modifies a polynomial to the polynomial norm form. <br>
> &nbsp; Mandatory arguments: <br>
> &nbsp; &nbsp; &nbsp; <**polynomial**> <br>
> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; String of polynomial to be normalized <br>
> &nbsp; Return value<br>
> &nbsp; &nbsp; &nbsp; This function returns a string of normalized polynomial.
> - EXAMPLES: <br>
> &nbsp; Polynomial already in normal form - **normPoli "x"**<br>
> &nbsp; &nbsp; **result** "x"
> <br><br>
> &nbsp; Polynomial with one term - **normPoli "2x^0"**<br>
> &nbsp; &nbsp; **result** "2"
> <br><br>
> &nbsp; Equal terms in polynomial - **normPoli "2x^2+3x^2"**<br>
> &nbsp; &nbsp; **result** "5x^2"
> <br><br>
> &nbsp; Term with same pair (variable, exponent) -  **normPoli "2x^2*x^2"**<br>
> &nbsp; &nbsp; **result** "2x^4"
> <br><br>
> &nbsp; Polynomial term with variables not sorted - **normPoli "2y^2*x"**<br>
> &nbsp; &nbsp; **result** "2x*y^2"
> <br><br>
> &nbsp; Polynomial with terms not sorted - **normPoli "2y\*x^2"** <br>
> &nbsp; &nbsp; **result** "2x^2\*y"
> <br><br>
> &nbsp; These examples can be mixed to form more complex examples <br>
> 
>- AUTHORS: <br>
> &nbsp; Written by **Andre Costa** and **Marcos Ferreira**.

<br>

> #### **ADDITION OF POLYNOMIALS** <br>
> - NAME: <br>
> &nbsp; addPolis - Sum two polynomials
> - SYNOPSIS: <br>
> &nbsp; sumPolis [polynomial string] [polynomial string]
> - DESCRIPTION: <br>
> &nbsp; Sums the first polynomial with the second one. <br>
> &nbsp; Mandatory arguments: <br>
> &nbsp; &nbsp; &nbsp; <**polynomial**> <br>
> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; First polynomial <br>
> &nbsp; &nbsp; &nbsp; <**polynomial**> <br>
> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Second polynomial <br>
> &nbsp; Return value<br>
> &nbsp; &nbsp; &nbsp; This function returns a string of the sum result.
> - EXAMPLES: <br>
> &nbsp; Addition with empty polynomial - **addPolis &nbsp; "x" &nbsp; " "**<br>
> &nbsp; &nbsp; **result** "x"
> <br><br>
> &nbsp; Addition of numbers (polynomial with x^0 only) - **addPolis &nbsp; "3" &nbsp; "2"**<br>
> &nbsp; &nbsp; **result** "5"
> <br><br>
>&nbsp; Addition with variables with no expoent - **addPolis &nbsp; "3x" &nbsp; "2y"**<br>
> &nbsp; &nbsp; **result** "3x + 2y"
> <br><br>
>&nbsp; Addition of opposites polynomial - **addPolis &nbsp; "3x^2" &nbsp; "-3x^2"**<br>
> &nbsp; &nbsp; **result** "0"
> <br><br>
>&nbsp; Addition of variables with same expoents - **addPolis &nbsp; "3x^2" &nbsp; "2x^2"**<br>
> &nbsp; &nbsp; **result** "5x^2"
> <br><br>
> &nbsp; These examples can be mixed to form more complex examples <br>
> - AUTHORS: <br>
> &nbsp; Written by **Andre Costa** and **Marcos Ferreira**.

> #### **MULTIPLICATION OF POLYNOMIALS** <br>
> - NAME: <br>
> &nbsp; multPolis - Multiply two polynomials
> - SYNOPSIS: <br>
> &nbsp; multPolis [polynomial string] [polynomial string]
> - DESCRIPTION: <br>
> &nbsp; Muliplys the first polynomial with the second one. <br>
> &nbsp; Mandatory arguments: <br>
> &nbsp; &nbsp; &nbsp; <**polynomial**> <br>
> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; First polynomial <br>
> &nbsp; &nbsp; &nbsp; <**polynomial**> <br>
> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Second polynomial <br>
> &nbsp; Return value<br>
> &nbsp; &nbsp; &nbsp; This function returns a string of the multiplication result.
> - EXAMPLES: <br>
> &nbsp; Multiplication with empty polynomial - **multPolis &nbsp; "x" &nbsp; ""**<br>
> &nbsp; &nbsp; **result** "Can't multiply with empty polynomial"
> <br><br>
&nbsp; Multiplication with empty polynomial - **multPolis &nbsp; "" &nbsp; "2x*y"**<br>
> &nbsp; &nbsp; **result** "Can't multiply with empty polynomial"
> <br><br>
> &nbsp; Multipliplication by 0 - **multPolis &nbsp; "3x^2" &nbsp; "0"**<br>
> &nbsp; &nbsp; **result** "0"
> <br><br>
> &nbsp; Multiplication of numbers - **multPolis &nbsp; "3" &nbsp; "6"**<br>
> &nbsp; &nbsp; **result** "18"
> <br><br>
> &nbsp; Multiplication of numbers - **multPolis &nbsp; "-3.2" &nbsp; "6"**<br>
> &nbsp; &nbsp; **result** "-19.2"
> <br><br>
> &nbsp; Multiplication of terms with same variables - **multPolis &nbsp; "3x" &nbsp; "6x"**<br>
> &nbsp; &nbsp; **result** "18x^2"
> <br><br>
> &nbsp; Multiplication with required normalization after - **multPolis &nbsp; "3x^2\*y + 3y" &nbsp; "6y + 6x^2\*y"**<br>
> &nbsp; &nbsp; **result** "18x^4*y^2 + 36x^2*y^2 + 18y^2"
> <br><br>
> &nbsp; These examples can be mixed to form more complex examples <br>
> - AUTHORS: <br>
> &nbsp; Written by **Andre Costa** and **Marcos Ferreira**.

> #### **DERIVATION OF POLYNOMIALS** <br>
> - NAME: <br>
> &nbsp; derivPoli - Derivation of a polynomial by a variable
> - SYNOPSIS: <br>
> &nbsp; derivPoli [Term] [polynomial string]
> - DESCRIPTION: <br>
> &nbsp; Derivates a polynomial by a variable. <br>
> &nbsp; Mandatory arguments: <br>
> &nbsp; &nbsp; &nbsp; <**Term**> <br>
> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; variable <br>
> &nbsp; &nbsp; &nbsp; <**polynomial**> <br>
> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Polynomial <br>
> &nbsp; Return value<br>
> &nbsp; &nbsp; &nbsp; This function returns a string of the resulting derivative.
> - EXAMPLES: <br>
> &nbsp; Derivation of empty polynomial - **derivPoli &nbsp; "x" &nbsp; ""**<br>
> &nbsp; &nbsp; **result** ""
> <br><br>
> &nbsp; Derivation of a number - **derivPoli &nbsp; "x" &nbsp; "3"**<br>
> &nbsp; &nbsp; **result** "0"
> <br><br>
> &nbsp; Derivation of a simple variable - **derivPoli &nbsp; "x" &nbsp; "3x"**<br>
> &nbsp; &nbsp; **result** "3"
> <br><br>
> &nbsp; Derivation of a non-existing variable - **derivPoli &nbsp; "y" &nbsp; "3x"**<br>
> &nbsp; &nbsp; **result** "0"
> <br><br>
> &nbsp; Derivation of a polynomial with multiple variables - **derivPoli &nbsp; "x" &nbsp; "3x^2*y^2"**<br>
> &nbsp; &nbsp; **result** "6x*y^2"
> <br><br>
> &nbsp; Derivation of a polynomial with negative floats expoents - **derivPoli &nbsp; "x" &nbsp; "3x^-2.3"**<br>
> &nbsp; &nbsp; **result** "-6.9x^(-3.3)"
> <br><br>
> &nbsp; These examples can be mixed to form more complex examples <br>
> - AUTHORS: <br>
> &nbsp; Written by **Andre Costa** and **Marcos Ferreira**.

## Parsing of the polynomial

Since the main functions require Strings as input the user is not expected to give the
input in the same way a polynomial is represented by the program. <br><br>

Simples rules to use the function: <br>
- Numbers can have a decimal part, for it use "." : "2.3", "4.89"
- Numbers can be negative: "-3", "-2.5"
- Variables needs to be divided using * : "2x*y", "2x^2\*y^2"
- Variable can have longer names: "2xy" is 2 (xy) while "2x*y" is 2 (x) (y)
- The numerical part of a term doesn't need "*" but can have it: "2x" or "2\*x"
- Terms can have as many variables as you like (none included): "2", "2x", "2x\*y\*z\*bee" 
- "+" can be used if the number is positive: "+2x", "2x^+4"
- If you wish parenthesis can be used on the exponents: "2x^(3)"

More detailed explanation about how the parser works (keep in mind this is a very simple parser):
- It divides the string using "+" or "-"
- It verifies the division in case the char before is "(" or "^", this is because of:
> User might input a negative exponent, for example: <br><br>
> &nbsp; "2x^-3" will be divided as "2x^-3" and not ("2x^" , "-3") <br>
> &nbsp; &nbsp; &nbsp; or <br>
> &nbsp; "2x^(-3)" will be divided as "2x^-3" and not ("2x^(" , "-3)") <br> <br>
> User might signilize number is positive, as follows: <br><br>
> &nbsp; "2x^+3" will be divided as "2x^+3" and not ("2x^" , "+3") <br>
> &nbsp; &nbsp; &nbsp; or <br>
> &nbsp; "2x^(+3)" will be divided as "2x^+3" and not ("2x^(" , "+3)") <br>
- Parser can detect negative numbers (as mentioned above)
- It can detect floats (using "."), for example:
> "2.3x", "x^3.5" <br>
> **OBS:** If the parser can't intrepet a number it will throw an error
- A term can have more than one variable, as long as they are divided using "*":
> "2x\*y", <br>
> "5x^2\*y",
> "x\*y^2", <br>
> "3.4x^2\*y^-1*z", <br>
>  and so on
- The numeric part of a term can be divided using "*" however this is not necessary
> "2*x" or "2x"
- Variables are represented by strings, so a variable can have more than a char in its name:
> "2xy" -> "xy" is the variable <br>
> "2x\*y" -> "x" and "y" are different variable <br>
> "2xy^2" -> "xy" is the variable <br>
> "2xy*z -> "xy" and "z" are different variables <br>
- For the exponents parenthesis can be used to better organize the string:
> "2x^(2)" <br>
> "2x^(-2.4)*y^(3)" <br>
> "2x^(4)*y^3"

**Technical details about the parser:** <br>

&nbsp; As mentioned the parser divided the string using "+" or "-", but before the division it verifies that the string can be divided (see examples above).<br>
After the initial division we will have a list of string, these will be the diferent terms of the polynomial. Each of these string will be processed as follows: <br><br>
&nbsp; First the signal will be extracted, in case there is no signal at the start, "+" will be infered (this happens on the start of the polynomial if user does not specifies it). <br><br>
&nbsp; Second The number will be extracted, this is done reading the remainder of the string (removing the signal) until the first letter is found.<br>
&nbsp; There is a function that will verify if number can be transformed into a float or not. <br>
&nbsp; In case of detection that it can not be transformed an error will occur and user will be signalized.<br>
&nbsp; If not, number will be converted into a float and stored.<br>
<br>
&nbsp; Third, the remainder of the string to be processed will be the list of pairs variable exponent. First the different variables divided using "*" as the divider. After this division the pair is processed as follows:<br>
&nbsp; &nbsp; &nbsp; name of the polynomial will be the letter until the end of the substring or "^" (whichever happens first). <br>
&nbsp; &nbsp; &nbsp; If a "^" is found exponent number is whatever is after it (at this point parethesis are included), else exponent is assigned as 1. <br>
&nbsp; &nbsp; &nbsp; If number is not assigned the same verification will occur as it was done for the numerical part of the term, however there is an additional step that is to remove the parenthesis if needed and the "+" before the number is found (haskell can't convert with the plus signal in the number).<br>
<b>OBS:</b> this list can be empty! <br><br>

This is the processing done for a term, a polynomial is just a list of terms so this process is repeated as needed.

## Code organization

The first part was how the polynomial should be represented, for easy organization it was organized as described:
- A polynomial is a list of terms, this was defined using:
> type Poli = [Term]
- A term stores its signal, its numeric part and a list of pairs (variable,exponent):
> data Term = Term {signal :: Char, numeric :: Float, expos :: [Expo]}
- Expo is how the pair (variable,exponent) was defined:
> data Expo = Expo {var :: String , expoNum :: Float}

The parser uses these functions (not including auxiliary functions):
- expoCreation: takes a string and returns an expo. 
- termCreation: takes a string and returns a Term. (Uses expoCreation)
- poliCreation: takes a String and returns a Poli. (Uses termCreation)

The component functions used as bulding block for the main function are:
- sortExpos: sort a list of expos
- sortTermExpos: Sort the expos af a term.
- sortTerms: Sort a list of terms by its list of expos.
- sumListExpos: Sums the exponents of a variable is they are equal on the Term (x^2*x^2=x^4)
- sumTermExpos: Receives two terms and sums them if possible
- sumListTerms: Sums all equals terms from a polynomial (Expos are equal)
- deriveTerm: Receives a variable (string) a Term and return the term derivation
- multiplyTerm: Receives two Terms and returns a term of the multiplication between them
- multiplyPolis: Receives two Polis and returns a Poli of the multiplicatiom between them

Functions used to transform a polynomial back into a string:
- joinStrings: joins two strings using a delimeter
- floatToString: transforms a string into a float. Approximates into an integer if possible, else approximate using two decimal places.
- expoToString: Transforms an Expo into a string.
- termToString: Transforms a Term into a string.
- firstTermToString: Transforms the first term into a string (because it doesn't have "+" at the front)
- removeDeadSpace: removes a space at the end of the string if it exists
- poliToString: Transforms a polynomial into a string. (Uses the functions above)

Many more auxiliary function was used for this project, however due to size it will not be included in the ReadMe. If you wish these can be viewed at the code itself. The code is commented and orfanized (at least tried).<br>
The main function are a combination of these functions mentioned above:
- normPoli utilizes: poliToString, sortTerms, removeZeroPoli, poliCreation, sumTermExpos, sumListTerms, removeZeroTerm. (and those functions rely on other functions like the auxiliary functions).
- addPolis utilizes:normPoli, poliCreation, sumListTerms, poliToString.
- multPolis utilizes: normPoli, poliCreation, multiplyPolis, poliToString
- derivPoli utilizes: normPoli, poliCreation, deriveTerm (used with map function), poliToString

**OBS: Like mentioned auxiliary function while not shown in the readme is a fundamental part of the project**

## EXTRA FUNCIONALITIES
- floats can be used
- approximation on floats
- negative numbers included for terms and exponents

## Tests

>### NORMALIZATION: COMPLEX TESTS
> <br>
> 1. normPoli "3x^2*y^5.2 -4y^3 -15"<br>
> 2. normPoli "5y^4*x^4*z + y^2*x^3 + 5.5555x^6"<br>
>
<br>

>### ADDITION: COMPLEX TESTS
> <br>
> 1. addPolis "3x^2*y^5.2 -4y^3 -15" "6.4x^-3 + 3y^3 + 40.65"<br>
> 2. addPolis "4.2x^2*y^2*z -3 +4*z^2" "2*z^2 - 4x^2*y^2*z +4.6 -3.1"<br> 
> 3. addPolis "3x^2*y^5.2 -4y^3 -15" "6.4y^-3 + 3y^3 + 40.65y"<br>
>
<br>

>### MULTIPLICATION: COMPLEX TESTS
> <br>
> 1. multPolis "3x^2*y^5.2 -15" "6.4x^-3 + 40.65"<br>
> 2. multPolis "4x^3 + 3y -2.2x^2*z" "-3.5x^3"<br>
>
<br>

>### DERIVATION: COMPLEX TESTS
> <br>
> 1. derivPoli "x" "3x^2*y^5.2 -4y^3 -15x^-3"<br>
> 2. derivPoli "y" "3x^2*y^5.2 -4y^3 -15x^-3"<br> 
>
<br>

## Requirements

This project requires the imports Data.List and Data.Char.

## Done by
- André Correia da Costa; up201905916
- Marcos William Ferreira Pinto; up201800177