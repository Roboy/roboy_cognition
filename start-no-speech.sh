if [ ! -d /var/run/neo4j ]; then
	sudo mkdir /var/run/neo4j
	
fi
sudo neo4j start
cd ~/cognition_ws
source devel/setup.bash
roslaunch roboy_cognition_manager roboy-no-recog.launch &
sleep 5
cd src/roboy_cognition/DeepQA 
./advertise_gnlp_service &

cd /home/roboy/cognition_ws/src/roboy_cognition/roboy_memory/target
java -jar roboy_memory-1.0.0-jar-with-dependencies.jar &

# rosservice call /roboy/cognition/generative_nlp/answer "text_input: 'hey ho'"


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