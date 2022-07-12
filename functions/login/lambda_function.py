from pymysql import connect
from base64 import urlsafe_b64encode, urlsafe_b64decode

endpoint = 'developdb.cfdptlopmdhe.us-east-1.rds.amazonaws.com'
username = 'admin'
pwd = 'admin123'
database = 'develop'
connection = connect(host=endpoint, user=username, password=pwd, db=database)

def lambda_handler(event, context):
    try:
        email = event["username"]
        password = event["password"]
        crypted = str(urlsafe_b64encode(bytes(password, 'utf-8'))).replace('\'', '')[1:]
        cursor = connection.cursor()
        cursor.execute("SELECT u.id, u.name, u.email, r.name as role, u.created FROM user u INNER JOIN role r ON u.role = r.id WHERE u.email = '{}' AND u.password = '{}' AND u.deleted IS NULL".format(email, crypted))
        columns = cursor.description
        result = [{columns[index][0]:str(column) for index, column in enumerate(value)} for value in cursor.fetchall()]
        cursor.close()

        # Case user is not registered
        if len(result) == 0:
            return {
                'statusCode': 500,
                'message': 'User does not exist'
            }
        # Successful response
        else:
            return {
                'statusCode': 200,
                'message': result,
                'x-api-token': 'PyYqFdCMxP1nZSpbO4o362JPbEqHmXEV1YJpp8r1'
            }
    except Exception as e:
        return {
            'statusCode': 500,
            'message': str(e)
        }