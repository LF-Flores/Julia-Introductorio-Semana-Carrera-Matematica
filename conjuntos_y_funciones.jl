### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 84e1cf74-d1ec-4a62-b6eb-8724a7845c2e
using LinearAlgebra

# ╔═╡ e5bd718d-1c46-4341-adee-17efddb0d199
begin
	using PlutoUI
end

# ╔═╡ 8e7c9226-ddee-11eb-3e73-3112eb059eb7
md"# Pensamiento matemático para la programación en Julia

¡Bienvenidos al **curso introductorio a Julia para matemáticos**!. Como dice el título, este curso estará de principio a fin orientado para matemáticos, dentro de lo que es capaz de contenerse dicho concepto en el manifiesto sencillo de un estilo inusual de programación. 

## Enteros en Julia

Para comenzar a ilustrar el punto de ello, consideremos lo que en Julia (y mucho otros lenguajes de programación) llaman **tipos**, desde otra perspectiva más adecuada:"

# ╔═╡ 49d3d127-c964-4494-94c2-c7f0123ba0d9
Integer <: Real

# ╔═╡ debb0d4f-f029-4067-920c-cc049cd83adc
Real <: Integer

# ╔═╡ 8db92bb9-1a1d-4398-9fc6-72734976c816
md"Lo anterior se entiende como la declaración común en matemáticas de que los números enteros son un **subconjunto** de los números reales, pero es código de Julia... y esos de arriba son 'tipos'."

# ╔═╡ 205e451b-cabb-4d52-b041-eeb5ce0bacbc
typeof(Integer), typeof(Real)

# ╔═╡ 4b567441-f60e-4a6f-a4ea-ef961762e7f0
md"Todos los objetos en julia tienen un tipo, el cual puede ser encontrado con la función `typeof`. No obstante, Julia tiene la peculiaridad de que sus tipos son realmente **conjuntos** en el sentido tradicional matemático. 

Por ejemplo, si bien `Integer` representa $1$-a-$1$ el concepto tradicional de número entero, éste es un **concepto abstracto** que es mejor entendido por humanos que por máquinas (por ahora...) y *no tiene una representación **concreta** en la computadora*.

Las computadoras actuales entienden la información en términos de representaciones de **bits** (cualquier cosa que pueda representar un estado de encendido, 1, y de apagado, 0. Comúnmente transistores). Por ello, tenemos distintos tipos de números enteros representables en la computadora"

# ╔═╡ beda1f98-d17f-4915-819d-24a1dbe3b837
Int64.isbitstype, Int32.isbitstype,  Int16.isbitstype


# ╔═╡ cae300fc-5dbc-447f-8f16-5e4d2ec98633
Integer.isbitstype

# ╔═╡ 5e771978-db46-409f-a91e-d66d6182340c
bitstring(Int16(5))

# ╔═╡ 4b60ab09-19ce-4501-b8da-20a667fdce52
Int64.isconcretetype, Int32.isconcretetype, Int16.isconcretetype

# ╔═╡ 627c5ca8-eed8-4dae-bf28-1c41996e70f6
md"Y todos estos 'enteros restringidos a ser representados de cierta manera' se puedne entender como subconjunto de `Integer`:"

# ╔═╡ b145a130-cc8e-4431-bfd2-ed85130b95a5
Int64 <: Integer, Int32 <: Integer, Int16 <: Integer

# ╔═╡ 1cb50db6-6207-4a84-a91d-1a41129f707c
md"No obstante, entre ellos no cumplen ninguna relación de contenencia:"

# ╔═╡ bb11b4d8-fef8-4f34-8bf6-e6a6ceb551c5
Int32 <: Int64, Int16 <: Int64

# ╔═╡ 349b1f42-bb9f-4770-a7d5-dd8bc78a318f
md"Para aclararlo, lo anterior debe enterse como:

- `Integer` = $\mathbb{Z}$


- `Int16` = $\{x \in \mathbb{Z}\ |\ x = \sum_{n = 0}^{16} m_k 2^{k} \text{ y } x \text{ se identifica con } (m_1, \ldots, m_{16})\in \{0,1\}^{16}\}$


- `Int32` = $\{x \in \mathbb{Z}\ |\ x = \sum_{n = 0}^{32} m_k 2^{k} \text{ y } x \text{ se identifica con } (m_1, \ldots, m_{32})\in \{0,1\}^{32}\}$


- ... etc."

# ╔═╡ b79180ce-d566-4039-b40f-b52ce1fd91f1
md"Es decir, podemos tener un número entero (pertenece a `Integer`) que puede pertenecer a `Int8` si se determina una cadena de **ocho** $0$s y $1$s (los $m_k$) y se representa como tal, y pertenecer por separado a `int16` si en su lugar se determina una cadena de **dieciseis** $0$s y $1$s y se identifica con dicha tupla en su lugar. 

Como a continuación podemos ver:"

# ╔═╡ 2d2d9b97-5522-446b-8c8b-aff0c20b0d8c
bitstring(Int8(10))

# ╔═╡ 9b502ab8-20ca-46e5-977e-80b0adc19bfd
bitstring(Int16(10))

# ╔═╡ 9e3c684b-4039-4eb2-b633-619f9bd4d851
md"La cadena selecta en ambos casos para representar al número 10 es porsupuesto la expanción binaria del número. Pero noten que son considerados objetos diferentes ya que están sometido a condiciones distintas."

# ╔═╡ d3e10fbc-f1b6-44b2-b40f-77d1d065d680
Int8(10) === Int8(10) # la triple igualdad verifica igualdad de objetos 

# ╔═╡ 82da2de9-d202-43d1-ab7d-c6c7f8e3ee55
Int8(10) === Int16(10)

# ╔═╡ 919fc101-078d-4e00-9fbe-3be7c677572e
md"Aunque aun es posible verificar que son ambos representaciones distintas de un mismo objeto. La doble igualdad verifica igualdad independiente de la representación si es posible. Si no, hace lo mismo que `===`"

# ╔═╡ 4a3e5c65-69da-428d-bce5-7f1348868657
Int8(10) == Int16(10) # La doble igualdad de valores, o una más "abstracta"

# ╔═╡ 28529472-2bda-44f1-9b17-8d9674fdd5f7
# Int8(200) == Int64(200) # Esto da error por que 200 es muy grande para 8 bits

# ╔═╡ 76bee316-0bfd-44f7-ab57-976a4ba56c11
typemax(Int8)

# ╔═╡ 244cfe8d-ad8e-49d2-8a28-9abbfed36d96
md"
En pocas palabras, Ambos `Int16` e `Int8` son subconjuntos de `Integer`, pero entre ellos, formalmente, no podemos hacer una relación a pesar que de forma intuitiva es claro que es el mismo número (como hemos visto que se puede verificar con `==`)

Para esto, Julia utiliza la función `convert`.
"

# ╔═╡ aefc90c8-a2eb-465f-9584-3f2224bfe5b6
typeof(convert(Int16, 10))

# ╔═╡ 350ab8e1-d0c2-4a5f-a8a1-c51f2d4f429a
convert(Int8, 10) |> typeof

# ╔═╡ e5db8570-7dc0-48e3-85bd-34feaacdc4a8
md"la función `convert` covierte su segundo argumento (que puede ser cualquier elemento de `Integer`. En este caso, `10` es un `Int64` por defecto) y lo lleva a su representación dentro del conjunto especificado en el primer argmento, o como diría un programador: Lo convierte al *tipo del primer argumento*

Notemos además el uso del símbolo `|>`, llamado **pipe**, para llevar el resultado de `convert(Int8, 10)` hacia ser evaluado en `typeof`. Es decir, esto fue equivalente a haber hecho:"

# ╔═╡ da194735-2d45-4af7-bd9c-3b24acb73e3a
typeof(convert(Int8, 10))

# ╔═╡ 48706abb-afb7-4533-bd8a-ac914b5ea692
md"Como ilustración, podemos realizar operaciones como la siguiente:"

# ╔═╡ ba33bfcc-1bee-4ada-b97f-0c88466d75a2
10 |> Int8 |> bitstring |> length

# ╔═╡ 22578cb2-8609-4504-8c24-06635967ccae
length(bitstring(Int8(10)))

# ╔═╡ 18430d41-e129-4614-aa63-4992db146a15
md"
## Más sobre tipos/conjuntos en Julia
En general, para todo tipo (conjunto) en Julia, podemos inspeccionar sus subtipos (subconjuntos) de la siguiente forma:"

# ╔═╡ 63df9020-91d3-48ea-8842-bff38784a5c2
subtypes(Integer)

# ╔═╡ 03911b4f-7f2f-4052-ba88-a329fd43306a
md"Arriba vemos una primera jerarquía de división de `Integer` en subconjuntos. Por ahora, inspeccionemos el llamado `Signed`:"

# ╔═╡ c90082b1-be11-4239-8818-bc4057743fe9
subtypes(Signed)

# ╔═╡ d67877ec-bd4e-4148-bb80-e138e29e760b
md"Notamos que los tipos anteriormente utilizados se encuentran como subconjuntos de `Signed`, el cual es subconjunto de `Integer`. `Signed` formalmente se puede definir como:

`Signed` $= \{x \in \mathbb{Z}\ |\ \text{tenemos una noción de signo para }x \}$

Lo cual puede sonar bastante abstracto tanto para la computadora como para nosotros (incluso algo vago). Esto es porque tipos como `Signed` (e `Integer`, `Unsiged`, etc.) existen con finalidad de organizar conceptos más que definir objetos concretos. 

Esto lo podemos enfatizar al observar que:"

# ╔═╡ 91c7ca22-ff23-4c6f-a325-69e02aa7c05e
Signed.abstract, Integer.abstract, Int64.abstract

# ╔═╡ 86c92f6a-aaeb-4d83-bb5c-66e7e2b523e0
md"Aquí visitamos el concepto de **tipo abstracto** y **tipo concetro** en Julia. Los tipos concretos son aquellos conjuntos que contienen elementos que estrictamente puedan ser representados en una computadora (ya sea como cadena de bits o de alguna manera más sofisticada). Mientras que los tipos abstractos, no necesitan poder ser representados, pues solo pretenden definir conceptos útiles para la organización y el humano lector.

Por otra parte, como caso especial de los tipos concretos, tenemos los 'tipos bits', que son tipos concretos que son representables como cadena de bits. El resto de tipos concretos ocupan dos o más cadenas y conexiones más complicadas para ser representadas, aunque siempre siendo posible."

# ╔═╡ 552a2916-d4d7-4a8a-8ce0-04099dac3e5b
Int64.isbitstype, Integer.isbitstype

# ╔═╡ 00cf2b2f-db7b-4aca-b66a-f5e245c0a9b8
subtypes(Int64)

# ╔═╡ 57d98383-9aa4-4ea8-abd5-aa5f983482f8
typeintersect(Int64, Int32)

# ╔═╡ 4180a87e-d0f6-473f-b96c-525230ac2153
md"Un ejemplo de un conjunto se elementos que puede ser representado en memoria de la computadora (tipo concreto) pero no como una sencilla cadena de bits es el vector con entradas de tipo `Int64`:"

# ╔═╡ 7a9b78f3-f872-4f35-b00d-cbbbef4f386c
Vector{Int64}.isconcretetype, Vector{Int64}.isbitstype

# ╔═╡ fb5917ee-edf4-4b2f-91dc-827219c50974
md"Hablaremos más sobre vectores más adelante. Por los momentos, observemos otros tipos de números que tenemos en Julia:"

# ╔═╡ 423ab2d4-d048-4573-b2cb-3558ff265a62
Number.abstract

# ╔═╡ 5bfb0f96-39d1-4db0-81f6-8988fa613afe
Number |> subtypes

# ╔═╡ 88e6559a-cad0-4e49-afc1-af31c4cc0ad2
Real |> subtypes

# ╔═╡ dc28040c-b779-420c-979f-9f525112d481
1//2 |> typeof 

# ╔═╡ 2eab181d-03e1-49f2-adeb-233a769087ee
(2+5im)//(6) |> typeof

# ╔═╡ a50634b5-e6fa-4b15-b80d-352815d9eb1b
AbstractFloat |> subtypes

# ╔═╡ c65b82c6-a851-42e7-bda9-9873a995fc6e
π |> typeof

# ╔═╡ 5e6dc109-b34b-4402-8c63-a1f90782e530
2.0 |> typeof

# ╔═╡ 5512c6a1-3cad-474d-be76-672ce48903c4
2.04 |> bitstring

# ╔═╡ 3c3600a9-e57a-4ac2-b996-b2395ab62b0a
md"Este es un vistazo de la jerarquía de conjuntos bajo el conjunto abstracto `Number`. La forma correcta de pensar en `Number` es que es el conjunto de toda entidad *'que se comporta como número'*. Esto podría incluir, por ejemplo, a los cuaterniones, a los p-ádicos, a los multivectores o cualquier objeto que *'tenga las operaciones y funciones que un número tendría'*. En particular, incluye a los números complejos como vemos en el diagrama.

Bajo la misma linea de pensamiento, un `AbstractFloat` contiene 'todos las entidades que se comportan como flotantes', siendo ejemplos `Float64`, `Float32`, etc. pero, como veremos luego, también tenemos permitido definir nuestros propios tipos. Esto permite a Julia ser **extensible**. 

![diagrama_tipos](https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Julia-number-type-hierarchy.svg/1920px-Julia-number-type-hierarchy.svg.png)"

# ╔═╡ 1d64b3df-f57a-4e4b-abf7-e6cbf99b7778
md"
Para culminar la discusión de los tipos en Julia como conjuntos, observemos que también tenemos la noción se unión e intersección de tipos

## Operaciones sobre conjuntos
### Unión de conjuntos

Tenemos unión de conjuntos:
"

# ╔═╡ d83268e9-28ae-46f6-8f86-3e6fa739094b
Union{Integer, AbstractFloat}

# ╔═╡ 00fd02e1-56af-4e68-869a-0938563cfeaf
md"Notemos que la unión entre `Integer` y `Real` es `Real` ya que tenemos que `Integer <: Real` "

# ╔═╡ eff7d1af-6dc3-448e-bbd7-35c0556ebb5f
Union{Integer, Real}

# ╔═╡ 83e3bdfb-f94a-4b37-99c2-48692b96066e
md"Igualmente para la siguiente lista de conjuntos, todos contenidos en `Integer`"

# ╔═╡ 8e18d4b0-918d-49b7-b0a3-ab542dc5cdd1
Union{Integer, Bool, Int64, Signed, BigInt}

# ╔═╡ b8679619-0a4c-40e9-a34a-f8b574fa3f7d
md"Por otro lado, tenemos el caso de los conjuntos `Bool`, `Signed`, `Unsigned` que juntos conforman `Integer` y su unión debería ser igual a `Integer`, pero esto no es decidido automáticamente:"

# ╔═╡ a079a501-ca65-49e5-8380-8677aa3c3bb2
Integer |> subtypes

# ╔═╡ ab150d7b-0323-44c2-bee9-904024b36a7f
Union{Bool, Signed, Unsigned}

# ╔═╡ 3f326e0d-0426-41bf-ba42-3359b7adab38
md"Esto es para dar consistencia ante uniones que solo son de un par de conjuntos que pueden o no estar relacionados:"

# ╔═╡ 4e1851ce-10e7-4b60-a9ac-9ba3aad98d15
Union{Float64, Integer}

# ╔═╡ 529d74b9-d016-4b10-af11-0dd9f8478ff3
md"Si uno insiste en obtener **el conjunto más pequeño que contiene la unión en cuestión** podemos lograrlo utilizando la función `typejoin`:"

# ╔═╡ 8e5c7acd-0d1c-4ece-915e-e0f26288ee7b
typejoin(Bool, Signed, Unsigned)

# ╔═╡ 292ba510-2ad2-4ac9-a0af-e5375540f1cb
typejoin(Float64, Integer)

# ╔═╡ acc308af-6c79-49e6-9568-4d1dca3d69e6
md"Esto se puede pensar también como *encontrar el ancestro más cercano en común. Gran parte del funcionamiento de Julia utiliza estas nociones como veremos más adelante.

### El conjunto vacío y el universal

Tenemos igual la noción del conjunto vacío, expresado en Julia como la unión de ningún conjunto, el cual vemos que no tiene ningún subconjunto y la relación de subconjunto da `true` para cualquier conjunto, incluso los concretos y con él mismo:"

# ╔═╡ 8e697f02-fdbd-4bdc-9e79-61eec5ec89a4
Union{}

# ╔═╡ ff621270-7f72-49b6-8f61-8d6a477d0cb1
subtypes(Union{})

# ╔═╡ c24e66fa-eca8-4acb-8e09-9101ff8677ad
Int64 |> subtypes

# ╔═╡ be7598e9-4beb-4338-be16-0aae10987051
Union{} <: Integer, Union{} <: Int64, Union{} <: Union{}

# ╔═╡ f8b37afc-816c-4050-a7f6-8585859bd3d4
md"En caso de uniones con el conjunto vacío, da el mismo resultado a que si no hubiese estado presente, tal como esperariamos:"

# ╔═╡ 3af58fab-af03-40c9-8807-fcc34fa2066b
Union{Union{}, Integer}

# ╔═╡ ee56b35e-31f8-4cce-a58a-002c8eb4368e
Union{Union{}, Float64, Float32}

# ╔═╡ 6cfb227b-27a5-44a7-b5c5-2564bc8e6c23
md"Similarmente para `typejoin`s:"

# ╔═╡ dd74d84d-ba49-4b28-b76d-dfceb7e4f826
typejoin(Union{}, Float64)

# ╔═╡ 34cebccc-7717-4bd0-8641-7c670f0f6c7c
md"El conjunto universal en Julia es denotado por `Any`, en el espíritu de consistencia con otros lenguajes de programación. Este tiene las propiedades esperadas de un conjunto universal que contiene a todos los demás:"

# ╔═╡ 57674351-c24d-4744-9dca-6fb6ff7c8276
Any # El conjunto universal

# ╔═╡ 142555da-2602-43ca-8cf2-15acbe5bc2d1
Any <: Any, Real <: Any, Number <: Any

# ╔═╡ 55966f3d-7c69-4e54-af99-42d6b971b926
Union{Any, Real, Number}

# ╔═╡ b65df0ea-60f3-47a5-b6c4-81d88b850063
typejoin(Any, Real, Number)

# ╔═╡ fcb025f9-fb22-4ced-a3e6-025d74159fa1
Any |> supertypes

# ╔═╡ 51ecb052-af9c-4627-a13c-7cd7d899aa16
subtypes(Any)

# ╔═╡ c006f66b-62b9-42dd-bf03-81ded6f626dd
length(subtypes(Any))

# ╔═╡ 1e3a07bd-c825-4a0f-a3a8-d2d774aea576
md"
Como podemos ver, hay una gran cantidad de conjuntos que son directos subconjuntos de `Any` y eso es sin contar a todos los subconjuntos de estos $(length(subtypes(Any))) subconjuntos directos.

### Intersecciones

Las uniones en Julia son altamente utilizadas, como veremos más adelante, para definir los posibles **dominios** en que actuarán nuestras funciones o donde existirán parámetros de nuestros tipos propios. 

Las intersecciones no son comúnmente utilizadas pero igual tenemos una interfaz para manipularlas:"

# ╔═╡ 3b63818b-4ce3-4347-a0b2-5680590d185e
typeintersect(Real, Integer)

# ╔═╡ 3ca8523e-988e-4ef4-8f4e-3edb43958b70
typeintersect(AbstractFloat, Integer)

# ╔═╡ 329ef148-9988-41df-8225-ac48942ce8ce
typeintersect(Union{Float64, Int64, Float32}, AbstractFloat)

# ╔═╡ 3bf72263-4afd-41ea-a41f-3f9976c2c87e
typeintersect(typeintersect(typeintersect(Union{Int32, Bool, Char}, Union{Char, Any}), Any), Union{Unsigned, Signed})

# ╔═╡ 3fa33c74-3adf-4f73-8ebf-d8e8cbd8d453
'🐰' |> typeof

# ╔═╡ 72bee22a-a78a-4171-a016-8b4348ff39b9
md"Vemos que tenemos las propiedades esperadas de una operación de intersección de conjuntos. 

## ¿Qué sucede con las otras operaciones?

Claramente tenemos otras posibles operaciones de conjuntos como el complemento, pero resulta que éstas existirían en Julia por capricho más que por utilidad si se implementasen (a menos que se les encuentre un uso real).

Por ello, no tenemos una operación para el complemento de un conjunto, especialmente dado que la intersección es rara vez utilizada. 

## Introducción a Funciones
### Funciones matemáticas y multiple dispatch

Ya entendiendo los básicos de los tipos/conjuntos en Julia, podemos hablar directamente de las funciones. En el mismo espíritu purista matemático, veamos que las funciones en Julia pueden ser definidas como estamos acostumbrados en matemáticas.

Considere a:

$\begin{aligned} g: \mathbb{R} &\longrightarrow \ \ \mathbb{R} \\ x &\longmapsto \sin(x) \end{aligned}$"

# ╔═╡ 981f14ad-dcfc-4009-bb0a-fcbfd2657648
g = x::Real -> sin(x)::Real

# ╔═╡ 8152c80b-d4e1-4b66-93e8-be42ede8e1dd
g(π/2)

# ╔═╡ 598b080a-f71f-43d6-a0c4-3e7566c18bd9
md"¿Qué pasa si intentamos evaluar algo que no sea un real?"

# ╔═╡ f3c6ecf9-28b4-4f73-881b-93f4bc197a07
#g("hola")

# ╔═╡ 9a078de5-7adb-45c8-8604-c5fbdd93983e
#g(1 + im)

# ╔═╡ c58c2532-9433-4f3b-bed8-bff7314ad635
md"Esta es una de las muchas maneras en que uno puede definir funciones en Julia. En particular, esta es conocida como una *función anónima* dado que, aunque le pusimos el nombre de `g`, realmente no ocupaba dicho nombre:"

# ╔═╡ 63fecdc6-b0eb-4d58-b398-5eeef42464ea
x::Real -> sin(x)

# ╔═╡ aae483ec-f49e-4735-bb55-5f3e9f4c202c
md"igualmente puede ser evaluada."

# ╔═╡ 16c32600-e92e-46fb-b98d-7627b2544a25
(x::Real -> sin(x))(π/2)

# ╔═╡ 89285103-c01a-45b3-a307-b5eb7e91745d
md"
Notemos además que si no especificamos su codominio, Julia automáticamente colocará un `Any` explícito

El tema del codominio merece un poco más de discusión. Es muy común en matemáticas preocuparnos sobre el codominio ya que nos define nociones como funciones sobreyectivas o propiedades de dimensión del rango sobre el del codominio, etc.

No obstante, al momento de programar nuestras funciones, esta no es una preocupación que se mantenga en mente y por ende es común no colocarlo y permitir que sea `Any` a menos que queramos explícitamos **anotarle al compilador** el tipo de salida (esto se discutirá a profundidad luego)

Otra forma de definir funciones, quizá más tradicional en notación, es:"

# ╔═╡ b187d275-730e-43cf-85a9-fed53e984d69
f(x::Real) = x^2

# ╔═╡ ba03c65f-a538-4624-a672-ef47722b4a33
md"¿Pero qué pasa si yo tengo dos funciones donde deseo hacer abuso de notación y llamarles `f` a ambas, para que se entienda acorde al contexto. O bien, puede ser que una versión necesite ciertas modificaciones para funcionar para cierto tipo de objetos, etc.

En Julia tenemos el concepto de **multiple dispatch** que traducido podría entenderse como *'entrega múltiple' o *'envío múltiple'*, entendiéndose como que una sola función `f` puede ser *entregada* o *entendida* bajo diferentes definiciones dependiendo del tipo de objeto utilizado. Obsvemos:"

# ╔═╡ b664d583-ec0d-4713-bbd3-c0c5a5a70222
f(z::Complex) = real(z)

# ╔═╡ aa74c32c-8e5f-42ea-b762-9f4a369d0fcd
f(x::Integer) = x - 5

# ╔═╡ a1e2f72a-a8f6-4048-b5e5-f922259dfc67
f(x::Int64) = √x

# ╔═╡ e3ea8720-26d4-46b6-8f5b-a3b66bba7910
f(2)

# ╔═╡ 94554311-81d4-497e-8add-461dba63ab43
f(2.5)

# ╔═╡ 8cce1773-0227-4dbf-bc7e-ea2ac29a3225
f(π)

# ╔═╡ a5efac21-a4f7-4531-945e-8c0f5003ec0c
f(3+im)

# ╔═╡ 44465bbb-4df1-4465-8f97-cd89d36d7f50
f(5)

# ╔═╡ 98348a61-0fb0-46e5-a795-b76e2f3533b3
f(2.0) 

# ╔═╡ eb9d82e1-3637-4f84-adbe-0111716f0993
md"Pero.. ¿No es `Real <: Complex` y entonces la definición reciente debería aplicar también para `Real`? ¿No habrá conflicto?

Primero que nada, un poco de terminología: 
- A lo que le hemos estado llamando **funciones** realmente se les conoce como **métodos**
- Múltiples métodos están contenidos dentro de lo que conocemos como **función genérica**, que podríamos pensar es el nombre en sí mientras que los métodos son las diferentes *entregas* del multiple dispatch.

Dicho eso, cuando Julia debe evaluar una función, lo que sucede detrás de cámaras es una búsqueda a lo largo de todos los métodos de la función genérica que estamos llamando, yendo de más a menos particular.

Esto quiere decir que, incluso si existe una definición de `f` para números complejos, si existe una para números reales, la de números reales va a ser utilizada al momento de llamarse con un elemento de `Real`.

Por otro lado, si existiese una definición `f(x::Float64)`, entonces al ser llamado por un `Float64`, usaríamos esa, pero al ser llamado con un `Float32`, al no existir `f(::Float32)`, el método a ser llamado sería el *más particular aplicable*, en este caso: `f(x::Real)`.

### Otras formas de definir funciones

Introducimos brevemente otras syntaxis para definir funciones, unas que son más similares a cómo se definen en otros lenguajes. Ya hemos platicado de funciones anónimas:"

# ╔═╡ 7101ef15-8b80-49f9-a8e4-8f2432827e73
x -> x + 3

# ╔═╡ e05a113e-1caf-4784-aa53-7f40c47a870f
md"Como mencionado anteriormente, las funciones anónimas tienen nombres e identidades automáticamente generadas. Además, comienzan con `#` que es el caracter de comentarios en Julia, por lo que no podríamos asignarle más métodos a dicha función genérica. 

En conclusión, el multiple dispatch no funciona con funciones anónimas, pero sí con la notación de `f(x) = x`. Otra notación posible es:"

# ╔═╡ b05d7c05-ac71-4870-9e1c-790e3cceecff
function miFunción(texto::String)
	return "¡Hola! El texto recibido fue: $(texto)"
end

# ╔═╡ abc74d08-dc46-4398-97ec-406ef8608a35
'🐰'

# ╔═╡ 93a038b8-019e-457b-b92a-83fa2bb01db2
miFunción("montaña")

# ╔═╡ c558b408-9cef-4848-83f5-03a6948ce0f6
5 ≠ 5.0 

# ╔═╡ 7b81bfb5-38ee-45bf-a97f-3a39c2009270
5 ≥ 5

# ╔═╡ 7b71d775-4540-4e36-8695-a8e40db9fbf6
π ≈ π - √eps(Float64)

# ╔═╡ 23ad64bd-ddcf-4544-aa50-45c1f62b4801
√eps(Float64)

# ╔═╡ c8ec4b83-f54b-4117-bd29-9317e63be499
1.0 + eps(Float64)

# ╔═╡ e596a83c-e13b-40b3-8a67-b2acb019f2f7
(f ∘ f)(10)

# ╔═╡ b934d565-f9ba-4be4-a3b3-177a07282a7a
[1,2] ∪ [2,4] 

# ╔═╡ 62371834-034d-4d3b-939f-d8e8d69c8a21
∩

# ╔═╡ f20630d8-3def-44a0-a875-2832d11855c8
[1,0,0] × [0,0,1]

# ╔═╡ f1d27a48-4924-4ed3-bf27-59de5b312918
md"aquí han ocurrido varias cosas que valen la pena comentar.

- Es la primera vez utilizando un elemento del conjunto `String`. Estos son todos las cadenas de caracteres en formato utf8 que puede manejar Julia. Esto quiere decir que podemos utilizar tildes, emoticones, etc. 
  
  Esto es de hecho verdad incluso para nombres de funciones


- Para decidir la salida de la función se utiliza la palabra clave reservada `return` y en este caso hemos retornado un nuevo string.


- Este string contiene en su interior una declaración de la forma `$()` donde dentro de los paréntesis hemos colocado el argumento de la función. A esto se le llama *interpolación de cadenas de caracteres*. Lo que le pasamos a `$()` no ocupa ser un string, si no cualquier cosa que queramos que Julia evalúa y coloque en nuestro texto. Miremos:"

# ╔═╡ 1688a976-9412-4632-96bb-f3352a6104b1
"2 + 2 = $(2+2)"

# ╔═╡ 2f515623-3173-4273-b761-11111baa71f7
"f(2) = $(f(2))"

# ╔═╡ 943d00c7-5dec-4e13-84ee-3ad55b676f69
md"Por supuesto, el cuerpo de las funciones con la sintaxis anterior puede ser mucho más extenso de lo que mostramos y en el futuro veremos ejemplos de ello.

Una última forma de definir funciones es:"

# ╔═╡ 0bd992a7-d333-4235-8bc8-554a76ef04e5
otraForma(texto::String, n) = begin
	resultado = ""
	for i ∈ 1:n
		resultado *= texto
	end
	return resultado
end

# ╔═╡ 2d484489-4786-489e-86c7-53b669878935
md"Ejemplo de uso de scope local con la keyword `let`"

# ╔═╡ eaef40eb-df5f-42ce-868f-e3200f0c5365
let x = 5
	y = 20
	# --- Hice cálculos
	x + y
end

# ╔═╡ 744e7ab3-fcfe-488e-8805-812135425e75
otraForma("Hola", 4)

# ╔═╡ 832b7bc6-0341-4560-8660-d1862351944d
otraForma("Hola", 2.0)

# ╔═╡ 01e94a33-76af-40ad-9846-dad66cedb37e
"Hola " * "¿Cómo están?"

# ╔═╡ 49a83604-134d-48a2-bf95-d8a6cb946da7
md"De nuevo, hagamos un desglose de lo que sucedió arriba:

- Esta es la primera vez que utilizamos más de un argumento en una función. Es claro que de la misma forma podemos tener múltiples argumentos para funciones en las sintaxis anteriores, incluso para funciones anónimas haciendo: 

  ```Jula
  (x,y,z) -> x+y-z
  ```

- La linea `resultado = \"\"` denota la asignación de la cadena vacía de caracteres, `\"\"`, hacia la variable `resultado`

- La linea `for i ∈ 1:n` es el inicio de la declaración de un **ciclo de repetición de tipo for**. Hablaremos en detalle de esto posteriormente en caso que no los conozcan.

- La linea `resultado *= texto` es una forma corta de representar a `resultado = resultado*texto`. Es decir, estamos asignando a la variable `resultado` el valor que resulta de multiplicar al valor antiguo de `resultado` y el valor de `texto`.

  ¿Cómo funciona esto? ¿Multiplicación entre texto? Esto no es tan poco común en lenguajes de programación. Se llama **concatenación de texto** y es usualmente represetado con una suma (como en Python), aunque tiene más sentido utilizar la multiplicación `*` ya que esta operación es **no conmutativa** y de hecho forma un monoide con `\"\"` como elemento identidad. Miremos:

"

# ╔═╡ 0b0446dc-ca43-409e-bc3d-5eaaca17c117
nombre = "Luis"

# ╔═╡ 510167e1-e4d3-48b0-a4cb-c42e728a1db2
"¡Hola, " * nombre * " ¿Cómo estás?"

# ╔═╡ 73e2a929-bb80-48c7-8fc7-ae861796068b
md"Por último ¿Qué diferencia hay entre las formas de definir funciones?

Apartando el caso especial de las funciones anónimas, no existe diferencia entre las otras tres presentadas más que la comodidad de escribirlas dependiendo la situación. definitivamente la segunda es la más común:

```Julia
function nombre_función(arg1, arg2, ...)
	# Cuerpo de la función
end
```

Además de tradicional y consistente con otros lenguajes. La última presentada puede de hecho verse como un efecto secundario de lo que llamamos **bloques begin-end** que tienen la forma 

```Julia
begin
	# instrucciones realizadas
end
```

Que en Julia no tiene mayor propósito más que organizar instrucciones que ameritan estar juntas en un solo 'bloque' (puesto a que no afecta el **scope** de las variables. Más adelante se discutirá más sobre scopes).

Entonces, una función definida de la forma

```Julia
nombre_función(arg1, arg2, ...) = begin
	# instrucciones realizadas
end
```

podría pensarse como una variable que contiene todas las instrucciones del bloque begin-end, el cual sí *entrega pertenencia de la función* a `nombre_función` a diferencia de las funciones anónimas.
"

# ╔═╡ aba32638-d45f-4bf4-8892-b4afe7837dc5
md"## Más ejemplos de Multiple Dispatch

Para complementar lo anterior, miremos el siguiente ejemplo que ilustra el poder de multiple dispatch y cómo esto nos permite hacer cosas que en otros lenguajes de programación sería muy difícil o a veces imposible de replicar exactamente:

Llamemos la librería de álgebra lineal que está en la librería estandar de Julia:
"

# ╔═╡ afb0c0c7-7a0d-4292-958c-02e085cece41
md"Esta trae muchas funciones de álgebra lineal numérica. Pero cuando decimos *muchas funciones* realmente nos referimos a *muchos métodos de algunas funciones genéricas*

Notemos: Tenemos por ejemplo el caso de la función genérica `factorize` que, tal cual como es común en julia, tiene un nombre sencillo que expresa un verbo asociado a su acción. `factorize` tiene métodos que le permiten *reaccionar* al tipo de matriz que tiene como argumento y utilizar técnicas distintas de factorización:"

# ╔═╡ 1a044da9-8fe8-447e-8761-255d81920644
factorize

# ╔═╡ bf1226a6-78dd-4611-840b-93859b9fa7a9
factorize([2 -1 0; -1 2 -1; 0 -1 2])

# ╔═╡ 270f04a2-bcd6-4122-9710-620993257535
factorize([1 2 3; 
  		   2 1 4;
		   3 4 1])

# ╔═╡ 7d435b4f-dbab-48fc-9ebb-504ccfeaad62
md"## Tipos compuestos, estudio de caso: Vectores

Los vectores en Julia son un caso especial del tipo `AbstractArray{T,N}`. Esto es lo que llamamos un **tipo paramétrico**. Es decir, es un conjunto que para ser completamente especificado, depende de parámetros. En este caso `T` (el tipo de las entradas del arreglo) y `N` (el número de dimensiones o grados de libertad). 

Realmente podemos pensar también en los tipos paramétricos como conjuntos que son **uniones de muchos conjuntos a lo largo de todos los posibles valores que tomen sus parámetros**. Es decir,

`AbstractArray{T,N}` = $\displaystyle \bigcup_{t \in T,\ n \in N}$ `AbstractArray{t,n}`

Esto se formalizará en breve cuando hablemos de estos tipos de datos llamados **UnionAll**. Por los momentos, miremos el ejemplo de un vector:"

# ╔═╡ 74976ad7-aa26-4a24-b25f-48165851153d
[1, 2, 3]

# ╔═╡ 544ebf57-936c-4cc1-b94e-a17d1110e59a
[1, 2, 3] |> typeof

# ╔═╡ 43ca5d5b-2e10-41c0-81ce-42cc344deb00
[1.0, 2.0, 3.0] |> typeof

# ╔═╡ ec7c769e-4e7b-4857-aa28-7cdf0d732378
[1, 2, 3.0] |> typeof

# ╔═╡ 86c2ebb9-9380-404a-8397-0efd2233ba96
md"También podemos definir los vectores de esta manera:"

# ╔═╡ 18a99b10-f9d0-4294-98b9-267cfe3fe2aa
[1 2 3]

# ╔═╡ f5ff1497-7553-4c45-85c2-34aacf32c2d8
md"... Excepto que como pueden notar, el tipo del objeto es diferente. Esto es por que hemos definido realmente una **matriz fila**. Los vectores en Julia son, por defecto, isomorfos a las matrices columna. Intentemos definir de esos:"

# ╔═╡ 32fb002e-4ecc-4e6b-bee3-98cd46f7a3d4
[1; 2; 3] |> typeof

# ╔═╡ 21698e47-4fae-423f-b38c-e4160a946507
md"¡Perfecto! Funcionó. Ahora, el caso general es cuando tenemos una matriz con varias columnas y filas:"

# ╔═╡ 1a46f05b-7e83-4986-b2de-3f57ae7126a0
[1 2 3; 2 3 4; 3 4 5]

# ╔═╡ 3a7c72b3-f98d-4e8a-a426-409e9bc2273a
md"### Operaciones sobre vectores"

# ╔═╡ 3cd266c7-cd8c-4bda-855e-168afcf9ad36
v⃗ = [1.0, 2.0, 3.0]

# ╔═╡ 53f3e8da-7681-4908-b9c9-51c7ecda9b46
md"## UnionAll: Tipos paramétricos"

# ╔═╡ d96d6da8-7505-451a-9d68-2ae5c70ce55a
mitipo = Union{Vector{T}} where {T <: Integer};

# ╔═╡ a2550528-734f-4658-a649-06c654b79151
Vector{Int64} <: mitipo

# ╔═╡ c400e7ba-0969-4733-a173-5fa505d3c30d
Vector{Bool} <: mitipo

# ╔═╡ 60e54e9a-2fc6-49b9-ab43-bc4e5278eb77
Vector{Float64} <: mitipo

# ╔═╡ 4714ca10-b741-472b-8f06-3a944a63b10e
md"## Structs: tipos compuestos propios"

# ╔═╡ c72240ff-3853-4cb5-90f8-d609517a0c5e
md"## Símbolos en Julia"

# ╔═╡ 1d70aaf6-3485-40c5-8f2d-f12af111c42a
md"
Julia es capaz de entender lenguaje simbólico:
"

# ╔═╡ 88552435-a511-48d2-9306-ab3c1dd5e2b2
:x, :y  

# ╔═╡ 2cb0c754-7bea-4e0d-8817-a7abe2b3f897
md"Julia es un lenguaje opcionalmente tipado, similar a cuando el ser humano puede **inferir** lo que significa algo sin que se nos diga, dependiendo dle contexto, y de no ser posible inferir en el momento, podemos inferir cuando tengamos más información:"

# ╔═╡ 497d436a-380f-48be-8336-32639a3dc565


# ╔═╡ 9f086353-b88b-444e-bbe5-426d2758a9e0
TableOfContents(title = "Contenidos", aside = true)

# ╔═╡ 101c6fab-780e-4c04-b495-1801bace7850


# ╔═╡ 66f87d6d-fde8-474a-a5ed-9957ef857327


# ╔═╡ 339377d9-a16d-4f21-a1ea-c4f6bdc1e41f


# ╔═╡ 60e43ecc-4bfb-4b4d-9993-e2ee739b6deb


# ╔═╡ 9eaad4fe-0eaf-4003-9ec3-5de0a756d4da
hint(texts::AbstractArray) = Markdown.MD(Markdown.Admonition("warning", "Nota", texts))

# ╔═╡ c78463d1-b682-48a4-b270-2fbe6c51acf6
hint(text::Union{AbstractString, Markdown.MD}) = hint([text])

# ╔═╡ 9938ab35-34c9-4578-aa01-25968e7a5812
hint(md"
Es importante notar que esto es posible ya que `==` es **una definida función realmente** mientras que `===` es una función que existe entendida a nivel de compilación del lenguaje:
	
```Julia
=== # Se le conoce como built-in function
```
	
```Julia
== # Tenemos 220 definiciones, cada una para diferentes tipos de objetos.
```	
	
	")

# ╔═╡ 3dcea53d-bb7f-480c-9aba-e9f460ea3bbd
hint(md"Es valioso aclarar que las funciones anónimas son *realmente siempre definidas sin nombre*, solo que podemos guardarlas en variables. Esto es fundamentalmente distinto a que la función tenga nombre como veremos cuando hablemos de **Multiple Dispatch**. 

Podemos pensarlo como que su nombre *real* será algo como `#793817` (o cualquier otra cosa realmente) y cuando hacemos algo como 

```julia
g = x -> sin(x)	
``` 
	
estamos guardando el objeto `#793817`, que pertenece al conjunto/tipo `Function` dentro de la variable con nombre `g`. Pero `g` podría luego asignársele otra cosa y la función `#793817` seguiría existiendo independiente de `g` (hasta que el *recolector de basura* lo recoja. Más de ello luego.)")

# ╔═╡ Cell order:
# ╟─8e7c9226-ddee-11eb-3e73-3112eb059eb7
# ╠═49d3d127-c964-4494-94c2-c7f0123ba0d9
# ╠═debb0d4f-f029-4067-920c-cc049cd83adc
# ╟─8db92bb9-1a1d-4398-9fc6-72734976c816
# ╠═205e451b-cabb-4d52-b041-eeb5ce0bacbc
# ╟─4b567441-f60e-4a6f-a4ea-ef961762e7f0
# ╠═beda1f98-d17f-4915-819d-24a1dbe3b837
# ╠═cae300fc-5dbc-447f-8f16-5e4d2ec98633
# ╠═5e771978-db46-409f-a91e-d66d6182340c
# ╠═4b60ab09-19ce-4501-b8da-20a667fdce52
# ╟─627c5ca8-eed8-4dae-bf28-1c41996e70f6
# ╠═b145a130-cc8e-4431-bfd2-ed85130b95a5
# ╟─1cb50db6-6207-4a84-a91d-1a41129f707c
# ╠═bb11b4d8-fef8-4f34-8bf6-e6a6ceb551c5
# ╟─349b1f42-bb9f-4770-a7d5-dd8bc78a318f
# ╟─b79180ce-d566-4039-b40f-b52ce1fd91f1
# ╠═2d2d9b97-5522-446b-8c8b-aff0c20b0d8c
# ╠═9b502ab8-20ca-46e5-977e-80b0adc19bfd
# ╟─9e3c684b-4039-4eb2-b633-619f9bd4d851
# ╠═d3e10fbc-f1b6-44b2-b40f-77d1d065d680
# ╠═82da2de9-d202-43d1-ab7d-c6c7f8e3ee55
# ╟─919fc101-078d-4e00-9fbe-3be7c677572e
# ╠═4a3e5c65-69da-428d-bce5-7f1348868657
# ╠═28529472-2bda-44f1-9b17-8d9674fdd5f7
# ╠═76bee316-0bfd-44f7-ab57-976a4ba56c11
# ╟─9938ab35-34c9-4578-aa01-25968e7a5812
# ╟─244cfe8d-ad8e-49d2-8a28-9abbfed36d96
# ╠═aefc90c8-a2eb-465f-9584-3f2224bfe5b6
# ╠═350ab8e1-d0c2-4a5f-a8a1-c51f2d4f429a
# ╟─e5db8570-7dc0-48e3-85bd-34feaacdc4a8
# ╠═da194735-2d45-4af7-bd9c-3b24acb73e3a
# ╟─48706abb-afb7-4533-bd8a-ac914b5ea692
# ╠═ba33bfcc-1bee-4ada-b97f-0c88466d75a2
# ╠═22578cb2-8609-4504-8c24-06635967ccae
# ╟─18430d41-e129-4614-aa63-4992db146a15
# ╠═63df9020-91d3-48ea-8842-bff38784a5c2
# ╟─03911b4f-7f2f-4052-ba88-a329fd43306a
# ╠═c90082b1-be11-4239-8818-bc4057743fe9
# ╟─d67877ec-bd4e-4148-bb80-e138e29e760b
# ╠═91c7ca22-ff23-4c6f-a325-69e02aa7c05e
# ╟─86c92f6a-aaeb-4d83-bb5c-66e7e2b523e0
# ╠═552a2916-d4d7-4a8a-8ce0-04099dac3e5b
# ╠═00cf2b2f-db7b-4aca-b66a-f5e245c0a9b8
# ╠═57d98383-9aa4-4ea8-abd5-aa5f983482f8
# ╟─4180a87e-d0f6-473f-b96c-525230ac2153
# ╠═7a9b78f3-f872-4f35-b00d-cbbbef4f386c
# ╟─fb5917ee-edf4-4b2f-91dc-827219c50974
# ╠═423ab2d4-d048-4573-b2cb-3558ff265a62
# ╠═5bfb0f96-39d1-4db0-81f6-8988fa613afe
# ╠═88e6559a-cad0-4e49-afc1-af31c4cc0ad2
# ╠═dc28040c-b779-420c-979f-9f525112d481
# ╠═2eab181d-03e1-49f2-adeb-233a769087ee
# ╠═a50634b5-e6fa-4b15-b80d-352815d9eb1b
# ╠═c65b82c6-a851-42e7-bda9-9873a995fc6e
# ╠═5e6dc109-b34b-4402-8c63-a1f90782e530
# ╠═5512c6a1-3cad-474d-be76-672ce48903c4
# ╟─3c3600a9-e57a-4ac2-b996-b2395ab62b0a
# ╟─1d64b3df-f57a-4e4b-abf7-e6cbf99b7778
# ╠═d83268e9-28ae-46f6-8f86-3e6fa739094b
# ╟─00fd02e1-56af-4e68-869a-0938563cfeaf
# ╠═eff7d1af-6dc3-448e-bbd7-35c0556ebb5f
# ╟─83e3bdfb-f94a-4b37-99c2-48692b96066e
# ╠═8e18d4b0-918d-49b7-b0a3-ab542dc5cdd1
# ╟─b8679619-0a4c-40e9-a34a-f8b574fa3f7d
# ╠═a079a501-ca65-49e5-8380-8677aa3c3bb2
# ╠═ab150d7b-0323-44c2-bee9-904024b36a7f
# ╟─3f326e0d-0426-41bf-ba42-3359b7adab38
# ╠═4e1851ce-10e7-4b60-a9ac-9ba3aad98d15
# ╟─529d74b9-d016-4b10-af11-0dd9f8478ff3
# ╠═8e5c7acd-0d1c-4ece-915e-e0f26288ee7b
# ╠═292ba510-2ad2-4ac9-a0af-e5375540f1cb
# ╟─acc308af-6c79-49e6-9568-4d1dca3d69e6
# ╠═8e697f02-fdbd-4bdc-9e79-61eec5ec89a4
# ╠═ff621270-7f72-49b6-8f61-8d6a477d0cb1
# ╠═c24e66fa-eca8-4acb-8e09-9101ff8677ad
# ╠═be7598e9-4beb-4338-be16-0aae10987051
# ╟─f8b37afc-816c-4050-a7f6-8585859bd3d4
# ╠═3af58fab-af03-40c9-8807-fcc34fa2066b
# ╠═ee56b35e-31f8-4cce-a58a-002c8eb4368e
# ╟─6cfb227b-27a5-44a7-b5c5-2564bc8e6c23
# ╠═dd74d84d-ba49-4b28-b76d-dfceb7e4f826
# ╟─34cebccc-7717-4bd0-8641-7c670f0f6c7c
# ╠═57674351-c24d-4744-9dca-6fb6ff7c8276
# ╠═142555da-2602-43ca-8cf2-15acbe5bc2d1
# ╠═55966f3d-7c69-4e54-af99-42d6b971b926
# ╠═b65df0ea-60f3-47a5-b6c4-81d88b850063
# ╠═fcb025f9-fb22-4ced-a3e6-025d74159fa1
# ╠═51ecb052-af9c-4627-a13c-7cd7d899aa16
# ╠═c006f66b-62b9-42dd-bf03-81ded6f626dd
# ╟─1e3a07bd-c825-4a0f-a3a8-d2d774aea576
# ╠═3b63818b-4ce3-4347-a0b2-5680590d185e
# ╠═3ca8523e-988e-4ef4-8f4e-3edb43958b70
# ╠═329ef148-9988-41df-8225-ac48942ce8ce
# ╠═3bf72263-4afd-41ea-a41f-3f9976c2c87e
# ╠═3fa33c74-3adf-4f73-8ebf-d8e8cbd8d453
# ╟─72bee22a-a78a-4171-a016-8b4348ff39b9
# ╠═981f14ad-dcfc-4009-bb0a-fcbfd2657648
# ╠═8152c80b-d4e1-4b66-93e8-be42ede8e1dd
# ╟─598b080a-f71f-43d6-a0c4-3e7566c18bd9
# ╠═f3c6ecf9-28b4-4f73-881b-93f4bc197a07
# ╠═9a078de5-7adb-45c8-8604-c5fbdd93983e
# ╟─c58c2532-9433-4f3b-bed8-bff7314ad635
# ╠═63fecdc6-b0eb-4d58-b398-5eeef42464ea
# ╟─aae483ec-f49e-4735-bb55-5f3e9f4c202c
# ╠═16c32600-e92e-46fb-b98d-7627b2544a25
# ╟─3dcea53d-bb7f-480c-9aba-e9f460ea3bbd
# ╟─89285103-c01a-45b3-a307-b5eb7e91745d
# ╠═b187d275-730e-43cf-85a9-fed53e984d69
# ╠═e3ea8720-26d4-46b6-8f5b-a3b66bba7910
# ╠═94554311-81d4-497e-8add-461dba63ab43
# ╠═8cce1773-0227-4dbf-bc7e-ea2ac29a3225
# ╟─ba03c65f-a538-4624-a672-ef47722b4a33
# ╠═b664d583-ec0d-4713-bbd3-c0c5a5a70222
# ╠═a5efac21-a4f7-4531-945e-8c0f5003ec0c
# ╠═aa74c32c-8e5f-42ea-b762-9f4a369d0fcd
# ╠═a1e2f72a-a8f6-4048-b5e5-f922259dfc67
# ╠═44465bbb-4df1-4465-8f97-cd89d36d7f50
# ╠═98348a61-0fb0-46e5-a795-b76e2f3533b3
# ╟─eb9d82e1-3637-4f84-adbe-0111716f0993
# ╠═7101ef15-8b80-49f9-a8e4-8f2432827e73
# ╟─e05a113e-1caf-4784-aa53-7f40c47a870f
# ╠═b05d7c05-ac71-4870-9e1c-790e3cceecff
# ╠═abc74d08-dc46-4398-97ec-406ef8608a35
# ╠═93a038b8-019e-457b-b92a-83fa2bb01db2
# ╠═c558b408-9cef-4848-83f5-03a6948ce0f6
# ╠═7b81bfb5-38ee-45bf-a97f-3a39c2009270
# ╠═7b71d775-4540-4e36-8695-a8e40db9fbf6
# ╠═23ad64bd-ddcf-4544-aa50-45c1f62b4801
# ╠═c8ec4b83-f54b-4117-bd29-9317e63be499
# ╠═e596a83c-e13b-40b3-8a67-b2acb019f2f7
# ╠═b934d565-f9ba-4be4-a3b3-177a07282a7a
# ╠═62371834-034d-4d3b-939f-d8e8d69c8a21
# ╠═f20630d8-3def-44a0-a875-2832d11855c8
# ╟─f1d27a48-4924-4ed3-bf27-59de5b312918
# ╠═1688a976-9412-4632-96bb-f3352a6104b1
# ╠═2f515623-3173-4273-b761-11111baa71f7
# ╟─943d00c7-5dec-4e13-84ee-3ad55b676f69
# ╠═0bd992a7-d333-4235-8bc8-554a76ef04e5
# ╟─2d484489-4786-489e-86c7-53b669878935
# ╠═eaef40eb-df5f-42ce-868f-e3200f0c5365
# ╠═744e7ab3-fcfe-488e-8805-812135425e75
# ╠═832b7bc6-0341-4560-8660-d1862351944d
# ╠═01e94a33-76af-40ad-9846-dad66cedb37e
# ╟─49a83604-134d-48a2-bf95-d8a6cb946da7
# ╠═0b0446dc-ca43-409e-bc3d-5eaaca17c117
# ╠═510167e1-e4d3-48b0-a4cb-c42e728a1db2
# ╟─73e2a929-bb80-48c7-8fc7-ae861796068b
# ╟─aba32638-d45f-4bf4-8892-b4afe7837dc5
# ╠═84e1cf74-d1ec-4a62-b6eb-8724a7845c2e
# ╟─afb0c0c7-7a0d-4292-958c-02e085cece41
# ╠═1a044da9-8fe8-447e-8761-255d81920644
# ╠═bf1226a6-78dd-4611-840b-93859b9fa7a9
# ╠═270f04a2-bcd6-4122-9710-620993257535
# ╟─7d435b4f-dbab-48fc-9ebb-504ccfeaad62
# ╠═74976ad7-aa26-4a24-b25f-48165851153d
# ╠═544ebf57-936c-4cc1-b94e-a17d1110e59a
# ╠═43ca5d5b-2e10-41c0-81ce-42cc344deb00
# ╠═ec7c769e-4e7b-4857-aa28-7cdf0d732378
# ╟─86c2ebb9-9380-404a-8397-0efd2233ba96
# ╠═18a99b10-f9d0-4294-98b9-267cfe3fe2aa
# ╟─f5ff1497-7553-4c45-85c2-34aacf32c2d8
# ╠═32fb002e-4ecc-4e6b-bee3-98cd46f7a3d4
# ╟─21698e47-4fae-423f-b38c-e4160a946507
# ╠═1a46f05b-7e83-4986-b2de-3f57ae7126a0
# ╟─3a7c72b3-f98d-4e8a-a426-409e9bc2273a
# ╠═3cd266c7-cd8c-4bda-855e-168afcf9ad36
# ╟─53f3e8da-7681-4908-b9c9-51c7ecda9b46
# ╠═d96d6da8-7505-451a-9d68-2ae5c70ce55a
# ╠═a2550528-734f-4658-a649-06c654b79151
# ╠═c400e7ba-0969-4733-a173-5fa505d3c30d
# ╠═60e54e9a-2fc6-49b9-ab43-bc4e5278eb77
# ╠═4714ca10-b741-472b-8f06-3a944a63b10e
# ╠═c72240ff-3853-4cb5-90f8-d609517a0c5e
# ╟─1d70aaf6-3485-40c5-8f2d-f12af111c42a
# ╠═88552435-a511-48d2-9306-ab3c1dd5e2b2
# ╟─2cb0c754-7bea-4e0d-8817-a7abe2b3f897
# ╠═497d436a-380f-48be-8336-32639a3dc565
# ╟─e5bd718d-1c46-4341-adee-17efddb0d199
# ╟─9f086353-b88b-444e-bbe5-426d2758a9e0
# ╟─101c6fab-780e-4c04-b495-1801bace7850
# ╟─66f87d6d-fde8-474a-a5ed-9957ef857327
# ╟─339377d9-a16d-4f21-a1ea-c4f6bdc1e41f
# ╟─60e43ecc-4bfb-4b4d-9993-e2ee739b6deb
# ╟─9eaad4fe-0eaf-4003-9ec3-5de0a756d4da
# ╟─c78463d1-b682-48a4-b270-2fbe6c51acf6
