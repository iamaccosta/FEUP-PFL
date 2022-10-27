-- Studying for test
import Data.List

-- (2019, 2018, 2017, 2016)

--------------------------------------------------------
------------------------- 2019 -------------------------
--------------------------------------------------------

-- 1
-- (a) [[1,2]]++[[]]++[[3,4],[5]] 
-- [[1,2],[],[3,4],[5]]

-- (b) ([1,2]:[]:[3,4]:[[5]]) !! 3 
-- [[1,2],[],[3,4],[5]] !! 3 = [5] -- 3º elemento

-- (c) length ([]:[]:[]) 
-- 2 -> [[],[]] (ultima é a empty list, as outras são duas listas)

-- (d) drop 4 [0,4..32] 
-- [16,20,24,28,32]

-- (e) [(x+y, x*y) | x <- [1..4], y <- [x+1..4]] 
-- [(3,2),(4,3),(5,4), (5,6),(6,8), (7,12)] -- para cada x percorre cada y

-- (f) [[y | y <- ys, y `mod` 2 == 0] | ys <- [[3,5,2,8],[4,6,7,1,3],[9,5,11]] 
-- [[2,8],[4,6],[]]

-- (g) [(0,6),(1,5),(2,4),(3,3),(4,2),(5,1),(6,0)]
-- [(x,y) | (x,y) <- zip xs (reverse xs)]

-- (h)
-- h [] = 1
-- h [x] = x
-- h (x:y:xs) = x*y + h (y:xs) 
-- 3 + 3 + 5 + 0 + 0 + 4 = 15

-- (i)
-- [(’1’,"a"),(’2’,"b")]
-- [(Char, String)]

-- (j)
-- f x xs = sum xs < x
-- (Num a, Ord a) => a -> [a] -> Bool

-- (k)
-- ig [] = True
-- ig [x] = True
-- ig (x1:x2:xs) = x1 == x2 && ig (x2:xs)
-- Eq a => [a] -> Bool

-- (l)
-- fix f x = f x == x
-- Eq a => (a -> a) -> a -> Bool

-- 2
-- (a)
pitagoricos:: Int -> Int -> Int -> Bool
pitagoricos _ _ 0 = False
pitagoricos _ 0 _ = False
pitagoricos 0 _ _ = False
pitagoricos a b c = (a^2 + b^2 == c^2) || (a^2 + c^2 == b^2) || (b^2 + c^2 == a^2)

-- (b)
hipotenusa:: Int -> Int -> Float
hipotenusa _ 0 = error "impossible value"
hipotenusa 0 _ = error "impossible value"
hipotenusa a b = sqrt(fromIntegral(a^2 + b^2))

-- 3
-- (a)
diferentes:: Eq a => [a] -> [a]
diferentes (x:[]) = []
diferentes (x:y:xs) | x /= y = [x] ++ diferentes (y:xs)
                    | otherwise = diferentes (y:xs)

-- (b)
diferentes':: Eq a => [a] -> [a]
diferentes' xs = [fst(x,y) | (x,y) <- zip xs (tail xs), x/=y]

-- 4
zip3':: [a] -> [b] -> [c] -> [(a,b,c)]
zip3' xs ys zs = [(x,y,z) | (x,(y,z)) <- zip xs (zip ys zs)]

-- 5
partir:: Eq a => a -> [a] -> ([a], [a])
partir _ [] = ([], [])
partir a xs = (takeWhile (\b -> b /= a) xs, dropWhile (\b -> b /= a) xs)

-- 6
parts:: [a] -> [[[a]]]
parts [] = [[]]
parts (x:xs) = [ [x]:ps | ps <- pss] ++ [ (x:p):ps| (p:ps) <- pss]
    where pss = parts xs


--------------------------------------------------------
------------------------- 2018 -------------------------
--------------------------------------------------------

-- 1
-- (a) [[1,2,3]] ++ [] ++ [[4],[5]]
-- [[1,2,3],[4],[5]]

-- (b) length ([1]:[2]:[]:[3]:[4]:[])
-- 5

-- (c) take 7 [8,6..0]
-- [8,6,4,2,0]

-- (d) fst ([(1,2),(3,4),(5,6),(9,7),(8,13)] !! 3)
-- 9

-- (e) [ (y,x) | x <- [1,2], y <- [x..4]]
-- [(1,1),(2,1),(3,1),(4,1),(2,2),(3,2),(4,2)]

-- (f) [2^x | x <- [1..5], y <- [1..3], mod (x+y) 3 == 0]
-- [2,4,8,16,32]

-- (g) [1,3,7,15,31,63,127,255,511,1023]
-- [2^x - 1 | x <- [1..10]]

-- (h) f [1..5]
-- f [] = 1
-- f [x] = x
-- f (x:xs) = x + f xs
-- 1 + 2 + 3 + 4 + 5 = 15

-- (i)
-- ([Bool, Bool], [Char, Char])

-- (j)
-- a -> a -> (a, a)

-- (k)
-- Eq a => [a] -> a -> [a]

-- (l)
-- Eq a => [a] -> Bool

-- 2
-- (a)
distancia:: (Float, Float) -> (Float, Float) -> Float
distancia (x1,y1) (x2,y2) = sqrt((x2-x1)^2 + (y2-y1)^2)

-- 3
-- (a)
niguais:: Int -> a -> [a]
niguais 0 _ = []
niguais n a = [a] ++ niguais (n-1) a

-- (b)
niguais':: Int -> a -> [a]
niguais' n a = [fst (a,y) | y <- [1..n]]

-- 4
merge':: Ord a => [a] -> [a] -> [a]
merge' xs [] = xs ++ []
merge' xs (y:ys) = merge' (insert y xs) ys

-- 5
length_zip:: [a] -> [(Int,a)]
length_zip xs = [(a,b) | (a,b) <- zip (reverse [1..n]) xs]
    where n = length xs


--------------------------------------------------------
------------------------- 2017 -------------------------
--------------------------------------------------------

-- 1
-- (a) 1:(5:(4:(3:[])))
-- [1,5,4,3]

-- (b) tail [4,5,6,9]
-- [5,6,9]

-- (c) head ([2,3] ++ [1,4] ++ [4,6])
-- 2

-- (d) drop 5 [0,3..30]
-- [15,18,21,24,27,30]

-- (e) length ([1,2]:[]:[3,4]:[[5]])
-- 4

-- (f) [ x*y | x <- [1..3], y <- [x..3]]
-- [1,2,3,4,6,9]

-- (g) [ x | x <- [1..3], y <- [1..3], (x+y) == 4]
-- [1,2,3]

-- (h)
-- [((-1)^x)*x | x <- [0..10]]

-- (i)
-- 8

-- (j)
-- ([Char], [Float])

-- (k)
-- (a,b) -> a

-- (l)
-- Ord a => a -> a -> a -> Bool

-- (m)
-- [a] -> a


-- 2
numEqual:: Int -> Int -> Int -> Int
numEqual a b c = if a == b && a == c        then 3
                 else if a /= b && a == c   then 2
                 else if a == b && a /= c   then 2
                 else if a /= b && b == c   then 2
                 else                            1

-- 4
enquantoPar:: [Int] -> [Int]
enquantoPar xs = takeWhile (\a -> mod a 2 == 0) xs

-- 5
nat_zip:: [a] -> [(Int, a)]
nat_zip xs = [(a,b) | (a,b) <- zip [1..n] xs]
    where n = length xs

-- 6
-- (a)
quadrados:: [Int] -> [Int]
quadrados [] = []
quadrados (x:xs) = x^2 : quadrados xs

-- (b)
quadrados':: [Int] -> [Int]
quadrados' xs = [x^2 | x <- xs]


--------------------------------------------------------
------------------------- 2016 -------------------------
--------------------------------------------------------

-- 1
-- (a) [2,3,1] ++ [4] ++ [4]
-- [2,3,1,4,4]

-- (b) take 5 [0,10..]
-- [0,10,20,30,40]

-- (c) tail ([1,2]:[]:[3,4]:[[5]])
-- [[],[3,4],[5]]

-- (d) [1,3,4,5,6,9] !! 3
-- 5

-- (e) [1 | x <- [1..3], y <- [1..x]]
-- [1,1,1,1,1,1]

-- (f) [(x,y) | x <- [1..3], y <- [2..4], (x+y) == 5]
-- [(1,4),(2,3),(3,2)]

-- (g) [1,2,4,8,16,32,64]
-- [2^x | x <- [0..6]]

-- (h)
-- 5*4*3*2*1*0 = 0

-- (i)
-- [(Bool, Int)]

-- (j)
-- (a,b) -> (b,a)

-- (k)
-- (Ord a, Num a) => a -> a -> a

-- 2
-- (a)
ttriangulo:: (Eq a, Num a) => a -> a -> a -> String
ttriangulo a b c | a == b && a == c = "Equilatero"
                 | a == b && a /= c = "Isosceles"
                 | a /= b && a == c = "Isosceles"
                 | b == c && b /= a = "Isosceles"
                 | a /= b && a /= c  && b /= c = "Escaleno"

-- (b)
rectangulo:: (Eq a, Num a) => a -> a -> a -> Bool
rectangulo a b c = (a^2 + b^2 == c^2) || (a^2 + c^2 == b^2) || (b^2 + c^2 == a^2)

-- 3
maiores:: (Ord a, Num a) => [a] -> [a]
maiores (x:[]) = []
maiores (x:y:xs) | x > y = x : maiores (y:xs)
                 | otherwise = maiores (y:xs)

-- 4
-- (a)
somapares:: (Num a) => [(a, a)] -> [a]
somapares [] = []
somapares (x:xs) = (fst x + snd x) : somapares xs

-- (b)
somapares':: (Num a) => [(a, a)] -> [a]
somapares' xs = [a+b | (a,b) <- xs]

-- 5
-- (a)
itera:: (Num a) => Int -> (a -> a) -> a -> a
itera 1 f v = f v
itera n f v = f (itera (n-1) f v)

-- (b)
mult:: Int -> Int -> Int
mult a b = itera 1 (*b) a


--------------------------------------------------------
------------------------- 2021 -------------------------
--------------------------------------------------------

---------------------------
--------- Parte 1 ---------
---------------------------

-- 1 [(x,y) | x <- "abc", y <- [1,2]]
-- [('a', 1),('a', 2),('b', 1),('b', 2),('c', 1),('c', 2)]

-- 2 (map (>0))
-- [Int] -> [Bool] // (Ord a, Num a) -> [a] -> [Bool]

-- 3
-- last [x] = x
-- last (x:xs) = last xs
-- [a] -> a

-- 4 foldr (+) 7 [1,2,3]
-- 13

-- 5  (estudar)

-- 6 head [[1], [2,3], [4,5,6]]
-- [Int]

-- 7 tail (reverse [1,2,3])
-- [2,1]

-- 8 [(x,y) | (x,y) <- [(1,2),(2,3)], x*y==6]
-- [(2,3)]

-- 9 cycle (cycle [1,2,3])
-- [1,2,3,1,2,3..]

-- 10 head (zip [1..10] (tail [1..10]))
-- (1,2)

-- 11 a)

-- 12 filter (/='a') "abba"
-- "bb"

---------------------------
--------- Parte 2 ---------
---------------------------

-- 1
maxpos:: [Int] -> Int
maxpos (x:[]) = if x > 0 then x else 0
maxpos (x:y:xs) | x > y = maxpos (x:xs)
                | otherwise = maxpos (y:xs)

maxpos':: [Int] -> Int
maxpos' xs = foldr max 0 xs


-- 2
dups:: [a] -> [a]
dups [] = []
dups (x:[]) = x : x : []
dups (x:y:xs) = x : x : y : dups xs

-- 3
transforma:: String -> String
transforma [] = []
transforma (x:xs) | x == 'a' || x == 'e' || x == 'i' || x == 'o' || x == 'u' = x : 'p' : x : transforma xs
                  | otherwise = x : transforma xs

--------------------------------------------------------------
type Vector = [Int]
type Matriz = [[Int]]

-- 4
transposta :: Matriz -> Matriz
transposta [] = []
transposta m = [head x | x <- m] : transposta [tail x | x <- m, tail x /= []]

-- 5
prodInterno :: Vector -> Vector -> Int
prodInterno xs ys = sum [x*y | (x,y) <- zip xs ys]

-- 6 
prodMat :: Matriz -> Matriz -> Matriz
prodMat m1 m2 = prodMatAux m1 (transposta m2)

prodMatAux :: Matriz -> Matriz -> Matriz
prodMatAux [] [] = []
prodMatAux m1 m2 = [[prodInterno v1 v2 | v2 <- m2] | v1 <- m1]

--------------------------------------------------------------
data Arv a = F | N a (Arv a) (Arv a) deriving(Show)

-- 7
alturas:: Arv a -> Arv Int
alturas F = F
alturas (N a esq dir) = N (alturasAux (N a esq dir)) (alturas esq) (alturas dir)


alturasAux:: Arv a -> Int
alturasAux F = 0
alturasAux (N a esq dir) = 1 + max (alturasAux esq) (alturasAux dir)

-- 8
equilibrada:: Eq a => Arv a -> Bool
equilibrada F = False
equilibrada (N a F dir) = False
equilibrada (N a esq F) = False
equilibrada (N a esq dir) | alturasAux esq == alturasAux dir = True 
                          | otherwise = False

-- 9
f:: (a -> b -> c) -> b -> a -> c
f g b a = g a b


--------------------------------------------------------------------
-- IO study

acao = do putStrLn "Que queres lanchar?"
          getLine
