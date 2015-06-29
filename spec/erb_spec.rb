
describe NetLinx::ERB do
  
  subject { NetLinx::ERB }
  
  its(:binding) { should be_a Binding }
  
  it { should respond_to :execute }
  it { should respond_to :generate_axi_files_from_template }
  
end
