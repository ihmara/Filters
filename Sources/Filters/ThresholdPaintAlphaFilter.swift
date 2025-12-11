import CoreImage

final class ThresholdPaintAlphaFilter: CIFilter {
    
    static let kernel: CIKernel = { () -> CIColorKernel in
        guard let url = Bundle.main.url(
            forResource: "ThresholdPaintAlphaFilterKernel.ci",
            withExtension: "metallib"),
              let data = try? Data(contentsOf: url) else {
            fatalError("Unable to load metallib")
        }
        
        guard let kernel = try? CIColorKernel(
            functionName: "thresholdPaintAlphaKernel",
            fromMetalLibraryData: data) else {
            fatalError("Unable to create color kernel")
        }
        
        return kernel
    }()
    
    func applyThresholdPaintAlpha(input: CIImage,
                                  threshold t: Float,
                                  ciColor: CIColor) -> CIImage? {
        
        let paintRGBA = CIVector(x: ciColor.red, y: ciColor.green, z: ciColor.blue, w: ciColor.alpha)
        return ThresholdPaintAlphaFilter.kernel.apply(
            extent: input.extent,
            roiCallback: { _, rect in
                return rect
            },
            arguments: [input, t, paintRGBA])
    }
}
