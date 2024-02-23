# About dbml_cli
The **dbml_cli** is a tool for a quick and easy conversion from **dbml** to **sql** formats **(supported format: mysql & postgresql)**. For more information check the [official website](https://www.dbml.org/cli/)
## How to install dbml_cli
A **Node.JS** server is required for using the **dbml_cli**, therefore it can be installed with NPM or Yarn directly on your Linux host:
    
    # with npm
    npm install -g @dbml/cli
    
    # or with using yarn
    yarn global add @dbml/cli

Otherwise, it is also possible to use directly the **Node.JS** with pre-installed tools provided in the **dmbl_cli** folder

## How to use dbml_cli
The tool is very easy to use as shown in below. For more information, please refer to the [official website](https://www.dbml.org/cli/).

    $ dbml2sql <path-to-dbml-file>
            [--mysql|--postgres|--mssql]
            [-o|--out-file <output-filepath>]