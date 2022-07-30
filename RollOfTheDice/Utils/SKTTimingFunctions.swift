//
//  SKTimingFunctions.swift
//  RollOfTheDice
//
//  Created by David Sadler on 7/29/22.
//

/// https://github.com/raywenderlich/SKTUtils

import Foundation
import CoreGraphics

public func SKTTimingFunctionLinear(_ t: Float) -> Float {
  return t
}

public func SKTTimingFunctionQuadraticEaseIn(_ t: Float) -> Float {
  return t * t
}

public func SKTTimingFunctionQuadraticEaseOut(_ t: Float) -> Float {
  return t * (2.0 - t)
}

public func SKTTimingFunctionQuadraticEaseInOut(_ t: Float) -> Float {
  if t < 0.5 {
    return 2.0 * t * t
  } else {
    let f = t - 1.0
    return 1.0 - 2.0 * f * f
  }
}

func SKTTimingFunctionCubicEaseIn(_ t: Float) -> Float {
  return t * t * t
}

func SKTTimingFunctionCubicEaseOut(_ t: Float) -> Float {
  let f = t - 1.0
  return 1.0 + f * f * f
}

public func SKTTimingFunctionCubicEaseInOut(_ t: Float) -> Float {
  if t < 0.5 {
    return 4.0 * t * t * t
  } else {
    let f = t - 1.0
    return 1.0 + 4.0 * f * f * f
  }
}

public func SKTTimingFunctionQuarticEaseIn(_ t: Float) -> Float {
  return t * t * t * t
}

public func SKTTimingFunctionQuarticEaseOut(_ t: Float) -> Float {
  let f = t - 1.0
  return 1.0 - f * f * f * f
}

public func SKTTimingFunctionQuarticEaseInOut(_ t: Float) -> Float {
  if t < 0.5 {
    return 8.0 * t * t * t * t
  } else {
    let f = t - 1.0
    return 1.0 - 8.0 * f * f * f * f
  }
}

public func SKTTimingFunctionQuinticEaseIn(_ t: Float) -> Float {
  return t * t * t * t * t
}

public func SKTTimingFunctionQuinticEaseOut(_ t: Float) -> Float {
  let f = t - 1.0
  return 1.0 + f * f * f * f * f
}

func SKTTimingFunctionQuinticEaseInOut(_ t: Float) -> Float {
  if t < 0.5 {
    return 16.0 * t * t * t * t * t
  } else {
    let f = t - 1.0
    return 1.0 + 16.0 * f * f * f * f * f
  }
}

public func SKTTimingFunctionSineEaseIn(_ t: Float) -> Float {
  return sin((t - 1.0) * .pi/2) + 1.0
}

public func SKTTimingFunctionSineEaseOut(_ t: Float) -> Float {
  return sin(t * .pi/2)
}

public func SKTTimingFunctionSineEaseInOut(_ t: Float) -> Float {
  return 0.5 * (1.0 - cos(t * .pi))
}

public func SKTTimingFunctionCircularEaseIn(_ t: Float) -> Float {
  return 1.0 - sqrt(1.0 - t * t)
}

public func SKTTimingFunctionCircularEaseOut(_ t: Float) -> Float {
  return sqrt((2.0 - t) * t)
}

public func SKTTimingFunctionCircularEaseInOut(_ t: Float) -> Float {
  if t < 0.5 {
    return 0.5 * (1.0 - sqrt(1.0 - 4.0 * t * t))
  } else {
    return 0.5 * sqrt(-4.0 * t * t + 8.0 * t - 3.0) + 0.5
  }
}

public func SKTTimingFunctionExponentialEaseIn(_ t: Float) -> Float {
  return (t == 0.0) ? t : pow(2.0, 10.0 * (t - 1.0))
}

public func SKTTimingFunctionExponentialEaseOut(_ t: Float) -> Float {
  return (t == 1.0) ? t : 1.0 - pow(2.0, -10.0 * t)
}

public func SKTTimingFunctionExponentialEaseInOut(_ t: Float) -> Float {
  if t == 0.0 || t == 1.0 {
    return t
  } else if t < 0.5 {
    return 0.5 * pow(2.0, 20.0 * t - 10.0)
  } else {
    return 1.0 - 0.5 * pow(2.0, -20.0 * t + 10.0)
  }
}

public func SKTTimingFunctionElasticEaseIn(_ t: Float) -> Float {
  return sin(13.0 * .pi/2 * t) * pow(2.0, 10.0 * (t - 1.0))
}

public func SKTTimingFunctionElasticEaseOut(_ t: Float) -> Float {
  return sin(-13.0 * .pi/2 * (t + 1.0)) * pow(2.0, -10.0 * t) + 1.0
}

public func SKTTimingFunctionElasticEaseInOut(_ t: Float) -> Float {
  if t < 0.5 {
    return 0.5 * sin(13.0 * .pi * t) * pow(2.0, 20.0 * t - 10.0)
  } else {
    return 0.5 * sin(-13.0 * .pi * t) * pow(2.0, -20.0 * t + 10.0) + 1.0
  }
}

public func SKTTimingFunctionBackEaseIn(_ t: Float) -> Float {
  let s: Float = 1.70158
  return ((s + 1.0) * t - s) * t * t
}

public func SKTTimingFunctionBackEaseOut(_ t: Float) -> Float {
  let s: Float = 1.70158
  let f = 1.0 - t
  return 1.0 - ((s + 1.0) * f - s) * f * f
}

public func SKTTimingFunctionBackEaseInOut(_ t: Float) -> Float {
  let s: Float = 1.70158
  if t < 0.5 {
    let f = 2.0 * t
    return 0.5 * ((s + 1.0) * f - s) * f * f
  } else {
    let f = 2.0 * (1.0 - t)
    return 1.0 - 0.5 * ((s + 1.0) * f - s) * f * f
  }
}

public func SKTTimingFunctionExtremeBackEaseIn(_ t: Float) -> Float {
  return (t * t - sin(t * .pi)) * t
}

public func SKTTimingFunctionExtremeBackEaseOut(_ t: Float) -> Float {
  let f = 1.0 - t
  return 1.0 - (f * f - sin(f * .pi)) * f
}

public func SKTTimingFunctionExtremeBackEaseInOut(_ t: Float) -> Float {
  if t < 0.5 {
    let f = 2.0 * t
    return 0.5 * (f * f - sin(f * .pi)) * f
  } else {
    let f = 2.0 * (1.0 - t)
    return 1.0 - 0.5 * (f * f - sin(f * .pi)) * f
  }
}

public func SKTTimingFunctionBounceEaseIn(_ t: Float) -> Float {
  return 1.0 - SKTTimingFunctionBounceEaseOut(1.0 - t)
}

public func SKTTimingFunctionBounceEaseOut(_ t: Float) -> Float {
  if t < 1.0 / 2.75 {
    return 7.5625 * t * t
  } else if t < 2.0 / 2.75 {
    let f = t - 1.5 / 2.75
    return 7.5625 * f * f + 0.75
  } else if t < 2.5 / 2.75 {
    let f = t - 2.25 / 2.75
    return 7.5625 * f * f + 0.9375
  } else {
    let f = t - 2.625 / 2.75
    return 7.5625 * f * f + 0.984375
  }
}

public func SKTTimingFunctionBounceEaseInOut(_ t: Float) -> Float {
  if t < 0.5 {
    return 0.5 * SKTTimingFunctionBounceEaseIn(t * 2.0)
  } else {
    return 0.5 * SKTTimingFunctionBounceEaseOut(t * 2.0 - 1.0) + 0.5
  }
}

public func SKTTimingFunctionSmoothstep(_ t: Float) -> Float {
  return t * t * (3 - 2 * t)
}

public func SKTCreateShakeFunction(_ oscillations: Int) -> (Float) -> Float {
  return {t in -pow(2.0, -10.0 * t) * sin(t * .pi * Float(oscillations) * 2.0) + 1.0}
}
