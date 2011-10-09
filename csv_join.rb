require 'csv'

puts ARGV
if ARGV.size != 2 
  puts "incorrect number of arguments"
  exit 0
end 


inigral_text = File.read(ARGV[0])
school_text = File.read(ARGV[1])

inigral_data = CSV.parse(inigral_text) 
school_data = CSV.parse(school_text)

USER_EXPORT_SOURCED_ID = 17
SCHOOL_DATA_STUDENT_ID = 0
empty_row = Array.new(school_data[0].size)


sourced_id_to_index = {}
(1..(school_data.size - 1)).each do |index| 
  #puts index
  sourced_id = school_data[index][SCHOOL_DATA_STUDENT_ID]
  sourced_id_to_index[sourced_id] = index
end


results_csv = File.new("output_#{Time.now}.csv", "w+")

results_csv.puts (inigral_data[0] + school_data[0]).to_csv
(1..(inigral_data.size - 1)).each do |index|
  sourced_id = inigral_data[index][USER_EXPORT_SOURCED_ID]
  school_data_index = sourced_id_to_index[sourced_id]
  if school_data_index 
    results_csv.puts (inigral_data[index] + school_data[school_data_index]).to_csv
  else 
    results_csv.puts (inigral_data[index] + empty_row).to_csv
  end
end

results_csv.close
