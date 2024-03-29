:- use_module(library(clpfd)).

workout(L, Bulking, Gym) :-
	L = [W1, W2, W3, W4],
	getExercises(Exercises),
	write(Exercises).

getExercises(Exercises) :-
	Exercises = [
		('Flat Bench Press',0,0,0,5,'http://www.bodybuilding.com/exercises/detail/view/name/barbell-bench-press-medium-grip'),
		('Inclined bench press',0,0,0,5,'http://www.bodybuilding.com/exercises/detail/view/name/barbell-incline-bench-press-medium-grip'),
		('Flat Dumbbell press',0,0,1,4,'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-bench-press'),
		('Incline Dumbbell press',0,0,1,4,'http://www.bodybuilding.com/exercises/detail/view/name/incline-dumbbell-press'),
		('Butterfly',0,0,2,4,'http://www.bodybuilding.com/exercises/detail/view/name/butterfly'),
		('Inclined Dumbbell flys',0,0,1,4,'http://www.bodybuilding.com/exercises/detail/view/name/incline-dumbbell-flyes'),
		('Low Cable Crossover',0,0,3,4,'http://www.bodybuilding.com/exercises/detail/view/name/low-cable-crossover'),
		('Cable Crossover',0,0,3,4,'http://www.bodybuilding.com/exercises/detail/view/name/cable-crossover'),
		('Dumbbell Flyes',0,0,1,4,'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-flyes'),
		('Straight-Arm Dumbbell Pullover',0,0,1,4,'http://www.bodybuilding.com/exercises/detail/view/name/straight-arm-dumbbell-pullover'),
		('Bent-Knee Hip Raise',0,1,4,4,'http://www.bodybuilding.com/exercises/detail/view/name/bent-knee-hip-raise'),
		('Cable Crunch',0,1,3,4,'http://www.bodybuilding.com/exercises/detail/view/name/cable-crunch'),
		('Cable Reverse Crunch',0,1,3,4,'http://www.bodybuilding.com/exercises/finder/lookup/filter/muscle/id/1/muscle/chest'),
		('Decline Reverse Crunch',0,1,4,4,'http://www.bodybuilding.com/exercises/detail/view/name/decline-reverse-crunch'),
		('Decline Crunch',0,1,4,4,'http://www.bodybuilding.com/exercises/detail/view/name/decline-crunch'),
		('Dumbbell Side Bend',0,1,1,4,'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-side-bend'),
		('Elbow to Knee',0,1,4,4,'http://www.bodybuilding.com/exercises/detail/view/name/elbow-to-knee'),
		('Exercise Ball Crunch',0,1,5,4,'http://www.bodybuilding.com/exercises/detail/view/name/exercise-ball-crunch'),
		('Jackknife Sit-Up',0,1,4,4,'http://www.bodybuilding.com/exercises/detail/view/name/jackknife-sit-up'),
		('Knee/Hip Raise On Parallel Bars',0,1,4,4,'http://www.bodybuilding.com/exercises/detail/view/name/kneehip-raise-on-parallel-bars'),
		('One-Arm High-Pulley Cable Side Bends',0,1,3,5,'http://www.bodybuilding.com/exercises/detail/view/name/one-arm-high-pulley-cable-side-bends-'),
		('Alternate Hammer Curl',0,2,1,5,'http://www.bodybuilding.com/exercises/detail/view/name/alternate-hammer-curl'),
		('Alternate Incline Dumbbell Curl',0,2,1,4,'http://www.bodybuilding.com/exercises/detail/view/name/alternate-incline-dumbbell-curl'),
		('Barbell Curl',0,2,0,5,'http://www.bodybuilding.com/exercises/detail/view/name/barbell-curl'),
		('Close-Grip EZ Bar Curl',0,2,0,5,'http://www.bodybuilding.com/exercises/detail/view/name/close-grip-ez-bar-curl'),
		('Concentration Curls',0,2,1,4,'http://www.bodybuilding.com/exercises/detail/view/name/concentration-curls'),
		('Dumbbell Alternate Bicep Curl',0,2,1,4,'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-alternate-bicep-curl'),
		('Machine Preacher Curls',0,2,2,4,'http://www.bodybuilding.com/exercises/detail/view/name/machine-preacher-curls'),
		('Overhead Cable Curl',0,2,3,4,'http://www.bodybuilding.com/exercises/detail/view/name/overhead-cable-curl'),
		('Standing One-Arm Dumbbell Curl Over Incline Bench',0,2,1,4,'http://www.bodybuilding.com/exercises/detail/view/name/standing-one-arm-dumbbell-curl-over-incline-bench'),
		('Wide-Grip Standing Barbell Curl',0,2,0,4,'http://www.bodybuilding.com/exercises/detail/view/name/wide-grip-standing-barbell-curl'),
		('Cable One Arm Tricep Extension',0,3,3,4,'http://www.bodybuilding.com/exercises/detail/view/name/cable-one-arm-tricep-extension'),
		('Cable Rope Overhead Triceps Extension',0,3,3,4,'http://www.bodybuilding.com/exercises/detail/view/name/cable-rope-overhead-triceps-extension'),
		('Close-Grip Barbell Bench Press',0,3,0,4,'http://www.bodybuilding.com/exercises/detail/view/name/close-grip-barbell-bench-press'),
		('EZ-Bar Skullcrusher',0,3,0,5,'http://www.bodybuilding.com/exercises/detail/view/name/ez-bar-skullcrusher'),
		('Incline Barbell Triceps Extension',0,3,0,4,'http://www.bodybuilding.com/exercises/detail/view/name/incline-barbell-triceps-extension'),
		('Reverse Grip Triceps Pushdown',0,3,3,4,'http://www.bodybuilding.com/exercises/detail/view/name/reverse-grip-triceps-pushdown'),
		('Seated Triceps Press',0,3,1,4,'http://www.bodybuilding.com/exercises/detail/view/name/seated-triceps-press'),
		('Standing Low-Pulley One-Arm Triceps Extension',0,3,1,4,'http://www.bodybuilding.com/exercises/detail/view/name/standing-low-pulley-one-arm-triceps-extension'),
		('Triceps Pushdown',0,3,3,5,'http://www.bodybuilding.com/exercises/detail/view/name/triceps-pushdown'),
		('Weighted Bench Dip',0,3,4,4,'http://www.bodybuilding.com/exercises/detail/view/name/weighted-bench-dip'),
		('Alternating Deltoid Raise',0,4,1,4,'http://www.bodybuilding.com/exercises/detail/view/name/alternating-deltoid-raise'),
		('Barbell Shoulder Press',0,4,0,4,'http://www.bodybuilding.com/exercises/detail/view/name/barbell-shoulder-press'),
		('Bent Over Dumbbell Rear Delt Raise With Head On Bench',0,4,1,4,'http://www.bodybuilding.com/exercises/detail/view/name/bent-over-dumbbell-rear-delt-raise-with-head-on-bench'),
		('Dumbbell Lying One-Arm Rear Lateral Raise',0,4,1,5,'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-lying-one-arm-rear-lateral-raise'),
		('Dumbbell Shoulder Press',0,4,1,5,'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-shoulder-press'),
		('Front Dumbbell Raise',0,4,1,4,'http://www.bodybuilding.com/exercises/detail/view/name/front-dumbbell-raise'),
		('Machine Shoulder (Military) Press',0,4,2,4,'http://www.bodybuilding.com/exercises/detail/view/name/machine-shoulder-military-press'),
		('Seated Barbell Military Press',0,4,0,4,'http://www.bodybuilding.com/exercises/detail/view/name/seated-barbell-military-press'),
		('Seated Side Lateral Raise',0,4,1,4,'http://www.bodybuilding.com/exercises/detail/view/name/seated-side-lateral-raise'),
		('Smith Machine Overhead Shoulder Press',0,4,2,4,'http://www.bodybuilding.com/exercises/detail/view/name/smith-machine-overhead-shoulder-press'),
		('Barbell Deadlift',0,5,0,5,'http://www.bodybuilding.com/exercises/detail/view/name/barbell-deadlift'),
		('Bent Over Barbell Row',0,5,0,5,'http://www.bodybuilding.com/exercises/detail/view/name/bent-over-barbell-row'),
		('Close-Grip Front Lat Pulldown',0,5,2,4,'http://www.bodybuilding.com/exercises/detail/view/name/close-grip-front-lat-pulldown'),
		('Elevated Cable Rows',0,5,2,4,'http://www.bodybuilding.com/exercises/detail/view/name/elevated-cable-rows'),
		('Hyperextensions',0,5,2,4,'http://www.bodybuilding.com/exercises/detail/view/name/hyperextensions-back-extensions'),
		('One-Arm Dumbbell Row',0,5,1,4,'http://www.bodybuilding.com/exercises/detail/view/name/one-arm-dumbbell-row'),
		('Reverse Grip Bent-Over Rows',0,5,0,5,'http://www.bodybuilding.com/exercises/detail/view/name/reverse-grip-bent-over-rows'),
		('V-Bar Pulldown',0,5,2,4,'http://www.bodybuilding.com/exercises/detail/view/name/v-bar-pulldown'),
		('Wide-Grip Lat Pulldown',0,5,2,5,'http://www.bodybuilding.com/exercises/detail/view/name/wide-grip-lat-pulldown'),
		('Barbell Full Squat',0,6,0,5,'http://www.bodybuilding.com/exercises/detail/view/name/barbell-full-squat'),
		('Front Barbell Squat',0,6,0,5,'http://www.bodybuilding.com/exercises/detail/view/name/front-barbell-squat'),
		('Hack Squat',0,6,2,3,'http://www.bodybuilding.com/exercises/detail/view/name/hack-squat'),
		('Leg Press',0,6,2,5,'http://www.bodybuilding.com/exercises/detail/view/name/leg-press'),
		('Leg Extensions',0,6,2,4,'http://www.bodybuilding.com/exercises/detail/view/name/leg-extensions'),
		('Narrow Stance Leg Press',0,6,2,4,'http://www.bodybuilding.com/exercises/detail/view/name/narrow-stance-leg-press'),
		('Smith Machine Squat',0,6,2,4,'http://www.bodybuilding.com/exercises/detail/view/name/smith-machine-squat'),
		('Split Squat with Dumbbells',0,6,1,4,'http://www.bodybuilding.com/exercises/detail/view/name/split-squat-with-dumbbells'),
		('Floor Glute-Ham Raise',0,7,4,4,'http://www.bodybuilding.com/exercises/detail/view/name/floor-glute-ham-raise'),
		('Good Morning',0,7,0,4,'http://www.bodybuilding.com/exercises/detail/view/name/good-morning'),
		('Lying Leg Curls',0,7,2,5,'http://www.bodybuilding.com/exercises/detail/view/name/lying-leg-curls'),
		('Romanian Deadlift',0,7,0,5,'http://www.bodybuilding.com/exercises/detail/view/name/romanian-deadlift'),
		('Seated Leg Curl',0,7,2,5,'http://www.bodybuilding.com/exercises/detail/view/name/seated-leg-curl'),
		('Stiff-Legged Dumbbell Deadlift',0,7,1,4,'http://www.bodybuilding.com/exercises/detail/view/name/stiff-legged-dumbbell-deadlift'),
		('Barbell Shrug Behind The Back',0,8,0,5,'http://www.bodybuilding.com/exercises/detail/view/name/barbell-shrug-behind-the-back'),
		('Barbell Shrug',0,8,0,5,'http://www.bodybuilding.com/exercises/detail/view/name/barbell-shrug'),
		('Dumbbell Shrug',0,8,1,5,'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-shrug'),
		('Smith Machine Shrug',0,8,2,5,'http://www.bodybuilding.com/exercises/detail/view/name/smith-machine-shrug'),
		('Cable Shrugs',0,8,2,5,'http://www.bodybuilding.com/exercises/detail/view/name/cable-shrugs'),
		('Barbell Seated Calf Raise',0,9,0,5,'http://www.bodybuilding.com/exercises/detail/view/name/barbell-seated-calf-raise'),
		('Calf Press On The Leg Press Machine',0,9,2,5,'http://www.bodybuilding.com/exercises/detail/view/name/calf-press-on-the-leg-press-machine'),
		('Seated Calf Raise',0,9,2,5,'http://www.bodybuilding.com/exercises/detail/view/name/seated-calf-raise'),
		('Smith Machine Calf Raise',0,9,2,5,'http://www.bodybuilding.com/exercises/detail/view/name/smith-machine-calf-raise'),
		('Standing Dumbbell Calf Raise',0,9,1,5,'http://www.bodybuilding.com/exercises/detail/view/name/standing-dumbbell-calf-raise'),
		('Cardio on treadmill (Minimum of 3 times a week)- 1 minute inclined walk and 30 seconds inclined sprints (10 sets) a total of 15 Minutes',1,10,2,5,'http://')
	].