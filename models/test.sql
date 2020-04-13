
{{config( materialized= 'view')}}

with pessoas as 
    (
    SELECT * from {{ ref('pessoas') }}
    ),
utilizacao as 
    (
    SELECT * from {{ ref('utilizacao') }}
    ) ,

utilizacao_total as 
    (
    SELECT 
    id_pessoa, 
    MIN(dt_utilizacao) as primeira_utilizacao, 
    sum(valor_pago) as total_utilizacao
from utilizacao 
group by id_pessoa 
    )
SELECT 
    pessoas.id_pessoa,
    pessoas.dt_nascimento,
    pessoas.cpf ,
    primeira_utilizacao,
    total_utilizacao
from utilizacao_total
left join pessoas 
on pessoas.id_pessoa = utilizacao_total.id_pessoa