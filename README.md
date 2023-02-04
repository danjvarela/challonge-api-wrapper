# Challonge API Wrapper

## Introduction
This is an API wrapper for https://api.challonge.com/ I created using Ruby on Rails to study creating API's.

## Development
To run this project locally, you must first create an account an get an API key on https://challonge.com/

1. Clone this repo locally and inside the project root directory, run:
    ```
    bundle install
    ```
    to install the dependencies.

2. Create a `.env` file inside the root folder and put the following:
  
    ```
    CHALLONGE_API_KEY=<YOUR API KEY>
    ```

3. To start a local server, run:
    ```
    rails server
    ```
4. You can also run the tests using
    ```
    rake
    ```
## Documentation
You can check out [Challonge's API Documentation](https://api.challonge.com/v1) for more details about the API. This project only covers 4 of those as mentioned in the next part.

### Limitations
This only covers 4 endpoints:
```bash
# get all tournaments
GET http://localhost:<PORT>/v1/tournaments
 
# get details about a  tournament
GET http://localhost:<PORT>/v1/tournaments/{tournament}

# create a tournament
POST http://localhost:<PORT>/v1/tournaments

# update a tournament
PUT/PATCH http://localhost:<PORT>/v1/tournaments/{tournament}

# delete a tournament
DELETE http://localhost:<PORT>/v1/tournaments/{tournament}
```

#### `GET http://localhost:<PORT>/v1/tournaments`
Check out https://api.challonge.com/v1/documents/tournaments/index for more details.

Sample requests:
```bash
# get all tournaments
curl --location --request GET 'http://localhost:3000/v1/tournaments'

# get all pending tournaments 
curl --location --request GET 'http://localhost:3000/v1/tournaments?state=pending'

# get all double_elimination type tournaments
curl --location --request GET 'http://localhost:3000/v1/tournaments?type=double_elimination'
```

#### `GET http://localhost:<PORT>/v1/tournaments/{tournament}`
Check out https://api.challonge.com/v1/documents/tournaments/show for more details.

Sample requests:
```bash
# get tournament details for tournament id 12505116
curl --location --request GET 'http://localhost:3000/v1/tournaments/12505116'

# include the tournament participants
curl --location --request GET 'http://localhost:3000/v1/tournaments/12505116?include_participants=1'
```

#### `POST http://localhost:<PORT>/v1/tournaments`

Check out https://api.challonge.com/v1/documents/tournaments/create for more details.

Sample requests:
```bash
# create a tournament with a name `Hello Tournament`
curl --location -g --request POST 'http://localhost:3000/v1/tournaments?tournament[name]=Hello Tournament' \
--header 'Accept: application/json'

# You can also skip the `tournament` key on the parameters
curl --location --request POST 'http://localhost:3000/v1/tournaments?name=Hello Tournament' \
--header 'Accept: application/json'
```

#### `PUT/PATCH http://localhost:<PORT>/v1/tournaments/{tournament}`

Check out https://api.challonge.com/v1/documents/tournaments/update for more details.

Sample requests:
```bash
# Update the name of tournament with id 12505116 to `New Tournament Name`
curl --location -g --request PUT 'http://localhost:3000/v1/tournaments/12505116?tournament[name]=New Tournament Name'

# You can skip the `tournament` key on the parameters
curl --location -g --request PUT 'http://localhost:3000/v1/tournaments/12505116?name=New Tournament Name'
```

#### `DELETE http://localhost:<PORT>/v1/tournaments/{tournament}`

Check out https://api.challonge.com/v1/documents/tournaments/destroy for more details.

Sample requests:
```bash
# delete the tournament with id 12505116
curl --location --request DELETE 'http://localhost:3000/v1/tournaments/12505116'
```
