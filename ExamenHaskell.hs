{-
Elija la definición correcta para la función largeFib :: Integer que calcula el primer fibonacci mayor a 1000

NOTA: Se asume que fibs es una función que calcula una lista infinita de números fibonacci

-}

fibs :: [Integer]
fibs = 0 : 1 : zipWith (+) fibs (tail fibs)

-- Respuesta : b) largeFib head (dropWhile (<= 1000) fibs)
largeFib :: Int
-- head toma el primer elemento de la lista y dropWhile elimina los elementos de la lista que seab menores o iguales a 1000
largeFib head (dropwhile (<= 1000) fibs)


{-
¿Cuál de las siguientes genera una lista finita?
-}

-- Respuesta: a) take 10 [1..]
-- take toma los primeros 10 elementos de la lista infinita [1..]
take 10 [1..]


{-
Elija la implementación correcta para la función

takewhile :: (a -> Bool) -> [a] -> [a]

considerando que sólo se aplica a listas finitas y que la función p siempre regresa True o False
-}
-- Respuesta: c)
takewhile :: (a -> Bool) -> [a] -> [a]
takewhile _ [] = []
takewhile p (x:xs)
  | p x = x : takewhile p xs
  | otherwise = []


{-
Cuál es el tipo de: (True, (False))
a. undefined

b. (Bool, (Bool))

c. ((Bool), a)

d. (Bool, (Bool))
-}

-- Respuesta: d) (Bool, (Bool))

{-
Elija la definición correcta de la función que nos dice si todos los elementos de una lista lógica son True and :: [Bool] -> Bool
-}
-- Respuesta: C. and [] = True and (b: bs) = b && and bs


{-
La siguiente lista por comprensión

[(x, y) | x <- [1, 2, 3], y < [4, 5, 6]]

se puede re-escribir usando dos o más listas por comprensión con generadores. Elija las implementaciones equivalentes a la mostrada anteriormente

Respuesta:
b. concat [[(x, y) | y < [4, 5, 6]] | x < [1, 2, 3]]
-}


{-
¿Cuál de los siguientes generadores calcula la suma de una lista de los primeros 10

a. sum100 = sum [const 2 x x <- [1.. 100]]

b. sum100 = sum [x 2x< [1..100]] A

C. sum100 = foldl (+) (1) (x^2 x <- [1.. 100]]

d. sum100 = sum [[x * x) | x <- [1.. 100]]
-}

-- respuesta: b) 















