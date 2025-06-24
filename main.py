from flask import Flask, render_template, request, redirect
import pyodbc

app = Flask(__name__)

# Configuração da conexão com o SQL Server
server = 'localhost\\SQLEXPRESS'
database = 'comunidade'
username = 'jhonathan'
password = '1101515'

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

# Rodando a aplicação
if __name__ == '__main__':
    app.run(debug=True)
