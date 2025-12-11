//
//  MyKernels.ci.metal
//  PaintAlpha
//
//  Created by Igor Hmara on 10.12.25.
//

#include <CoreImage/CoreImage.h>

extern "C" {
    namespace coreimage {
        float4 thresholdPaintAlphaKernel(sample_t s, float t, float4 paintRGBA) {
            float pass = float(s.a >= t);
            float outA = paintRGBA.a * pass;
            float3 outRGB = paintRGBA.rgb * outA;
            return float4(outRGB, outA);
        }
    }
}
