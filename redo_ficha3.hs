-- Studying for test
import Data.List
import Data.Char

-- 3.1
-- [f x | x ← xs, p x]
-- map(f filter(p xs))

-- 3.2
dec2int:: [Int] -> Int
dec2int xs = foldl ((+).(*10)) 0 xs

-- 3.3
zipWith':: (a->b->c) -> [a] -> [b] -> [c]
zipWith' f [] [] = []
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys 

-- 3.4 insert -> inserts a number always in the right place
isort':: Ord a => [a] -> [a]
isort' xs = foldr insert [] xs

-- 3.5
-- (a)
maximum':: Ord a => [a] -> a
maximum' xs = foldl1 max xs

maximum_r':: Ord a => [a] -> a
maximum_r' xs = foldr1 max xs

minimum':: Ord a => [a] -> a
minimum' xs = foldl1 min xs

minimum_r':: Ord a => [a] -> a
minimum_r' xs = foldr1 min xs

-- (b)
foldl1':: (a -> a -> a) -> [a] -> a
foldl1' f xs = foldl f (head xs) (tail xs)

foldr1':: (a -> a -> a) -> [a] -> a
foldr1' f xs = foldr f (last xs) (init xs)

-- 3.6
mdc:: Int -> Int -> Int
mdc a b =  fst (until (\(a,b) -> b == 0) (\(a,b) -> (b, mod a b)) (a,b))

-- 3.7
-- (a)
(+++):: [a] -> [a] -> [a]
(+++) xs ys = foldr (:) ys xs

-- (b)
concat':: [[a]] -> [a]
concat' xss = foldr (++) [] xss

-- (c)
reverse':: [a] -> [a]
reverse' xs = foldr (\a b -> b ++ [a]) [] xs

-- (d)
reverse'' :: [a] -> [a]
reverse'' xs = foldl(\a b -> [b] ++ a) [] xs

-- (e)
elem':: Eq a => a -> [a] -> Bool
elem' a xs = any (\b -> b == a) xs

-- 3.8
palavras:: String -> [String]
palavras [] = []
palavras xs = takeWhile isLetter xs : palavras (dropWhile (\b -> b == ' ' ) (dropWhile isLetter xs))
