#!/usr/local/bin/python3

import twint

# get the followers first
c = twint.Config()

c.Store_object = True
c.Username = "target"
c.Search = "\"instagram.com\" "\"instagr.am\" "\"instagr.com\""	# search links to instagram
# c.Search = "\"facebook.com\" \"fb.me\" \"on.fb.me\""	# search links to facebook
# c.Search = "\"youtube.com\" \"youtu.be\""	# search links to youtube
# c.Search = "\"google.com\" \"goo.gl\""	# search links to google
# c.Search = "\"linkedin.com\" \"lnkd.in\""	# search links to linkedin
# Use Cases:
# "instagram.com" = the tweet must contain this word
# Or add other keywords to scrape one search
# c.Search = "\"instagram.com\" \"fb.me\"", returns twits containing links to at least one listed domain

twint.run.Search(c)

# analyze data contents
tweets = twint.output.tweets_object

links = []

for tweet in tweets:
    text = tweet.text.split(' ')
    for t in text:
        if t.startswith('instagram.com'):
            links.append(t)

ig_users = {}
for l in links:
    l = l.replace('instagram.com/', '') # clean up the data
    l = l.split('?')[0] # remove tracking codes, e.g. ?igshid=xd1dx9s33funk
    slashes = len(l.split('/'))
    user = l.split('/')[0]
    try:
        ig_users[user] += 1
    except KeyError:
        ig_users[user] = 1

# show top 5 users
import operator

i = 0
sorted_users = dict(sorted(ig_users.items(), key=operator.itemgetter(1), reverse=True))

for s_user in sorted_users:
    if i == 4:
        break
    print('User: {} | Rank: {}'.format(s_user, sorted_users[s_user]))
    i += 1