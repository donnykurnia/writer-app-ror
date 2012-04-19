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
end
