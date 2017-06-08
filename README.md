# VideoStoreAPI
This Video Store API implementation is based on the Video Store API project that you have previously completed.

## Functionality
This API comes pre-packaged with most of the functionality that you will require. The following endpoints are impemented, based off of the primary and optional requirements of the project.
- `GET /customers`  
List all customers
- `GET /movies`  
List all movies
- `GET /movies/:title`  
Look a movie up by `title`
- `POST /rentals/:title/check-out`  
Check out one of the movie's inventory to the customer. The rental's check-out date should be set to today.
- `POST /rentals/:title/check-in`  
Check in one of a customer's rentals
- `GET /rentals/overdue`  
List all customers with overdue movies


## New Functionality
- `GET /movies/search?query=`  
Search The Movies DB for movies matching the query

  Minimum fields to return:
  - `title`
  - `release_date`

## Other Notes
Note that this is functionality that was built into the original API
### Query Parameters
Any endpoint that returns a list should accept 3 _optional_ query parameters:

| Name   | Value   | Description
|--------|---------|------------
| `sort` | string  | Sort objects by this field
| `n`    | integer | Number of responses to return per page
| `p`    | integer | Page of responses to return

So, for an API endpoint like `GET /customers`, the following requests should be valid:
- `GET /customers`: All customers, sorted by ID
- `GET /customers?sort=name`: All customers, sorted by name
- `GET /customers?n=10&p=2`: Customers 10-19, sorted by ID
- `GET /customers?sort=name&n=10&p=2`: Customers 10-19, sorted by name

Things to note:
- Sorting by ID is the rails default
- Possible values for `sort` will be specified
- If the client requests both sorting and pagination, pagination should be relative to the sorted order
- Check out the [will_paginate gem](https://github.com/mislav/will_paginate)
