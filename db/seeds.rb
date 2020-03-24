if Rails.env == "development"
  50.times do |i|
    Task.create!(
      name: "test#{i + 1}",
      description: "test#{i + 1}だよ！", 
      end_date: "2020-03-22 08:26:00",
      priority: i % 3
    )
  end
end