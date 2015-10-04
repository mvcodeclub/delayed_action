# Delayed Action

If you are receiving lots of timeouts in your application because your sql queries run longer than your timeout settings, this is the gem for you.

A common scenario is running your app on Heroku, you may receive RackTimeout or Heroku H13 errors. 

Most existing solutions encourage you to package up your request as an ActiveJob or similar, and then do a bunch of boilerplate work to unwrap things and show your request.

Rather than tediously rewriting your controller method as a background job, just add this one statement and it will get packaged up as a background job and will run when it's completed.

This could also be helpful as a way of throttling requests to your server.  For example, if you have a query that is very db intensive, you can quickly turn on or off delayed_action on those requests. You could also send them to different queues based on priority of work etc.

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

## Status:
- Better "Refresh the page" UI needed.
- Conditional (`:if / :unless`) blocks would be nice to turn it on / off

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

# Milestones:
* Work with DelayedJob / Postgres
* Work with configurable to any queue or ActiveJob

# How to report bugs
Please use our github issues page to report bugs or feature requests
