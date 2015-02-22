require 'yaml'

def greeting
    puts "Make a choice:"
    puts "\e[4mA\e[0mDD a movie"
    puts "\e[4mD\e[0mELETE a movie"
    puts "\e[4mU\e[0mPDATE a movie"
    puts "D\e[4mI\e[0mSPLAY all movies"
    puts "\e[4mQ\e[0mUIT the program"
end

def add_movie
    add_hash = YAML.load_file('movies.yml')
    puts "Add a movie:"
    title = gets.chomp.downcase.gsub(" ","_").to_sym
        if add_hash[title] == nil
            system "clear"
            puts "What is your rating?"
            rating = gets.chomp.to_i
            until rating.between?(1,10)
                system "clear"
                puts "ERROR!"
                puts "Your rating must be a number between 1 and 10."
                puts "What is your rating?" 
                rating = gets.chomp.to_i
            end
            add_hash[title] = rating
        else
            system "clear"
            puts "That movies already exists!"
            print "Press ENTER to continue"
            gets
        end
    File.open('movies.yml','w') {|f| f.write(add_hash.to_yaml)}
end

def update_movie
    update_hash = YAML.load_file('movies.yml')
    puts "What is the movie title?"
    title = gets.chomp.downcase.gsub(" ","_").to_sym
    if update_hash[title] == nil
        system "clear"
        puts "That movie doesn't exist"
        print "press ENTER to continue"
        gets
    else
        puts "What is the new rating?"
        rating = gets.chomp.to_i
        until rating.between?(1,10)
            system "clear"
            puts "ERROR!"
            puts "Your rating must be a number between 1 and 10."
            puts "What is your rating?" 
            rating = gets.chomp.to_i
        end
        update_hash[title] = rating
    end
    File.open('movies.yml','w') {|f| f.write(update_hash.to_yaml)}
end

def display_movie
    system "clear"
    display_hash = YAML.load_file('movies.yml')
    display_hash.each {|k,v|
        puts k.to_s.gsub("_"," ").split.map{|k| k.capitalize}.join(' ') + ": #{v}"
    }
    puts ""
    print "Press ENTER when done"
    gets
end

def delete_movie
    delete_hash = YAML.load_file('movies.yml')
    puts "What is the movie title?"
    title = gets.chomp.downcase.gsub(" ","_").to_sym
    if delete_hash[title] == nil
        system "clear"
        puts "That movie doesn't exist!"
        print "Press ENTER to continue"
        gets
    else delete_hash.delete(title)
    File.open('movies.yml','w') {|f| f.write(delete_hash.to_yaml)}
    end
end

def error
    system "clear"
    puts "Error!"
    print "Hit ENTER to continue"
    gets
end

def hash_cleanup
    hash = YAML.load_file('movies.yml')
    hash.each {|k,v|
    puts k if v == nil
    }  
    hash.delete_if{|k, v| v == nil}
    File.open('movies.yml','w') {|f| f.write(hash.to_yaml)}
end

while true
    system "clear"
    hash_cleanup
    greeting
    choice = gets.chomp.downcase
    system "clear"
    case choice
    when "add", "a"
        add_movie
    when "delete", "d"
        delete_movie
    when "update", "u"
        update_movie
    when "display", "i"
        display_movie
    when "quit", "q"
        break
    else
        error
    end
end