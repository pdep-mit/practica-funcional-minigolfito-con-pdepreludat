module Lib where
import PdePreludat

-- Modelo inicial

data Jugador = UnJugador {
  nombre :: String,
  padre :: String,
  habilidad :: Habilidad
} deriving (Eq, Show)

data Habilidad = Habilidad {
  fuerzaJugador :: Number,
  precisionJugador :: Number
} deriving (Eq, Show)

-- Jugadores de ejemplo

bart = UnJugador "Bart" "Homero" (Habilidad 25 60)
todd = UnJugador "Todd" "Ned" (Habilidad 15 80)
rafa = UnJugador "Rafa" "Gorgory" (Habilidad 10 1)

data Tiro = UnTiro {
  velocidad :: Number,
  precision :: Number,
  altura :: Number
} deriving (Eq, Show)

type Puntos = Number

-- Funciones útiles

between n m x = elem x [n .. m]

maximoSegun f = foldl1 (mayorSegun f)

mayorSegun f a b
  | f a > f b = a
  | otherwise = b

----------------------------------------------
---- Resolución del ejercicio
----------------------------------------------

{-
    a. Modelar los palos usados en el juego que a partir de una determinada habilidad generan un tiro que se compone por velocidad, precisión y altura.
    - El putter genera un tiro con velocidad igual a 10, el doble de la precisión recibida y altura 0.
    - La madera genera uno de velocidad igual a 100, altura igual a 5 y la mitad de la precisión.
    - Los hierros, que varían del 1 al 10 (número al que denominaremos n), generan un tiro de velocidad igual a la fuerza multiplicada por n, la precisión dividida por n y una altura de n-3 (con mínimo 0). Modelarlos de la forma más genérica posible.
-}

palo :: String -> Number -> Habilidad -> Tiro
palo "putter" _ habilidad = UnTiro {
  velocidad = 10,
  precision = precisionJugador habilidad * 2,
  altura = 0
  }
palo "madera" _ habilidad = UnTiro {
  velocidad = 100,
  altura = 5,
  precision = precisionJugador habilidad `div` 2
  }
palo "hierro" n habilidad = UnTiro {
  velocidad = fuerzaJugador habilidad * n,
  altura = (n-3) `max` 0,
  precision = precisionJugador habilidad `div` n
  }

{-
    b. Definir una constante palos que sea una lista con todos los palos que se pueden usar en el juego.
-}

-- Estamos forzados a poner basura en el putter y la madera, no nos gusta y abandonamos esta solución definitivamente
palos = [palo "putter" 0, palo "madera" 0, palo "hierro" 1]