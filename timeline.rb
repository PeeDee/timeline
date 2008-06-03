# Ruby script for plotting a timeline in Google SketchUp
#  needs to reside in /Library/Application Support/Google SketchUp 6/SketchUp/plugins/

# See:
#  http://dl.google.com/sketchup/gsu6/GoogleSketchUpMEN.dmg
#  http://sketchup.google.com/download/rubyscripts.html

#=============================================================================

require 'sketchup.rb'

#=============================================================================



#=============================================================================
# Add a menu to draw timeline
if( not $timeline_menu_loaded )
    plugins_menu = UI.menu("Plugins")
    tl_menu = plugins_menu.add_submenu("Time Line")
    tl_menu.add_item("Load File") { load "timeline.dat" }
    dr_menu = tl_menu.add_submenu("Draw")
    #...
    dr_menu.add_item("Location") { puts "Draw Location Item" }
    dr_menu.add_item("School") { puts "Draw School Item" }
    #...
    $timeline_menu_loaded = true
end

