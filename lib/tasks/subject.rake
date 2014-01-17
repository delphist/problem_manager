namespace :subject do
  task :import => :environment do
    require 'net/http'
    result = Net::HTTP.get(URI.parse('http://www.angrycitizen.ru/problems'))

    coutn = 0

    subjects = {}
    result.scan(Regexp.new("\<a.*?collapse\-([0-9]+).*?\>(.*?)\<i\>", Regexp::IGNORECASE | Regexp::MULTILINE)).each do |res|
      id, title = res
      id = id.to_i
      title.strip!

      subject = Subject.find_or_initialize_by(title: title)
      subject.parent_id = nil
      subjects[id] = subject
      p subject
      count += 1
    end

    result.scan(Regexp.new("\<div id=\"collapse\-([0-9]+).*?\>(.*?)\</div\>", Regexp::IGNORECASE | Regexp::MULTILINE)).each do |res|
      id, data = res
      id = id.to_i
      parent_id = subjects[id].id
      data.scan(Regexp.new("\\<a.*?\>\<i.*?\>(.*?)\<\/i\>", Regexp::IGNORECASE | Regexp::MULTILINE)).each do |res|
        title = res.first
        subject = Subject.find_or_initialize_by(title: title)
        subject.parent_id = parent_id
        p subject
        count += 1
      end
    end

    p "Subjects: #{count}"
  end
end