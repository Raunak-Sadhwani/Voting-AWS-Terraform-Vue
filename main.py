import json
import boto3
from boto3.dynamodb.conditions import Key

dynamodb = boto3.resource('dynamodb')

def lambda_handler(event, context):
    if event['httpMethod'] == 'GET':
        if event['path'] == '/companies':
            return get_companies()
        elif event['path'] == '/users':
            return get_users(event['queryStringParameters'])
        elif event['path'] == '/polls':
            return get_polls(event['queryStringParameters'])
        elif event['path'] == '/votes':
            return get_votes(event['queryStringParameters'])
    elif event['httpMethod'] == 'POST':
        if event['path'] == '/companies':
            return create_company(json.loads(event['body']))
        elif event['path'] == '/users':
            return create_user(json.loads(event['body']))
        elif event['path'] == '/polls':
            return create_poll(json.loads(event['body']))
        elif event['path'] == '/votes':
            return create_vote(json.loads(event['body']))
    
    return {
        'statusCode': 400,
        'body': json.dumps('Invalid Request')
    }

def get_companies():
    table = dynamodb.Table('companies')
    response = table.scan()
    return {
        'statusCode': 200,
        'body': json.dumps(response['Items'])
    }

def get_users(params):
    table = dynamodb.Table('users')
    response = table.query(
        IndexName='CompanyIndex',
        KeyConditionExpression=Key('company_id').eq(params['company_id'])
    )
    return {
        'statusCode': 200,
        'body': json.dumps(response['Items'])
    }

def get_polls(params):
    table = dynamodb.Table('polls')
    response = table.query(
        IndexName='CompanyIndex',
        KeyConditionExpression=Key('company_id').eq(params['company_id'])
    )
    return {
        'statusCode': 200,
        'body': json.dumps(response['Items'])
    }

def get_votes(params):
    table = dynamodb.Table('votes')
    response = table.query(
        IndexName='PollIndex',
        KeyConditionExpression=Key('poll_id').eq(params['poll_id'])
    )
    return {
        'statusCode': 200,
        'body': json.dumps(response['Items'])
    }

def create_company(company):
    table = dynamodb.Table('companies')
    table.put_item(Item=company)
    return {
        'statusCode': 201,
        'body': json.dumps('Company created')
    }

def create_user(user):
    table = dynamodb.Table('users')
    table.put_item(Item=user)
    return {
        'statusCode': 201,
        'body': json.dumps('User created')
    }

def create_poll(poll):
    table = dynamodb.Table('polls')
    table.put_item(Item=poll)
    return {
        'statusCode': 201,
        'body': json.dumps('Poll created')
    }

def create_vote(vote):
    table = dynamodb.Table('votes')
    table.put_item(Item=vote)
    return {
        'statusCode': 201,
        'body': json.dumps('Vote created')
    }
