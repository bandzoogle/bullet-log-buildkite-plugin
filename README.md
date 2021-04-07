# Bullet Log buildkite plugin

A [Buildkite plugin](https://buildkite.com/docs/agent/v3/plugins) that parses
bullet.log artifacts (generated across any number of parallel steps) and creates
a report from the data.

## Example

The following pipeline will run rspec jobs in parallel, and then process all
the resulting bullet log files to create a summary build annotation.

```yml
steps:
  - command: rspec
    parallelism: 50
    artifact_paths: log/bullet.log
  - wait: ~
    continue_on_failure: true
  - plugins:
      - bullet-report#v1.9.0:
          artifacts: log/bullet.log
```

## Configuration

### `artifacts` (required)

The artifact glob path to find the bullet log files.

Example: `log/bullet.log`


## Developing

To test the plugin hooks (in Bash) and the bullet log parser (in Ruby):

```bash
docker-compose run --rm plugin &&
docker-compose run --rm ruby
```

To test the Ruby parser locally:

```bash
cd ruby
rake
```

To test your plugin in your builds prior to opening a pull request, you can
refer to your fork and SHA from a branch in your `pipeline.yml`.

```
steps:
  - label: Annotate
    plugins:
      - YourGithubHandle/bullet-report#v1.2.3:
          ...
```

## License

MIT (see [LICENSE](LICENSE))
