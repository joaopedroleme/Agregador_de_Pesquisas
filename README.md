# Agregador_de_Pesquisas
Agregador de Pesquisas simples - MacroCapital

Este é um agregador simples de pesquisas de inteções de voto para os dois turnos das eleições presidenciais de 2022. A partir dos microdados disponibilizados pela database da Poder360, geraremos gráficos que modelam a evolução do percentual de votos de cada um dos candidatos especificados.

Cabe relembrar que o código aqui demonstrado é bastante flexível, já que outros filtros podem ser adicionados/acomodados com poucas mudanças, como a seleção de institutos de pesquisa em específico (ou mesmo a exclusão pontual de alguns deles), atribuição de pesos distintos para os resultados de determinadas pesquisas (usando critérios temporais ou institucionais, p. ex.), utilização de modelos econométricos distintos (nesse exercício, utilizamos LM e LOESS), ou mesmo sua reapropriação para outras eleições locais (governador, senador, etc.).

Nem todos os agregadores de pesquisa (XP, Jota, PoderData) buscam modelar a trajetória dos candidatos. Alguns simplesmente descrevem a movimentação dos resultados, ponto a ponto. Um exemplo desta formatação será dado adiante.
