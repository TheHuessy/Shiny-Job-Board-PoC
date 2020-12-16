# Shiny-Job-Board-PoC
This is a super rough PoC to answer /u/oscarhrose's question about how to input and display user generated job postings.


## Other Things To Look At/Think About

You'll see that this looks ugly and is super clunky. This should be a jumping off point. Here are some resources you should explore to make the following types of changes:

### Connecting to a SQLdb
I have an example of a shiny app connecting to a locally hosted SQL server in my repo at https://github.com/TheHuessy/Viewer/blob/master/Viewer/server.R

In that example, I connect to a Postgres server using [RPostgreSQL](https://cran.r-project.org/web/packages/RPostgreSQL/RPostgreSQL.pdf), but there are other packages that better handle other kinds of SQL connections. 

### Stylizing
You can customize a CSS file that is then applied to the shiny app when it's deployed. [Here's](https://shiny.rstudio.com/articles/css.html) a good jumping off point, it just shows you how to point shiny to a css file you provide.

There are other options outside of CSS, especially in the world of dashboards. I have had a great time using [shinydashboard](https://rstudio.github.io/shinydashboard/) and [shinydashboardPlus](https://rinterface.github.io/shinydashboardPlus/) which offer a lot of JS wrappers that add tons of cool elements and whatnot to your app. Keep in mind that these additional packages can affect load times in the app.

It wouldn't be a shiny example without at least a shout out to [shinywidgets](http://shinyapps.dreamrs.fr/shinyWidgets/) which has a ton of cool widgets that you can easily add into your app to make it look less, well, like a shiny app.