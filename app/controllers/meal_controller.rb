class MealController < ApplicationController
	def index
		@meals = params["meals"] || 3
		@Weight = params["Weight"] || 70
		@Percentage = params["Percentage"] || 30
		@activity = params["activity"] || "1"
		@build = params["build"] || "true"

		if params.size === 9
			schedule = "run(#{@meals}, #{@build}, #{@Weight}, #{@Percentage}, #{@activity})"
			@command = `swipl -s prolog/meal.pl -g '#{schedule}' -t 'halt'`
			# @command = @command[1..-2]
			@command = eval @command
			@command = convertMonth(@command)
  		end
	end

	def convertMonth command
		month = []
		command.each do |week|
			month << convertWeek(week)
		end
		month
	end

	def convertWeek command
		week = []
		command.each do |day|
			week << convertDay(day)
		end
		week
	end

	def convertDay command
		day = []
		command.each do |meal|
			day << convertMeal(meal)
		end
		day
	end

	def convertMeal command
		meal = []
		command.each do |food|
			temp = "#{Menu[food[0]]}, #{food[1]}"
			# temp = temp.strip.gsub(" ", "")
			meal << temp
		end
		meal
	end

	Menu = ["Chicken Breast (Uncooked)", "Lean Beef (Uncooked)", "Cheddar Cheese", "Gouda Cheese",
			"Swiss cheese", "Carrots", "Broccoli", "Spinach", "White Rice (Uncoooked)",
			"Potato (Uncooked)", "Tomato", "Whole Egg (Uncooked)", "Egg Whites (Uncooked)",
			"Sweet Potato (Uncooked)", "Milk full fat", "Multi Grain Bread", "Honey", "Olive Oil",
			"Pasta (Uncooked)", "Salmon (Uncooked)", "Fish", "Shrimp (Uncooked)", "Peanut butter",
			"Skimmed Milk", "Banana", "Pear", "Tuna (Brine)", "Whey Protein"]
end
