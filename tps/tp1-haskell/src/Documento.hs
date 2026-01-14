module Documento
  ( Doc,
    vacio,
    linea,
    texto,
    foldDoc,
    (<+>),
    indentar,
    mostrar,
    imprimir,
  )
where

data Doc
  = Vacio
  | Texto String Doc
  | Linea Int Doc
  deriving (Eq, Show)

vacio :: Doc
vacio = Vacio

linea :: Doc
linea = Linea 0 Vacio

texto :: String -> Doc
texto t | '\n' `elem` t = error "El texto no debe contener saltos de línea"
texto [] = Vacio
texto t = Texto t Vacio

foldDoc :: b -> (String -> b -> b) -> (Int -> b -> b) -> Doc -> b
foldDoc fVacio fTexto fLinea t = case t of
    Vacio -> fVacio
    Texto s d -> fTexto s (rec d)
    Linea n d -> fLinea n (rec d)
  where rec = foldDoc fVacio fTexto fLinea

-- NOTA: Se declara `infixr 6 <+>` para que `d1 <+> d2 <+> d3` sea equivalente a `d1 <+> (d2 <+> d3)`
-- También permite que expresiones como `texto "a" <+> linea <+> texto "c"` sean válidas sin la necesidad de usar paréntesis.
infixr 6 <+>

{-  
  Se satisface el invariante del Doc ya que para el caso de un Texto s d:
    -s no es el string vacio ni contiene saltos de linea ya que por precondicion recibimos 
  dos documentos validos.
    -Sea d1, d2. Sea d1 de la forma d1 = ... Vacio, 
  como <+> se encarga de remplazar ese vacio por d2. 
  El único caso borde que podría atentar contra el invariante 
  viene a ser d1 = ... Texto s1 Vacio, d2 = Texto s2 ... Vacio, 
  que se reemplazaría como Texto s1 (Texto s2 doc), que nuestra función se encarga
  que transforme en Texto (s1 ++ s2) doc. Ese doc pertenece a un "subdocumento" de d2 
  y por lo tanto cumple el invariante.
    -Las Lineas no se modifican por lo que siguen siendo validas luego de la concatenación

-}
(<+>) :: Doc -> Doc -> Doc
d1 <+> d2 = foldDoc d2
    (\s rec -> case rec of
        Texto s2 d -> Texto (s ++ s2) d
        Vacio      -> Texto s rec
        Linea n d     -> Texto s rec)
    Linea
    d1

{- Esto satisface el invariante ya que:
Como recibe un Doc valido y los constructores Texto no son modificados,
los mismos siguen cumpliendo el invariante.
Debido a que por la precondicion de que recibimos un numero positivo al 
sumarle a este a los valores en el constructor Linea, ya que estos eran validos (>=0) 
cuando le sumamos un numero positivo este sigue siendo un numero positivo que cumple el invariante.
-}
indentar :: Int -> Doc -> Doc
indentar i = foldDoc Vacio Texto (\n rec -> Linea (n + i) rec)


--Se nos ocurrio para poner los espacios utilizar una lista infinita de espacios 
--al que le extraemos los n que necesitamos.
mostrar :: Doc -> String
mostrar = foldDoc "" (++) (\n rec->  "\n" ++ take n [' ',' '..] ++ rec)

-- | Función dada que imprime un documento en pantalla
-- 
-- ghci> imprimir (Texto "abc" (Linea 2 (Texto "def" Vacio)))
-- abc
--   def

imprimir :: Doc -> IO ()
imprimir d = putStrLn (mostrar d)
