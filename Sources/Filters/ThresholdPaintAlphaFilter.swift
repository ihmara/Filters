import CoreImage

public final class ThresholdPaintAlphaFilter: CIFilter {
    
    static let kernel: CIKernel = { () -> CIColorKernel in
        
        guard let filtersBundleURL = Bundle.main.url(forResource: "Filters_Filters", withExtension: "bundle") else {
            fatalError("Unable to find Filters_Filters bundle")
        }
        
        guard let filtersBundle = Bundle(url: filtersBundleURL) else {
            fatalError("Unable to create Filters_Filters bundle")
        }
        
        guard let url = filtersBundle.url(
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
    
    public func applyThresholdPaintAlpha(input: CIImage,
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
