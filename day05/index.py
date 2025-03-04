# 파이썬 웹앱(Flask) 1. Flask 라이브러리 설치
## pip install Flask (파워쉘)

# Flask 및 관련 라이브러리 import
from flask import Flask, render_template, request
import pymysql

# 변수초기화 (데이터베이스 연결)
host = 'localhost' # or '127.0.0.1'
port = 3306
database = 'madang'
username = 'root'
password = '12345'

# DB 접속 상태 플래그
conflag = True # 접속상태 확인

# Flask 애플리케이션 객체 생성
app = Flask(__name__) # 플라스크 웹앱 실행

# MySQL DB 연결
conn = pymysql.connect(host=host, user=username, passwd=password, port=port, database=database)
cursor = conn.cursor()

# 기본 페이지 라우팅
@app.route('/') # routing decorator : 웹사이트 경로를 실행할 때 http://localhost:5000/
def index():
    # 데이터베이스에서 책 목록 조회
    query = '''SELECT bookid
                    , bookname
                    , publisher
                    , price 
                FROM Book'''  
    # 쿼리 실행 및 결과 가져오기
    res = cursor.execute(query)     # SQL 실행(1회 실행)
    data = cursor.fetchall()        # MySQL 데이터를 한번에 다 가져옴
    # HTML 템플릿 렌더링
    # templates 폴더에 있는 html을 데이터와 연결해서 렌더링 함
    return render_template('booklist.html', book_list=data)

# 책 상세 정보 페이지 라우팅
@app.route('/view')  # http://localhost/5000/view?id=2 #/view 경로에 접속하면 실행되는 함수
def getDetail():
    # 요청에서 id 값 가져오기
    bookid = request.args.get('id')
    # 특정 책 정보를 조회하는 SQL문 생성
    query = f'''SELECT bookid
                    , bookname
                    , publisher
                    , price 
                FROM Book
               WHERE bookid = '{bookid}'
            '''  
    # SQL 실행 및 데이터 가져오기
    cursor.execute(query)
    data = cursor.fetchall()
    # HTML 템플릿 렌더링(책 상세 정보 페이지)
    return render_template('bookview.html', book=data)

# Flask 애플리케이션 실행
if __name__ == '__main__':
    app.run('localhost')
# 이 파일이 직접 실행될 때 Flask 애플리케이션을 실행, localhost에서 실행됨