### Hello this is a bot

#### Configuration

* Rename `sample.config.yml` to `config.yml`
* Open it and fill it with your credentials
* [Create firefox profile](#create_ff_profile)
* Check if `at` [is available](#check_at)

#### Run it

```shell
./bin/cli default_loop --env=production
```

#### <a name="create_ff_profile"></a> Create firefox profile

__OSX__

```shell
/Applications/Firefox.app/Contents/MacOS/firefox-bin -p
```

#### <a name="check_at"></a> Check at command

__OSX__

On OSX you have to turn on the at command :

```shell
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.atrun.plist
```