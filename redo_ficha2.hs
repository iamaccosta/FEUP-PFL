-- Studying for test
import Data.List
import Data.Char

-- 2.1
-- (a)
my_and:: [Bool] -> Bool
my_and [] = True
my_and (x:xs) = x && my_and xs

-- (b)
my_or:: [Bool] -> Bool
my_or [] = False
my_or (x:xs) = x || my_or xs

-- (c)
my_concat:: [[a]] -> [a]
my_concat [] = []
my_concat xss = head xss ++ my_concat (tail xss)

-- (d)
my_replicate:: Int -> a -> [a]
my_replicate 0 a = [] 
my_replicate n a = [a] ++ my_replicate (n-1) a

-- (e)
(!!!):: [a] -> Int -> a
(!!!) [] _ = error "empty list"
(!!!) (x:xs) 1 = x
(!!!) (x:xs) n = (!!!) xs (n - 1)

-- (f)
my_elem:: Eq a => a -> [a] -> Bool
my_elem _ [] = False
my_elem a (x:xs) | a == x = True
                 | otherwise = my_elem a xs

-- 2.2
my_intersperse:: a -> [a] -> [a]
my_intersperse _ [] = []
my_intersperse _ (x:[]) = [x]
my_intersperse a (x:xs) = x : [a] ++ my_intersperse a xs

-- 2.4
myInsert :: Ord a => a -> [a] -> [a]
myInsert a b | length b == 0    = [a]
             | a <= head b      = [a] ++ b
             | otherwise        = head b : myInsert a (tail b)

-- 2.6
sumSquare = sum [x^2 | x <- [1..100]]

-- 2.7
aprox:: Int -> Double
aprox n = 4 * sum [((-1)**x)/((2*x) + 1) | x <- [0.0, 1.0 .. fromIntegral n]]

-- 2.8
dotprod:: [Float] -> [Float] -> Float
dotprod [] _ = 0
dotprod _ [] = 0
dotprod xs ys = sum [a*b | (a,b) <- zip xs ys]

-- 2.9
divprop:: Integer -> [Integer]
divprop n = [a | a <- [1..n-1], mod n a == 0] 

-- 2.10
perfeitos:: Integer -> [Integer]
perfeitos n = [x | x <- [1..n], sum(divprop x) == x]

-- 2.11
pitagoricos:: Integer -> [(Integer, Integer, Integer)]
pitagoricos n = [(a, b, c) | a <- [1..n], b <- [1..n], c <- [1..n], (a^2) + (b^2) == (c^2)]

-- 2.12
primo:: Integer -> Bool
primo a | (length divs) <= 1 = True
        | otherwise = False
        where divs = divprop a

-- primo a = divprop a == [1] -- tamanho de divprop a não passa de 1, porque o a não está incluido

-- 2.13
mersennes:: [Int]
mersennes = [fromIntegral x | x <- [1..30], primo x]

-- 2.14
fatorial:: Integer -> Integer
fatorial 0 = 1
fatorial a = a * fatorial(a-1)

binom:: Integer -> Integer -> Integer
binom a b = (fatorial a) `div` ((fatorial b)*(fatorial (a - b)))

pascal:: Integer -> [[Integer]]
pascal n = [[binom a b | b <- [0..a]] | a <- [0..n]]

-- 2.15
cifraLetra :: Int -> Char -> Char
cifraLetra k x | isLetter x && isUpper x = chr (mod (ord x + k - ord 'A' ) 26 + ord 'A' )
               | isLetter x && isLower x = chr (mod (ord x +k - ord 'a' ) 26 + ord 'a' )
               | otherwise = x

cifrar:: Int -> String -> String
cifrar a xs = [cifraLetra a x | x <- xs]

-- 2.16
concat':: [[a]] -> [a]
concat' xss = [x | xs <- xss, x <- xs]

replicate':: Int -> a -> [a]
replicate' n a = [a | _ <- [1..n]]

-- 2.17
forte:: String -> Bool
forte xs = (any isUpper xs) && (any isLower xs) && (any isNumber xs) && (length xs) >= 8

-- 2.18
-- (a)
mindiv:: Int -> Int
mindiv a = head(tail b)
        where b = [x | x <- [1..a], mod a x == 0]
    
-- (b)
primo':: Int -> Bool
primo' n = ((mindiv n) == n) 

-- 2.19
nub' :: Eq a => [a] -> [a]
nub' []  = []
nub' (x:xs) = x : nub' [y | y <- xs, y/=x]

-- 2.21
algarismos:: Int -> [Int]
algarismos n | n < 10 = [n]
             | otherwise = algarismos (div n 10) ++ [mod n 10]

-- 2.22
toBits:: Int -> [Int]
toBits n | n < 0 = error "Number inválid"
         | n < 2 = [n]
         | otherwise = toBits(div n 2) ++ [mod n 2]

-- 2.23
fromBits:: [Int] -> Int
fromBits [] = 0
fromBits xs | head(xs) == 0 = fromBits(tail xs)
            | otherwise = 2^(length(xs) - 1) + fromBits(tail xs)

-- 2.24
-- (a)
merge:: Ord a => [a] -> [a] -> [a]
merge [] ys = sort ys
merge xs [] = sort xs
merge (x:xs) (y:ys) | x < y = x : merge xs (y:ys)
                    | otherwise = y : merge (x:xs) ys

-- (b)
metades :: [a] -> ([a],[a]) 
metades [] = ([],[])
metades [x] = ([x],[])
metades (x:x1:xs) = (x:z,x1:z1)
    where (z,z1) = metades xs

mergeSort :: Ord a => [a] -> [a]
mergeSort [] = []
mergeSort [x] = [x]
mergeSort xs = merge (mergeSort left) (mergeSort right)
    where  (left,right) = metades xs