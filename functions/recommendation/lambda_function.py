from spotipy import Spotify
from json import dumps
from random import choice, randint
from spotipy.oauth2 import SpotifyClientCredentials
from pymysql import connect

endpoint = 'developdb.cf.us-east-1.rds.amazonaws.com'
username = 'pvirtualizacion'
pwd = 'pvirtualizacion'
database = 'develop'

def getRecommendation(event):
    try:
        userId = event['user_id']
        connection = connect(host=endpoint, user=username, password=pwd, db=database)
        cursor = connection.cursor()

        diccionarioEmociones = {
            'HAPPY': [0.7,1,0.7,1.0], 
            'SAD': [0.75,1.0, 0.5,0.75],
            'ANGRY': [0.8,0.9,0.25,0.5],
            'CONFUSED': [0.5,0.7,0.25,0.5],
            'DISGUSTED': [0.5,0.7,0,0.25],
            'SURPRISED': [0.7,0.8,0.7,1],
            'CALM': [0.5,0.6,0,0.25],
            'UNKNOWN': [0.5,1.0,0.5,1.0],
            'FEAR': [0.5,0.7,0,0.5]
        }

        spotify = Spotify(auth_manager=SpotifyClientCredentials(client_id="6ce0298824d040dc8ec35be49b71f7cd", client_secret="e2295e77326d435e844163f2734403db"))                                            
        emocion = event['queryStringParameters']['emocion']
        rangos=(diccionarioEmociones.get(emocion))

        random_wildcards = [
            '%25a%25', 'a%25', '%25a',
            '%25e%25', 'e%25', '%25e',
            '%25i%25', 'i%25', '%25i',
            '%25o%25', 'o%25', '%25o',
            '%25u%25', 'u%25', '%25u'
        ]
                            
        wildcard = choice(random_wildcards)    
        results = spotify.search(q=wildcard, type='track', offset=randint(0, 200))
        items = results['tracks']['items']
        recomendacion = spotify.recommendations(seed_tracks=[items[0]['id']], minval=rangos[0], maxval=rangos[1], mindanceability=rangos[2], maxdanceability=[3], limit=10)
        resultado = []
        
        for track in recomendacion['tracks']:
            resultado.append(
            {
                "Nombre": track['name'] ,
                "Artista": track['artists'][0]['name'],
                "Album": track['album']['name'], 
                "Enlace": track['external_urls']['spotify'],
                "ImagenAlbum": track['album']['images'][1]['url'], 
                "DuracionSegundos": track['duration_ms']/1000,
                "Año": track['album']['release_date']
            })

            cursor.execute('''INSERT INTO recommendation (user_id, mood, song_name, song_artist, song_album, song_link, song_img, created) 
            VALUES ({}, '{}', '{}', '{}', '{}', '{}', '{}', CONVERT_TZ(NOW(), 'SYSTEM', 'AMERICA/GUATEMALA')'''.format(userId, emocion, track['name'], track['artists'][0]['name'], track['album']['name'], track['external_urls']['spotify'], track['album']['images'][1]['url']))
            connection.commit()
        
        cursor.close()

        return {
            'statusCode':200,
            'body': dumps(resultado),
            'headers': {'Content-Type': 'application/json'}
        }
    except Exception as e:
        return {
            'statusCode':500,
            'message': str(e)
        }

def listRecommendations(event):
    try:
        userId = event['userId']
        connection = connect(host=endpoint, user=username, password=pwd, db=database)
        cursor = connection.cursor()
        cursor.execute("SELECT * FROM recommendation WHERE user_id = {}".format(userId))
        columns = cursor.description
        result = [{columns[index][0]:str(column) for index, column in enumerate(value)} for value in cursor.fetchall()]
        cursor.close()
        
        return {
            'statusCode':200,
            'data': dumps(result),
            'headers': {'Content-Type': 'application/json'}
        }
    except Exception as e:
        return {
            'statusCode':500,
            'message': str(e)
        }

def lambda_handler(event, context):
    if event["operation"] == "list":
        listRecommendations(event)
    else:
        getRecommendation(event)