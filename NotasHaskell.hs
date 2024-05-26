-- Para usar el shell poner dhci

-- succ te devuelve el siguiente elemento de un tipo que tenga un orden
succ 8
-- 9
succ 'a'
-- 'b'
succ 'z'
-- '{'

-- min te devuelve el menor de dos elementos
min 3 4
-- 3

-- max te devuelve el mayor de dos elementos
max 3 4
-- 4

-- min te devuelve el menor de dos elementos
min 3 4
-- 3

max 4 (succ 8)
-- 9

succ (max 4 8)
-- 9

succ (max 8 (min 4 9))
-- 9

-- Funciones
-- Estrucutra de una función
-- nombreFuncion :: tipoEntrada -> tipoEntrada -> ... -> tipoSalida
-- nombreFuncion :: valopresEntrada -> valorSalida

-- Función que suma dos números
sumarNumeros :: Int -> Int -> Int
sumarNumeros x y = x + y

-- Funcion para incrementar 10 a un número
incrementar10 :: Int -> Int 
incrementar10 x = x + 10


-- Estructura IF THEN ELSE
-- if condicion then valorSiTrue else valorSiFalse
-- de ahuevo tener un else

-- Funcion que regresa si un numero es par o impar
esPar :: Int -> Bool
esPar x = if (mod x 2) == 0 
    then True 
    else False

-- Las salidas tienen que ser del mismo tipo

-- Funcion para ver si dos numeros son divisibles
sonDivisibles :: Int -> Int -> Bool
sonDivisibles x y = if (mod x y) == 0
    then True
    else False


-- Listas
-- Las listas son una estructura de datos que puede contener cualquier tipo de dato
-- Las listas se definen con corchetes []
-- Las listas pueden ser de un solo tipo de dato o de varios
-- Los string son listas de caracteres

-- Lista de números
numeros = [1,2,3,4,5,6,7,8,9,10]

-- Lista de caracteres
letras = ['a','b','c','d','e','f','g','h','i','j']
-- = "abcdefghij"


-- Concatenar listas
-- Se usa el operador ++
lista1 = [1,2,3,4,5]
lista2 = [6,7,8,9,10]
lista3 = lista1 ++ lista2
-- = [1,2,3,4,5,6,7,8,9,10]

-- Agregar un elemento a una lista
-- Se usa el operador :
lista4 = 0 : lista1
-- = [0,1,2,3,4,5]

-- Acceder a un elemento de una lista
-- Se usa el operador !!
elemento = lista1 !! 2
-- = 3

-- Longitud de una lista}
longitud = length lista1
-- = 5

-- Reversa de una lista
reversa = reverse lista1
-- = [5,4,3,2,1]

-- Tomar los primeros n elementos de una lista
tomar = take 3 lista1
-- = [1,2,3]

-- Eliminar los primeros n elementos de una lista
eliminar = drop 3 lista1
-- = [4,5]

-- Máximo de una lista
maximo = maximum lista1
-- = 5

-- Mínimo de una lista
minimo = minimum lista1
-- = 1

-- Suma de los elementos de una lista
suma = sum lista1
-- = 15

-- Producto de los elementos de una lista
producto = product lista1
-- = 120

-- Crear una lista con un rango de números
rango = [1..10]
-- = [1,2,3,4,5,6,7,8,9,10]
rango2 = ["a".."z"]
-- = "abcdefghijklmnopqrstuvwxyz"

-- Crear una lista con un rango de números con un paso
rangoPaso = [1,3..10]
-- = [1,3,5,7,9]

-- Crear una lista con un rango de números en reversa
rangoReversa = [10,9..1]
-- = [10,9,8,7,6,5,4,3,2,1]

-- Devolver cabeza y cola de una lista
cabeza = head lista1
-- = 1
cola = tail lista1
-- = [2,3,4,5]

-- Devolver el último elemento de una lista
ultimo = last lista1
-- = 5

-- Devolver todo menos el último elemento de una lista
init = init lista1
-- = [1,2,3,4]

-- tomar los primeros n elementos de una lista
tomar = take 3 lista1
-- = [1,2,3]

-- Eliminar los primeros n elementos de una lista
eliminar = drop 3 lista1
-- = [4,5]

-- comprobar si un elemento está en una lista
pertenece = elem 3 lista1
-- = True

-- Repetir un elemento n veces
repetir = replicate 3 5
-- = [5,5,5]

-- Crear una lista con un patrón
patron = [0,2..10]
-- = [0,2,4,6,8,10]

-- Crear una lista con un patrón infinito
infinito = [1..]

-- Crear una lista con un patrón infinito y tomar los primeros n elementos
infinitoTomar = take 10 [1..]
-- = [1,2,3,4,5,6,7,8,9,10]

-- repetir un elemento n veces	
repetir = replicate 3 5
-- = [5,5,5]
-- repetir un elemento n veces
take 3 (repeat 5)
-- = [5,5,5]

-- crear un ciclo infinito
ciclo = cycle [1,2,3]



-- Listas intencionales 
-- Son listas que se crean con una condición
-- [expresion | variable <- lista, condicion]

-- mostrar una lista con los numero impares del 1 al 10
impares = [x | x <- [1..10], x `mod` 2 /= 0]
-- = [1,3,5,7,9]

-- mostrar los numeros impares multiplicados por 10
impares10 = [x * 10 | x <- [1..10], x `mod` 2 /= 0]
-- = [10,30,50,70,90]

-- contar las cifras de un numero
cifras lista = [ if(x < 10) then 1 else 1 + cifras (div x 10) 
| x <- lista, odd x]

cifras [1,2,3,4,5,6,7,8,9,10]
-- = [1,1,1,1,1]


-- listas intencionales 

-- contar cuantos elementos hay en una lista
contar lista = [1 | x <- lista]

-- mostrar las vocales de una lista
vocales lista = [x | x <- lista, elem x "a","e","i","o","u"]



-- Tuplas
-- Las tuplas son una estructura de datos que puede contener cualquier tipo de dato
-- Las tuplas se definen con paréntesis ()
-- Las tuplas pueden ser de un solo tipo de dato o de varios

-- Tupla de dos elementos
tupla2 = (1, "hola")
-- = (1,"hola")

-- si las tuplas estan en una lista
-- deben tener el mismo tamaño y patron
tuplas = [(1, "hola"), (2, "adios")]
-- = [(1,"hola"),(2,"adios")]

-- acceder a un elemento de una tupla
elemento1 = fst tupla2
-- = 1
elemento2 = snd tupla2
-- = "hola"

-- lista de tuplas zip
-- zip toma dos listas y las combina en una lista de tuplas
lista1 = [1,2,3,4,5]
lista2 = ["a","b","c","d","e"]
tuplas = zip lista1 lista2
-- = [(1,"a"),(2,"b"),(3,"c"),(4,"d"),(5,"e")]

-- si una lista es mas grande que la otra se toma el tamaño de la lista mas pequeña
lista1 = [1,2,3,4,5]
lista2 = ["a","b","c"]
tuplas = zip lista1 lista2
-- = [(1,"a"),(2,"b"),(3,"c")]



-- tipos de datos
-- Haskell tiene tipos de datos predefinidos
-- Int: Números enteros
-- Integer: Números enteros de precisión infinita
-- Float: Números de punto flotante
-- Double: Números de punto flotante de doble precisión
-- Bool: Booleanos
-- Char: Caracteres
-- String: Cadenas de caracteres
-- [a]: Listas de elementos de tipo a
-- (a,b): Tuplas de elementos de tipo a y b

-- Definir un tipo de dato
-- Se usa la palabra clave data
-- data NombreTipo = Valor1 | Valor2 | ... | ValorN
data Color = Rojo | Verde | Azul
-- = Rojo | Verde | Azul

-- saber el tipo de dato
:t 5
-- = 5 :: Num a => a


-- show convierte un tipo de dato a string
show 5
-- = "5"

-- read convierte un string a un tipo de dato
read "5" + 3
-- = 8





