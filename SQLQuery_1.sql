CREATE TABLE Afiliados (
    CPF VARCHAR(11),
    Nome VARCHAR(150),
    endereco_id INT,
    telefone_id INT,
    email_id INT,
    data_filiacao date,
    status VARCHAR(20)
    PRIMARY KEY(CPF)
);

CREATE TABLE Cursos (
    ID INT,
    Nome VARCHAR(100),
    Area VARCHAR(100),
    Descricao VARCHAR(255),
    Carga_Horaria VARCHAR(20),
    Nivel VARCHAR(20)
);

CREATE TABLE Professores (
    CPF VARCHAR(11),
    Nome VARCHAR(100),
    Especializacao VARCHAR(100),
    telefone_id INT,
    email_id INT
);

CREATE TABLE Boletos (
    COD VARCHAR(20),
    Afiliado VARCHAR(11),
    Valor INT,
    Data_vencimento DATE,
    Data_pagamento DATE,
    Status VARCHAR(20)
);

CREATE TABLE Turmas (
    ID INT,
    Curso VARCHAR(100),
    Professor VARCHAR(100),
    Horario TIME,
    Vagas_total INT,
    Vagas_disponiveis INT
);

CREATE TABLE matricula (
    data_incricao date,
    id_curso VARCHAR(20),
    CPF VARCHAR(11)
);

CREATE TABLE professores_cursos (
    CPF_Professor VARCHAR(11),
    ID_Curso VARCHAR(20)
);

CREATE TABLE professore_turmas (
    CPF_Professor VARCHAR(11),
    Cod_Turma VARCHAR(20)
);

CREATE TABLE Possui_boleto (
    fk_Afiliados_CPF VARCHAR(11),
    fk_Boletos_COD VARCHAR(20)
);

CREATE TABLE Possui (
    fk_matricula_id_curso VARCHAR(20),
    fk_matricula_CPF VARCHAR(11),
    fk_Turmas_ID INT
);

CREATE TABLE participa (
    fk_matricula_id_curso VARCHAR(20),
    fk_matricula_CPF VARCHAR(11),
    fk_Afiliados_CPF VARCHAR(11)
);

CREATE TABLE professores_tem_turmas (
    fk_Professores_CPF VARCHAR(11),
    fk_professore_turmas_CPF_Professor VARCHAR(11),
    fk_professore_turmas_Cod_Turma VARCHAR(20)
);

CREATE TABLE turmas_tem_professores (
    fk_Turmas_ID INT,
    fk_professore_turmas_CPF_Professor VARCHAR(11),
    fk_professore_turmas_Cod_Turma VARCHAR(20)
);

CREATE TABLE curso_tem_professores (
    fk_Cursos_ID INT,
    fk_professores_cursos_CPF_Professor VARCHAR(11),
    fk_professores_cursos_ID_Curso VARCHAR(20)
);

CREATE TABLE turmas_do_curso (
    fk_Turmas_ID INT,
    fk_Cursos_ID INT
);

CREATE TABLE professores_dao_cursos (
    fk_Professores_CPF VARCHAR(11),
    fk_professores_cursos_CPF_Professor VARCHAR(11),
    fk_professores_cursos_ID_Curso VARCHAR(20)
);


SELECT * from sys.tables

-- Gera comandos DROP TABLE para todas as tabelas
DECLARE @sql NVARCHAR(MAX) = N'';

SELECT @sql += 'DROP TABLE [' + SCHEMA_NAME(schema_id) + '].[' + name + '];' + CHAR(13)
FROM sys.tables
ORDER BY name;

EXEC sp_executesql @sql;
