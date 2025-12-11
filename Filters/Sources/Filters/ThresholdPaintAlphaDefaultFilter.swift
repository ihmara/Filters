//
//  ThresholdPaintAlphaDefaultFilter.swift
//  PaintAlpha
//
//  Created by Igor Hmara on 11.12.25.
//

import CoreImage

public struct ThresholdPaintAlphaDefaultFilter {

    private static let thresholdPaintAlphaKernel: CIColorKernel? = {
        // If s.a >= t -> output = paintColor (premultiplied), else -> output = transparent.
        let source = """
        kernel vec4 thresholdPaintAlpha(__sample s, float t, vec3 paintRGB, float paintA) {
            // pass = 1.0 when s.a >= t, else 0.0
            float pass = step(t, s.a);
        
            // Premultiplied output: multiply RGB by final alpha
            float outA  = paintA * pass;
            vec3  outRGB = paintRGB * outA;
        
            return vec4(outRGB, outA);
        }
        """
        return CIColorKernel(source: source)
    }()
    
    public static func thresholdPaintAlpha(
        _ input: CIImage,
        threshold: CGFloat,
        color: CIColor
    ) -> CIImage? {
        guard let kernel = thresholdPaintAlphaKernel else { return nil }

        
        let r = color.red, g = color.green, b = color.blue, a = color.alpha
        return kernel
            .apply(
                extent: input.extent,
                arguments: [input, threshold, CIVector(x: r, y: g, z: b), a]
            )?
            .cropped(to: input.extent)
    }
}
