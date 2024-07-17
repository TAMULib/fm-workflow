print "\nHello World from Ruby workflow!\n"

users = reqResponse["users"]

insertQuery = "INSERT INTO tamu_workflow_examples.example_users_table (id, username, barcode, active, preferred_contact_type_id, last_name, first_name, email, created_date) VALUES "

users.each do |user|
  puts user
  personal = user["personal"]
  metadata = user["metadata"]

  barcode = ''
  if user["barcode"].nil? == false
    barcode = user["barcode"]
  end

  email = ''
  if personal["email"].nil? == false
    email = personal["email"]
  end

  insertQuery << "('" + user["id"] + "','" + user["username"] + "','" + barcode + "'," + user["active"].to_s + "," + personal["preferredContactTypeId"].to_s + ",'" + personal["lastName"] + "','" + personal["firstName"] + "','" + email + "','" + metadata["createdDate"] + "'),"
end

insertQuery = insertQuery.chomp(",")

puts insertQuery

queryWrapper = { "insertQuery" => insertQuery}

execution.setVariableLocal('queryWrapper', S(JSON.generate(queryWrapper)))
