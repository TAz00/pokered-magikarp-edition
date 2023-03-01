MACRO pic_money
	dw \1
	bcd3 \2
ENDM

TrainerPicAndMoneyPointers::
	table_width 5, TrainerPicAndMoneyPointers
	; pic pointer, base reward money
	; money received after battle = base money × level of last enemy mon
	pic_money YoungsterPic,    1500
	pic_money YoungsterPic,   1000
	pic_money YoungsterPic,         1500
	pic_money YoungsterPic,       3000
	pic_money YoungsterPic,   2000
	pic_money YoungsterPic,   2000
	pic_money YoungsterPic,   5000
	pic_money YoungsterPic,    2500
	pic_money YoungsterPic,        3500
	pic_money YoungsterPic,        2000
	pic_money YoungsterPic,      9000
	pic_money YoungsterPic,     5000
	pic_money YoungsterPic,      3500
	pic_money YoungsterPic,       3500
	pic_money YoungsterPic,       500
	pic_money YoungsterPic,      2500
	pic_money YoungsterPic,      7000
	pic_money YoungsterPic,       7000
	pic_money YoungsterPic,      1000
	pic_money YoungsterPic,       2500
	pic_money YoungsterPic,      3500
	pic_money YoungsterPic,        4000
	pic_money YoungsterPic,   2500
	pic_money YoungsterPic,    2500
	pic_money Rival1Pic,       3500
	pic_money ProfOakPic,      9900
	pic_money YoungsterPic,        3000
	pic_money YoungsterPic,    5000
	pic_money GiovanniPic,     9900
	pic_money RocketPic,       3000
	pic_money YoungsterPic, 3500
	pic_money YoungsterPic, 3500
	pic_money BrunoPic,        9900
	pic_money BrockPic,        9900
	pic_money MistyPic,        9900
	pic_money LtSurgePic,      9900
	pic_money ErikaPic,        9900
	pic_money KogaPic,         9900
	pic_money BlainePic,       9900
	pic_money SabrinaPic,      9900
	pic_money YoungsterPic,    7000
	pic_money YoungsterPic,       6500
	pic_money YoungsterPic,       9900
	pic_money LoreleiPic,      9900
	pic_money ChannelerPic,    3000
	pic_money AgathaPic,       9900
	pic_money LancePic,        9900
	assert_table_length NUM_TRAINERS
