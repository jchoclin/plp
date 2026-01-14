module Main (main) where

import Documento
import PPON
import Test.HUnit

main :: IO ()
main = runTestTTAndExit allTests

allTests :: Test
allTests =
  test
    [ "Ejercicio 2" ~: testsEj2,
      "Ejercicio 3" ~: testsEj3,
      "Ejercicio 4" ~: testsEj4,
      "Ejercicio 6" ~: testsEj6,
      "Ejercicio 7" ~: testsEj7,
      "Ejercicio 8" ~: testsEj8,
      "Ejercicio 9" ~: testsEj9
    ]

testsEj2 :: Test
testsEj2 =
  test
    [ vacio <+> vacio ~?= vacio,
      texto "a" <+> texto "b" ~?= texto "ab",
      (texto "a" <+> linea) <+> texto "b" ~?= texto "a" <+> (linea <+> texto "b"),
      ---
      texto "a" <+> linea <+> texto "b" <+> texto "c" ~?= texto "a" <+> linea <+> texto "bc",
      texto "a" <+> vacio ~?= texto "a"
    ]

testsEj3 :: Test
testsEj3 =
  test
    [ indentar 2 vacio ~?= vacio,
      indentar 2 (texto "a") ~?= texto "a",
      indentar 2 (texto "a" <+> linea <+> texto "b") ~?= texto "a" <+> indentar 2 (linea <+> texto "b"),
      indentar 2 (linea <+> texto "a") ~?= indentar 1 (indentar 1 (linea <+> texto "a")),
      --
      indentar 0 (linea <+> texto "a") ~?= linea <+> texto "a",
      indentar 5 (linea <+> texto "a") ~?= indentar 2 (indentar 3 (linea <+> texto "a")),
      -- indentar 5 (texto "a" <+> texto "b") ~?= texto "a" <+> texto "b"
      indentar 2 (linea <+> indentar 3 (linea <+> texto "a")) ~?= indentar 2 linea <+> indentar 5 linea <+> texto "a"
    ]

testsEj4 :: Test
testsEj4 =
  test
    [ mostrar vacio ~?= "",
      mostrar linea ~?= "\n",
      mostrar (indentar 2 (texto "a" <+> linea <+> texto "b")) ~?= "a\n  b",
      --
      mostrar (texto "hola Mundo!") ~?= "hola Mundo!",
      mostrar (linea <+> texto "a") ~?= "\na",
      mostrar (indentar 5 linea) ~?= "\n     "
    ]

pericles, merlina, addams, familias :: PPON
pericles = ObjetoPP [("nombre", TextoPP "Pericles"), ("edad", IntPP 30)]
merlina = ObjetoPP [("nombre", TextoPP "Merlina"), ("edad", IntPP 24)]
addams = ObjetoPP [("0", pericles), ("1", merlina)]
familias = ObjetoPP [("Addams", addams)]

pponTriste = ObjetoPP [("sad", pponDepre)]

pponDepre = ObjetoPP []
racing = ObjetoPP [("dt", TextoPP "Gustavo Costas"), ("arquero", arquero), ("defensores", defensores), ("mediocampistas", mediocampistas), ("delanteros", delanteros)]

arquero = TextoPP "Arias"

defensores = ObjetoPP [("nombre", TextoPP "martirena"), ("nombre", TextoPP "di cesare"), ("nombre", TextoPP "sosa"), ("nombre", TextoPP "garcia basso"), ("nombre", TextoPP "rojas")]

mediocampistas = ObjetoPP [("nombre", TextoPP "nardoni"), ("nombre", TextoPP "zuculini"), ("nombre", TextoPP "vietto")]

delanteros = ObjetoPP [("Martinez", ObjetoPP [("numero", TextoPP "9"), ("apodo", TextoPP "Maravilla")]), ("Salas", ObjetoPP [("numero", TextoPP "7"), ("apodo", TextoPP "Pizzero")])]

testsEj6 :: Test
testsEj6 =
  test
    [ pponObjetoSimple pericles ~?= True,
      pponObjetoSimple addams ~?= False,
      ---
      pponObjetoSimple arquero ~?= False,
      pponObjetoSimple defensores ~?= True,
      pponObjetoSimple mediocampistas ~?= True,
      pponObjetoSimple delanteros ~?= False,
      pponObjetoSimple racing ~?= False
    ]

a, b, c :: Doc
a = texto "a"
b = texto "b"
c = texto "c"

lisDocVacio :: [Doc]
lisDocVacio = [vacio]

vac = vacio

listaVacios = [vac, vac, vac, vac]

algo = texto "insertar" <+> linea <+> texto "saltos de" <+> linea <+> texto "linea"

testsEj7 :: Test
testsEj7 =
  test
    [ mostrar (intercalar (texto ", ") []) ~?= "",
      mostrar (intercalar (texto ", ") [a, b, c]) ~?= "a, b, c",
      mostrar (entreLlaves []) ~?= "{ }",
      mostrar (entreLlaves [a, b, c]) ~?= "{\n  a,\n  b,\n  c\n}",
      --
      mostrar (intercalar a lisDocVacio) ~?= mostrar vacio,
      mostrar (intercalar a listaVacios) ~?= "aaa",
      intercalar algo [a, b, c] ~?= a <+> algo <+> b <+> algo <+> c,
      intercalar (texto " ") [vacio, vacio] ~?= texto " ",
      intercalar (texto " ") [texto "a", vacio] ~?= texto "a ",
      intercalar vacio [texto "a", texto "b",texto "c"] ~?= texto "abc"
    ]

testsEj8 :: Test
testsEj8 =
  test
    [ mostrar (aplanar (a <+> linea <+> b <+> linea <+> c)) ~?= "a b c",
      ---
      aplanar vacio ~?= vacio,
      aplanar linea ~?= texto " ",
      mostrar (aplanar (indentar 2 (a <+> linea <+> b <+> linea <+> c))) ~?= "a b c"
    ]

testsEj9 :: Test
testsEj9 =
  test
    [ mostrar (pponADoc pericles) ~?= "{ \"nombre\": \"Pericles\", \"edad\": 30 }",
      mostrar (pponADoc addams) ~?= "{\n  \"0\": { \"nombre\": \"Pericles\", \"edad\": 30 },\n  \"1\": { \"nombre\": \"Merlina\", \"edad\": 24 }\n}",
      mostrar (pponADoc familias) ~?= "{\n  \"Addams\": {\n    \"0\": { \"nombre\": \"Pericles\", \"edad\": 30 },\n    \"1\": { \"nombre\": \"Merlina\", \"edad\": 24 }\n  }\n}",
      --
      mostrar (pponADoc arquero) ~?= "\"Arias\"",
      mostrar (pponADoc defensores) ~?= "{ \"nombre\": \"martirena\", \"nombre\": \"di cesare\", \"nombre\": \"sosa\", \"nombre\": \"garcia basso\", \"nombre\": \"rojas\" }",
      mostrar (pponADoc mediocampistas) ~?= "{ \"nombre\": \"nardoni\", \"nombre\": \"zuculini\", \"nombre\": \"vietto\" }",
      mostrar (pponADoc delanteros) ~?= "{\n  \"Martinez\": { \"numero\": \"9\", \"apodo\": \"Maravilla\" },\n  \"Salas\": { \"numero\": \"7\", \"apodo\": \"Pizzero\" }\n}",
      mostrar (pponADoc racing) ~?= "{\n  \"dt\": \"Gustavo Costas\",\n  \"arquero\": \"Arias\",\n  \"defensores\": { \"nombre\": \"martirena\", \"nombre\": \"di cesare\", \"nombre\": \"sosa\", \"nombre\": \"garcia basso\", \"nombre\": \"rojas\" },\n  \"mediocampistas\": { \"nombre\": \"nardoni\", \"nombre\": \"zuculini\", \"nombre\": \"vietto\" },\n  \"delanteros\": {\n    \"Martinez\": { \"numero\": \"9\", \"apodo\": \"Maravilla\" },\n    \"Salas\": { \"numero\": \"7\", \"apodo\": \"Pizzero\" }\n  }\n}",
      mostrar (pponADoc pponDepre) ~?= "{ }",
      mostrar (pponADoc pponTriste) ~?= "{\n  \"sad\": { }\n}"
    ]
