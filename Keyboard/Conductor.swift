//
//  Conductor.swift
//  SwiftKeyboard
//
//  Created by Aurelius Prochazka on 11/28/14.
//  Copyright (c) 2014 AudioKit. All rights reserved.
//

class Conductor {
    
    var soundFont = AKSoundFont(filename: NSBundle.mainBundle().pathForResource("AcousticGuitar", ofType:"sf2")!)
    var presetPlayer: AKInstrument
    var player: AKSoundFontInstrumentPlayer
    
    
    init() {
        
        soundFont.fetchPresets(nil)
        print("Sound Font Loaded: \(soundFont.loaded)")
        
        presetPlayer = AKInstrument(number: 1)
        
        let soundFontInstrument = AKSoundFontInstrument(name: "SFTester", number: 0, soundFont: soundFont)
        player = AKSoundFontInstrumentPlayer(soundFontInstrument: soundFontInstrument)
        player.noteNumber = akp(62)
        player.frequencyMultiplier = akp(1.0)
        player.amplitude = akp(0.5)
        player.velocity = akp(0.2)
        presetPlayer.setStereoAudioOutput(player)
        AKOrchestra.addInstrument(presetPlayer)
        
        AKOrchestra.start()
    }
    
    func play(key: Int, duration: Float, velocity: Int) {
        
        player.noteNumber = AKConstant(integer: key)
        player.velocity = akp(Float(velocity)/128.0)
        
        print("Player Velocity: \(player.velocity)")
        let note = AKNote(instrument: presetPlayer, forDuration: NSTimeInterval(duration))
        presetPlayer.playNote(note)
    }
}