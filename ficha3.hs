import Data.List
-- 3.1
-- [f x | x ← xs, p x]
-- map(f (filter p xs))

-- 3.2
dec2int :: [Int] -> Int
dec2int xs = foldl ((+).(*10)) 0 xs

-- 3.3
-- zipWith f xs ys = [f x y | (x, y) ← zip xs ys]
myzipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myzipWith f [] [] = []
myzipWith f (x:xs) (y:ys) = f x y :  myzipWith f xs ys 

-- 3.4
isort :: Ord a => [a] -> [a]
isort xs = foldr insert [] xs

-- 3.5
myMaximum :: Ord a => [a] -> a
myMaximum xs = foldl1 (max) xs

myMinimum :: Ord a => [a] -> a
myMinimum xs = foldr1 (min) xs

-- 3.6


-- 3.7
-- (a)
(+++):: [a] -> [a] -> [a]
(+++) xs ys = foldr (:) ys xs

-- (b)
myconcat :: [[a]] -> [a]
myconcat xss = foldr (++) [] xss

-- (c)
myreverse :: [a] -> [a]
myreverse xs = foldr (\a b -> b ++ [a]) [] xs

-- (d)
myreverse2 :: [a] -> [a]
myreverse2 xs = foldl(\a b -> [b] ++ a) [] xs

-- (e)
myelem :: Eq a => a -> [a] -> Bool
myelem a xs = any (\b -> b == a) xs

-- 3.8
-- (a)
palavras :: String -> [String]
palavras [] = []
palavras a = takeWhile (\b -> b /= ' ') a : palavras (dropWhile (\b -> b == ' ') (dropWhile (\b -> b /= ' ') a))

-- (b)
despalavras :: [String] -> String
despalavras xs = tail (foldr ((++).((++)[' '])) [] xs) 
