#Libraries utilizadas

library("basedosdados")
library("tidyverse")
library("ggplot2")

#Conectando o data lake ao projeto no Google Cloud

set_billing_id("agregadorpesquisas")

#Estabelecendo query para a database eleitoral da Poder360

query <- bdplyr("br_poder360_pesquisas.microdados")
  
#Criando dataframe e selecionando as colunas relevantes

df <- bd_collect(query)

df_2 <- data.frame(df$ano, df$cargo, df$data, df$data_referencia,
                   df$instituto, df$turno, df$descricao_cenario,
                   df$nome_candidato, df$percentual)

names(df_2) <- c("ano", "cargo", "data", "data_ref", "instituto", "turno",
                 "descricao_cenario", "candidato", "percentual")

#Criando subset para rodar o modelo

df_3 <- subset(df_2, ano >= 2022 & turno == 1 & cargo == "presidente" & 
                     percentual >= 1 & (candidato %in% c("Bolsonaro" , "Lula",
                                                         "Ciro", "Simone Tebet")
                   | is.na(candidato)) & (descricao_cenario %in% c(
                        "cenário 2 - estimulado - 1º turno", 
                     "cenário 2 - estimulada - 1º turno",
                     "cenário 3 - estimulada - 1º turno",
                     "cenário 4 - estimulada = 1º turno") | 
                        is.na(descricao_cenario)) & data >= "2021-01-01")

df_4 <- data.frame(df_3$instituto, df_3$data, df_3$candidato, df_3$percentual)

names(df_4) <- c("instituto", "data", "candidato", "percentual")

df_4$data <- as.Date(df_4$data)

group.colors <- c("Lula" = "red", "Bolsonaro" = "blue", "Ciro" = "dark green", "Simone Tebet" = "purple")

grafico_1turno <- ggplot(df_4, aes(x=data, y=percentual, colour=candidato)) +  
                  geom_point() + 
                  geom_line() +
                  stat_smooth(data=subset(df_4,candidato == "Lula"), method = "loess", 
                        size = 1, se = T, colour = "red") + 
                  stat_smooth(data=subset(df_4,candidato == "Bolsonaro"), method = "loess", 
                        size = 1, se = T, colour = "blue" ) +
                  stat_smooth(data=subset(df_4,candidato == "Ciro"), method = "loess", 
                        size = 1, se = T, colour = "dark green") +
                  stat_smooth(data=subset(df_4,candidato == "Simone Tebet"), method = "loess", 
                        size = 1, se = T, colour = "purple") +
                  scale_color_manual(values = group.colors)

grafico_1turno

#Subset para o 2º turno

df_5 <-  subset(df_2, ano >= 2022 & turno == 2 & cargo == "presidente" & 
               percentual >= 1 & (candidato %in% c("Bolsonaro" , "Lula")
               | is.na(candidato)) & (descricao_cenario %in% 
               c("cenário 1 - estimulado - 2º turno") | 
               is.na(descricao_cenario)) & data >= "2021-01-01")

df_6 <- data.frame(df_5$instituto, df_5$data, df_5$candidato, df_5$percentual)

names(df_6) <- c("instituto", "data", "candidato", "percentual")

df_6$data <- as.Date(df_5$data)

group.colors2 <- c("Lula" = "red", "Bolsonaro" = "blue")

grafico_2turno <- ggplot(df_6, aes(x=data, y=percentual, colour=candidato)) +
                  geom_point()+
                  geom_line()+
                  stat_smooth(data=subset(df_6, candidato == "Lula"), method = "loess",
                  size = 1, se = T, colour = "red") +
                  stat_smooth(data=subset(df_6, candidato == "Bolsonaro"), method = "loess",
                  size = 1, se = T , colour = "blue") +
                  scale_color_manual(values = group.colors2)

grafico_2turno