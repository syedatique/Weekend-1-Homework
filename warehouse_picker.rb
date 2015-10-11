# Warehouse Picker

@list_product_in_key= {"bath fizzers"=>"b7", "blouse"=> "a3", "bookmark"=> "a7", "candy wrapper"=> "c8", "chalk"=> "c3", "cookie jar"=> "b10", "deodorant"=> "b9", "drill press"=> "c2", "face wash"=> "c6", "glow stick"=> "a9", "hanger"=> "a4", "leg warmers"=> "c10", "model car"=> "a8", "nail filer"=> "b5", "needle"=> "a1", "paint brush"=> "c7", "photo album"=> "b4", "picture frame"=> "b3", "rubber band"=> "a10", "rubber duck"=> "a5", "rusty nail"=> "c1", "sharpie"=> "b2", "shoe lace"=> "c9", "shovel"=> "a6", "stop sign"=> "a2", "thermometer"=> "c5", "tire swing"=> "b1", "tissue box"=> "b8", "tooth paste"=> "b6", "word search"=> "c4"}

@list_bay_in_key = @list_product_in_key.invert # now, products are in "value" field

@lane_a = ["a1", "a2", "a3", "a4", "a5", "a6","a7", "a8", "a9","a10"]
@lane_b = ["b1", "b2", "b3", "b4", "b5", "b6","b7", "b8", "b9","b10"]
@lane_c = ["c1", "c2", "c3", "c4", "c5", "c6","c7", "c8", "c9","c10"]

@lane_arrangement = @lane_a.reverse + @lane_c + @lane_b


def menu
  puts `clear`
  puts "\n*** Warehouse Picker ***"
  puts "Checking bay's items and their location "
  puts "\nPlease select the options:"
  print "\n(1) Check bays to see which items they contain, (2) Check the bay location of items or (q)uit: "
  gets.chomp.downcase
end

def pause
puts "To continue press enter..."
  gets
end

def find_bay
  puts "\n Select the bay numbers you wish to check: #{@list_bay_in_key.keys.join(', ')}"
  bay_select = gets.chomp.downcase.split(" ")

  bay_select.each {|bay| puts "Bay #{bay} contain product #{@list_bay_in_key[bay]}"}

  # distance=bay_select.map { |bay| @lane_arrangement.index(bay) }.max
  # puts "The distance from the two furthest apart bays is #{distance}"

  distance = []
  bay_select.each_with_index do |bay, index|
   distance[index] = @lane_arrangement.index(bay)
  end
  puts "The distance from the two furthest apart bays (start bay to final bay) is #{distance.max - distance.min} bays"
end

def find_product
  puts "\n Select the items (separated by comma) you wish to find: #{@list_product_in_key.keys.join(', ')}"
  product_select = gets.chomp.downcase.split(", ")

  lane_num = []
  lane_number_index = []
  product_select.each_with_index do |product, indx|
    lane_num[indx] = @list_product_in_key[product]
    puts "Products #{product} can be found in #{lane_num[indx]}"

    
    lane_number_index[indx] = @lane_arrangement.index(lane_num[indx])
  end
  puts "lane number #{lane_num}"
  lane_number_index = lane_number_index.sort
  puts "lane number in index #{lane_number_index}"

  # lane_number_index.each {|ln_num| puts "Items need to be collected from #{@lane_arrangement[ln_num]} in order"}

  lane_order = []
  lane_number_index.each_with_index do |ln_num, index|

     lane_order[index] = @lane_arrangement[ln_num.to_i]
   end
   puts "Items need to be collected from #{lane_order.join(', ')} in order"

end


response = menu
until response == 'q'
  case response
  when '1'
    find_bay
  when '2'
    find_product
  end

  pause
  response = menu
end
