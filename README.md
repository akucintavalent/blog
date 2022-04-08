# Blog app

The Blog app will be a classic example of a blog website. You will create a fully functional website that will show the list of posts and empower readers to interact with them by adding comments and liking posts.

## Getting Started

To get a local copy up and running follow these simple example steps.

### Prerequisites

```
Ruby
rails version 7.x gem package
```

### Setup

Open terminal and go to the folder you want to store the repo in:

```
# For example
cd Documents
```

Clone the repo and move to the folder with the repo:

```
git clone git@github.com:akucintavalent/blog.git
cd blog
```

### Run Program

First, you need to install the required gems:

```
bundle install
```

Then you need to create a database:

```
rails db:create
```

Then you need to run migrations:

```
rails db:migrate
```

In order to start and checkout the app you should run in your terminal:

```
rails s
```

Then open http://localhost:3000 in the browser.

### API documentation

## **Endpoints**

**/api/posts**

Allowed actions:

- GET all posts of the user

Mandatory parameters for GET action:

- user_id: id of the user

Parameters example for GET action (sent in the body of the request in JSON format):
  
```
{ 
	"user_id": 1 
}
```

Return value: posts, Example Response:

```
[
  {
    "id": 9,
    "title": "my title",
    "text": "text",
    "comments_counter": 1,
    "likes_counter": 2,
    "created_at": "2022-04-06T10:25:48.933Z",
    "updated_at": "2022-04-06T10:25:48.933Z",
    "author_id": 7
  },
  {
    "id": 10,
    "title": "tite",
    "text": "text2",
    "comments_counter": 0,
    "likes_counter": 2,
    "created_at": "2022-04-06T10:25:59.684Z",
    "updated_at": "2022-04-06T10:25:59.684Z",
    "author_id": 7
  }
]
```

**/api/login**

Allowed actions:

- POST logins the user

Mandatory parameters for POST action:

- email: email of the user
- password: password of the user

Parameters example for POST action (sent in the body of the request in JSON format):

```
{ 
	"email": "test@example.com",
  "password": "password" 
}
```

Example Response:

```
{
  "token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo3LCJleHAiOjE2NTAwNDY4ODR9.yKAPdF-5gZpiyqEfVk0YU05Q6hqLKCQnb1qBQxs7Xcs"
}
```

Token should be passed in the Headers with the Authorization key

**/api/comments**

Allowed actions:

- POST adds a new comment

Mandatory parameters for POST action:

- post_id: id of the post the user comments to
- text: your comment text

Parameters example for POST action (sent in the body of the request in JSON format):

```
{ 
	"post_id:": 1,
  "text": "my first comment" 
}
```
Example Response :

``` 
{
  "id": 8,
  "text": "my first comment",
  "created_at": "2022-04-08T18:50:03.699Z",
  "updated_at": "2022-04-08T18:50:03.699Z",
  "post_id": 9,
  "author_id": 7
}
```

**/api/comments**

Allowed actions:

- GET gets all the comments

Mandatory parameters for POST action:

- post_id: id of the post the user comments to
- user_id: id of the user

Parameters example for GET action (sent in the body of the request in JSON format):

```
{ 
	"post_id:": 1,
  "user_id": 2 
}
```
Example Response :

``` 
[
  {
    "id": 7,
    "text": "my first comment",
    "created_at": "2022-04-08T18:23:16.223Z",
    "updated_at": "2022-04-08T18:23:16.223Z",
    "post_id": 9,
    "author_id": 7
  },
  {
    "id": 8,
    "text": "my first comment",
    "created_at": "2022-04-08T18:50:03.699Z",
    "updated_at": "2022-04-08T18:50:03.699Z",
    "post_id": 9,
    "author_id": 7
  }
]
```

## Tests
To run all test on this repository run the command `bundle exec rspec`

### To track linter errors locally follow these steps:  

Track linter errors run:
```
rubocop
```

### Video Demonstration

[Here](https://youtu.be/ASm7hJsg7CA) is a quick video demonstration showing how to clone, set up, run, and use this web application.

## Views of the Web Application

![image](https://user-images.githubusercontent.com/87897753/162081150-ab629a11-262e-4af7-b875-40e80bbad5d3.png)

![image](https://user-images.githubusercontent.com/87897753/162080806-6791d66e-51ac-4318-9f9f-048eaba48c82.png)

![image](https://user-images.githubusercontent.com/87897753/162080365-f69a96aa-32ee-425b-999b-479fbf7d9106.png)

![image](https://user-images.githubusercontent.com/87897753/162080461-15cc71af-e8a0-4133-8e2d-ffba049eb438.png)

![image](https://user-images.githubusercontent.com/87897753/162080502-fd4d9844-4984-452c-9145-0d3ed06fb8da.png)

![image](https://user-images.githubusercontent.com/87897753/162080554-9d4fccb8-fe28-4f39-9ad7-1dd090f3ca1a.png)


## Authors

:man: **Bohdan Shcherbak**

- [GitHub](https://github.com/akucintavalent)
- [Twitter](https://twitter.com/ibodi828)
- [LinkedIn](https://www.linkedin.com/in/bohdan-shcherbak/)


:woman: **Meri Gogichashvili**

- [GitHub](https://github.com/Meri-MG)
- [LinkedIn](https://www.linkedin.com/in/meri-gogichashvili/)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](https://github.com/AmaduKamara/ruby-enumerabble/issues).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- Hat tip to anyone whose code was used
- Inspiration
- etc

## 📝 License

This project is [MIT](./MIT.md) licensed.
