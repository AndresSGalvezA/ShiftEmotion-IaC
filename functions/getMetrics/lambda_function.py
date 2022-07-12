from pymysql import connect
from datetime import date

endpoint = 'developdb.cfdptlopmdhe.us-east-1.rds.amazonaws.com'
username = 'admin'
pwd = 'admin123'
database = 'develop'
connection = connect(host=endpoint, user=username, password=pwd, db=database)
currentYear = date.today().year

def lambda_handler(event, context):
    try:
        cursor = connection.cursor()

        # Order by mood
        cursor.execute('''SELECT COUNT(*) AS 'total', r.mood FROM recommendation r 
        WHERE r.created BETWEEN '{}-01-01' AND '{}-12-31' AND r.deleted IS NULL
        GROUP BY r.mood'''.format(currentYear, currentYear))
        columns = cursor.description
        mood = [{columns[index][0]:str(column) for index, column in enumerate(value)} for value in cursor.fetchall()]

        # Order by country
        cursor.execute('''SELECT COUNT(*) AS 'total', c.name AS 'country' FROM user u
        INNER JOIN country c ON u.country_id = c.id
        WHERE u.created BETWEEN '{}-01-01' AND '{}-12-31' AND u.deleted IS NULL
        GROUP BY country'''.format(currentYear, currentYear))
        columns = cursor.description
        country = [{columns[index][0]:str(column) for index, column in enumerate(value)} for value in cursor.fetchall()]

        # Order by month
        cursor.execute('''SELECT COUNT(*) AS 'total', MONTH(created) as 'month' FROM recommendation
        WHERE created BETWEEN '{}-01-01' AND '{}-12-31' AND deleted IS NULL
        GROUP BY MONTH(created)'''.format(currentYear, currentYear))
        columns = cursor.description
        month = [{columns[index][0]:str(column) for index, column in enumerate(value)} for value in cursor.fetchall()]

        # Summary
        cursor.execute("SELECT COUNT(*) AS 'total' FROM recommendation WHERE deleted IS NULL and created BETWEEN '{}-01-01' AND '{}-12-31'".format(currentYear, currentYear))
        columns = cursor.description
        thisRecs = [{columns[index][0]:str(column) for index, column in enumerate(value)} for value in cursor.fetchall()]

        cursor.execute("SELECT COUNT(*) AS 'total' FROM recommendation WHERE deleted IS NULL")
        columns = cursor.description
        totalRecs = [{columns[index][0]:str(column) for index, column in enumerate(value)} for value in cursor.fetchall()]

        cursor.execute("SELECT COUNT(*) AS 'total' FROM user WHERE deleted IS NULL and created BETWEEN '{}-01-01' AND '{}-12-31'".format(currentYear, currentYear))
        columns = cursor.description
        thisUsers = [{columns[index][0]:str(column) for index, column in enumerate(value)} for value in cursor.fetchall()]

        cursor.execute("SELECT COUNT(*) AS 'total' FROM user WHERE deleted IS NULL")
        columns = cursor.description
        totalUsers = [{columns[index][0]:str(column) for index, column in enumerate(value)} for value in cursor.fetchall()]
        cursor.close()

        if len(mood) == 0:
            mood = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        if len(country) == 0:
            country = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        if len(month) == 0:
            month = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        if len(thisRecs) == 0:
            thisRecs = 0
        if len(totalRecs) == 0:
            totalRecs = 0
        if len(thisUsers) == 0:
            thisUsers = 0
        if len(totalUsers) == 0:
            totalUsers = 0

        return {
            'statusCode': 200,
            'data': {
                'mood': mood,
                'country': country,
                'month': month,
                'thisRecs': thisRecs,
                'totalRecs': totalRecs,
                'thisUsers': thisUsers,
                'totalUsers': totalUsers
            }
        }
    except Exception as e:
        return {
            'statusCode': 500,
            'message': str(e)
        }