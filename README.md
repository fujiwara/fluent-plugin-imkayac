# Fluent::Plugin::Imkayac

Fluentd output plugin to im.kayac.com.

[im.kayac.com](http://im.kayac.com/) is a web service that provides some notification APIs.

## Installation

    $ gem install fluent-plugin-imkayac

## Configuration

Specify your username of im.kayac.com.

    <match app.error>
      type       imkayac
      username   USERNAME
      handler    http://example.com
    </match>

Using password authentication.

    <match app.error>
      type       imkayac
      username   USERNAME
      password   PASSWORD
    </match>

Using signing by secret key.

    <match app.error>
      type       imkayac
      username   USERNAME
      secret_key SECRET
    </match>

### See also

[API documentation](http://im.kayac.com/#docs)

## Copyright

* Copyright (c) 2012- FUJIWARA Shunichiro
* License: Apache License, Version 2.0
