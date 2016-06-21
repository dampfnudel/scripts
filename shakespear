#/bin/bash

declare -a expressions=('Ploink' 'I Need Oil' 'Some Bytes are Missing' 'Poink Poink' 'Piiiip Beeeep' 'Hello' 'Whoops I am out of memory')

declare -a first=(
    "artless"
    "bawdy"
    "beslubbering"
    "bootless"
    "churlish"
    "cockered"
    "clouted"
    "craven"
    "currish"
    "dankish"
    "dissembling"
    "droning"
    "errant"
    "fawning"
    "fobbing"
    "froward"
    "frothy"
    "gleeking"
    "goatish"
    "gorbellied"
    "impertinent"
    "infectious"
    "jarring"
    "loggerheaded"
    "lumpish"
    "mammering"
    "mangled"
    "mewling"
    "paunchy"
    "pribbling"
    "puking"
    "puny"
    "quailing"
    "rank"
    "reeky"
    "roguish"
    "ruttish"
    "saucy"
    "spleeny"
    "spongy"
    "surly"
    "tottering"
    "unmuzzled"
    "vain"
    "venomed"
    "villainous"
    "warped"
    "wayward"
    "weedy"
    "yeasty"
)

declare -a second=(
    "base-court"
    "bat-fowling"
    "beef-witted"
    "beetle-headed"
    "boil-brained"
    "clapper-clawed"
    "clay-brained"
    "common-kissing"
    "crook-pated"
    "dismal-dreaming"
    "dizzy-eyed"
    "doghearted"
    "dread-bolted"
    "earth-vexing"
    "elf-skinned"
    "fat-kidneyed"
    "fen-sucked"
    "flap-mouthed"
    "fly-bitten"
    "folly-fallen"
    "fool-born"
    "full-gorged"
    "guts-griping"
    "half-faced"
    "hasty-witted"
    "hedge-born"
    "hell-hated"
    "idle-headed"
    "ill-breeding"
    "ill-nurtured"
    "knotty-pated"
    "milk-livered"
    "motley-minded"
    "onion-eyed"
    "plume-plucked"
    "pottle-deep"
    "pox-marked"
    "reeling-ripe"
    "rough-hewn"
    "rude-growing"
    "rump-fed"
    "shard-borne"
    "sheep-biting"
    "spur-galled"
    "swag-bellied"
    "tardy-gaited"
    "tickle-brained"
    "toad-spotted"
    "unchin-snouted"
    "weather-bitten"
)

declare -a third=(
    "apple-john"
    "baggage"
    "barnacle"
    "bladder"
    "boar-pig"
    "bugbear"
    "bum-bailey"
    "canker-blossom"
    "clack-dish"
    "clotpole"
    "coxcomb"
    "codpiece"
    "death-token"
    "dewberry"
    "flap-dragon"
    "flax-wench"
    "flirt-gill"
    "foot-licker"
    "fustilarian"
    "giglet"
    "gudgeon"
    "haggard"
    "harpy"
    "hedge-pig"
    "horn-beast"
    "hugger-mugger"
    "joithead"
    "lewdster"
    "lout"
    "maggot-pie"
    "malt-worm"
    "mammet"
    "measle"
    "minnow"
    "miscreant"
    "moldwarp"
    "mumble-news"
    "nut-hook"
    "pigeon-egg"
    "pignut"
    "puttock"
    "pumpion"
    "ratsbane"
    "scut"
    "skainsmate"
    "strumpet"
    "varlot"
    "vassal"
    "whey-face"
    "wagtail"
)
voices=(
    Agnes
    Kathy
    Princess
    Vicki
    Victoria
    Alex
    Bruce
    Fred
    Junior
    Ralph
    Albert
    'Bad News'
    Bahh
    Bells
    Boing
    Bubbles
    Cellos
    Deranged
    'Good News'
    Hysterical
    'Pipe Organ'
    Trinoids
    Whisper
    Zarvox
)

first_index=$( jot -r 1  0 $((${#first[@]} - 1)) )
first_selected=${first[first_index]}

second_index=$( jot -r 1  0 $((${#second[@]} - 1)) )
second_selected=${second[second_index]}

third_index=$( jot -r 1  0 $((${#third[@]} - 1)) )
third_selected=${third[third_index]}

voice_index=$( jot -r 1  0 $((${#voices[@]} - 1)) )
voice_selected=${voices[voice_index]}

echo $voice_selected
echo "$first_selected $second_selected $third_selected"
# say -v "$voice_selected" "$first_selected $second_selected $third_selected" -r 150
say -v Princess "$first_selected $second_selected $third_selected" -r 120
