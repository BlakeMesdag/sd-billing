#### Description

This application is a simple invoicing app built on Rails 4.0.0 and Batman. It ties into Stripe.js and makes use of Sendgrid for email delivery.

#### Installation

Deployment to Heroku is simple, set the following environment variables to your own values (these aren't usable or advisable):

##### Stripe

[Signup for Stripe](https://stripe.com/). Your credentials are available at [manage.stripe.com](https://manage.stripe.com/) under ``` Your Account > Account Settings > API Keys```

heroku config:set STRIPE_SECRET_KEY="sk_1234567890987654321" STRIPE_PUBLISHABLE_KEY="pk_1234567890987654321"

##### Sendgrid

Install the sendgrid addon.

heroku config:set SENDGRID_DOMAIN="example.com"

##### Cookies

You'll want to set a secret key, otherwise each restart of the app will cycle your key.

heroku config:set SECRET_KEY_BASE="q1w2e3r4t5y6u7i8o9p0a1s2d3f4g5h6j7k8l9z1x2c3v4b5n6m7"

##### Google App Auth

By default auth for the base url is controller using the SENDGRID_DOMAIN environment variable, feel free to change this.