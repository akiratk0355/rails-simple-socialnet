# Practice of Information Systems (2017)  <br> Web Information System Design 

<p style="text-align: right;">
2017/06/29
<br>
Okamoto Lab. Information Security Adjunct Unit
<br>
Akira Takahashi (takahashi.akira.58s@st.kyoto-u.ac.jp)
<br>
6930-29-4069
</p>

----
## Overview
### What is this?
- The repository is dedicated for "Practice of Information Systems" course at the Kyoto University.
- We are supposed to design and implement a basic Web app with Ruby on Rails. I created a simple social networking
- Based on the official [Getting Started with Rails guide](http://edgeguides.rubyonrails.org/getting_started.html), but many additional features are implemented, e.g., association between user and articles/comments, proper authentication and session management with [Devise](https://github.com/plataformatec/devise), resource control with [CanCanCan](https://github.com/CanCanCommunity/cancancan), etc.

### Basic features
- sign up & sign in with E-mail address and password
- user can search articles by title or text
- user can publish & manage article (i.e., _CRUD_ )
- user can mark their articles as either "published" or "unpublished"
- user can read other user's published article (i.e., _R_ )
- user can read & create comments on other user's published articles (i.e., _CR_ )
- user can delete their comments and comments on their own article (i.e., _D_ )
- display the total number of articles and "published today" articles which are visible to the current user
- special user role, `admin`, can manage any resource
- deployable to Heroku

### Limitations
Unlike common social networking websites, this app does not support following features:
- E-mail confirmation in sign up flow
- password reset request
- decent UI

### Database
The database consists of 3 tables: `users`, `articles`, `comments`. 

### Dependencies
- Should run in Ubuntu Xenial
- Ruby (2.2.6), Rails (4.2), devise, cancancan, figaro

### Build
- Run `make` in the project root

### Deploy
- `master` branch automatically gets deployed to Heroku 

### Demo
- Demo app is available [here](https://shrouded-stream-48188.herokuapp.comhttps://shrouded-stream-48188.herokuapp.com)





## Use case
- TBD

## Special notes
- TBD

## Wrap-up
- TBD