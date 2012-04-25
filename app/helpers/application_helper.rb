module ApplicationHelper
  def display_flash(name,msg)
    case name.to_s
    when "notice" then
      content_tag :div, :class => "alert alert-success fade in" do
        link_to('&times;'.html_safe, '#', :class => "close", :"data-dismiss" => "alert") +
        '<i class="icon-ok-sign"></i> '.html_safe +
        msg
      end
    when "alert" then
      content_tag :div, :class => "alert alert-warning fade in" do
        link_to('&times;'.html_safe, '#', :class => "close", :"data-dismiss" => "alert") +
        '<i class="icon-warning-sign"></i> '.html_safe +
        msg
      end
    else
      content_tag :div, :class => "alert alert-info fade in" do
        link_to('&times;'.html_safe, '#', :class => "close", :"data-dismiss" => "alert") +
        '<i class="icon-info-sign"></i> '.html_safe +
        msg
      end
    end
  end

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

  def link_to_add_fields(name, f, association, options)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, [new_object], :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{j(fields)}\")", options)
  end

end
