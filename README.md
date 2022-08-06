# fivem-lua-lint-action

This GitHub Action runs `luacheck` on your Lua codebase against known FiveM natives for any GitHub repository!

> Now supports FiveM Lua backtick syntax.

---

## Using

To use this in your GitHub repository, create the following file:

> **.github/workflows/lint.yml**

```yml
name: Lint
on: [push, pull_request]
jobs:
  lint:
    name: Lint Resource
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Lint
        uses: iLLeniumStudios/fivem-lua-lint-action@v2
```

This will automatically run `luacheck` for both commits and pull requests!

---

## JUnit Reporting (Getting Fancy)

If you would like to display fancy results in the GitHub action job, you can try the following configuration,
which outputs a JUnit results file:

![Fancy JUnit Reporting in GitHub Actions Example](.github/docs/fancy_example.png)

> **.github/workflows/lint.yml**

```yml
name: Lint
on: [push, pull_request]
jobs:
  lint:
    name: Lint Resource
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Lint
        uses: iLLeniumStudios/fivem-lua-lint-action@v2
        with:
          capture: "junit.xml"
          args: "-t --formatter JUnit"
      - name: Generate Lint Report
        if: always()
        uses: mikepenz/action-junit-report@v3
        with:
          report_paths: "**/junit.xml"
          check_name: Linting Report
          fail_on_failure: false

```

## Extra Libs

Following extra libs are supported by the linter natively:

| Lib          | Description                                                                          |
|--------------|--------------------------------------------------------------------------------------|
| mysql        | Globals for oxmysql library (https://github.com/overextended/oxmysql)                |
| menuv        | Globals for menuv (https://github.com/ThymonA/menuv)                                |
| polyzone     | Globals for polyzone (https://github.com/mkafrin/PolyZone)                           |
| qblocales    | Globals for qb-core locales system (https://github.com/qbcore-framework/qb-core)     |
| qbgarages    | Globals for qb-garages config (https://github.com/qbcore-framework/qb-garages)       |
| qbapartments | Globals for qb-apartments config (https://github.com/qbcore-framework/qb-apartments) |

In case you're using any of these as a dependency to your resource, you will need to add them to the lint action using the argument `extra_libs`.
For example if you're using polyzone and oxmysql in your resource, this is how your action would look like:

```yaml
name: Lint
on: [push, pull_request]
jobs:
  lint:
    name: Lint Resource
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Lint
        uses: iLLeniumStudios/fivem-lua-lint-action@v2
        with:
          capture: "junit.xml"
          args: "-t --formatter JUnit"
          extra_libs: mysql+polyzone
      - name: Generate Lint Report
        if: always()
        uses: mikepenz/action-junit-report@v3
        with:
          report_paths: "**/junit.xml"
          check_name: Linting Report
          fail_on_failure: false
```

**Note:** If there are multiple extra libs that you need to specify, join them using the `+` sign as shown in the above example
