-- Studying for test
import Data.List

-- (No 5 (No 3 (No 2 Vazia Vazia) (No 4 Vazia Vazia)) (No 8 (No 6 Vazia Vazia) (No 9 Vazia Vazia)))

data Arv a = Vazia | No a (Arv a) (Arv a) deriving (Show)
-- 4.1
sumArv:: Num a => Arv a -> a
sumArv Vazia = 0
sumArv (No a esq dir) = a + sumArv esq + sumArv dir

-- 4.2
listarDecres:: Arv a -> [a]
listarDecres Vazia = []
listarDecres (No a esq dir) = listarDecres esq ++ [a] ++ listarDecres dir

-- 4.3
nivel:: Int -> Arv a -> [a]
nivel 0 (No a esq dir) = [a]
nivel n (No a esq dir) = nivel (n-1) esq ++ nivel (n-1) dir

-- 4.5
mapArv:: (a -> b) -> Arv a -> Arv b
mapArv _ Vazia = Vazia
mapArv f (No a esq dir) = No (f a) (mapArv f esq) (mapArv f dir)

-- 4.6
-- (a)
mais_dir:: Arv a -> a
mais_dir (No a _ Vazia) = a
mais_dir (No _ _ dir) = mais_dir dir

-- (b)
remover' :: Ord a => a -> Arv a -> Arv a
remover' _ Vazia = Vazia
remover' a (No b esq dir) | a < b = remover' a esq
                          | a > b = remover' a dir
                          | otherwise = removerNo (No b esq dir)

removerNo :: Ord a => Arv a -> Arv a
removerNo Vazia = error "Não tem membros para remover"
removerNo (No _ Vazia dir) = dir
removerNo (No _ esq Vazia) = esq
removerNo (No _ esq dir) = No n (remover' n esq) dir
    where n = mais_dir esq