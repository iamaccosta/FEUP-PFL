import Data.Char

-- 2.1
-- (a)
myand :: [Bool] -> Bool
myand [] = True
myand (False : xs) = False
myand (_ : xs) = myand xs

-- (b)
myor :: [Bool] -> Bool
myor [] = False
myor (True : xs) = True
myor (_ : xs) = myor xs

-- (c)
myconcat :: [[a]] -> [a]
myconcat [] = []
myconcat (x:xs) = x ++ myconcat xs

-- (d)
myreplicate :: Int -> a -> [a]
myreplicate x y | x == 0    = []
                | otherwise = [y] ++ myreplicate (x-1) y

-- (e)
(!!!) :: [a] -> Int -> a
(!!!) a b | length a == 0       = error "lista vazia"
          | length a <= b        = error "b maior do que tamanho da lista"
          | b == 0              = head a
          | otherwise           =  (!!!) (tail a) (b-1)

-- (f)
myelem :: Eq a => a -> [a] -> Bool
myelem x y | length y == 0     = False
           | x == head y       = True
           | otherwise         = myelem x (tail y)

-- 2.2
myintersperse :: a -> [a] -> [a]
myintersperse x y | length y == 0   = []
                  | length y == 1   = y
                  | otherwise       = head y : [x] ++ myintersperse x (tail y)

-- 2.3
my_mdc :: Integer -> Integer -> Integer
my_mdc a b | b == 0 = a
           | otherwise = my_mdc b (mod a b)

-- 2.4
-- (a)
myInsert :: Ord a => a -> [a] -> [a]
myInsert a b | length b == 0    = [a]
             | a <= head b      = a : b
             | otherwise        = head b : myInsert a (tail b)

-- (b)
myIsort :: Ord a => [a] -> [a]
myIsort [] = []
myIsort (x:xs) = myInsert x (myIsort xs)

-- 2.5
-- (a)
myMinimum :: Ord a => [a] -> a
myMinimum [] = error "no values"
myMinimum (x:[]) = x
myMinimum (x:xs) | x <= (myMinimum xs) = x
                 | otherwise = myMinimum xs

-- (b)
myDelete :: Eq a => a -> [a] -> [a]
myDelete x [] = []
myDelete x (y:ys) | (x == y) = ys
                  | otherwise = y : myDelete x ys

-- (c)
mySsort :: Ord a => [a] -> [a]
mySsort [] = []
mySsort x = myMinimum x : mySsort(myDelete(myMinimum x) x)

-- 2.6
sumSquare = [x^2 | x <- [1..100]]

-- 2.7
-- (a)
aprox :: Int -> Double
aprox n = 4 * sum [ (-1)**a / (2 * a + 1) | a <- [0.0, 1.0 .. fromIntegral n]]

-- (b)
aprox' :: Int -> Double
aprox' n = sqrt ( 12* sum [(-1)**a / (a + 1)^2 | a <- [0.0, 1.0 .. fromIntegral n]])

-- 2.8
dotprod :: [Float] -> [Float] -> Float
dotprod a b = sum [x*y |(x, y) <- zip a b]

-- 2.9
divprop :: Integer -> [Integer]
divprop a = [x | x <- [1 .. a-1], a `mod` x == 0]

-- 2.10
perfeitos :: Integer -> [Integer]
perfeitos a = [x | x <- [1 .. a-1], sum (divprop x) == x]

-- 2.11
pitagoricos :: Integer -> [(Integer, Integer, Integer)]
pitagoricos a = [(x, y, z) | x <- [1..a], y <- [1..a], z <- [1..a], x^2 + y^2 == z^2]

-- 2.12 
primo :: Integer -> Bool
primo a = divprop a == [1]

-- 2.13 
mersennes :: [Integer]
mersennes = take 30 [x | x <- [1..], primo x == True]

-- 2.14 
binom :: Int -> Int -> Int
binom n k = fact n `div` (fact k * fact (n-k))
    where fact n = product [1..n]

pascal :: Int -> [[Int]]
pascal n = [[ binom i j | j <- [0..i]] | i <- [0..n]]

-- 2.15
cifraLetra :: Int -> Char -> Char
cifraLetra k x | isLetter x && isUpper x = chr (mod (ord x + k - ord 'A' ) 26 + ord 'A' )
               | isLetter x && isLower x = chr (mod (ord x +k - ord 'a' ) 26 + ord 'a' )
               | otherwise = x

cifrar :: Int -> String -> String
cifrar k xs = [cifraLetra k x | x <- xs]

-- 2.16
compConcat :: [[a]] -> [a]
compConcat xss = [x | xs <- xss, x <- xs]

compReplicate :: Int -> a -> [a]
compReplicate n x = [x | _ <- [1..n]]

-- 2.17
forte :: String -> Bool
forte x = length x >= 8 && any isLower x && any isUpper x && any isNumber x

-- 2.18
-- (a)
mindiv :: Int -> Int
mindiv n = head [i | i <- [2..n], mod n i == 0]

-- (b)
primo' :: Int -> Bool
primo' n = n > 1 && (mindiv n == n)


-- 2.19
mynub :: Eq a => [a] -> [a]
mynub []  = []
mynub (x:xs) = x:mynub [y | y <- xs, y /= x]

-- 2.20
transpose :: [[a]] -> [[a]]
transpose xss = [ [xs !! i | xs <- xss] | i <- [0..(z-1)] ]
    where z = length (head xss)
