######################################################
# Roboy Cognition env
######################################################

export COGNITION_WS="/home/roboy/cognition_ws"
source $COGNITION_WS/devel/setup.bash

export NEO4J_USERNAME=""
export NEO4J_ADDRESS="bolt://bot.roboy.org:7687"
export NEO4J_PASSWORD=""

######################################################

# if [ ! -d /var/run/neo4j ]; then
# 	sudo mkdir /var/run/neo4j
	
# fi
# sudo neo4j start

roscore&
sleep 2
echo "STARTED ROSCORE"

cd $COGNITION_WS
source devel/setup.bash
roslaunch roboy_cognition_manager roboy.launch &
sleep 5
echo "STARTED roboy_cognition_manager"
cd src/roboy_cognition/DeepQA
./advertise_gnlp_service &
echo "STARTED roboy_generative_nlp"


cd $COGNITION_WS/src/roboy_cognition/roboy_memory/target
java -jar roboy_memory-1.0.0-jar-with-dependencies.jar &
echo "STARTED roboy_memory"

rosservice call /roboy/cognition/generative_nlp/answer "text_input: 'hey ho'"


# while true; do

# 	echo "Start dialog system? (y/n)"
# 	read dialog
# 	if [ "$dialog" == "y" ]; then
# 		echo "Starting dialog"
#   		cd /home/roboy/cognition_ws/src/roboy_cognition/roboy_dialog
# 		mvn exec:java -Dexec.mainClass=\"roboy.dialog.DialogSystem\"
#   		break
# 	fi

# done
