INSERT INTO tipo_rede_esgoto
    VALUES (1, 'Coletor'),
    (2, 'Coletor tronco'),
    (3, 'Interceptor'),
    (4, 'Recalque'),
    (5, 'Emissario');

INSERT INTO tipo_esgoto
    VALUES (1, 'Domestico'),
    (2, 'Industrial'),
    (3, 'Pluvial'),
    (4, 'Tratado');

INSERT INTO tipo_material
    VALUES (1, 'CA'),
    (2, 'Concreto'),
    (3, 'FoFo'),
    (4, 'FGal'),
    (5, 'PRFV'),
    (6, 'PVC'),
    (7, 'PVC Corrugado'),
    (8, 'PVC DeFoFo'),
    (9, 'PEAD'),
    (10, 'PEAD Corrugado'),
    (11, 'Aco'),
    (12, 'Tijolo');

INSERT INTO tipo_situacao
    VALUES (1, 'Ativa'),
    (2, 'Inativa'),
    (3, 'Em construcao');

INSERT INTO tipo_nivel_tratamento_esgoto
    VALUES (1, 'Preliminar/Acondicionamento'),
    (2, 'Primario'),
    (3, 'Secundario'),
    (4, 'Terciario');

INSERT INTO tipo_tecnologia_tratamento_esgoto
    VALUES (1, 'Decantacao primaria'),
    (2, 'Lagoa anaerobica'),
    (3, 'Reator anaerobico'),
    (4, 'Lagoa aerobica'),
    (5, 'Lodos ativados'),
    (6, 'Filtro biologico'),
    (7, 'Coagulacao'),
    (8, 'Flotacao'),
    (9, 'Desinfeccao'),
    (10, 'Outros - especificar na obs');

INSERT INTO tipo_bomba
    VALUES (1, 'Centrifuga'),
    (2, 'Submersa'),
    (3, 'Submersivel'),
    (4, 'Auto-aspirante'),
    (5, 'Periferica'),
    (6, 'Injetora');

INSERT INTO tipo_forma
    VALUES (1, 'Circular'),
    (2, 'Quadrado'),
    (3, 'Retangular');

INSERT INTO tipo_lancamento
    VALUES (1, 'Descarga'),
    (2, 'Extravazamento'),
    (3, 'Padrao de saida');

INSERT INTO tipo_manancial
    VALUES (1, 'Rio'),
    (2, 'Lago'),
    (3, 'Acude'),
    (4, 'Represa'),
    (5, 'Aquifero'),
    (6, 'Nascente');

INSERT INTO tipo_valvula
    VALUES (1, 'Borboleta'),
    (2, 'Esferica'),
    (3, 'Gaveta'),
    (4, 'Redutora de pressao'),
    (5, 'Retencao');

INSERT INTO tipo_funcao_valvula
    VALUES (1, 'Bloqueio'),
    (2, 'Controle'),
    (3, 'Descarga'),
    (4, 'Redutora de pressao'),
    (5, 'Retencao');

INSERT INTO tipo_acionamento_valvula
    VALUES (1, 'Eletrico'),
    (2, 'Manual Chave'),
    (3, 'Manual Volante'),
    (4, 'Mecanico');

INSERT INTO tipo_acesso_valvula
    VALUES (1, 'Caixa'),
    (2, 'Enterrado'),
    (3, 'Acesso livre'),
    (4, 'PV'),
    (5, 'Tampa T9');

INSERT INTO tipo_posicao_valvula
    VALUES (1, 'Aberta'),
    (2, 'Fechada'),
    (3, 'Nao aplicavel'),
    (4, 'Parcialmente aberta');

INSERT INTO tipo_unidade_inspecao
    VALUES (1, 'Caixa de passagem'),
    (2, 'Poco de inspecao'),
    (3, 'Poco de visita'),
    (4, 'Terminal de limpeza');

INSERT INTO tipo_conexao
    VALUES (1, 'Adaptador'),
    (2, 'CAP'),
    (3, 'Colar de tomada'),
    (4, 'Cruzeta'),
    (5, 'Curva'),
    (6, 'Luva de uniao'),
    (7, 'Reducao'),
    (8, 'TE'),
    (9, 'Ventosa');

