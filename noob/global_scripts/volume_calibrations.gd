extends Node

var mics = [0]
var max_vol = [1,1]
var reset = false
var callib_mode = 0
var left_volume = [0,0]
var right_volume = [1,1]
var decline_function = [0,0]

func calcDecline():
    decline_function = [
        right_volume[0] - left_volume[0],
        right_volume[1] - left_volume[1]
    ]