#Openwhisk Package Template
==========================
[![Build Status](https://travis-ci.org/openwhisk/openwhisk-package-template.svg?branch=master)](https://travis-ci.org/openwhisk/openwhisk-package-template)
This package is a template for Openwhisk Packages, it can be used to build, test and integrate new packages.

```
openwhisk-package-template/
├── actions
│   └── hello_world.js
├── CONTRIBUTING.md
├── feeds
│      └── ...
├── install.sh
├── LICENSE.txt
├── README.md
├── tests
│   ├── credentials.json
│   ├── credentials.json.enc
│   └── src
│      └── TemplateTests.scala
├── tools
│   └── travis
│       └── build.sh
├── TriggerProvider
│      └── ...
└── uninstall.sh
```

##How to install and uninstall this package ?
Install the package using `./install.sh  $EDGE_HOST $AUTH_KEY $WSK_CLI`
where :
- **$EDGE_HOST** is where openwhisk is deployed
- **$AUTH_KEY** is the authentication key
- **$WSK_CLI** is the path of Openwhisk command interface binary

This will create a new package called **packageTemplate** as well as a hello world action.

To uninstall the package, please use `./uninstall.sh  $EDGE_HOST $AUTH_KEY $WSK_CLI` 

##Testing
You can test your package using the test cases you provided within tests/src, it is highly recommended to use Scala in writing test cases. To execute the test cases locally ( local deployment of Openwhisk), please copy your test files into `openwhisk/tests/src/packages` and then by using gradle within Openwhisk `gradle :tests:test` this will execute all test files of openwhisk, to execute a specific test class you can use `gradle :tests:test --tests "packages.CLASS_NAME`

**credentials**: You may need credentials during testing, you can put whatever credentials you need in `tests/credentials.json` (use `tests/template_ceredentials.json` as an example). In case of travis deployment for continuous integration, you can encrypt credentials.json file by using [travis CLI](https://docs.travis-ci.com/user/encrypting-files/).

**Caution:** Do not forget to include tests/credentials.json in .gitignore.

##Package contents
| Entity | Type | Parameters | Description |
| --- | --- | --- | --- |
| `/namespace/packageTemplate` | package | - | Openwhisk Package Template |
| `/namespace/packageTemplate/helloWorld` | action | [details](#hello-world) | A simple hello world action |

###Feeds
List here Feed actions ...

###Actions
####Hello World
This action is a simple hello world,  
######Parameters
| **Parameter** | **Type** | **Required** | **Description**| **Options** | **Default** | **Example** |
| ------------- | ---- | -------- | ------------ | ------- | ------- |------- |
| name | *string* | no |  A name to greet | - | - | "Openwhisk" |

######Usage
To use this action, you need to pass the required parameters (refer to the table above)
```bash
wsk action invoke /namespace/packageTemplate/helloWorld -p name 'Openwhisk' --blocking
```

Output:
```javascript
{
  "message": "Hello, Openwhisk!"
}
```

## Contributing
Please refer to [CONTRIBUTING.md](CONTRIBUTING.md)

## License
Copyright 2015-2016 IBM Corporation

Licensed under the [Apache License, Version 2.0 (the "License")](http://www.apache.org/licenses/LICENSE-2.0.html).

Unless required by applicable law or agreed to in writing, software distributed under the license is distributed on an "as is" basis, without warranties or conditions of any kind, either express or implied. See the license for the specific language governing permissions and limitations under the license.
