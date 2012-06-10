# Fluent::Plugin::Imkayac

Fluentd output plugin to im.kayac.com.

[im.kayac.com](http://im.kayac.com/) is a web service that provides some notification APIs.

## Installation

    $ gem install fluent-plugin-imkayac

## Configuration

Specify your `username` of im.kayac.com.

    <match app.error>
      type       imkayac
      username   USERNAME
    </match>

Using password authentication.

    <match app.error>
      type       imkayac
      username   USERNAME
      password   PASSWORD
    </match>

Using secret authentication.

    <match app.error>
      type       imkayac
      username   USERNAME
      secret_key SECRET
    </match>

* `handler`: custom url scheme for iPhone application.

    <match app.error>
      type        imkayac
      username    USERNAME
      handler     mailto:foo@example.com
    </match>

### See also

[im.kayac.com API documentation](http://im.kayac.com/#docs)

## Copyright

* Copyright (c) 2012- FUJIWARA Shunichiro
* License: Apache License, Version 2.0
