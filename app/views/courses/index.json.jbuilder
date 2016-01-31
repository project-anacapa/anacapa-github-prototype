json.array!(@courses) do |course|
  json.extract! course, :id, :dept, :num, :desc
  json.url course_url(course, format: :json)
end
