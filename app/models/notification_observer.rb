class NotificationObserver < ActiveRecord::Observer
  observe Project

  def after_create(project)
    project.team_writers.each do |writer|
      UserMailer.new_project_notification(project, writer).deliver
    end
  end
end
