import pymysql

endpoint = 'developdb.cfdptlopmdhe.us-east-1.rds.amazonaws.com'
username = 'admin'
dbPwd = 'admin123'
database = 'develop'
#connection = pymysql.connect(host=endpoint, user=username, password=pwd, db=database)

def lambda_handler(event, context):
    try:
        name = event['username']
        email = event['email']
        pwd = event['password']
        country = event['country']
        connection = pymysql.connect(host=endpoint, user=username, password=dbPwd, db=database)
        cursor = connection.cursor()
        # Check if user already exists
        cursor.execute("SELECT email FROM user WHERE email = '{}' AND deleted IS NULL".format(email))
        columns = cursor.description
        result = [{columns[index][0]:str(column) for index, column in enumerate(value)} for value in cursor.fetchall()]
    
        if len(result) != 0:
            cursor.close()
            
            return {
                'statusCode': 500,
                'message': 'User already exists'
            }
        else:
            
            # If user does not exist, create it
            cursor.execute("INSERT INTO user (role, name, email, created) VALUES (2, '{}', '{}', CONVERT_TZ(NOW(), 'SYSTEM', 'AMERICA/GUATEMALA'))".format(name, email))
            connection.commit()
            cursor.close()

            return {
                'statusCode': 200,
                'message': 'User created'
            }
    except Exception as e:
        return {
            'statusCode': 500,
            'message': str(e)
        }