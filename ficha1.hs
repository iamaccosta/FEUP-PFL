-- 1.1
testaTriangulo :: Float -> Float -> Float -> Bool
testaTriangulo a b c = (a + b) > c &&
    (a + c) > b &&
    (b + c) > a

-- 1.2
areaTriangulo :: Float -> Float -> Float -> Float
areaTriangulo a b c = sqrt(s*(s - a)*(s - b)*(s - c)) where 
    s = (a + b + c)/2

-- 1.3
metades :: [a] -> ([a], [a])
metades a = (take b a, drop b a) where 
    b = length(a) `div` 2

-- 1.4 a)
my_last1 :: [a] -> a
my_last1 a = (drop b a)!!0 where
    b = length(a) - 1

my_last2 :: [a] -> a
my_last2 a = head (reverse a)

-- 1.4 b)
my_init1 :: [a] -> [a]
my_init1 a = reverse (tail (reverse a))

my_init2 :: [a] -> [a]
my_init2 a = (take b a) where
    b = length(a) - 1 

-- 1.6
raizes :: Float -> Float -> Float -> (Float, Float)
raizes a b c = (((-b) - sqrt(s))/(a2), (((-b) + sqrt(s))/(a2)))
    where   s = b^2 - 4*a*c
            a2 = 2*a

-- 1.7
{--
(a) ['a', 'b', 'c'] = [Char]
(b) ('a', 'b', 'c') = (Char, Char, Char)
(c) [(False, '0'), (True, '1')] = [(Bool, Char)]
(d) ([False, True], ['0', '1']) = ([Bool], [Char])
(e) [tail, init, reverse] = [[a] -> [a]]
(f) [id, not] = [Bool -> Bool]
-}

-- 1.8
{--
(a) [a] -> a
(b) (a, b) -> (b, a)
(c) a -> b -> (a, b)
(d) Num -> Num
(e) Fractional -> Fractional
(f) Char -> Bool
(g) Char -> Bool
(h) [a] -> Bool
(i) 
-}

-- 1.9
classifica_guardas :: Int -> String
classifica_guardas n | n <= 9               = "reprovado"
                     | n >= 10 && n <= 12   = "suficiente"
                     | n >= 10 && n <= 15   = "bom"
                     | n >= 16 && n <= 18   = "muito bom"
                     | n >= 19 && n <= 20   = "excelente"
                     | otherwise            = error "nota invalida"

classifica_cond :: Int -> String
classifica_cond n = if n <= 9                   then "reprovado"
                    else if n >= 10 && n <= 12  then "suficiente"
                    else if n >= 10 && n <= 15  then "bom"
                    else if n >= 16 && n <= 18  then "muito bom"
                    else if n >= 19 && n <= 20  then "excelente"
                    else                        error "nota invalida"

-- 1.10
imc_calculo :: Float -> Float -> Float
imc_calculo x y = x/(y^2)

classifica_IMC :: Float -> Float -> String
classifica_IMC x y | imc_calculo x y < 18.5                             = "baixo peso"
                   | imc_calculo x y >= 18.5 && imc_calculo x y < 25    = "peso normal" 
                   | imc_calculo x y >= 25 && imc_calculo x y < 30      = "excesso de peso"
                   | imc_calculo x y >= 30                              = "obesidade"

-- 1.11
-- (a)
max3, min3 :: Ord a => a -> a -> a -> a
max3 x y z = if (x >= y && x >= z)       then x
             else if (y >= x && y >= z)   then y
             else                              z

min3 x y z = if ( x <= y && x <= z)       then x
             else if (y <= x && y <= z)   then y
             else                              z

-- (b)
max3_b, min3_b :: Ord a => a -> a -> a -> a
max3_b x y z = if max x y < z then z else max x y
min3_b x y z = if min x y > z then z else min x y

-- 1.12
xor :: Bool -> Bool -> Bool
xor True False = True 
xor False True = True 
xor _ _ = False 

-- 1.13
safetail_a :: [a] -> [a]
safetail_a a | length a == 0    = []
             | otherwise        = tail a

safetail_b a = if length a == 0 then []
               else                  tail a

safetail_c [] = []
safetail_c a = tail a

-- 1.14

