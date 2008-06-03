# Ruby script for plotting a timeline in Google SketchUp
#  needs to reside in /Library/Application Support/Google SketchUp 6/SketchUp/plugins/

# See:
#  http://dl.google.com/sketchup/gsu6/GoogleSketchUpMEN.dmg
#  http://sketchup.google.com/download/rubyscripts.html
#  http://code.google.com/apis/sketchup/docs/developers_guide/index.html
#  http://groups.google.com/group/SketchUp-Plugins-Dev/web/Ruby-classes.html
#
#=============================================================================

require 'sketchup.rb' 
Sketchup.require('/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/lib/ruby/1.8/yaml') # http://www.yaml.org/

#=============================================================================

class TimeLine

  attr_accessor :name, :birth_date, :locations, :schools, :jobs, :events

  def to_s
    "Timeline for: #{@name}, born: #{@birth_date.to_s}" << 
      "\n" << @locations.to_s << @schools.to_s # << @jobs.to_s << @events.to_s
  end
  
  def to_yaml_file(filename = "timeline.yaml")
    File.open(filename, "w") {|f| YAML.dump(self, f)}
  end
  
  def draw
    # draw all elements into a 5 x decade coordinate system....
    Sketchup.active_model.add_note @name, 0.1, 0.1
  end
  
end

class TLLocation

  attr_accessor :name, :start, :finish
  
  def to_s
    "  Location: #{@name} from: #{@start.to_s} to #{@finish.to_s}\n"
  end

end

class TLSchool

  attr_accessor :name, :date, :terms
  
  def to_s
    "  School: #{@name} from: #{@date.to_s}\n" << @terms.to_s
  end

end

class TLTerm
  attr_accessor :name, :start, :finish
  
  def to_s
    "    Term: #{@name} from: #{@start.to_s} to #{@finish.to_s}\n"
  end
  
end

#=============================================================================
if __FILE__ == $0 # running from command line to test
  tl = YAML.load(File.open("timeline.pd.yaml"))
  puts tl.to_yaml
end

#=============================================================================
#Add a menu to draw timeline into SketchUp (tested)
if( not $timeline_menu_loaded )
    plugins_menu = UI.menu("Plugins")
    tl_menu = plugins_menu.add_submenu("Time Line")
    tl_menu.add_item("Load File") { tl = YAML.load(File.open("timeline.pd.yaml")) }
    tl_menu.add_item("Draw") { tl.draw }
    #dr_menu = tl_menu.add_submenu("Draw")
    #...
    #dr_menu.add_item("Location") { puts "Draw Location Item" }
    #dr_menu.add_item("School") { puts "Draw School Item" }
    #...
    $timeline_menu_loaded = true
end

