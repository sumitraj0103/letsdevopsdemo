resource_group_name ="devops_prod_rg"
location="southeastasia"
cluster_name="react-and-spring-data-prod"
kubernetes_version= "1.23.3"
system_node_count= 2
max_node_count=4
min_node_count=2
acr_id="reactspringdata"
acr_resourcegroup="devops-common-resources"
dns_prefix="k8sprod"
log_analytics_workspace_name="prodLogAnalyticsWorkspace"
log_analytics_workspace_location="eastus"
log_analytics_workspace_sku="pergb2018"
