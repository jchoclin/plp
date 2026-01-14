module PPON where

import Documento

data PPON
  = TextoPP String
  | IntPP Int
  | ObjetoPP [(String, PPON)]
  deriving (Eq, Show)

pponAtomico :: PPON -> Bool
pponAtomico (IntPP n) = True
pponAtomico (TextoPP n) = True
pponAtomico _ = False

pponObjetoSimple :: PPON -> Bool
pponObjetoSimple p = case p of
  IntPP n -> False
  TextoPP n -> False
  ObjetoPP xs -> foldr (\x rec -> pponAtomico (snd x) && rec) True xs

-- podemos hacer rec == vacio porque rec :: Doc y Doc es un tipo comparable.
intercalar :: Doc -> [Doc] -> Doc
intercalar s xs = if null xs then vacio else foldr1 (\x rec -> x <+> s <+> rec) xs

entreLlaves :: [Doc] -> Doc
entreLlaves [] = texto "{ }"
entreLlaves ds =
  texto "{"
    <+> indentar
      2
      ( linea
          <+> intercalar (texto "," <+> linea) ds
      )
    <+> linea
    <+> texto "}"

aplanar :: Doc -> Doc
aplanar = foldDoc vacio (\s rec -> texto s <+> rec) (\n rec -> texto " " <+> rec)

-- pponADoc utiliza recursión primitiva ya que nos referimos a la subestructura (de hecho utilizamos toda la estructura en pponObjetoSimple (ObjetoPP o))
-- en lugar de utilizar unicamente el resultado de la recursion sobre la subestructura.

pponADoc :: PPON -> Doc
pponADoc (IntPP n) = texto (show n)
pponADoc (TextoPP n) = texto (show n)
pponADoc (ObjetoPP o) =
  if pponObjetoSimple (ObjetoPP o)
    then aplanar (entreLlaves (parsearPPON (ObjetoPP o)))
    else entreLlaves (parsearPPON (ObjetoPP o))
  where
    parsearPPON :: PPON -> [Doc]
    parsearPPON (ObjetoPP xs) = map claveValor xs
      where
        claveValor (s, r) = texto (show s) <+> texto ": " <+> pponADoc r
