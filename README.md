# HumbleShame
(aka the Humblebrag Wall of Shame)

### The goal
Write an iOS app that retrieves the 100 most recent people who have been singled out on the Twitter "Humblebrag" feed, and displays all of their profile photos in a long scrolling list.

### Details
* You'll probably want to use the Twitter API to retrieve the raw
data; see `https://api.twitter.com/1/statuses/retweeted_by_user.json?screen_name=humblebrag&count=10&include_entities=true`
for an example.
* Images should be scaled up to fill the width of the device. Yes,
this does mean they'll be very granulated.

### Bonus points:
* Include the offending Tweet above each picture
* When the user scrolls to the bottom of the list, automatically fetch
the next-most-recent set of 50 tweets

### My notes
They didn’t mention making it a universal app. I’m making it a universal app. Deal.
