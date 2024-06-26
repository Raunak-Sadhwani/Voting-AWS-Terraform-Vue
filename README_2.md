<br/>

# voting Management System

###### Prof. Dr Thomas Fankhauser | Cloud Computing  | Hochshule Heilbronn 

---

<br />
<table>
    <tbody>
        <tr>
            <td>Students (ID)</td>
           <td>Aditya Gawade, Raunak Sadhwani </td> 
        </tr>
        <tr>
            <td>Semester</td>
            <td>Summer Semester 2024</td>
        </tr>
        <tr>
            <td>Repository</td>
            <td><a href="https://git.it.hs-heilbronn.de/it/courses/msem/cc2/ss24/group10</a>&nbsp;</td>
        </tr>
        <tr>
            <td>Course ID</td>
            <td>172369 </td>
        </tr>
        <tr>
            <td>Course Name </td>
            <td>Cloud Computing (SEM)</td>
        </tr>
    </tbody>
</table>

## Chapter 1 - Introduction

The project involves the development of voting Management System, serving as a centralized platform for efficient way to take voting which can help organisation to elect good candidate. This system facilitates the management of votes from employee of organisation.



Amazon Cognito Integration:
Amazon Cognito is integrated for robust identity management and user authentication.
In our project we used it for login to admin portal to check how many people voted till now. instead of using hosted ui provided by cognate we used tokens to atuhrize persons identity.



To provide a user-friendly interface, the frontend of the application was developed as a static website using vue and JavaScript. The frontend interacts with the backend through API endpoints to fetch a list of available voters table, voter_id, voter_name, voter_email.
.

The backend of the application is built as a serverless application using AWS Lambda and JS. The backend exposes Representational State Transfer (REST) API endpoints that handle requests from the frontend. The data is stored in DynamoDB, a cloud database service provided by AWS. The use of serverless architecture allows for automatic scaling based on demand, ensuring efficient resource allocation.

### 1.1 Application doing 
Our Application is an interface to store new employees details in the database and perform operations on that data. New employee can be added, View, Update and delete existing from the database. Only the Employee admin team can perform these operations. We also have an alert mechanism for Convicted employees and an Alert Email is sent to HR when a Convicted Employee is added to the database. 
Our website enables employees to cast votes for electing candidates to various organizational positions. Employees can visit the site to view candidate details, including manifestos, before casting their votes. After selecting a candidate, employees must enter their name, email, and voter ID provided by the organization. A "View Result" button allows employees to see the number of votes each candidate has received.

The backend of the application is built as a serverless application using AWS Lambda and JavaScript. It exposes Representational State Transfer (REST) API endpoints that handle requests from the frontend. Voting data is stored in DynamoDB, a cloud-based database service provided by AWS. The serverless architecture ensures automatic scaling based on demand, enabling efficient resource allocation.  The application also performs create operations for voters using the POST method, allowing new voters to be registered seamlessly. This approach ensures a secure, efficient, and transparent voting process, providing a user-friendly experience for all employees within the organization.

### 1.2 Functionality
The functionality of our application is as such:
Our project is exclusively accessible to admin teams, ensuring secure access and management. For authentication, we integrated AWS Cognito, allowing admins to log in via a Cognito user pool. Upon logging in, admins can fetch data from the company table, which contains details of candidates interested in positions such as CEO, President, Senior Manager, and Managing Director. Admins can add this data to DynamoDB.
Employees, who are the voters, can visit the website to vote for the candidate they believe is most suitable for a position. They need to enter their details, including name, email, and voter ID provided by the organization. The backend, built as a serverless application using AWS Lambda and JavaScript, handles data passed through REST API endpoints. The data is stored in DynamoDB. for viewing results, employees can click on the "View Result" button on the same portal to see the voting outcomes. This setup ensures a secure, efficient, and transparent voting process, providing a seamless experience for both admins and employees.

### 1.1 screenshots of the application:
Here are some screenshots of the frontend of the application which is available at 

Figure 1.1.1 Sign in page 
![](images/firstpage.jpeg)
Figure 1.1.2 - Please Signup 
![](images/unregisterusers.jpeg)
Figure 1.1.3 - SignUp Page
![](images/singup.jpeg)
Figure 1.1.4 - DashBoard
![](images/from.jpeg)
Figure 1.1.5 - Employee Data Table
![](images/table.jpeg)
Figure 1.1.5 - ReLogin Page
![](images/existinglogin.jpeg)

## Chapter 2 - Architecture 
**2.1 setup of architecture**
We planned our application requirements in a simple format and looked for suitable AWS services and structured the architecture

![](images/architecture.png)
Figure 2.1 - Architecture of Employee managemnt project


**2.2 AWS - Services Used**

The application uses the following AWS services:

1. **AWS Lambda:** Executing the backend JavaScript code responsible for handling REST API requests. It reads, writes and detlete data to the database. Lambda was chosen for its serverless nature, automatically scaling and eliminating the need for server management.
2. **DynamoDB**: A NoSql database, was used in storing and retrieving  data about employees details. DynamoDB was used because it provides table ,fast and predictable performance with seamless scalability. It is a managed NoSQL database which fits well with our serverless architecture.
3. **API Gateway**: For exposing the API endpoints and to interact with the lambda backend.
4. **Identity and Authorisation Management** **(IAM)**: IAM plays a crucial role in managing access control , policies and permissions for various AWS services, including DynamoDB. It ensures that only authorized entities have the necessary permissions to interact with specific resources.
5. **Simple Storage Service** (s3): Amazon CloudFront is employed as a content delivery network (CDN) to distribute static website content globally, enhancing performance, reliability, and security. S3 (the name is dynamically generated by concatenating the resource type ("aws_s3_bucket") with the random identifier from the ), in conjunction with CloudFront, offers a scalable and cost-effective solution for hosting and delivering static website content.
6. **Amazon Cognito** :  Integrated for identity management and user authentication. Cognito allows you to easily add user sign-up, sign-in, and access control to web and mobile apps.

The application scales out automatically as AWS lambda and dynamodb automatically scales out whenever we create more no. of employees. When employees are added, lambda handles the workload concurrently.

**2.4 Data Model**

The data model of the application includes entities such details. The data model is stored in DynamoDB and follows a NoSQL structure. The attributes of the Employee data is shown in Table 1.2

**Table 1.2 - Data model company Table**

company Table--


<table>
    <tbody>
        <tr>
            <td><strong>Attribute</strong></td>
            <td><strong>Data Type</strong></td>
        </tr>
        <tr>
            <td>company name</td>
            <td>String</td>
        </tr>
        <tr>
            <td>company descriptions</td>
            <td>string</td>
        </tr>
        <tr>
            <td>voting role</td>
            <td>string</td>
        </tr>
        <tr>
            <td>user name</td>
            <td>string</td>
        </tr>
        <tr>
            <td>user description</td>
            <td>String</td>
        </tr>
        <tr>
            <td>user manifesto</td>
            <td>String</td>
        </tr>
        <tr>
            <td>user votes</td>
            <td>Number</td>
        </tr>
       
    </tbody>
</table>


voters table

<table>
    <tbody>
        <tr>
            <td><strong>Attribute</strong></td>
            <td><strong>Data Type</strong></td>
        </tr>
        <tr>
            <td>voter_id</td>
            <td>String</td>
        </tr>
        <tr>
            <td>voter_name</td>
            <td>string</td>
        </tr>
        <tr>
            <td>voter_email</td>
            <td>string</td>
        </tr>
        <tr>
            <td>voted_for_id</td>
            <td>string</td>
        </tr>
       
    </tbody>
</table>

 **2.5 Application Programming Interface (API)**

The application exposes REST API endpoints to enable communication between the frontend and the backend. These endpoints handle requests for fetching company data , updating by id , deleting and creating new employee data. The communication between the frontend and the backend occurs over HTTP protocols.

The communication between the frontend and backend is facilitated by the API Gateway, which acts as a mediator for the requests and responses.

 Table 2.2 - Api endpoints exposed by api gateway

<table>
    <tbody>
        <tr>
            <td>Description</td>
            <td>HTTP Method</td>
            <td>Relative URL</td>
            <td>Request</td>
            <td>Sample Response</td>
        </tr>
        <tr>
            <td>Cast vote</td>
            <td>POST</td>
            <td>/VotingData</td>
            <td>Post operation</td>
            <td>Records inserted successfully!</td>
        </tr>
        <tr>
            <td>Retrieve a candidate data</td>
            <td>GET</td>
            <td>/CompanyData</td>
            <td>Get operation</td>
            <td>All Candidate data</td>
        </tr>
        <tr>
            <td>Voter details</td>
            <td>POST</td>
            <td>/VoterData/:id</td>
            <td>Post operation</td>
            <td>Data added successfully!</td>
        </tr>
    </tbody>
</table>
    **2.6 Communication between all components**
In this system, different AWS components work together to keep everything running smoothly. Users start by making requests through API Gateway, which sends these requests to JavaScript code running on AWS Lambda. This code then talks to DynamoDB, a NoSQL database, to store and get information about voters and candidates. IAM ensures that access to these services is secure. Amazon Cognito manages user login and identity, and AWS CloudFront helps deliver content quickly around the world and connects users to Cognito for authentication.

## Chapter 3 -  Tooling
**3.1 Working on the application**
### How does a developer work on your application 
- step 1: git clone 
- step 2: git pull
- step 3: If the access key and Security Key is not added in the git repo then developer should add these keys in main.tf.
- step 4: check the region, change accordingly to his current region. 
- step 5: terraform init 
- step 6: terraform plan 
- step 7: terraform apply --auto-approve
- step 8: terraform apply --auto-approve
- step 9: In terminal we will have domian endpoints Url then use the url to access our application

- We have added the comments to understand the code proccess in each files 
The development process of the application is facilitated by several tools and practices. The application was worked on in a local development environment in Visual Studio Code, a text editor. The following tools were installed in the local environment to enable testing parts of the application locally - 

-  **Command Line Interface for Amazon Web Services** (aws-cli) : for interacting with resources in the AWS account. An IAM user was created in the AWS portal and the access key id, secret access key and default aws region were stored in a file on disk located at  ~./aws/credentials
-  **Git** : a version control system was used to save code changes, fetch code from the remote repository and also send code (push) to the remote repository.

-  **JavaScript language** : was used in implementing the REST api endpoints and node_module installation is automated in code for macos and Ubuntu. 

**3.2 Docker** : 
The Docker image encapsulates the necessary dependencies and environment for executing Terraform scripts. It streamlines the CI/CD process and enhances the reliability of infrastructure deployment tasks.


**3.3 Deployment Process**
Code changes in the serverless Employee Management platform are deployed using GitLab's CI/CD pipelines. The deployment process involves the following steps:

1. **Version Control and Collaboration**: Developers work in feature branches in the Git repository and collaborate using GitLab's version control system. Branches are created for each new feature or bug fix.

2. **Continuous Integration/Continuous Deployment (CI/CD)**: The CI/CD pipeline is triggered automatically when changes are pushed to the repository. It performs automated builds, tests, and deployments.due to use of cloudfront sometimes it takes time to build.

3. **Test and Deploy**: During the pipeline, the code changes are built, tested, and packaged for deployment. 

**3.4 Automation**
-  **Terraform** : an Infrastructure as Code tool, was used for automated infrastructure provisioning and management, ensuring consistent and reproducible deployments. It was used to define the AWS resources required for the application, such as API Gateway, Lambda functions, DynamoDB, and IAM policies.
-  **lambda testing** Jest test enables GitLab CI/CD pipelines to automatically run tests whenever code changes are pushed to your repository.
- **CI/CD**: When code changes are deployed, GitLab CI/CD automatically applies the Terraform configuration, which creates, updates, or deletes the necessary AWS resources.

**3.5 Build pipeline**

![](images/deploy.jpeg)


## Chapter 4 - Lessons Learned
### 4.1 - Learnings

- We have embarked on a captivating journey into the realm of cloud platforms. The evolution from those stringent measures to the seamless access of easily scalable, robust hardware through minimal lines of declarative configuration or a few intuitive clicks on cloud platforms has been a revelation.
Amidst this exploration, We delved into various AWS services, acquiring practical skills in deploying static websites, defining REST APIs with a specific focus on user authentication using Cognito, optimizing content delivery through CloudFront, implementing Lambda functions, and mastering data interactions with DynamoDB for CRUD operations.
However, this journey wasn't without its challenges. Notably, we encountered a 403 Forbidden error during API testing, which required a nuanced approach in policy definition (as reflected in policy.tf). Additionally, grappling with CORS errors during URL automation and REST API deployment demanded innovative solutions, including a unique adjustment to the source_arn of aws_lambda_permission and the implementation of a dedicated CORS handling file in the project.
This journey has not only enriched our technical proficiency but has also provided valuable insights into troubleshooting and optimizing cloud-based infrastructures. We've accomplished the following activities:
* Deployed a static website.
* Defined a REST API 
* Cognito for user authentication.
* CloudFront for content delivery.
* Implemented Lambda functions.
* Interacted with DynamoDB for CRUD operations.
* Implemented SES for Email notifications

### 4.2 - Challenges Faced and Solutions (complicated)

### 4.2.1 - 403 Forbidden Error for API Testing

- Encountering a 403 Forbidden error during API testing led to the realization that additional policies needed to be defined. This was addressed by adding relevant policies in policy.tf.
## Referance <a href="https://medium.com/collaborne-engineering/403-cursed-by-cors-d1700cab754">https://medium.com/collaborne-engineering/403-cursed-by-cors-d1700cab754</a>


### 4.2.2 - CORS Error Resolution

- Issue Deploying the REST API
During frontend testing, a CORS error emerged due to insufficient knowledge about cross-functional errors. The issue was addressed by learning more about CORS and implementing a specific file to handle it.
## Referance <a href="https://docs.aws.amazon.com/apigateway/latest/developerguide/how-to-cors.html">https://docs.aws.amazon.com/apigateway/latest/developerguide/how-to-cors.html
</a>

### 4.2.3 - Fetching the API_URL With script 
- The api url was fetched from the html file using a json file. First we performed echo operation to save the api url in a json file(api_url.json). This echo operation is done in the output.tf file. The api_url is saved in the json file as a key-value pair and this file is created in the frontend folder. 
From the json file, we are fetching the url into the html file using fetch operation in  tag. We are reading the json file and saving the value of the api_url key into a variable “apiUrl”. This apiUrl is made to be globally accessible and is used in code for GET, POST and PUT operation. 
The url is saved to a variable when we run the terraform apply cmd once. 
In order to fetch the api url for performing operations from the frontend web page, we have to run terraform apply once again, i.e we run terraform apply twice overall. This is one of the challenge we faced and found that running the terraform apply cmd twice, can fetch us the required url to perform the operations from front end.

### 4.2.4 - Difficult to resolve
- The URL can be accessed successfully after the second Terraform apply operation.

### 4.2.5 - Gitlab access issue 
- Due some issues in the vactions we were not able to access gitlab so we were collabrating through personal accounts 

### 4.2.6- Passing the Key for SES trigger
- We faced a issue to trigger the SES from front end. We are using a checkbox to pass Yes or No value to Convicted parameter. But by default, the Checkbox inputs boolean values and it was passed as false and true. We solved this by changing the code to pass Yes when checkbox is ticked and No when it is unchecked in our html file. 
### 4.2.7 Have you been surprised by anything?
- we learnt about auto genrated id's so, it was new concept for us we implemented it in our code.for example 
The Terraform script dynamically generates names for the S3 bucket and Cognito User Pool resources using a random_id resource. The random_id generates a unique identifier, and this identifier is concatenated with resource types to create distinct and automatically generated names. This practice helps prevent naming conflicts and ensures uniqueness each time the Terraform configuration is applied.

## Referances
## 1 <a href="https://developer.hashicorp.com/terraform/tutorials/aws-get-started">https://developer.hashicorp.com/terraform/tutorials/aws-get-started 
</a>
<br>

## 2 <a href="https://medium.com/@thearaseng/build-s3-static-website-and-cloudfront-using-terraform-and-gitlab-888a8ec1d37d">https://medium.com/@thearaseng/build-s3-static-website-and-cloudfront-using-terraform-and-gitlab-888a8ec1d37d
</a>

## Chapter 5 - Conclusion

- In this course, we have learnt the basics of Cloud computing and building an serverless application using terraform. 
- We gained understanding on the communication between some AWS services and their implementation through terraform. 
- As a part of the course completion, we built a serverless application for "Employee Management Portal" using the basics of cloud. 



# Project Video
<video src="Report/video/Video/.mp4" controls title="Project Video"></video>







eyJraWQiOiJqWHRrV2V1aGdheHJHa09VeiswVmUxZHJGcXpaOVwvNzZneGdWQ1BZWGtLYz0iLCJhbGciOiJSUzI1NiJ9.eyJvcmlnaW5fanRpIjoiYjRiYjQxY2QtMzgyYi00YjljLTlkNDQtMjcwNzRhOTY5ODYyIiwic3ViIjoiYTQyODU0ODgtOTBjMS03MDczLWZjZmMtY2RhMGI0ZDU0NjMyIiwiYXVkIjoiNWl2bXVlMDFia3VyMmhvbzVsbTB0NnBhOG0iLCJldmVudF9pZCI6IjBkYThjNWNkLTQ1MmItNDhmNy1iNzBjLTY3ZjhhZDg2ZjU2OSIsInRva2VuX3VzZSI6ImlkIiwiYXV0aF90aW1lIjoxNzE5MTUyNjQ3LCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAudXMtZWFzdC0xLmFtYXpvbmF3cy5jb21cL3VzLWVhc3QtMV96NHVGbnNGOU4iLCJjb2duaXRvOnVzZXJuYW1lIjoidGVzdCIsImV4cCI6MTcxOTE1NjI0NywiaWF0IjoxNzE5MTUyNjQ3LCJqdGkiOiJiODMzMmRlZi1lOTdkLTRiYTktYmZmZC03YjdmOWEwYjRlMTgifQ.oBnsRvKrViT3eSuk2CTIpZMtZVzP5Uk0-TjlMweT1oPx3OGEMCIXlA_peVrKMomSCreKekGVHXEp7vFE_SmxEyDx-8Oj2WfcuRsm0H7MRZRTie7ytMOS55YjRo7rmiiFuNUwe2xll5r-P7w2LMy0gEJU0wg9VzkFloeENT_eJVIc4OP4Toe03xBegRb0CUvPra26kBLWmQMTIrJmhwyfvavzxghClFnnYCQGOZTvAPymOO5V1Qo3YVK-1ysWBl5Gnq3_GenztKftyYUiy-4N6VkS5F_FQdjjVvEBEpL3waJ1a-0