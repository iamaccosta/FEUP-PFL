import Data.List

-- (No 11 (No 3 (No 2 Vazia Vazia) (No 5 Vazia Vazia)) (No 19 (No 13 Vazia Vazia) (No 23 Vazia Vazia)))
-- 4.1
data Arv a = Vazia | No a (Arv a) (Arv a) deriving (Show)

sumArv :: Num a => Arv a -> a
sumArv Vazia = 0
sumArv (No x esq dir) = x + sumArv esq + sumArv dir

-- 4.2
listarDecres:: Arv a -> [a]
listarDecres Vazia = []
listarDecres (No x esq dir) = listarDecres dir ++ [x] ++ listarDecres esq

-- 4.3
nivel:: Int -> Arv a -> [a]
nivel _ Vazia = []
nivel n (No x esq dir) | n > 0      = (nivel (n-1) esq) ++ (nivel (n-1) dir)
                       | n == 0     = [x]
                       | n < 0      = error "nivel inválido"

-- 4.4
divideList:: [a] -> [[a]]
divideList [] = []
divideList xs = take (div (length xs) 2) xs : [drop (div (length xs) 2) xs]


-- (a)
construir:: Ord a => [a] -> Arv a
construir [] = Vazia
construir xs = No first (construir (head divided)) (construir (tail(last (divided))))
            where first = head(last (divided))
                  divided = divideList (sort xs)

-- (b)

-- 4.5
mapArv:: (a -> b) -> Arv a -> Arv b
mapArv _ Vazia = Vazia
mapArv f (No x esq dir) = (No (f x) (mapArv f esq) (mapArv f dir))

-- 4.6