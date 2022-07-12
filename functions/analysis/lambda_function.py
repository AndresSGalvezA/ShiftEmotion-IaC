from uuid import uuid1
from boto3 import client as boto3
from base64 import b64decode

rekognition = boto3("rekognition")
s3 = boto3("s3")
BUCKET_NAME = "shiftemotion-images"

def saveImage(image):
    try:
        photo_key = str(uuid1())
        
        s3_response = s3.put_object(
            Bucket=BUCKET_NAME, Key=photo_key, Body=image
        )
        return (photo_key)

    except Exception as e:
        return ("error")

def lambda_handler(event, context):
    photo_key = saveImage(b64decode(event['content']))

    if photo_key != "error":
        rekognition_res = rekognition.detect_faces(
            Image = {'S3Object': {
                    'Bucket': BUCKET_NAME, 
                    'Name': photo_key
                }
            },
            Attributes=["ALL"]
        )

        faceDetails = rekognition_res["FaceDetails"]

        if rekognition_res == []:
            return {
                'statusCode': 500,
                'message': "Rekognition was not able to identify a face"
            }
        else:
            return {
                'statusCode': 200,
                'body': faceDetails[0]["Emotions"][0]
            }
    else:
        return {
            'statusCode': 400,
            'message': "Bad request"
        }
