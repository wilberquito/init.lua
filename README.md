# init.lua

Mi configuración de Neovim. Esto **no** es la lista completa de atajos
(`<leader>fk` la busca, y which-key la enseña al pulsar `<leader>`): es la
chuleta de lo esencial para **moverse por el contenido** sin pensar.

`<leader>` = `Espacio`.

## 1. Dentro del fichero

| Quiero…                              | Tecla                      |
| ------------------------------------ | -------------------------- |
| Bajar / subir media página           | `Ctrl+d` / `Ctrl+u` (arriba) |
| Saltar al párrafo anterior / siguiente | `{` / `}` (arriba)       |
| Ir al principio / final              | `gg` / `G`                 |
| Saltar a la pareja `( ) [ ] { }`     | `%`                        |
| Ir al carácter `x` de la línea       | `fx` / `Fx` (o `tx`/`Tx`), repetir con `;` `,` |
| Buscar la palabra bajo el cursor     | `*` / `#` (arriba)         |
| Siguiente / anterior resultado       | `n` / `N` (arriba)         |
| Buscar texto en el buffer (fuzzy)    | `<leader>/`                |
| Recolocar la vista                   | `zt` arriba · `zz` centro · `zb` abajo |

## 2. Entre ficheros y buffers

| Quiero…                              | Tecla                      |
| ------------------------------------ | -------------------------- |
| Volver al fichero de antes (ida/vuelta) | `<leader><leader>`      |
| Buffer siguiente / anterior          | `Shift+l` / `Shift+h`      |
| Elegir entre los buffers abiertos    | `<leader>fb`               |
| Buscar fichero por nombre            | `<leader>ff`               |
| Buscar texto en el proyecto          | `<leader>fg` (palabra bajo cursor: `<leader>fs`) |
| Ficheros recientes                   | `<leader>fo`               |
| Reabrir el último buscador           | `<leader>fr`               |
| Cerrar buffer                        | `<leader>x`                |

## 3. Harpoon: los ficheros de la tarea

Bufferline recorre **todos** los buffers abiertos. Harpoon es la lista corta
que eliges tú, con un orden fijo.

| Quiero…                              | Tecla                      |
| ------------------------------------ | -------------------------- |
| Fijar el fichero actual              | `<leader>a`                |
| Ver / reordenar / borrar la lista    | `Ctrl+e` (es un buffer: `dd`, mover líneas, `:w` o `q`) |
| Ir al fichero 1, 2, 3, 4             | `<leader>1` … `<leader>4`  |

## 4. Volver a donde estaba

| Quiero…                              | Tecla                      |
| ------------------------------------ | -------------------------- |
| Salto anterior / siguiente (cruza ficheros) | `Ctrl+o` / `Ctrl+i` (arriba) |
| Ver la lista de saltos               | `<leader>fj`               |
| Ir al último sitio donde **edité**   | `g,` (ver nota)            |

La *jumplist* guarda dónde estabas antes de cada salto "grande": `gg`, `G`,
`%`, `/`, `n`, `*`, `gd`, abrir otro fichero… Moverse con `j`/`k` no cuenta.

> Nota: `g;` (ir al cambio anterior) está remapeado a "repetir último `f`/`t`",
> así que de la *changelist* solo queda `g,` (hacia delante) y `:changes`.

## 5. Marks: marcapáginas

| Quiero…                              | Tecla                      |
| ------------------------------------ | -------------------------- |
| Marcar aquí (solo en este fichero)   | `ma` … `mz`                |
| Marcar aquí (global, entre ficheros) | `mA` … `mZ`                |
| Volver a la línea / posición exacta  | `'A` / `` `A ``            |
| Ver todas las marks                  | `<leader>fm`               |

Truco: `mA` en el fichero principal y `mT` en el de tests → `'A` / `'T` desde
cualquier sitio. Marks especiales: `''` (antes del último salto), `` `. ``
(último cambio), `` `" `` (dónde estaba al cerrar el fichero).

## 6. Seguir el código (tags + LSP)

Cuando un servidor LSP se engancha, Neovim pone `tagfunc=vim.lsp.tagfunc`: los
**tags de vim funcionan sin `ctags`**, usando el LSP.

| Quiero…                              | Tecla                      |
| ------------------------------------ | -------------------------- |
| Ir a la definición (pila de tags)    | `Ctrl+]`                   |
| Volver de esa definición             | `Ctrl+t`                   |
| Ver la pila de tags                  | `:tags`                    |
| Definición / referencias / implementaciones (Telescope) | `gd` / `gr` / `gi` → volver con `Ctrl+o` |
| Documentación del símbolo            | `K`                        |
| Diagnóstico siguiente / anterior     | `]d` / `[d`                |
| Ver el diagnóstico de la línea       | `<leader>ld`               |
| Renombrar · code action · formatear  | `<leader>rn` · `<leader>ca` · `<leader>cf` |

`Ctrl+]` + `Ctrl+t` es una **pila**: bajas tres niveles de definiciones y
subes tres veces con `Ctrl+t`, sin perderte en la jumplist.

## 7. Ventanas y exploradores

| Quiero…                              | Tecla                      |
| ------------------------------------ | -------------------------- |
| Moverme entre splits                 | `Ctrl+h/j/k/l`             |
| Maximizar / restaurar el split       | `<leader>z`                |
| Árbol de ficheros                    | `<leader>t`                |
| Yazi en el proyecto / en el fichero  | `<leader>n` / `<leader>N`  |

## Flujo recomendado

1. Empiezas una tarea: abre los 2-4 ficheros clave con `<leader>ff` y fíjalos
   con `<leader>a`. A partir de ahí, `<leader>1..4`.
2. Para ir y volver entre dos ficheros: `<leader><leader>`.
3. Para entender código: `Ctrl+]` para bajar a la definición, `Ctrl+t` para
   subir. Para ver usos: `gr`.
4. ¿Te has perdido? `Ctrl+o` hasta volver, o `<leader>fj` para elegir.
5. Un sitio al que vuelves todo el rato pero no es un fichero entero (una
   función concreta): mark global `mA`.
