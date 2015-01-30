
describe NetLinx::ERB::Helpers do
  
  let(:dvTP) { 'dvTP_ADMIN_1' }
  
  subject {
    Object.new.tap do |o|
      o.extend NetLinx::ERB::Helpers
      o.instance_variable_set :@dvTP, dvTP
    end
  }
  
  
  describe "justify" do
    
    let(:original_equals_block) {
<<-EOS
[dvTP_ADMIN_1, BTN_ADMIN_SELECT_BLANK] = (matrix_outputs[get_output_from_display(selected_display)].input == VID_SRC_BLANK);
[dvTP_ADMIN_1, BTN_ADMIN_SELECT_CABLE_1] = (get_tuner_from_matrix_input(matrix_outputs[get_output_from_display(selected_display)].input) == top_select_tuner + 0);
[dvTP_ADMIN_1, BTN_ADMIN_SELECT_CABLE_2] = (get_tuner_from_matrix_input(matrix_outputs[get_output_from_display(selected_display)].input) == top_select_tuner + 1);
[dvTP_ADMIN_1, BTN_ADMIN_SELECT_CABLE_3] = (get_tuner_from_matrix_input(matrix_outputs[get_output_from_display(selected_display)].input) == top_select_tuner + 2);
[dvTP_ADMIN_1, BTN_ADMIN_SELECT_CABLE_4] = (get_tuner_from_matrix_input(matrix_outputs[get_output_from_display(selected_display)].input) == top_select_tuner + 3);
[dvTP_ADMIN_1, BTN_ADMIN_SELECT_CABLE_5] = (get_tuner_from_matrix_input(matrix_outputs[get_output_from_display(selected_display)].input) == top_select_tuner + 4);
[dvTP_ADMIN_1, BTN_ADMIN_SELECT_CABLE_6] = (get_tuner_from_matrix_input(matrix_outputs[get_output_from_display(selected_display)].input) == top_select_tuner + 5);
[dvTP_ADMIN_1, BTN_ADMIN_SELECT_SIGNAGE_1] = (matrix_outputs[get_output_from_display(selected_display)].input == VID_SRC_SIGNAGE_1);
[dvTP_ADMIN_1, BTN_ADMIN_SELECT_SIGNAGE_2] = (matrix_outputs[get_output_from_display(selected_display)].input == VID_SRC_SIGNAGE_2);
EOS
    }
    
    let(:justified_equals_block) {
<<-EOS
[dvTP_ADMIN_1, BTN_ADMIN_SELECT_BLANK]     = (matrix_outputs[get_output_from_display(selected_display)].input == VID_SRC_BLANK);
[dvTP_ADMIN_1, BTN_ADMIN_SELECT_CABLE_1]   = (get_tuner_from_matrix_input(matrix_outputs[get_output_from_display(selected_display)].input) == top_select_tuner + 0);
[dvTP_ADMIN_1, BTN_ADMIN_SELECT_CABLE_2]   = (get_tuner_from_matrix_input(matrix_outputs[get_output_from_display(selected_display)].input) == top_select_tuner + 1);
[dvTP_ADMIN_1, BTN_ADMIN_SELECT_CABLE_3]   = (get_tuner_from_matrix_input(matrix_outputs[get_output_from_display(selected_display)].input) == top_select_tuner + 2);
[dvTP_ADMIN_1, BTN_ADMIN_SELECT_CABLE_4]   = (get_tuner_from_matrix_input(matrix_outputs[get_output_from_display(selected_display)].input) == top_select_tuner + 3);
[dvTP_ADMIN_1, BTN_ADMIN_SELECT_CABLE_5]   = (get_tuner_from_matrix_input(matrix_outputs[get_output_from_display(selected_display)].input) == top_select_tuner + 4);
[dvTP_ADMIN_1, BTN_ADMIN_SELECT_CABLE_6]   = (get_tuner_from_matrix_input(matrix_outputs[get_output_from_display(selected_display)].input) == top_select_tuner + 5);
[dvTP_ADMIN_1, BTN_ADMIN_SELECT_SIGNAGE_1] = (matrix_outputs[get_output_from_display(selected_display)].input == VID_SRC_SIGNAGE_1);
[dvTP_ADMIN_1, BTN_ADMIN_SELECT_SIGNAGE_2] = (matrix_outputs[get_output_from_display(selected_display)].input == VID_SRC_SIGNAGE_2);
EOS
    }
    
    let(:original_colon_block) {
<<-EOS
case BTN_ADMIN_SELECT_BLANK: input = VID_SRC_BLANK;
case BTN_ADMIN_SELECT_SIGNAGE_1: input = VID_SRC_SIGNAGE_1;
case BTN_ADMIN_SELECT_SIGNAGE_2: input = VID_SRC_SIGNAGE_2;
case BTN_ADMIN_SELECT_PARLOR_LIVE: input = VID_SRC_COMEDY_CAMERAS;
EOS
    }
    
    let(:justified_colon_block) {
<<-EOS
case BTN_ADMIN_SELECT_BLANK:          input = VID_SRC_BLANK;
case BTN_ADMIN_SELECT_SIGNAGE_1:      input = VID_SRC_SIGNAGE_1;
case BTN_ADMIN_SELECT_SIGNAGE_2:      input = VID_SRC_SIGNAGE_2;
case BTN_ADMIN_SELECT_PARLOR_LIVE:    input = VID_SRC_COMEDY_CAMERAS;
EOS
    }
    
    
    specify "block with equals" do
      # Return diff of the first line for printed output.
      subject.justify(original_equals_block).split("\n").first.strip.should eq \
        justified_equals_block.split("\n").first.strip
      
      # Full diff.
      subject.justify(original_equals_block).strip.should eq justified_equals_block.strip
    end
    
    specify "block with colon" do
      # Return diff of the first line for printed output.
      subject.justify(original_colon_block).split("\n").first.strip.should eq \
        justified_colon_block.split("\n").first.strip
      
      # Full diff.
      subject.justify(original_colon_block).strip.should eq justified_colon_block.strip
    end
    
    specify "block without comparable characters" do
      block = "nothing to justify\non either line\n"
      subject.justify(block).strip.should eq block.strip
    end
  
  end # justify
  
  
  describe "print_constant_hash" do
    
    let(:constant_hash) {
      {
        BTN_ADMIN_SELECT_BLANK:        80,
        BTN_ADMIN_SELECT_CABLE_1:      81,
        BTN_ADMIN_SELECT_CABLE_2:      82,
        BTN_ADMIN_SELECT_CABLE_3:      83
      }
    }
    
    let(:constant_hash_output) {
<<-EOS
BTN_ADMIN_SELECT_BLANK        = 80;
BTN_ADMIN_SELECT_CABLE_1      = 81;
BTN_ADMIN_SELECT_CABLE_2      = 82;
BTN_ADMIN_SELECT_CABLE_3      = 83;
EOS
    }
    
    
    specify do
      subject.print_constant_hash(constant_hash, justify: 29).strip.should eq \
        constant_hash_output.strip
    end
    
  end # print_constant_hash
  
  
  describe "generate_constant_ivars" do
    
    let(:hash) {
      {
        BTN_PRESET_1: 1,
        BTN_PRESET_2: 1,
      }
    }
    
    let(:suffix) { 'TEST_PANEL' }
    
    specify "without suffix" do
      subject.generate_constant_ivars hash
      
      subject.instance_variable_get(:@BTN_PRESET_1).should eq "BTN_PRESET_1"
      subject.instance_variable_get(:@BTN_PRESET_2).should eq "BTN_PRESET_2"
    end
    
    specify "with suffix, append off" do
      subject.instance_variable_set :@tmpl_suffix, suffix
      subject.generate_constant_ivars hash
      
      subject.instance_variable_get(:@BTN_PRESET_1).should eq "BTN_PRESET_1"
      subject.instance_variable_get(:@BTN_PRESET_2).should eq "BTN_PRESET_2"
    end
    
    specify "with suffix, append on" do
      subject.instance_variable_set :@tmpl_suffix, suffix
      subject.generate_constant_ivars hash, append_suffix: true
      
      subject.instance_variable_get(:@BTN_PRESET_1).should eq "BTN_PRESET_1_#{suffix}"
      subject.instance_variable_get(:@BTN_PRESET_2).should eq "BTN_PRESET_2_#{suffix}"
    end
    
  end
  
  
  describe "generate_variable_ivars" do
    
    let(:hash) {
      {
        var_1: { type: :integer, default: 0 },
        var_2: { type: :integer, default: 0 },
        var_3: { type: :integer, default: 0 },
      }
    }
    
    let(:suffix) { 'TEST_PANEL' }
    
    specify "without suffix" do
      subject.generate_variable_ivars hash
      
      subject.instance_variable_get(:@var_1).should eq "var_1"
      subject.instance_variable_get(:@var_2).should eq "var_2"
      subject.instance_variable_get(:@var_3).should eq "var_3"
    end
    
    specify "with suffix" do
      subject.instance_variable_set :@tmpl_suffix, suffix
      subject.generate_variable_ivars hash
      
      subject.instance_variable_get(:@var_1).should eq "var_1_#{suffix.downcase}"
      subject.instance_variable_get(:@var_2).should eq "var_2_#{suffix.downcase}"
      subject.instance_variable_get(:@var_3).should eq "var_3_#{suffix.downcase}"
    end
    
  end
  
  
  describe "auto_comment" do
    
    describe "single line" do
    
      let(:code) { "[dvProjector, BTN_PROJ_ON] = 1" }
      
      
      it "passes code through unaltered if the condition is met" do
        subject.auto_comment(code, condition_met = true).should eq code
      end
      
      it "comments out the code if the condition is not met" do
        subject.auto_comment(code, condition_met = false).should eq "// " + code
      end
      
    end
    
    describe "multi-line" do
      
      let(:code) {
        "[dvProjector, BTN_PROJ_ON] = 1\n" +
        "[dvProjector, BTN_PROJ_OFF] = 0"
      }
      
      
      it "passes code through unaltered if the condition is met" do
        subject.auto_comment(code, condition_met = true).should eq code
      end
      
      it "comments out the code if the condition is not met" do
        subject.auto_comment(code, condition_met = false).split("\n").should eq \
          code.split("\n").map { |line| "// " + line }
      end
      
    end
    
  end # auto_comment
  
  
  describe "group" do
    
  end # group
  
  
  describe "button_event" do
    
    let(:button_event_hash) {
      {
        BTN_ADMIN_SELECT_BLANK:        80,
        BTN_ADMIN_SELECT_CABLE_1:      81,
        BTN_ADMIN_SELECT_CABLE_2:      82,
        BTN_ADMIN_SELECT_CABLE_3:      83
      }
    }
    
    let(:button_event_output) {
<<-EOS
button_event[dvTP, BTN_ADMIN_SELECT_BLANK]
button_event[dvTP, BTN_ADMIN_SELECT_CABLE_1]
button_event[dvTP, BTN_ADMIN_SELECT_CABLE_2]
button_event[dvTP, BTN_ADMIN_SELECT_CABLE_3]
EOS
    }
    
    let(:touch_panel) { 'dvTP' }
    
    
    specify do
      subject.button_event(button_event_hash, touch_panel).strip.should eq \
        button_event_output.strip
    end
    
  end # button_event
  
  
  describe "check_for_duplicate_values" do
    
  end # check_for_duplicate_values
  
  
  describe "hash remap" do
    
    let(:hash) {
      {
        :TOUCH_PANEL_BUTTON_1 => { btn: 1, matrix_input: :MTX_IN_DVD },
        :TOUCH_PANEL_BUTTON_2 => { btn: 2, matrix_input: :MTX_IN_VCR },
      }
    }
    
    let(:result) {
      {
        :TOUCH_PANEL_BUTTON_1 => 1,
        :TOUCH_PANEL_BUTTON_2 => 2,
      }
    }
    
    specify do
      hash.remap(:btn).should eq result
    end
    
  end
  
  
  describe "to_hiqnet" do
    
    specify "with sv as number" do
      '0x100203000103'.to_hiqnet(0x0000).should eq '{$10, $02, $03, $00, $01, $03, $00, $00},'
    end
    
    specify "with sv as string" do
      '0x100203000103'.to_hiqnet('00').should eq '{$10, $02, $03, $00, $01, $03, $00, $00},'
    end
    
    specify "with sv containing unique hex digits" do
      '0x100203000103'.to_hiqnet(0xA8F).should eq '{$10, $02, $03, $00, $01, $03, $0A, $8F},'
    end
    
    specify "without sv" do
      '0x1002030001030000'.to_hiqnet.should eq '{$10, $02, $03, $00, $01, $03, $00, $00},'
    end
    
  end
  
  
  describe "hiqnet_empty" do
    
    its(:hiqnet_empty) { should eq '0x000000000000' }
    
  end
  
  
  describe "show_control" do
    
    let(:name) { :CTRL_CONST }
    
    describe "Fixnum" do
      
      specify "0" do
        subject.show_control(name, 0).should eq "send_command #{dvTP}, \"'^SHO-', itoa(#{name}), ',0'\";"
      end
      
      specify "1" do
        subject.show_control(name, 1).should eq "send_command #{dvTP}, \"'^SHO-', itoa(#{name}), ',1'\";"
      end
      
    end
    
    describe "Boolean" do
      
      specify "false" do
        subject.show_control(name, false).should eq "send_command #{dvTP}, \"'^SHO-', itoa(#{name}), ',0'\";"
      end
      
      specify "true" do
        subject.show_control(name, true).should eq "send_command #{dvTP}, \"'^SHO-', itoa(#{name}), ',1'\";"
      end
      
      specify "nil" do
        subject.show_control(name, nil).should eq "send_command #{dvTP}, \"'^SHO-', itoa(#{name}), ',0'\";"
      end
      
    end
    
    describe "expression" do
      
      let(:expression) { "touch_panel == TP_ROOM_1" }
      
      specify do
        subject.show_control(name, expression).should eq "send_command #{dvTP}, \"'^SHO-', itoa(#{name}), ',', itoa(#{expression})\";"
      end
      
    end
    
    describe "device (override dvTP)" do
      
      let(:device) { 'dvTP_ALTERNATE_PANEL' }
      
      specify do
        subject.show_control(name, 0, device: device).should eq "send_command #{device}, \"'^SHO-', itoa(#{name}), ',0'\";"
      end
      
    end
    
  end
  
end