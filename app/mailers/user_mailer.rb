class UserMailer < ActionMailer::Base
  default from: "writer-app@dev.abifathir.com"

  def new_project_notification(project)
    @project = project
    project.writers.each do |writer|
      @writer = writer
      mail(:to => writer.email, :subject => "New project posted for your team")
    end
  end
end
