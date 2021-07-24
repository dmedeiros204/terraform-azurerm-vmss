title 'terraform vmss  config'

vmss_linux_id = attribute('vmss_linux_id')
vmss_windows_id = attribute('vmss_windows_id')

control 'terraform-azure-01' do
  desc 'linux vmss scale set'
  describe azure_generic_resource(resource_id: vmss_linux_id) do
    it { should exist }
    its('location') { should eq 'canadacentral' }
    its('properties.provisioningState') { should cmp 'Succeeded' }
    its('sku.name') { should eq 'Standard_D48s_v3' }
  end
end

control 'terraform-azure-02' do
  desc 'windows vmss scale set'
  describe azure_generic_resource(resource_id: vmss_windows_id) do
    it { should exist }
    its('location') { should eq 'canadacentral' }
    its('properties.provisioningState') { should cmp 'Succeeded' }
    its('sku.name') { should eq 'Standard_D48s_v3' }
  end
end
