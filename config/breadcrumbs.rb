crumb :root do
  link "Главная", root_path
end

# Problems
crumb :problems do
  link "Проблемы", problems_path
end
crumb :problems_map do
  link "Карта проблем", problems_path(:view => :map)
  parent :problems
end
crumb :problem do |problem|
  link problem.title, problem_path(problem)
  parent :problems
end
crumb :edit_problem do |problem|
  link "Редактировать", edit_problem_path(problem)
  parent :problem, problem
end
crumb :new_problem do
  link "Новая проблема", new_problem_path
  parent :problems
end

# Subjects
crumb :subjects do
  link "Тематики", subjects_path
end
crumb :subject do |subject|
  link subject.title, subject_path(subject)
  parent :subjects
end
crumb :edit_subject do |subject|
  link "Редактировать", edit_subject_path(subject)
  parent :subject, subject
end
crumb :new_subject do
  link "Новая тематика", new_subject_path
  parent :subjects
end

# Statuses
crumb :statuses do
  link "Статусы", statuses_path
end
crumb :status do |status|
  link status.title, status_path(status)
  parent :statuses
end
crumb :edit_status do |status|
  link "Редактировать", edit_status_path(status)
  parent :status, status
end
crumb :new_status do
  link "Новый статус", new_status_path
  parent :statuses
end