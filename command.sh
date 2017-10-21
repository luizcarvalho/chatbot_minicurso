curl -X POST -H "Content-Type: application/json" -d '{
  "recipient": {
    "id": "1389611254450074"
  },
  "message": {
    "text": "hello, world!"
  }
}' "https://graph.facebook.com/v2.6/me/messages?access_token=EAAFPeoB7myEBAEv0oorx2rt1oyfRhvssIdPPF7qFICAWHVIYVdu9UUZAikoegokhmyZBsL1rM6urv6gwnYJ1R0rAZCn180sDYdvRUNEtuquGqjUxs6SgMDgzfjyM9otpWHkffGHhrqsrT9ZB0njfp5ZBc22OykIZA0UWTuZBYHmjgZDZD"