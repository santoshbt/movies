# Movies

This project is buuit in Erlang/OTP 25 and Elixir 1.13.4.

The movies DB is searched using the API provided by https://developers.themoviedb.org/3

Users can Search, View details, Add to Watch Later and Remove from Watch later.
I have used Many to Many relationship. Because one user can add many movies to watch list
and one movie can belong to many users.
We donot have mavies locally and they are being accessed from remote API call.
To achieve this, we need both users and movies tables.

Hence, when user clicks on "Watch Later", I add the movie id into movies table.
It is inserted only if it does not exist already.
Once it is added to table, we can establish many-to-many relationship between both users and movies.

- Used "pow" library for user authentication and management.
- Added "watch_later" context to club all the related functionalities of movies.
- Added services to call Movie DB apis via HTTPoison.
- Separated search controller, because it can be extended to serve different entities later.
- Added /config/dev.exs to .gitignore for security purposes.

Thanks

