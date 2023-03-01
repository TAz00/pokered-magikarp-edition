TrainerNamePointers:
; These are only used for trainers' defeat speeches.
; They were originally shortened variants of the trainer class names
; in the Japanese versions, but are now redundant with TrainerNames.
	table_width 2, TrainerNamePointers
	dw .YoungsterName
	dw .BugCatcherName
	dw .LassName
	dw wTrainerName
	dw .JrTrainerMName
	dw .JrTrainerFName
	dw .PokemaniacName
	dw .SuperNerdName
	dw wTrainerName
	dw wTrainerName
	dw .BurglarName
	dw .EngineerName
	dw .UnusedJugglerName
	dw wTrainerName
	dw .SwimmerName
	dw wTrainerName
	dw wTrainerName
	dw .BeautyName
	dw wTrainerName
	dw .RockerName
	dw .JugglerName
	dw wTrainerName
	dw wTrainerName
	dw .BlackbeltName
	dw wTrainerName
	dw .ProfOakName
	dw .ChiefName
	dw .ScientistName
	dw wTrainerName
	dw .RocketName
	dw .CooltrainerMName
	dw .CooltrainerFName
	dw wTrainerName
	dw wTrainerName
	dw wTrainerName
	dw wTrainerName
	dw wTrainerName
	dw wTrainerName
	dw wTrainerName
	dw wTrainerName
	dw wTrainerName
	dw wTrainerName
	dw wTrainerName
	dw wTrainerName
	dw wTrainerName
	dw wTrainerName
	dw wTrainerName
	assert_table_length NUM_TRAINERS

.YoungsterName:     db "MAGIKARP@"
.BugCatcherName:    db "MAGIKARP@"
.LassName:          db "MAGIKARP@"
.JrTrainerMName:    db "MAGIKARP@"
.JrTrainerFName:    db "MAGIKARP@"
.PokemaniacName:    db "MAGIKARP@"
.SuperNerdName:     db "MAGIKARP@"
.BurglarName:       db "MAGIKARP@"
.EngineerName:      db "MAGIKARP@"
.UnusedJugglerName: db "MAGIKARP@"
.SwimmerName:       db "MAGIKARP@"
.BeautyName:        db "MAGIKARP@"
.RockerName:        db "MAGIKARP@"
.JugglerName:       db "MAGIKARP@"
.BlackbeltName:     db "MAGIKARP@"
.ProfOakName:       db "MAGIKARP@"
.ChiefName:         db "MAGIKARP@"
.ScientistName:     db "MAGIKARP@"
.RocketName:        db "MAGIKARP@"
.CooltrainerMName:  db "MAGIKARP@"
.CooltrainerFName:  db "MAGIKARP@"
