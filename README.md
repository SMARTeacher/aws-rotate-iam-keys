# aws-rotate-iam-keys
Rotate your IAM Keys to be in compliance with security best practices with this script. 
A copy of this is also on the ServiceDesk knowlege base: [Link}(https://prodigygame.atlassian.net/wiki/spaces/DSD/pages/628097181/How+to+rotate+your+AWS+Credentials_

## Installation
AWS Rotate IAM Keys is supported on MacOS


### MacOS

```
brew tap SMARTeacher/aws-rotate-iam-keys https://github.com/SMARTeacher/aws-rotate-iam-keys
brew install aws-rotate-iam-keys
```
Requires [Homebrew](https://brew.sh/) to install. I am hoping to be included in Homebrew Core soon!

***IMPORTANT:*** You must install your own cron job for automated key rotation. [Instructions here](https://github.com/rhyeal/aws-rotate-iam-keys#macos-1) or scroll down to `Additional Cron Instructions` below.


## Features

AWS Rotate IAM Keys is simple and powerful. There aren't too many features other than rotating keys for a single profile or multiple profiles. The power comes from multiple cron jobs daily that can rotate multiple sets of keys automatically.

### Improvements / Issues

* Currently, AWS Rotate IAM Keys will only work with a single computer. Rotating keys on a desktop and a laptop for the same IAM user will lead to invalid keys.
* AWS Rotate IAM Keys takes an opinionated view that you should only have 1 active key at a time. It might not work with IAM users that have 2 keys active at a time.

## Documentation

#### To rotate your default profile manually:

```
$ aws-rotate-iam-keys
Making new access key
Updating profile: default
Made new key AKIAIOSFODNN7EXAMPLE
Key rotated
```

#### To rotate a specific profile in your `~/.aws/credentials` file:

```
$ aws-rotate-iam-keys --profile myProfile
$ aws-rotate-iam-keys -p myProfile
```

#### To rotate multiple profiles *with the same key*:

```
$ aws-rotate-iam-keys --profiles myProfile,myOtherProfile
```

The result of the above script is that both `myProfile` and `myOtherProfile` will have the **same access and secret keys** in your `~/.aws/credentials` file.

#### To rotate multiple profiles *with their own keys*:

```
$ aws-rotate-iam-keys --profile myProfile
$ aws-rotate-iam-keys --profile myOtherProfile
```

The result of the above script is that `myProfile` and `myOtherProfile` will have **different** access and secret keys in your `~/.aws/credentials` file.

## Additional Cron Instructions
For some operating systems, you need to install your own cron schedule. This is
due to the fact that some operating systems do not allow installed programs
via the package managers selected to create their own cron schedules.

### MacOS

MacOS does not allow programs to modify the crontab when installing via Homebrew. Unfortunately, this means that MacOS users will need to manually finish installation to automate AWS Rotate IAM Keys. Here's how to do that:

#### Using a cron job (easiest)

Open your crontab by typing:

```
EDITOR=nano crontab -e
```

Copy and paste the following line into the end of the crontab file:

```
33 4 * * * /usr/local/bin/aws-rotate-iam-keys --profile default >/dev/null 2>&1 #rotate AWS keys daily
```

Save your crontab with `Ctrl` + `O` and then press `[Enter]`. Exit and apply changes with `Ctrl` + `X`. That's it!

#### Using launchd (MacOS recommended)

[Launchd](http://www.launchd.info/) is the MacOS replacement for cron.

Open a Terminal and cd into the Launch Agents directory. Make the plist file and open your text editor.

```
cd ~/Library/LaunchAgents
touch com.aws.rotate.iam.keys.plist
nano com.aws.rotate.iam.keys.plist
```

Copy and paste the following into your text editor:

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>EnvironmentVariables</key>
	<dict>
		<key>PATH</key>
		<string>/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin</string>
	</dict>
	<key>Label</key>
	<string>com.aws.rotate.iam.keys</string>
	<key>ProgramArguments</key>
	<array>
		<string>/usr/local/bin/aws-rotate-iam-keys</string>
		<string>--profile</string>
		<string>default</string>
	</array>
	<key>StartCalendarInterval</key>
	<dict>
		<key>Hour</key>
		<integer>3</integer>
		<key>Minute</key>
		<integer>23</integer>
	</dict>
</dict>
</plist>

```

Save the file with `Ctrl` + `O` and then press `[Enter]`. Exit with `Ctrl` + `X`.

Load up the launchd job with
```
launchctl load -F ~/Library/LaunchAgents/com.aws.rotate.iam.keys.plist
```

You can check that everything worked by running:
```
launchctl start com.aws.rotate.iam.keys
```

That's it. Now your keys will be rotated every day for you.

### MacOS

Homebrew gets the release zip of the entire repo: `SHA256 bff7a999f402db12114fae91d46455e5f36b9559fd4a07caad09c5f42a99b8d6`

