# amplify使用時のめも

amplify/backend/strage/{DynamoDBName}/build/{DynamoDBName}-cloudformation-template.json
```json
{
  "Description": "{\"createdOn\":\"Mac\",\"createdBy\":\"Amplify\",\"createdWith\":\"10.6.0\",\"stackType\":\"storage-DynamoDB\",\"metadata\":{}}",
  "AWSTemplateFormatVersion": "2010-09-09",
  "Parameters": {
    "partitionKeyName": {
      "Type": "String"
    },
    "partitionKeyType": {
      "Type": "String"
    },
    "env": {
      "Type": "String"
    },
    "sortKeyName": {
      "Type": "String"
    },
    "sortKeyType": {
      "Type": "String"
    },
    "tableName": {
      "Type": "String"
    }
  },
  "Conditions": {
    "ShouldNotCreateEnvResources": {
      "Fn::Equals": [
        {
          "Ref": "env"
        },
        "NONE"
      ]
    }
  },
  "Resources": {
    "DynamoDBTable": {
      "Type": "AWS::DynamoDB::Table",
      "Properties": {
        "KeySchema": [
          {
            "AttributeName": "id",
            "KeyType": "HASH"
          },
          {
            "AttributeName": "displayOrder",
            "KeyType": "RANGE"
          }
        ],
        "AttributeDefinitions": [
          {
            "AttributeName": "id",
            "AttributeType": "N"
          },
          {
            "AttributeName": "displayOrder",
            "AttributeType": "N"
          }
        ],
        "GlobalSecondaryIndexes": [],
        "ProvisionedThroughput": {
          "ReadCapacityUnits": 5,
          "WriteCapacityUnits": 5
        },
        "StreamSpecification": {
          "StreamViewType": "NEW_IMAGE"
        },
        "TableName": {
          "Fn::If": [
            "ShouldNotCreateEnvResources",
            {
              "Ref": "tableName"
            },
            {
              "Fn::Join": [
                "",
                [
                  {
                    "Ref": "tableName"
                  },
                  "-",
                  {
                    "Ref": "env"
                  }
                ]
              ]
            }
          ]
        }
      }
    }
  },
  "Outputs": {
    "Name": {
      "Value": {
        "Ref": "DynamoDBTable"
      }
    },
    "Arn": {
      "Value": {
        "Fn::GetAtt": [
          "DynamoDBTable",
          "Arn"
        ]
      }
    },
    "StreamArn": {
      "Value": {
        "Fn::GetAtt": [
          "DynamoDBTable",
          "StreamArn"
        ]
      }
    },
    "PartitionKeyName": {
      "Value": {
        "Ref": "partitionKeyName"
      }
    },
    "PartitionKeyType": {
      "Value": {
        "Ref": "partitionKeyType"
      }
    },
    "SortKeyName": {
      "Value": {
        "Ref": "sortKeyName"
      }
    },
    "SortKeyType": {
      "Value": {
        "Ref": "sortKeyType"
      }
    },
    "Region": {
      "Value": {
        "Ref": "AWS::Region"
      }
    }
  }
}
```

以下を書き換えても、`amplify push`で元に戻る
```json
"ProvisionedThroughput": {
  "ReadCapacityUnits": 5,
  "WriteCapacityUnits": 5
},
```

```json
"BillingMode" : "PAY_PER_REQUEST",
```

`amplify override storage`を使う
https://docs.amplify.aws/cli/storage/override/

amplify/backend/storage/{DynamoDBName}/override.ts
AWS CDKの記法で書ける

```typescript
import { AmplifyDDBResourceTemplate } from '@aws-amplify/cli-extensibility-helper';

export function override(resources: AmplifyDDBResourceTemplate) {
  resources.dynamoDBTable.billingMode = "PAY_PER_REQUEST";
  resources.dynamoDBTable.provisionedThroughput = {
    readCapacityUnits: 0,
    writeCapacityUnits: 0
  };
}
```

参考：
- https://docs.aws.amazon.com/cdk/api/v2/docs/aws-cdk-lib.aws_dynamodb.BillingMode.html
- https://docs.aws.amazon.com/cdk/api/v2/docs/aws-cdk-lib.aws_dynamodb.CfnTable.ProvisionedThroughputProperty.html

```bash
amplify push            
⠋ Fetching updates to backend environment: dev from the cloud.⠋ Building resource storage/OrderManag
✔ Successfully pulled backend environment dev from the cloud.

    Current Environment: dev
    
┌──────────┬──────────────────────────┬───────────┬───────────────────┐
│ Category │ Resource name            │ Operation │ Provider plugin   │
├──────────┼──────────────────────────┼───────────┼───────────────────┤
│ Storage  │ OrderManagementDynamoDB  │ Update    │ awscloudformation │
├──────────┼──────────────────────────┼───────────┼───────────────────┤
│ Function │ OrderManagementApiLambda │ No Change │ awscloudformation │
├──────────┼──────────────────────────┼───────────┼───────────────────┤
│ Auth     │ ordermanagement          │ No Change │ awscloudformation │
├──────────┼──────────────────────────┼───────────┼───────────────────┤
│ Api      │ OrderManagementApi       │ No Change │ awscloudformation │
└──────────┴──────────────────────────┴───────────┴───────────────────┘
? Are you sure you want to continue? Yes

Deploying resources into dev environment. This will take a few minutes. ⠋
Deploying resources into dev environment. This will take a few minutes. ⠹
Deploying resources into dev environment. This will take a few minutes. ⠼
Deployment failed.
Deploying root stack ordermanagement [ ================------------------------ ] 2/5
        amplify-ordermanagement-dev-2… AWS::CloudFormation::Stack     UPDATE_ROLLBACK_COMPLETE   
        storageOrderManagementDynamoDB AWS::CloudFormation::Stack     UPDATE_FAILED              
        authordermanagement            AWS::CloudFormation::Stack     UPDATE_COMPLETE            
Deploying storage OrderManagementDynamoDB [ ---------------------------------------- ] 0/1
        DynamoDBTable                  AWS::DynamoDB::Table           UPDATE_FAILED              

🛑 The following resources failed to deploy:
Resource Name: DynamoDBTable (AWS::DynamoDB::Table)
Event Type: update
Reason: Resource handler returned message: "Property ProvisionedThroughput can't be used with PAY_PER_REQUEST BillingMode." (RequestToken: b93314a5-647d-8704-34d7-382bea58ddb0, HandlerErrorCode: InvalidRequest)
URL: https://console.aws.amazon.com/cloudformation/home?region=ap-northeast-1#/stacks/arn%3Aaws%3Acloudformation%3Aap-northeast-1%3A537542138877%3Astack%2Famplify-ordermanagement-dev-234753-storageOrderManagementDynamoDB-8P0E0NZ9ZPMX%2Fd009b260-8c42-11ed-a86d-0a600deffea5/events


🛑 Resource is not in the state stackUpdateComplete

Learn more at: https://docs.amplify.aws/cli/project/troubleshooting/

Session Identifier: ac45464a-278a-4cdc-9176-476710dddda9
```

```bash
amplify push            
⠏ Fetching updates to backend environment: dev from the cloud.⠋ Building resource storage/OrderManag
✔ Successfully pulled backend environment dev from the cloud.

    Current Environment: dev
    
┌──────────┬──────────────────────────┬───────────┬───────────────────┐
│ Category │ Resource name            │ Operation │ Provider plugin   │
├──────────┼──────────────────────────┼───────────┼───────────────────┤
│ Storage  │ OrderManagementDynamoDB  │ Update    │ awscloudformation │
├──────────┼──────────────────────────┼───────────┼───────────────────┤
│ Function │ OrderManagementApiLambda │ No Change │ awscloudformation │
├──────────┼──────────────────────────┼───────────┼───────────────────┤
│ Auth     │ ordermanagement          │ No Change │ awscloudformation │
├──────────┼──────────────────────────┼───────────┼───────────────────┤
│ Api      │ OrderManagementApi       │ No Change │ awscloudformation │
└──────────┴──────────────────────────┴───────────┴───────────────────┘
? Are you sure you want to continue? Yes

Deploying resources into dev environment. This will take a few minutes. ⠼
Deployment completed.
Deployed root stack ordermanagement [ ======================================== ] 5/5
        amplify-ordermanagement-dev-2… AWS::CloudFormation::Stack     UPDATE_COMPLETE            
        storageOrderManagementDynamoDB AWS::CloudFormation::Stack     UPDATE_COMPLETE            
        authordermanagement            AWS::CloudFormation::Stack     UPDATE_COMPLETE            
        functionOrderManagementApiLam… AWS::CloudFormation::Stack     UPDATE_COMPLETE            
        apiOrderManagementApi          AWS::CloudFormation::Stack     UPDATE_COMPLETE            
Deployed storage OrderManagementDynamoDB [ ======================================== ] 1/1
        DynamoDBTable                  AWS::DynamoDB::Table           UPDATE_COMPLETE
```

約18分待ちました。