class ExerciseController < ApplicationController
	def index
		@test = `swipl -s prolog/exercise.pl -g 'workout(L, Bulking, Gym)' -t 'halt'`
	end
end
