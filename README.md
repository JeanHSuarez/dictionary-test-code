# dictionary-test-code

This app consumes the Oxford Dictionary API.
This app consumes the Oxford Dictionary REST API.This would allow users to lookup words and get its definition/s via https://developer.oxforddictionaries.com/documentation.

This app should include the following:

* Ability to enter a dictionary term, via form page
* Ability to retrieve the corresponding definition for the term entered
* Ability to maintain a list of the last 5 terms searched
* Ability to handle exception errors, gracefully
* Ability to log such exceptions to assist in troubleshooting

# About the Codes
I used a model for the terms recently searched to be able to persist the data. I could have used a particular session and retain the last five searches, however, sessions would make recent searches be bound to the user. It wasn't very clear in the requirement so I just picked one implementation over the other. I am not that familiar of rails so I didn't use a lot of rails helpers in the views. I just did enough to make it work cleanly. 

There is only one single generic message to handle all the error scenarios. So, to troubleshoot errors, please see the logs. (attached at the bottom via screenshot)

I created a service directory under app/ to have a home for the API client. This is the most complicated part of the project, it made sense to hide its implementation away from the rest of the app.

I didn't make any security considerations as it wasn't required -  if it was, I probably look at cleaning the input coming from the user to prevent SQL injections and XSS injections.

If I had more time, and testing was required, I would have make sure to cover the application with testing. 

I didn't have time to make the views pretty as well. I felt like it wasn't required to make it pretty as it seemed that the challenge more in the backend side.

# System Requirements
* ruby-2.7.0
* rails (6.0.3.4)
* sqlite3 (1.4.2)

# Running the app
```
rake db:create
rake db:migrate
OXFORD_DICTIONARY_APP_KEY=<INSERT APP_KEY HERE> OXFORD_DICTIONARY_APP_ID=<INSERT APP_ID HERE> rails s

```
# Screenshots

![Screenshot from 2020-10-24 01-34-51](https://user-images.githubusercontent.com/26676486/97069060-3ea44800-159b-11eb-88f0-4913f0d865cd.png)
![Screenshot from 2020-10-24 00-57-36](https://user-images.githubusercontent.com/26676486/97068989-a6a65e80-159a-11eb-9441-addc2d935117.png)
![Screenshot from 2020-10-24 00-58-19](https://user-images.githubusercontent.com/26676486/97069031-06046e80-159b-11eb-8ca2-5c4ac43ef829.png)
![Screenshot from 2020-10-24 00-58-26](https://user-images.githubusercontent.com/26676486/97069055-292f1e00-159b-11eb-9a26-6a772d15cade.png)


