
from flask import Flask, render_template, request, redirect
import pyodbc

app = Flask(__name__)

# Configuração da conexão com o SQL Server
server = 'localhost\\SQLEXPRESS'
database = 'comunidade'
username = 'jhonathan'
password = 'FuturaSenhaFort3!'

connection_string = f'DRIVER={{ODBC Driver 17 for SQL Server}};SERVER={server};DATABASE={database};UID={username};PWD={password}'


def get_connection():
    return pyodbc.connect(connection_string)

# Rota Inicial
@app.route('/')
def index():
    return render_template('index.html')

# Exemplo: Listar Cursos
@app.route('/cursos')
def cursos():
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute('SELECT ID, Nome, Area FROM Cursos')
    cursos = cursor.fetchall()
    conn.close()
    return render_template('cursos.html', cursos=cursos)

# Exemplo: Listar Afiliados
@app.route('/afiliados')
def afiliados():
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute('SELECT CPF, Nome, Status FROM Afiliados')
    afiliados = cursor.fetchall()
    conn.close()
    return render_template('afiliados.html', afiliados=afiliados)

@app.route('/professores')
def professores():
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute('SELECT CPF, Nome, Especializacao FROM Professores')
    professores = cursor.fetchall()
    conn.close()
    return render_template('professores.html', professores=professores)
@app.route('/afiliados/novo', methods=['GET', 'POST'])
def novo_afiliado():
    if request.method == 'POST':
        cpf = request.form['cpf']
        nome = request.form['nome']
        status = request.form['status']
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute('''
            INSERT INTO Afiliados (CPF, Nome, endereco_id, telefone_id, email_id, data_filiacao, status)
            VALUES (?, ?, ?, ?, ?, GETDATE(), ?)
        ''', (cpf, nome, status))
        conn.commit()
        conn.close()
        return redirect('/afiliados')
    return render_template('novo_afiliado.html')


@app.route('/cursos/novo', methods=['GET', 'POST'])
def novo_curso():
    if request.method == 'POST':
        nome = request.form['nome']
        area = request.form['area']
        descricao = request.form['descricao']
        carga = request.form['carga']
        nivel = request.form['nivel']

        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute('SELECT ISNULL(MAX(ID), 0) + 1 FROM Cursos')
        novo_id = cursor.fetchone()[0]

        cursor.execute('''
                       INSERT INTO Cursos (ID, Nome, Area, Descricao, Carga_Horaria, Nivel)
                       VALUES (?, ?, ?, ?, ?, ?)
                       ''', (novo_id, nome, area, descricao, carga, nivel))

        conn.commit()
        conn.close()
        return redirect('/cursos')
    return render_template('novo_curso.html')


@app.route('/professor/novo', methods=['GET', 'POST'])
def novo_professor():
    if request.method == 'POST':
        cpf = request.form['cpf']
        nome = request.form['nome']
        especializacao = request.form['especializacao']

        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute('''
                       INSERT INTO Professores (CPF, Nome, Especializacao, telefone_id, email_id)
                       VALUES (?, ?, ?, NULL, NULL)
                       ''', (cpf, nome, especializacao))

        conn.commit()
        conn.close()
        return redirect('/professores')

    return render_template('novo_professor.html')

@app.route('/boletos', methods=['GET'])
def boletos():
    if request.method == 'GET':
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute('SELECT COD, Afiliado_CPF, Valor, Data_vencimento, Data_pagamento, Status FROM Boletos')
        boletos = cursor.fetchall()
        conn.close()
        return render_template('boletos.html', boletos=boletos)

@app.route('/boletos/novo', methods=['GET', 'POST'])
def novo_boletos():
    if request.method == 'POST':
        cod = request.form['COD']
        afiliado_CPF = request.form['Afiliado_CPF']
        valor = request.form['Valor']
        data_vencimento = request.form['Data_vencimento']
        status = 'Aberto'

        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute('''
                       INSERT INTO Professores (COD, Afiliado_CPF, Valor, Data_vencimento,Data_pagamento, Status)
                       VALUES (?, ?, ?, ?, NULL, ?)
                       ''', (cod,afiliado_CPF , valor, data_vencimento, status))

        conn.commit()
        conn.close()
        return redirect('/boletos')

    return render_template('novo_boletos.html')

@app.route('/relatorios')
def relatorio():
    conn = get_connection()
    cursor = conn.cursor()

    cursor.execute("SELECT COUNT(*) FROM Afiliados WHERE status = 'Ativo'")
    afiliados_ativos = cursor.fetchone()[0]

    cursor.execute("SELECT COUNT(*) FROM Afiliados WHERE status = 'Inativo'")
    afiliados_inativos = cursor.fetchone()[0]

    cursor.execute("SELECT COUNT(*) FROM Cursos")
    total_cursos = cursor.fetchone()[0]

    cursor.execute("SELECT COUNT(*) FROM Professores")
    total_professores = cursor.fetchone()[0]

    cursor.execute("SELECT COUNT(*) FROM Boletos WHERE Status = 'Pago'")
    boletos_pagos = cursor.fetchone()[0]

    cursor.execute("SELECT COUNT(*) FROM Boletos WHERE Status = 'Aberto'")
    boletos_abertos = cursor.fetchone()[0]

    conn.close()

    return render_template(
        'relatorios.html',
        afiliados_ativos=afiliados_ativos,
        afiliados_inativos=afiliados_inativos,
        total_cursos=total_cursos,
        total_professores=total_professores,
        boletos_pagos=boletos_pagos,
        boletos_abertos=boletos_abertos
    )




# Rodando a aplicação
if __name__ == '__main__':
    app.run(debug=True)
