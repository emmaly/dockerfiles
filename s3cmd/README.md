# s3cmd

## Requirements

`AWS_ACCESS_KEY` and `AWS_SECRET_KEY` are required to be supplied as environment variables.  If not, it'll complain and bail.  Use your favorite manner to do make this happen.

An easy way to do this in pretty much any environment is the use of an `.env` file.
```sh
# ensure file .env contains appropriate values for AWS_ACCESS_KEY and AWS_SECRET_KEY.
$ cat .env
AWS_ACCESS_KEY=someaccessvalue
AWS_SECRET_KEY=somesecretvalue
```

But if you can use a secrets manager instead, please make use of that instead.

## Usage

```sh
$ docker <docker-args> emmaly/s3cmd <s3cmd-args>
```

Generally, it is recommended that you use `--rm` and `-it` as `docker-args` unless you know you want otherwise.

Anything you provide as `s3cmd-args` are simply whatever you would provide as arguments to `s3cmd` directly.  See also `--help` for more information on what `s3cmd` itself expects and supports.

Make sure in your `docker-args` that you're mapping a volume or otherwise attaching storage that supplies files to upload from, download to, or sync against, as appropriate.  The `-v` argument might be an easy answer for this, such as `-v $(pwd)/files:/workdir` and then refer to the `/workdir` path in the `s3cmd-args` as appropriate.

## workdir

The `WORKDIR` is `/workdir`, which in `Docker`-speak means that's the working directory your `s3cmd` will be sitting in when it runs.  So the path `.` is equivalent to `/workdir` at that point.  See the example in `put` below showing the `.` path in action for a recursive upload.

You should be mounting your paths to `/workdir` if you intend to use a recursive upload strategy.

## s3cmd help

To get help with `s3cmd`, as the `s3cmd-args`, just supply `--help`.

Or if you supply no `s3cmd-args`, `--help` is implied.

```sh
# this gives s3cmd help
$ docker --rm -it --env-file .env emmaly/s3cmd --help

# this gives s3cmd help, too
$ docker --rm -it --env-file .env emmaly/s3cmd
```

## `put` Verb

See the notes above about mounting storage and info about pathing.

```sh
# use the workdir path to your benefit for recursive uploads (it's empty by default!):
$ docker --rm -it --env-file .env -v $(pwd)/some_files_to_copy:/workdir emmaly/s3cmd put -r . s3://my-bucket-name/
```

See the note in `workdir` above about the relationship between `.` and `/workdir` _(TL;DR: they're the same thing)_.

## Anything else...

If you understand `s3cmd` and `docker`, you probably don't need any further help.  Just extrapolate the storage/volume mapping, pathing, and otherwise to suit your needs.

# License

See the [LICENSE](/LICENSE) file for details.

# Authors

* [emmaly](https://github.com/emmaly)
