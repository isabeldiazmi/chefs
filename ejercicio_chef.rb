require 'sqlite3'

class Chef
  def initialize(first_name, last_name, birthday, email, phone)
    @first_name = first_name
    @last_name = last_name
    @birthday = birthday
    @email = email
    @phone = phone
  end

  def save
    Chef.db.execute(
      <<-SQL
        INSERT INTO chefs
          (first_name, last_name, birthday, email, phone, created_at, updated_at)
        VALUES
          ('#{@first_name}', '#{@last_name}', '#{@birthday}', '#{@email}', '#{@phone}', DATETIME('now'), DATETIME('now'));
      SQL
    )
  end

  def self.create_table
    Chef.db.execute(
      <<-SQL
        CREATE TABLE chefs (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          first_name VARCHAR(64) NOT NULL,
          last_name VARCHAR(64) NOT NULL,
          birthday DATE NOT NULL,
          email VARCHAR(64) NOT NULL,
          phone VARCHAR(64) NOT NULL,
          created_at DATETIME NOT NULL,
          updated_at DATETIME NOT NULL
        );
      SQL
    )
  end

  def self.seed
    Chef.db.execute(
      <<-SQL
        INSERT INTO chefs
          (first_name, last_name, birthday, email, phone, created_at, updated_at)
        VALUES
          ('Ferran', 'Adrián', '1985-02-09', 'ferran.adria@elbulli.com', '42381093238', DATETIME('now'), DATETIME('now')),
          ('Diaz', 'Isabel', '1985-02-09', 'ferran.adria@elbulli.com', '42381093238', DATETIME('now'), DATETIME('now')),
          ('Garcia', 'Mau', '1985-02-09', 'ferran.adria@elbulli.com', '42381093238', DATETIME('now'), DATETIME('now')),
          ('Ibarrola', 'Javi', '1985-02-09', 'ferran.adria@elbulli.com', '42381093238', DATETIME('now'), DATETIME('now')),
          ('Slobotzky', 'Ale', '1985-02-09', 'ferran.adria@elbulli.com', '42381093238', DATETIME('now'), DATETIME('now'));
      SQL
    )
  end

  def self.all
    Chef.db.execute(
      <<-SQL
        SELECT * FROM chefs
      SQL
    )
  end

  def self.where(attribute, name)
    Chef.db.execute(
      <<-SQL
        SELECT * FROM chefs WHERE "#{attribute}" = "#{name}"
      SQL
    )
  end

  private

  def self.db
    @@db ||= SQLite3::Database.new("chefs.db")
  end

end

#puts Chef.all
#puts Chef.where('first_name', 'Diaz')
chef = Chef.new('Ferrer', 'Carolina', '1994-04-27', 'carolina@gmail.com', '5520463984')
chef.save