//
//  EffectsProcessor.swift
//  SwiftKeyboard
//
//  Created by Aurelius Prochazka on 11/28/14.
//  Copyright (c) 2014 AudioKit. All rights reserved.
//

class EffectsProcessor: AKInstrument {

    // Instrument Properties
    var feedbackLevel  = AKInstrumentProperty(value: 0.0, minimum: 0.0, maximum: 1.0)
    
    init(audioSource: AKAudio) {
        
        super.init()

        // Instrument Properties
        addProperty(feedbackLevel)

        // Instrument Definition
        let reverb = AKReverb(
            input: audioSource,
            feedback: feedbackLevel,
            cutoffFrequency: 4000.ak
        )
        
        let leftMix = AKMix(
            input1: reverb.leftOutput,
            input2: audioSource,
            balance: 0.5.ak
        )

        let rightMix = AKMix(
            input1: reverb.rightOutput,
            input2: audioSource,
            balance: 0.5.ak
        )
        
        connect(AKAudioOutput(leftAudio: leftMix, rightAudio: rightMix))
            
        resetParameter(audioSource)
    }
}
