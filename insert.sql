-- Inserindo cursos
INSERT INTO Cursos (ID, Nome, Area, Descricao, Carga_Horaria, Nivel) VALUES
(1, 'Informática Básica', 'Tecnologia', 'Curso introdutório de informática', '40h', 'Iniciante'),
(2, 'Auxiliar Administrativo', 'Administração', 'Curso de capacitação administrativa', '60h', 'Intermediário'),
(3, 'MMA Iniciante', 'Esportes', 'Artes marciais para iniciantes', '30h', 'Iniciante');

-- Inserindo professores
INSERT INTO Professores (CPF, Nome, Especializacao, telefone_id, email_id) VALUES
('11122233344', 'Carlos Silva', 'Tecnologia da Informação', 1, 1),
('55566677788', 'Maria Souza', 'Administração', 2, 2),
('99988877766', 'João Santos', 'Educação Física', 3, 3);

-- Inserindo afiliados
INSERT INTO Afiliados (CPF, Nome, endereco_id, telefone_id, email_id, data_filiacao, status) VALUES
('12345678900', 'Ana Oliveira', 1, 4, 4, '2024-03-10', 'Ativo'),
('98765432100', 'Bruno Lima', 2, 5, 5, '2024-04-15', 'Ativo'),
('45678912300', 'Clara Mendes', 3, 6, 6, '2024-05-20', 'Inativo');

-- Inserindo boletos
INSERT INTO Boletos (COD, Afiliado_CPF, Valor, Data_vencimento, Data_pagamento, Status) VALUES
('B001', '12345678900', 100, '2024-07-01', '2024-06-25', 'Pago'),
('B002', '98765432100', 150, '2024-07-10', NULL, 'Aberto'),
('B003', '45678912300', 120, '2024-06-20', '2024-06-18', 'Pago');

-- Inserindo turmas
INSERT INTO Turmas (ID, Curso_ID, Professor_CPF, Horario, Vagas_total, Vagas_disponiveis) VALUES
(1, 1, '11122233344', '08:00:00', 20, 15),
(2, 2, '55566677788', '10:00:00', 25, 20),
(3, 3, '99988877766', '18:00:00', 30, 28);

-- Inserindo matriculas
INSERT INTO Matricula (data_inscricao, Curso_ID, Afiliado_CPF) VALUES
('2024-06-01', 1, '12345678900'),
('2024-06-05', 2, '98765432100'),
('2024-06-10', 3, '45678912300');

-- Relacionando professores com cursos
INSERT INTO Professores_Cursos (CPF_Professor, ID_Curso) VALUES
('11122233344', 1),
('55566677788', 2),
('99988877766', 3);

-- Relacionando professores com turmas
INSERT INTO Professores_Turmas (CPF_Professor, ID_Turma) VALUES
('11122233344', 1),
('55566677788', 2),
('99988877766', 3);

-- Relacionando afiliados com boletos (Possui_Boleto)
INSERT INTO Possui_Boleto (Afiliado_CPF, Boleto_COD) VALUES
('12345678900', 'B001'),
('98765432100', 'B002'),
('45678912300', 'B003');

-- Relacionando matriculas com afiliados na tabela Participa
INSERT INTO Participa (Matricula_ID, Afiliado_CPF) VALUES
(1, '12345678900'),
(2, '98765432100'),
(3, '45678912300');

-- Relacionando turmas com cursos (Turmas_do_Curso)
INSERT INTO Turmas_do_Curso (Turma_ID, Curso_ID) VALUES
(1, 1),
(2, 2),
(3, 3);
