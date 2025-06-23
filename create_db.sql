-- Afiliados
CREATE TABLE Afiliados (
    CPF VARCHAR(11) PRIMARY KEY,
    Nome VARCHAR(150),
    endereco_id INT,
    telefone_id INT,
    email_id INT,
    data_filiacao DATE,
    status VARCHAR(20)
);

-- Cursos
CREATE TABLE Cursos (
    ID INT PRIMARY KEY,
    Nome VARCHAR(100),
    Area VARCHAR(100),
    Descricao VARCHAR(255),
    Carga_Horaria VARCHAR(20),
    Nivel VARCHAR(20)
);

-- Professores
CREATE TABLE Professores (
    CPF VARCHAR(11) PRIMARY KEY,
    Nome VARCHAR(100),
    Especializacao VARCHAR(100),
    telefone_id INT,
    email_id INT
);

-- Boletos
CREATE TABLE Boletos (
    COD VARCHAR(20) PRIMARY KEY,
    Afiliado_CPF VARCHAR(11),
    Valor INT,
    Data_vencimento DATE,
    Data_pagamento DATE,
    Status VARCHAR(20),
    FOREIGN KEY (Afiliado_CPF) REFERENCES Afiliados(CPF)
);

-- Turmas
CREATE TABLE Turmas (
    ID INT PRIMARY KEY,
    Curso_ID INT,
    Professor_CPF VARCHAR(11),
    Horario TIME,
    Vagas_total INT,
    Vagas_disponiveis INT,
    FOREIGN KEY (Curso_ID) REFERENCES Cursos(ID),
    FOREIGN KEY (Professor_CPF) REFERENCES Professores(CPF)
);

-- Matricula
CREATE TABLE Matricula (
    ID INT PRIMARY KEY IDENTITY,
    data_inscricao DATE,
    Curso_ID INT,
    Afiliado_CPF VARCHAR(11),
    FOREIGN KEY (Curso_ID) REFERENCES Cursos(ID),
    FOREIGN KEY (Afiliado_CPF) REFERENCES Afiliados(CPF)
);

-- Professores_Cursos
CREATE TABLE Professores_Cursos (
    CPF_Professor VARCHAR(11),
    ID_Curso INT,
    PRIMARY KEY (CPF_Professor, ID_Curso),
    FOREIGN KEY (CPF_Professor) REFERENCES Professores(CPF),
    FOREIGN KEY (ID_Curso) REFERENCES Cursos(ID)
);

-- Professores_Turmas
CREATE TABLE Professores_Turmas (
    CPF_Professor VARCHAR(11),
    ID_Turma INT,
    PRIMARY KEY (CPF_Professor, ID_Turma),
    FOREIGN KEY (CPF_Professor) REFERENCES Professores(CPF),
    FOREIGN KEY (ID_Turma) REFERENCES Turmas(ID)
);

-- Possui_Boleto
CREATE TABLE Possui_Boleto (
    Afiliado_CPF VARCHAR(11),
    Boleto_COD VARCHAR(20),
    PRIMARY KEY (Afiliado_CPF, Boleto_COD),
    FOREIGN KEY (Afiliado_CPF) REFERENCES Afiliados(CPF),
    FOREIGN KEY (Boleto_COD) REFERENCES Boletos(COD)
);

-- Participa
CREATE TABLE Participa (
    Matricula_ID INT,
    Afiliado_CPF VARCHAR(11),
    PRIMARY KEY (Matricula_ID, Afiliado_CPF),
    FOREIGN KEY (Matricula_ID) REFERENCES Matricula(ID),
    FOREIGN KEY (Afiliado_CPF) REFERENCES Afiliados(CPF)
);

-- Turmas_do_Curso
CREATE TABLE Turmas_do_Curso (
    Turma_ID INT,
    Curso_ID INT,
    PRIMARY KEY (Turma_ID, Curso_ID),
    FOREIGN KEY (Turma_ID) REFERENCES Turmas(ID),
    FOREIGN KEY (Curso_ID) REFERENCES Cursos(ID)
);

