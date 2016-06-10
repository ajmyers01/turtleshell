namespace :enspire do
  task seed_users: :environment do
    names = [
      # Default admin user.
      'admin',
      # Ruby team and BAs.
      'alex.myers'
    ]

    users = names.map do |name|
      email = "#{name}@enspiresoftware.com"
      # Skip any users that already exist.
      next if User.find_by(email: email).present?

      fragments = name.split '.'
      { email: email,
        password: 'Password1!',
        first_name: fragments[0].capitalize,
        last_name: (fragments[1] || 'user').capitalize}
    end
    User.create(users.compact)
  end
end
