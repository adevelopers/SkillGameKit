//
//  Substance.swift
//  SkillGameKit
//
//  Created by Kirill Khudyakov on 19.07.17.
//  Copyright © 2017 adeveloper. All rights reserved.
//

//// Usage:
//var root = Substance(value: "a")
//let child = Substance(value: "b", child: Substance(value: "c"))
//root.child = child


struct Substance<T> {
    private var _child: [Substance]?
    var child: Substance? {
        set {
            _child = newValue.map{[$0]}
        }
        get {
            return _child?.first
        }
    }
    var value: T
    
    init(value: T, child: Substance? = nil) {
        _child = child.map{ [$0] }
        self.value = value
    }
}


