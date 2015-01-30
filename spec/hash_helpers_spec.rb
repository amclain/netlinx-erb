
describe NetLinx::ERB::HashHelpers do
  
  subject { Hash.new.extend NetLinx::ERB::HashHelpers }
  
  before {
    Hash.instance_variable_set :@tmpl_suffix, suffix
    Hash.instance_variable_set :@tmpl_var_suffix, suffix.downcase
  }
  
  let(:suffix) { 'SFX' }
  
  
  its(:tmpl_suffix)     { should eq suffix }
  its(:tmpl_var_suffix) { should eq suffix.downcase }
  
  
  describe "append_suffix" do
    
    subject {
      {
        key_1: 1,
        key_2: 2,
      }
    }
    
    specify do
      subject.append_suffix[:key_1_SFX].should eq 1
      subject.append_suffix[:key_2_SFX].should eq 2
      
      subject[:key_1_SFX].should eq nil
      subject[:key_2_SFX].should eq nil
      subject[:key_1].should eq 1
      subject[:key_2].should eq 2
    end
    
  end
  
  
  describe "append_suffix!" do
    
    subject {
      {
        key_1: 1,
        key_2: 2,
      }.append_suffix!
    }
    
    specify do
      subject[:key_1_SFX].should eq 1
      subject[:key_2_SFX].should eq 2
      
      # Original keys.
      subject[:key_1].should eq nil
      subject[:key_2].should eq nil
    end
    
  end
  
  
  describe "append_suffix! no suffix defined" do
    
    subject {
      {
        key_1: 1,
        key_2: 2,
      }.append_suffix!
    }
    
    let(:suffix) { '' }
    
    specify do
      subject[:key_1].should eq 1
      subject[:key_2].should eq 2
    end
    
  end
  
end