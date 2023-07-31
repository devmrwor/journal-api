# API for Quote App

How to run: `rails s` - runs on port 3000
To run tests simply run `rspec`

# Endpoints

Built in Ruby on Rails, the app is a RESTful API only for a React client. The API endpoints are below:

### `GET /posts`

Returns a JSON array of all posts.

#### Parameters
None

#### Example Response

Sure! Here's the raw markdown for the Ruby on Rails controller actions documentation:

shell
Copy code
## Api::V1::PostsController

### `GET /posts`

Returns a JSON array of all posts.

#### Parameters
None

#### Example Response
```
[
  {
    "id": 1,
    "title": "Example Post 1",
    "content": "This is an example post.",
    "label": "idea",
    "created_at": "2023-07-31T12:34:56.789Z"
  },
  {
    "id": 2,
    "title": "Example Post 2",
    "content": "Another example post.",
    "label": "fun",
    "created_at": "2023-07-31T15:30:00.000Z"
  },
...
]
```

### `GET /posts?label=idea`

Returns a JSON array of posts with the specified label.

#### Parameters
- `label` (string): The label to filter posts by.

### `GET /posts/1`

Returns a JSON object representing the post with the specified ID.

#### Parameters
- `id` (integer): The ID of the post to retrieve.


### `GET /posts?date=2021-01-01`

Returns a JSON object representing the post created on the specified date.

#### Parameters
- `date` (string, format: "YYYY-MM-DD"): The date to filter posts by.


### `POST /posts`

Creates a new post with the specified parameters.

#### Parameters
- `post` (object): An object containing the post data.
  - `title` (string, required): The title of the post.
  - `content` (string, required): The content of the post.
  - `label` (string): The label of the post.
  - `created_at` (string, format: "YYYY-MM-DDTHH:mm:ss.SSSZ"): The creation date of the post.


### `PATCH/PUT /posts/1`

Updates the post with the specified ID using the provided parameters.

#### Parameters
- `id` (integer): The ID of the post to update.
- `post` (object): An object containing the updated post data.
  - `title` (string): The updated title of the post.
  - `content` (string): The updated content of the post.
  - `label` (string): The updated label of the post.
  - `created_at` (string, format: "YYYY-MM-DDTHH:mm:ss.SSSZ"): The updated creation date of the post.


### `DELETE /posts/1`

Deletes the post with the specified ID.

#### Parameters
- `id` (integer): The ID of the post to delete.

#### Example Response
Status: 204 No Content
