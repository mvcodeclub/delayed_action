# Delayed Action
Add asynchronous queuing to your HTTP requests with one line, via a controller concern.  

# Who needs this
Many requests (reports, admin requests, data dumps,) often take longer than a typical HTTP timeout, and it is quite tedious to have to queue things up.    The code looks identical to a normal page request, the only difference is that it's expected to take a longer time to execute.  Right now, you are forced to package things up into ActiveJob or other queuing mechanisms manually, and there's lots of duplicated code.

It should be easy to switch between a queued request and a normal synchronous HTTP request.

Some Scenarios:
* You are receiving lots of timeouts in your application because your  queries run longer than your timeout settings, this is the gem for you.
* A common scenario is running your app on Heroku, you may receive RackTimeout or Heroku H13 errors. 
* You often send these requests via email to users, even though it's awkward and non-standard.  Users are generally fine to wait 30 seconds or even a few minutes, and it's easier to just keep the tab open in your browser than to have to check your email.

Most existing solutions encourage you to package up your request as an ActiveJob or similar, and then do a bunch of boilerplate work to unwrap things and show your request.  

Rather than tediously rewriting your controller method as a background job, just add this gem and one statement and it will get packaged up as a background job and will run when it's completed.

## Prerequisites
 * Rails 4
 * ActiveJob
 * A queue provider, such as DelayedJob or Resque
 
NOTE: This will not work and cause bad things to happen if you try to use the default inline ActiveJob provider

## How to use:

Add to your gemfile:
``` gem "delayed_action", github: "mvcodeclub/delayed_action" ```

Install the Migration
``` rake delayed_action::install::migrations ```

Run the migration
``` rake db:migrate ```

Add a delayed_action to your controller
```
class ArticlesController < ApplicationController
   include DelayedAction
   
   delayed_action [:show] # the show method will be queued
   
   def index
   
   end
   
   def show # use this as normal
   
   end
end

```

## Todo:
- Better "Refresh the page" UI needed.
- Conditional (`:if / :unless`) blocks would be nice to turn it on / off
- Expiration of requests
- Test under load

## Example:
```
class AccountController < ApplicationController

  delayed_action [:run_report]

  def run_report
    # this takes a long time and fails!
    @report = @account.run_really_long_report
  end

end
```

# How it works
DelayedAction intercepts calls to actions you specify.  If it finds one, it queues up a request to a job which will run the action on a job queue.  It then redirects to your page, with the UUID of the result.  

If it sees the UUID on the querystring, it loads the resulting HTML from the database.

It uses `app.get` to call your functions, and passes on most of the cookies and environment variables to the request so it can be authenticated.

# Gotchas
Don't use ActiveJob's default (ActiveJobInline) as this will probably cause a deadlock.  Queues need to run out of process.

All of your requests are stored in the DelayedActionResults table. This could get large, and there's no cleanup functionality currently.  You have to clean it up yourself

You need to think about security.  

# Features:
* Works with ActiveRecord
* Work with DelayedJob / Postgres
* Supports Rack::Timeout
* Work with configurable to any queue or ActiveJob
* Works with any mime-type

# How to report bugs
Please use our github issues page to report bugs or feature requests
