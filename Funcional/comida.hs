

pesoPar :: Persona -> Bool
pesoPar = even . peso

-- 1) Queremos que la persona pueda comer distintas comidas. 
-- Existen las ensaladas, las hamburguesas y las paltas, 
-- quiero comer las distintas cosas y cada cosa aporta distinto 
-- al comerla

-- una ensalada de x kilos aporta la mitad de peso para la persona
-- y no agrega colesterol
type Comida = Persona -> Persona

ensalada :: Kilos -> Comida
ensalada kilos persona = persona {
  peso = peso persona + div kilos 2
}

-- cada hamburguesa tiene una cantidad de ingredientes
-- el colesterol aumenta un 50%
-- el peso aumenta en 3 kilos * la cantidad de ingredientes
hamburguesa :: [Ingrediente] -> Comida
hamburguesa ingredientes persona = persona {
  peso = peso persona + (3 * fromIntegral (length ingredientes)),
  colesterol = colesterol persona * 1.5
}

-- la palta aumenta 2 kilos a quien la consume
palta :: Comida
palta persona = persona {
  peso = peso persona + 2
}

almuerzo :: [Comida]
almuerzo = [ensalada 1, hamburguesa ["cheddar", "bacon"], palta, ensalada 3]

almorzar :: Persona -> Persona
almorzar persona = foldr ($) persona almuerzo

almorzarRec :: Persona -> Persona
almorzarRec persona = comerAlmuerzo almuerzo persona
  where
    comerAlmuerzo :: [Comida] -> Persona -> Persona
    comerAlmuerzo [] persona = persona
    comerAlmuerzo (comida:comidas) persona = comerAlmuerzo comidas (comida persona)
-- para mayor expresividad
-- almorzar persona = foldr comer persona almuerzo
-- comer persona comida = comida persona

--2) Queremos que todas las comidas se puedan comer dos veces seguidas
repetir:: Comida -> Persona -> Persona
repetir comida = comida.comida

--3) Queremos ver si un almuerzo contiene una comida dada
--contieneComida::Comida -> [Comida]->Bool
-- No podemos hacerlo porque las comidas no son Eq

--4) Queremos averiguar si una comida es sabrosa.
-- las ensaladas son sabrosas cuando tienen más de un kilo
-- las hamburguesas son sabrosas cuando tienen cheddar
-- las paltas son sabrosas
-- No podemos hacerlo

--5) Queremos averiguar si una comida va a ser disfrutada por alguien.
-- Para quienes pesan una cantidad par, todas las comidas son disfrutadas, 
-- para los demás, solo son disfrutadas las comidas sabrosas
-- Necesitamos nuevas funciones para disfrutar cada comida 
-- (tal vez convenga renombrar las anteriores, x ej comerEnsalada en vez de ensalada)
disfrutarEnsalada :: Kilos -> Persona -> Bool
disfrutarEnsalada kilos alguien = pesoPar alguien || kilos > 1

disfrutarHamburguesa :: [Ingrediente] -> Persona -> Bool
disfrutarHamburguesa ingredientes alguien = pesoPar alguien || elem "cheddar" ingredientes

disfrutarPalta:: Persona -> Bool
disfrutarPalta _ = True

-- ************************************************************
-- CON DATA
-- ************************************************************

-- Queremos que la persona pueda comer distintas comidas. 
-- Existen las ensaladas, las hamburguesas y las paltas, 
-- quiero comer las distintas cosas y cada cosa aporta distinto 
-- al comerla

type Kilos = Int
type Ingrediente = String

data Persona = Persona {
  colesterol :: Float,
  peso :: Kilos
} deriving (Show, Eq)

data Comida' = Ensalada Kilos | Hamburguesa [Ingrediente] | Palta
  deriving (Eq, Ord, Show)

-- una ensalada de x kilos aporta la mitad de peso para la persona
-- y no agrega colesterol
comer' :: Comida' -> Persona -> Persona
comer' (Ensalada kilos) persona = persona {
  peso = peso persona + div kilos 2
}

-- cada hamburguesa tiene una cantidad de ingredientes
-- el colesterol aumenta un 50%
-- el peso aumenta en 3 kilos * la cantidad de ingredientes
comer' (Hamburguesa ingredientes) persona = persona {
  peso = peso persona + (3 * fromIntegral (length ingredientes)),
  colesterol = colesterol persona * 1.5
}

-- la palta aumenta 2 kilos a quien la consume
comer' Palta persona = persona {
  peso = peso persona + 2
}

almuerzo' :: [Comida']
almuerzo' = [Ensalada 1, Hamburguesa ["cheddar", "bacon"], Palta, Ensalada 3]

--Version normal
almorzar' :: Persona -> Persona
almorzar' persona = foldr comer' persona almuerzo'

--vesion recursiva
almorzarRecur' :: Persona -> Persona
almorzarRecur' persona = comerAlmuerzo persona almuerzo'
  where
    comerAlmuerzo :: Persona -> [Comida'] -> Persona
    comerAlmuerzo persona [] = persona
    comerAlmuerzo persona (x:xs) = comerAlmuerzo (comer' x persona) xs


-- 3) Queremos ver si un almuerzo contiene una comida dada
--version recursiva
contieneComidaRec :: Comida' -> [Comida'] -> Bool
contieneComidaRec _ [] = False
contieneComidaRec comida (x:xs) = comida == x || contieneComidaRec comida xs

--version no recursiva
contieneComida' :: Comida' -> [Comida'] -> Bool
contieneComida' comida comidas = elem comida comidas

-- 4) Queremos averiguar si una comida es sabrosa.
sabrosa' :: Comida' -> Bool

-- las ensaladas son sabrosas cuando tienen más de un kilo
sabrosa' (Ensalada kilos) = kilos > 1

-- las hamburguesas son sabrosas cuando tienen cheddar
--sabrosa' (Hamburguesa ingredientes) = "cheddar" `elem` ingredientes

--version recursiva
sabrosa' (Hamburguesa []) = False
sabrosa' (Hamburguesa (ingrediente:ingredientes)) = ingrediente == "cheddar" || sabrosa' (Hamburguesa ingredientes)

-- las paltas son sabrosas
sabrosa' Palta = True

-- 5) Queremos averiguar si una comida va a ser disfrutada por alguien.
-- Una comida es disfrutada si su peso es par y es sabrosa
disfrutar' :: Comida' -> Persona -> Bool
disfrutar' comida alguien = pesoPar alguien && sabrosa' comida


enForma :: Persona -> Bool
enForma persona = colesterol persona < 100

-- 6) Queremos saber entre una lista de personas, cuales estan en forma y disfrutan la comida
filtroPersonas :: [Persona] -> Comida' -> [Persona]
filtroPersonas personas comida = filter (disfrutar' comida) (filter enForma personas)