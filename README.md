pip-tools-docker
================

[pip-tools](https://github.com/jazzband/pip-tools) Docker Image

Installation
------------

```console
curl -L# https://raw.githubusercontent.com/shakiyam/pip-tools-docker/master/pip-compile \
  | sudo tee /usr/local/bin/pip-compile >/dev/null
sudo chmod +x /usr/local/bin/pip-compile
```

Usage
-----

The pip-compile command lets you compile a requirements.txt file from your dependencies, specified in either setup.py or requirements.in.

```console
pip-compile
```

Author
------

[Shinichi Akiyama](https://github.com/shakiyam)

License
-------

[MIT License](https://opensource.org/licenses/MIT)
