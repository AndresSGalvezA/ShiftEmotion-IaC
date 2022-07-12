from pymysql import connect

endpoint = 'developdb.cfdptlopmdhe.us-east-1.rds.amazonaws.com'
username = 'admin'
pwd = 'admin123'
database = 'develop'

def deleteUser(cursor, connection, email):
    try:
        cursor.execute("UPDATE user set deleted = CONVERT_TZ(NOW(), 'SYSTEM', 'AMERICA/GUATEMALA') WHERE email = '{}'".format(email))
        connection.commit()
        cursor.close()

        return {
            'statusCode': 200,
            'message': 'User deleted'
        }
    except Exception as e:
        return {
            'statusCode': 500,
            'message': str(e)
        }

def updateUser(cursor, connection, email, role):
    try:
        cursor.execute("UPDATE user set role = {}, updated = CONVERT_TZ(NOW(), 'SYSTEM', 'AMERICA/GUATEMALA') WHERE email = '{}'".format(role, email))
        connection.commit()
        cursor.close()

        return {
            'statusCode': 200,
            'message': 'User updated'
        }
    except Exception as e:
        return {
            'statusCode': 500,
            'message': str(e)
        }

def getUsers(cursor, connection):
    try:
        connection = connect(host=endpoint, user=username, password=pwd, db=database)
        cursor = connection.cursor()
        cursor.execute("SELECT * FROM user WHERE deleted IS NULL")
        columns = cursor.description
        result = [{columns[index][0]:str(column) for index, column in enumerate(value)} for value in cursor.fetchall()]
        cursor.close()

        return {
            'statusCode': 200,
            'data': result
        }
            
    except Exception as e:
        return {
            'statusCode': 500,
            'message': str(e)
        }

def lambda_handler(event, context):
    connection = connect(host=endpoint, user=username, password=pwd, db=database)
    cursor = connection.cursor()

    if event['operation'] == 'delete':
        return deleteUser(cursor, connection, event['email'])
    elif event['operation'] == 'update':
        return updateUser(cursor, connection, event['email'], event['role'])
    elif event['operation'] == 'get':
        return getUsers()