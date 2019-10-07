extends Node2D

var lines: Dictionary = {
    "howtobuy": ["Hello! If you'd like anything, press 'X' to buy it.", "You can press 'X' to buy things!"],
    "doublejump": ["Usually the double jump costs more than 3 coins!", "You can jump while in the air now!"],
    "10coins": ["Hi, little one!", "Hello again, do you need anything?", "Fixing to get rid of that debt?", "Baby steps."],
    "slugshot": ["Now you'll be able to take down those nasty jellycats!", "That seems a little too heavy for you, no?", "The bullets are almost as large as you are."],
    "25coins": ["I'd help you with getting some coins, but I have a business to run here.", "Having fun out there?", "I don't usually get much business here", "You know, setting up shop under a broken bridge was a bad idea.", "I don't get many clients down in this dungeon."],
    "50coins": ["Hello again! Can I help you with anything?", "How're the jellycats doing?"],
    "divinggear": ["This'll help you get through the FLUID.", "The FLUID is horrible, it's why nothing grows here."],
    "75coins": ["Have you heard of the big jellycat?", "There's a big jelly cat not far from here"],
    "bigjellycat": ["So you got rid of the big jellycat, huh?", "Things are gonna be a lot more quiet around here"]
}

func _on_InteractionZone_body_entered(body):
    if body is Player:
        $Label.visible = true
        $ShopkeeperTalk.play()
        if body.subject in lines:
            var subject_array = lines[body.subject]
            $Label.text = subject_array[randi() % subject_array.size()]


func _on_InteractionZone_body_exited(body):
    if body is Player:
        $Label.visible = false
