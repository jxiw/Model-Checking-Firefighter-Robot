go
pick_state -r
simulate -r -k 4000
show_traces -o log.txt

#check1: The robot can't go advance if the temperature measurement over the certain degree.
#AG((engine.frontTemperature \ge threshold) \rightarrow AX(\neg enable(GoAhead))
check_ctlspec -p "AG(( eig.NuVut mod 0ud3_3 >= 0ud3_2) -> AX(eig.Nuplace!=NuSS5) )"

#check2: Once the robot finds a victim, it must transmit their location to the rescue mission control centre.
#AG((engine.state = findVictim) \rightarrow AX (transmitter.state = sendMessage) ) 
check_ctlspec -p "AG (eig.Nuplace = NuSS6 -> AX (transim.Nuplace = NuSWork))"

#check3: Once the robot go advance, it should  measure the temperature again.
#AG(EF(engine.state = startMeasure))
check_ctlspec -p "AG EF eig.Nuplace=NuSStart"

#check4: Deadlock-freedom for action GoAhead
#AG(EF(enable(a)))
check_ctlspec -p "AG(EF(eig.Nuplace=NuSS5))"

#check5: No Starvation for action rotate
#AG(AF(after(a)))
check_ctlspec -p "AG(AF(eig.Nuplace=NuSS4))"

#check deadlock_free
check_fsm

#computer reachable state and deadlock_free diameter
computer_reachable


