# OpenGrok packaged as a snap for Ubuntu core. It consists of:
- OpenGrok runtime
- OpenGrok tools
- Tomcat
- Helper tools to manage index
- runtime dependencies:
  - java openJDK runtime
  - universal ctags
  - Tomcat native bindigs
  - git. bazaar, mercirial,...

## Suported snap applications:
- #### opengrok.add-project  
	Helper to add new prokect to the index. First project is added using projadm, then indexed with indexer and finally index config is replaced with new one and webapp is redeployed

- #### opengrok.config-merge  
	Invocation of `opengrok-tools/bin/opengrok-config-merge`. For detailed help run: `opengrok.config-merge --help`

- #### opengrok.deploy  
  	Invocation of `opengrok-tools/bin/opengrok-deploy`.	For detailed help run: `opengrok.deploy --help`

- #### opengrok.groups  
	Invocation of `opengrok-tools/bin/opengrok-groups`. For detailed help run: `opengrok.groups --help`

- #### opengrok.help  
	Help info and current snap config informations.
	

- #### opengrok.index-all  
	Helper to index all the project in src root directory. Internally `opengrok.indexer` is used with appropriatery parameters

- #### opengrok.indexer  
	Invocation of `opengrok-tools/bin/opengrok-indexer`. For detailed help run: `opengrok.indexer --help`

- #### opengrok.java  
	Invocation of `opengrok-tools/bin/opengrok-java`. For detailed help run: `opengrok.java --help`

- #### opengrok.mirror  
	Invocation of `opengrok-tools/bin/opengrok-mirror`. For detailed help run: `opengrok.mirror --help`

- #### opengrok.projadm  
	Invocation of `opengrok-tools/bin/opengrok-projadm`. For detailed help run: `opengrok.projadm --help`

- #### opengrok.reindex-project  
	Invocation of `opengrok-tools/bin/opengrok-reindex-project`. For detailed help run: `opengrok.reindex-project --help`

- #### opengrok.sync  
	Invocation of `opengrok-tools/bin/opengrok-sync`. For detailed help run: `opengrok.sync --help`

- #### opengrok.import-dpkg-list  
	Helper to import source definition from `dpkg.list`.  
	For detailed help run: `opengrok.import-dpkg-list --help`.  
	Use: `$ cat /snap/core20/current/usr/share/snappy/dpkg.list | sudo opengrok.import-dpkg-list <project name> <Ubuntu series> [list of source packages to ignore]`

- #### opengrok.update-source  
	Helper script to invoke update source helper.  <br><br>
	There is default src-updater script wich takes input snap config.  
	See configured sources with `$ snap get -d opengrok sources`.  <br><br>
	***Warning***: `/var/snap/opengrok/common/source.conf` config file has been deprecated and existing content from `/var/snap/opengrok/common/source.conf` has been imported into snap config.  <br><br>
	Custom source updater can be provided using 'src-updater' content interface'.  
	Example of custom source updater is here: https://github.com/kubiko/opengrok-src-updater.


## Suported snap settings keys:
OpenGrok supports settings keys. Vvalues can be changed by calling:  
`$ snap set opengrok <key name>='<key value>'`  
List of supported keys:
- ### java:  
	- #### java.extra-opt:  
		Additional JVM options.  
		Default value: ''
	- #### java.max-mem:  
		Maximum memory for the JVM.  
		Default value: `512M`
	- #### java.min-mem:  
		Minimum memory for the JVM.  
		Default value: `128M`

- ### opengrok:
	- #### opengrok.auto-rebuild-index:  
		Automatically rebuild index when new version is installed. Permited values: ON/OFF.  
		Default value: `ON`
	- #### opengrok.http-port:  
		http port OpenGrok's tomcat webserver is exposed on, atter change restart service.  
		Default value: `8080`
	- #### opengrok.https-port:  
		https port OpenGrok's tomcat webserver is exposed on, atter change restart service.  
		Default value: `8443`
	- #### opengrok.src-data:  
		Data directory OpenGrok will index.  
		Default value: `${SNAP_COMMON}/data`
	- #### opengrok.src-root:  
		Source directory OpenGrok will index.  
		Default value: `${SNAP_COMMON}/src`
	- #### opengrok.ssh-key-name:  
		Name of ssh-key(s) to load, comma separated file names or full file paths.  
		Default value: `id_rsa`
	- #### opengrok.webapp-name:  
		web app name at which indexer is exposed.  
		Default value: `source`

- ### tomcat:
	- #### tomcat.catalina-opts:  
		Java runtime options used when the `start`, `run` or `debug` command is executed.  
		Default value: ''
	- #### tomcat.jpda-opts:  
		Java runtime options used when the `jpda start`  
		Default value: ''
	- #### tomcat.shutdown-port:  
		tompcat shutdown port.  
		Default value: `8005`

- ### source:  
	Source defintion used by `opengrok.update-source`.  
	Each source config has to contain at least `name` and `type` fields, and exta fields based on a given `type`.  
	- #### name:  
		type `string`: name of the project.  <br>
	- #### type:  
		type `string`: type of given source definition.  <br>
		Supported types:  
		- #### git:  
			Single git repository.  
			Additional configs:  
			- ###### url:  
				type `string`: repository url
			- ###### branch:  
				type `string`: repository branch
		- ***bzr***:  
			Bazaar repository.  
			Additional configs:
			- ###### url:
				type `string`: repository url
			- ###### branch:
				type `string`: repository branch
		- #### repo:  
			Repo repository.  
			Additional configs:
			- ###### url:
				type `string`: repository url
			- ###### branch:
				type `string`: repository branch
		- #### deb:
			List of deb packages.  
			Additional configs:
			- ###### debs:  
				type `string array`: list of deb packages
			- ###### series:  
				type `string`: ubuntu series
			- ###### ignore-packages:  
				type `string array`: list of source packages to ignore
		- #### germinate:  
			Collection of germinate lists.  
			Additional configs:  
			- ###### url:  
				type `string`: base germinate url.
			- ###### germinate-lists:  
				type `string array`: list of germinate list, without base url.
			- ###### ignore-packages:  
				type `string array`: list of source packages to ignore.  <br><br>


## snap configure examples.  
Examples of configuration using `snap set`.
#### Configure `java`
```json5
$ snap set opengrok java.max-mem="1024MB"
```
#### Configure `opengrok`
```json5
$ snap set opengrok opengrok.http-port="8040"
```
#### Configure `source`
```json5
$ snap set opengrok sources.opengrok='{
		"name":"opengrok",
		"type":"git",
		"url":"https://github.com/oracle/opengrok.git",
		"branch":"master"
	}'
```

```json5
$ snap set opengrok sources.core20='{
		"name":"core20",
		"type":"deb",
		"series":"focal",
		"debs":[
			"grep",
			"gzip",
			"python3-newt"
			],
		"ignore-packages":[
			"newt"
			]
	}'
```

```json5
$ snap set opengrok sources.core20='{
		"name":"core20",
		"type":"germinate",
		"url":"https://people.canonical.com/~ubuntu-archive/germinate-output/ubuntu.focal",
		"germinate-lists":[
			"server",
			"server.seed"
			],
		"ignore-packages":[
			"newt"
			]
	}'
```
<br><br>

## Helper to import from `dpkg.list`.
Included parser `import-dpkg-list` simplifies import of deb packages definition from `dpkg.list` file.  
```bash
$ cat /snap/core20/current/usr/share/snappy/dpkg.list \
| sudo opengrok.import-dpkg-list <project name> <Ubuntu series> [list of source packages to ignore]
```



