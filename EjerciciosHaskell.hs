-- Ejercicios

-- Calcular todos los triangulos pitagoricos con lados menores a 10
-- a^2 + b^2 = c^2
-- a < b < c
pitagoras :: [(Int, Int, Int)]
pitagoras = [(a, b, c) | c <- [1 .. 10], b <- [1 .. c], a <- [1 .. b], a * a + b * b == c * c]


-- Calcular el factorial de un número
-- factorial 5 = 5 * 4 * 3 * 2 * 1 = 120

factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial (n - 1)


-- Calcular la suma de los primeros 100 números naturales
-- 1 + 2 + 3 + ... + 100 = 5050

sum [1..100]

-- Realizar una función que reciba una lista de números y devuelva la suma de los elementos pares de la lista
-- sumarPares [1,2,3,4,5,6,7,8,9,10] = 2 + 4 + 6 + 8 + 10 = 30

sumarPares :: Int
sumarPares = sum[x | x <- [1..10], mod x 2 == 0]


{-3. (25 pts) con la pandemia la suma y la multiplicación se enfadaron y ahora funcionan diferente. 
Cuando sumas dos números el resultado es el mayor de ellos 
y cuando los multiplicas el resultado es el menor. 
Ejemplo: 2+3=3 y 3*8=3. Elabore en haskell una función que haga el
cálculo de la multiplicación para dos números.-}

sumar :: Int -> Int -> Int
sumar x y = if x > y then x else y

multiplicar :: Int -> Int -> Int
multiplicar x y = if x < y then x else y
