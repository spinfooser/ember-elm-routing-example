# Intro
This is a proof of concept website for elm hash routing mixed with an existing ember single page application.

It shows a basic example of how to embed an Elm hash routing app into an ember app.

# Goals
The original goal was to show issues that were present in earlier versions of the router that still exist. We
would see that the router was still handling route change events in elm version 0.17. I was unsuccessful in proving
that this issue still exists.

This has disappeared with the changes made to elm-lang/navigation since the 0.18 elm release. Specifically using the
app update function instead of a separate urlUpdate function was the biggest change that I could see.

Every time elm processes a route in the update function, a debug log statement is made to track what is happening.
Elm navigation only processes routes when the elm app is embedded in an active div now. This is the behavior I would
expect.