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
aprox :: Int -> Double
