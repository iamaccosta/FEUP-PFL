-- Studying for test
import Data.List

-- 1.1
testaTriangulo:: Float -> Float -> Float -> Bool
testaTriangulo a b c = (a + b > c) && (a + c > b) && (b + c > a)

-- 1.2
areaTriangulo:: Float -> Float -> Float -> Float
areaTriangulo a b c = sqrt s*(s-a)*(s-b)*(s-c)
                    where s = (a + b + c) / 2

-- 1.3
metades:: [a] -> ([a], [a])
metades a = (take b a, drop b a) 
          where b = length(a) `div` 2

-- 1.4
-- (a)
my_last1:: [a] -> a
my_last1 [] = error "empty list"
my_last1 a = head (reverse a)

my_last2:: [a] -> a
my_last2 [] = error "empty list"
my_last2 a = (drop (length(a) - 1) a)!! 0

-- (b)
my_init1:: [a] -> [a]
my_init1 [] = []
my_init1 xs = reverse(tail(reverse xs))

my_init2:: [a] -> [a]
my_init2 [] = []
my_init2 xs = take (length(xs) - 1) xs


-- 1.5
-- (a)
fatorial:: Integer -> Integer
fatorial 0 = 1
fatorial a = a * fatorial(a-1)

binom:: Integer -> Integer -> Integer
binom a b = (fatorial a) `div` ((fatorial b)*(fatorial (a - b)))

-- 1.6
raizes:: Float -> Float -> Float -> (Float, Float)
raizes a b c = (-b -raiz/(2*a), -b + raiz/(2*a))
            where raiz = sqrt((b^2) - (4*a*c))

-- 1.8
-- estudar tipos

-- 1.14
curta:: [a] -> Bool
curta a | (length a) <= 2 = True
        | otherwise = False

curta':: [a] -> Bool
curta' [] = True
curta' [_] = True
curta' [_,_] = True
curta' (_:_:_) = False

-- 1.15 must use () on negative numbers (e.g. 1 (-1) 3 -> result is 1)
mediana:: (Ord a) => a -> a -> a -> a
mediana a b c = head(tail(sort([a] ++ [b] ++ [c])))
