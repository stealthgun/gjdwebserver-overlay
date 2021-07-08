# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

DESCRIPTION="Microsoft Azure Command-Line Tools"
HOMEPAGE="https://pypi.org/project/azure-cli"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~arm ~x86"
LICENSE="MIT"
SLOT="0"

IUSE="+acr +acs +advisor +ams +apim +appconfig +appservice +aro +backup \
	+batch +billing +bot +cdn +cloud +cognitiveservices +consumption \
	+container +cosmosdb +databoxedge +deploymentmanager +dla +dls +dms \
	+eventgrid +eventhubs extension +feedback +find +hdinsight interactive \
	+iot +keyvault +kusto +lab +managedservices +maps +monitor \
	+netappfiles +network +policyinsights +rdbms +redis +relay +reservations \
	+resource +role +search +security +servicebus +sf +signalr +sql +sqlvm \
	+storage +synapse +util +vm"

CLI_DEPEND="
	acr? (
		virtual/python-cffi[${PYTHON_USEDEP}]
		>=dev-python/azure-storage-common-1.4.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-storage-17.0.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-containerregistry-3.0.0_rc17[${PYTHON_USEDEP}]
	)
	acs? (
		virtual/python-cffi[${PYTHON_USEDEP}]
		>=dev-python/azure-graphrbac-0.61.1[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-authorization-0.61.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-compute-20.0.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-containerservice-11.1.0[${PYTHON_USEDEP}]
		dev-python/scp[${PYTHON_USEDEP}]
		dev-python/sshtunnel[${PYTHON_USEDEP}]
	)
	advisor? (
		>=dev-python/azure-mgmt-advisor-2.0.1[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-media-3.0.0[${PYTHON_USEDEP}]
	)
	ams? (
		>=dev-python/azure-graphrbac-0.61.1[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-media-3.0.0[${PYTHON_USEDEP}]
	)
	apim? (
		>=dev-python/azure-mgmt-apimanagement-0.2.0[${PYTHON_USEDEP}]
	)
	appconfig? (
		>=dev-python/azure-mgmt-appconfiguration-1.0.1[${PYTHON_USEDEP}]
		>=dev-python/azure-appconfiguration-1.1.1[${PYTHON_USEDEP}]
	)
	appservice? (
		virtual/python-cffi[${PYTHON_USEDEP}]
		>=dev-python/azure-functions-devops-build-0.0.22[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-applicationinsights-0.2.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-containerregistry-3.0.0_rc17[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-storage-17.0.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-web-0.48.0[${PYTHON_USEDEP}]
		dev-python/fabric:2[${PYTHON_USEDEP}]
		>=dev-python/urllib3-1.18[${PYTHON_USEDEP}]
		dev-python/vsts-cd-manager[${PYTHON_USEDEP}]
		dev-python/xmltodict[${PYTHON_USEDEP}]
	)
	aro? (
		>=dev-python/azure-mgmt-redhatopenshift-0.1.0[${PYTHON_USEDEP}]
	)
	backup? (
		>=dev-python/azure-mgmt-recoveryservices-0.2.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-recoveryservicesbackup-0.11.0[${PYTHON_USEDEP}]
	)
	batch? (
		>=dev-python/azure-batch-10.0.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-batch-9.0.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-keyvault-8.0.0[${PYTHON_USEDEP}]
	)
	billing? (
		>=dev-python/azure-mgmt-billing-1.0.0[${PYTHON_USEDEP}]
	)
	bot? (
		>=dev-python/azure-mgmt-botservice-0.3.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-web-0.48.0[${PYTHON_USEDEP}]
	)
	cdn? (
		>=dev-python/azure-mgmt-cdn-11.0.0[${PYTHON_USEDEP}]
	)
	container? (
		>=dev-python/azure-mgmt-authorization-0.61.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-containerinstance-1.5.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-loganalytics-8.0.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-network-18.0.0[${PYTHON_USEDEP}]
		>=dev-python/azure-loganalytics-0.1.0[${PYTHON_USEDEP}]
		dev-python/websocket-client[${PYTHON_USEDEP}]
	)
	cognitiveservices? (
		>=dev-python/azure-mgmt-cognitiveservices-6.3.0[${PYTHON_USEDEP}]
	)
	consumption? (
		>=dev-python/azure-mgmt-consumption-2.0.0[${PYTHON_USEDEP}]
	)
	cosmosdb? (
		>=dev-python/azure-cosmos-3.1.2[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-cosmosdb-3.1.0[${PYTHON_USEDEP}]
		>=dev-python/azure-multiapi-storage-0.6.2[${PYTHON_USEDEP}]
	)
	databoxedge? (
		>=dev-python/azure-mgmt-databoxedge-0.2.0[${PYTHON_USEDEP}]
	)
	deploymentmanager? (
		>=dev-python/azure-mgmt-deploymentmanager-0.2.0[${PYTHON_USEDEP}]
	)
	dla? (
		>=dev-python/azure-mgmt-datalake-analytics-0.2.1[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-datalake-store-0.5.0[${PYTHON_USEDEP}]
	)
	dls? (
		>=dev-python/azure-datalake-store-0.0.49[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-datalake-store-0.5.0[${PYTHON_USEDEP}]
	)
	dms? (
		>=dev-python/azure-mgmt-datamigration-4.1.0[${PYTHON_USEDEP}]
	)
	eventgrid? (
		>=dev-python/azure-mgmt-eventgrid-3.0.0_rc9[${PYTHON_USEDEP}]
	)
	eventhubs? (
		>=dev-python/azure-mgmt-eventhub-4.1.0[${PYTHON_USEDEP}]
	)
	extension? (
		dev-python/wheel[${PYTHON_USEDEP}]
	)
	hdinsight? (
		>=dev-python/azure-mgmt-hdinsight-2.2.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-network-18.0.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-storage-17.0.0[${PYTHON_USEDEP}]
	)
	interactive? (
		dev-python/prompt_toolkit[${PYTHON_USEDEP}]
	)
	iot? (
		virtual/python-cffi[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-iotcentral-4.1.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-iothub-0.12.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-iothubprovisioningservices-0.2.0[${PYTHON_USEDEP}]
	)
	keyvault? (
		virtual/python-cffi[${PYTHON_USEDEP}]
		>=dev-python/azure-graphrbac-0.61.1[${PYTHON_USEDEP}]
		>=dev-python/azure-keyvault-administration-4.0.0_beta3[${PYTHON_USEDEP}]
		>=dev-python/azure-keyvault-1.1.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-keyvault-8.0.0[${PYTHON_USEDEP}]
	)
	kusto? (
		>=dev-python/azure-mgmt-kusto-0.3.0[${PYTHON_USEDEP}]
	)
	lab? (
		>=dev-python/azure-graphrbac-0.61.1[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-devtestlabs-4.0.0[${PYTHON_USEDEP}]
	)
	managedservices? (
		>=dev-python/azure-mgmt-managedservices-1.0.0[${PYTHON_USEDEP}]
	)
	maps? (
		>=dev-python/azure-mgmt-maps-0.1.0[${PYTHON_USEDEP}]
	)
	monitor? (
		>=dev-python/azure-mgmt-monitor-2.0.0[${PYTHON_USEDEP}]
	)
	netappfiles? (
		>=dev-python/azure-mgmt-netapp-2.0.0[${PYTHON_USEDEP}]
	)
	network? (
		>=dev-python/azure-mgmt-dns-3.0.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-network-18.0.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-privatedns-0.1.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-trafficmanager-0.51.0[${PYTHON_USEDEP}]
	)
	policyinsights? (
		>=dev-python/azure-mgmt-policyinsights-0.5.0[${PYTHON_USEDEP}]
	)
	rdbms? (
		>=dev-python/azure-mgmt-rdbms-8.1.0_beta2[${PYTHON_USEDEP}]
	)
	redis? (
		>=dev-python/azure-mgmt-redis-7.0.0_rc1[${PYTHON_USEDEP}]
	)
	relay? (
		>=dev-python/azure-mgmt-relay-0.2.0[${PYTHON_USEDEP}]
	)
	reservations? (
		>=dev-python/azure-mgmt-reservations-0.6.0[${PYTHON_USEDEP}]
	)
	resource? (
		>=dev-python/azure-mgmt-authorization-0.61.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-managementgroups-0.2.0[${PYTHON_USEDEP}]
	)
	role? (
		>=dev-python/azure-graphrbac-0.61.1[${PYTHON_USEDEP}]
		>=dev-python/azure-keyvault-1.1.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-authorization-0.61.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-msi-1.0.0[${PYTHON_USEDEP}]
		>=dev-python/azure-identity-1.5.0[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}]
	)
	search? (
		>=dev-python/azure-mgmt-search-8.0.0[${PYTHON_USEDEP}]
	)
	security? (
		>=dev-python/azure-mgmt-security-0.6.0[${PYTHON_USEDEP}]
	)
	servicebus? (
		>=dev-python/azure-mgmt-servicebus-0.6.0[${PYTHON_USEDEP}]
	)
	sf? (
		virtual/python-cffi[${PYTHON_USEDEP}]
		>=dev-python/azure-graphrbac-0.61.1[${PYTHON_USEDEP}]
		>=dev-python/azure-keyvault-1.1.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-compute-20.0.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-keyvault-8.0.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-network-18.0.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-servicefabric-0.5.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-servicefabricmanagedclusters-1.0.0_beta1[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-storage-17.0.0[${PYTHON_USEDEP}]
	)
	signalr? (
		>=dev-python/azure-mgmt-signalr-0.4.0[${PYTHON_USEDEP}]
	)
	sql? (
		>=dev-python/azure-mgmt-sql-0.26.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-storage-17.0.0[${PYTHON_USEDEP}]
	)
	sqlvm? (
		>=dev-python/azure-mgmt-sqlvirtualmachine-0.5.0[${PYTHON_USEDEP}]
	)
	storage? (
		>=dev-python/azure-multiapi-storage-0.6.2[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-storage-17.0.0[${PYTHON_USEDEP}]
	)
	synapse? (
		>=dev-python/azure-mgmt-synapse-0.6.0[${PYTHON_USEDEP}]
		>=dev-python/azure-synapse-artifacts-0.3.0[${PYTHON_USEDEP}]
		>=dev-python/azure-synapse-accesscontrol-0.5.0[${PYTHON_USEDEP}]
		>=dev-python/azure-synapse-spark-0.2.0[${PYTHON_USEDEP}]
	)
	vm? (
		>=dev-python/azure-keyvault-1.1.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-authorization-0.61.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-compute-20.0.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-imagebuilder-0.4.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-keyvault-8.0.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-marketplaceordering-1.1.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-monitor-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-msi-1.0.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-network-18.0.0[${PYTHON_USEDEP}]
		>=dev-python/azure-multiapi-storage-0.6.2[${PYTHON_USEDEP}]
	)"

RDEPEND="${CLI_DEPEND}
	>=dev-python/urllib3-1.25.9[${PYTHON_USEDEP}]
	>=dev-python/jsondiff-1.2.0[${PYTHON_USEDEP}]
	>=dev-python/jsmin-2.2.2[${PYTHON_USEDEP}]
	>=dev-python/azure-mgmt-resource-12.1.0[${PYTHON_USEDEP}]
	~dev-python/azure-cli-core-2.22.1[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

src_prepare() {
	distutils-r1_src_prepare

	eapply "${FILESDIR}"/no_user_upgrade.diff

	rm az.bat || die
	sed -i -e 's:PIP:PORTAGE:' az || die
	sed -i -e '/az.bat/ d' setup.py || die
	sed -i -e '/import antlr4/ d' azure/cli/command_modules/monitor/actions.py || die

	use acr || rm -r azure/cli/command_modules/acr || die
	use acs || rm -r azure/cli/command_modules/acs || die
	use advisor || rm -r azure/cli/command_modules/advisor || die
	use ams || rm -r azure/cli/command_modules/ams || die
	use apim || rm -r azure/cli/command_modules/apim || die
	use appconfig || rm -r azure/cli/command_modules/appconfig || die
	use appservice || rm -r azure/cli/command_modules/appservice || die
	use aro || rm -r azure/cli/command_modules/aro || die
	use backup || rm -r azure/cli/command_modules/backup || die
	use batch || rm -r azure/cli/command_modules/batch || die
	rm -r azure/cli/command_modules/batchai || die
	use billing || rm -r azure/cli/command_modules/billing || die
	use bot || rm -r azure/cli/command_modules/botservice || die
	use cdn || rm -r azure/cli/command_modules/cdn || die
	use cloud || rm -r azure/cli/command_modules/cloud || die
	use cognitiveservices || rm -r azure/cli/command_modules/cognitiveservices || die
	use consumption || rm -r azure/cli/command_modules/consumption || die
	use container || rm -r azure/cli/command_modules/container || die
	use cosmosdb || rm -r azure/cli/command_modules/cosmosdb || die
	use databoxedge || rm -r azure/cli/command_modules/databoxedge || die
	use deploymentmanager || rm -r azure/cli/command_modules/deploymentmanager || die
	use dla || rm -r azure/cli/command_modules/dla || die
	use dls || rm -r azure/cli/command_modules/dls || die
	use dms || rm -r azure/cli/command_modules/dms || die
	use eventgrid || rm -r azure/cli/command_modules/eventgrid || die
	use eventhubs || rm -r azure/cli/command_modules/eventhubs || die
	use extension || rm -r azure/cli/command_modules/extension || die
	use feedback || rm -r azure/cli/command_modules/feedback || die
	use find || rm -r azure/cli/command_modules/find || die
	use hdinsight || rm -r azure/cli/command_modules/hdinsight || die
	use interactive || rm -r azure/cli/command_modules/interactive || die
	use iot || rm -r azure/cli/command_modules/iot || die
	use keyvault || rm -r azure/cli/command_modules/keyvault || die
	use kusto || rm -r azure/cli/command_modules/kusto || die
	use lab || rm -r azure/cli/command_modules/lab || die
	use managedservices || rm -r azure/cli/command_modules/managedservices || die
	use maps || rm -r azure/cli/command_modules/maps || die
	use vm || \
	use monitor || rm -r azure/cli/command_modules/monitor || die
	use network || rm -r azure/cli/command_modules/natgateway || die
	use netappfiles || rm -r azure/cli/command_modules/netappfiles || die
	use network || rm -r azure/cli/command_modules/network || die
	use policyinsights || rm -r azure/cli/command_modules/policyinsights || die
	use network || rm -r azure/cli/command_modules/privatedns || die
	use rdbms || rm -r azure/cli/command_modules/rdbms || die
	use redis || rm -r azure/cli/command_modules/redis || die
	use relay || rm -r azure/cli/command_modules/relay || die
	use reservations || rm -r azure/cli/command_modules/reservations || die
	use resource || rm -r azure/cli/command_modules/resource || die
	use role || rm -r azure/cli/command_modules/role || die
	use search || rm -r azure/cli/command_modules/search || die
	use security || rm -r azure/cli/command_modules/security || die
	use servicebus || rm -r azure/cli/command_modules/servicebus || die
	use sf || rm -r azure/cli/command_modules/servicefabric || die
	use signalr || rm -r azure/cli/command_modules/signalr || die
	use sql || rm -r azure/cli/command_modules/sql || die
	use sqlvm || rm -r azure/cli/command_modules/sqlvm || die
	use storage || rm -r azure/cli/command_modules/storage || die
	use synapse || rm -r azure/cli/command_modules/synapse || die
	use util || rm -r azure/cli/command_modules/util || die
	use vm || rm -r azure/cli/command_modules/vm || die
}
