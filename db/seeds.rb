if Rails.env == "development"
  status_arr = %w(yet started done)

  10.times do |i|
    User.create!(
      name: "user#{i + 1}",
      email: "user#{i + 1}@test.com",
      password: "aaa",
      password_confirmation: "aaa",
      administrator: (i == 0)
    )
  end

  50.times do |i|
    Task.create!(
      name: "test#{i + 1}",
      description: "test#{i + 1}だよ！", 
      end_date: "2020-03-22 08:26:00",
      priority: i % 3,
      status: status_arr[i % 3],
      user_id: i % 10 + 1
    )
  end
end