% imageComparisonToolDemo
% Demonstrate ImageComparisonTool in a simple filtering workflow.
%
% The example displays an image and a Gaussian-filtered version side by
% side. Move the slider to update the filtered image and its title.
%
% Copyright 2026 The MathWorks, Inc.

originalImage = imread("cameraman.tif");
initialSigma = 2;
filteredImage = imgaussfilt(originalImage, initialSigma);

fig = uifigure( ...
    "Name", "Image Comparison Tool Example", ...
    "Position", [100 100 1000 750]);

mainGrid = uigridlayout(fig, [2 1]);
mainGrid.RowHeight = {"1x", 70};
mainGrid.ColumnWidth = {"1x"};

comparison = ImageComparisonTool(mainGrid);
comparison.Layout.Row = 1;

% Configure the component with the images, titles, and linked viewers.
comparison.Image1 = originalImage;
comparison.Image2 = filteredImage;
comparison.Title1 = "Original";
comparison.Title2 = sprintf("Gaussian filtered (sigma = %.1f)", initialSigma);
comparison.LinkedViewers = true;

controlGrid = uigridlayout(mainGrid, [1 3]);
controlGrid.Layout.Row = 2;
controlGrid.ColumnWidth = {"fit", "1x", "fit"};
controlGrid.Padding = [15 10 15 10];

filterLabel = uilabel(controlGrid, "Text", "Gaussian filter strength");
filterLabel.Layout.Column = 1;

sigmaLabel = uilabel(controlGrid, ...
    "Text", sprintf("sigma = %.1f", initialSigma), ...
    "HorizontalAlignment", "right");
sigmaLabel.Layout.Column = 3;

sigmaSlider = uislider(controlGrid);
sigmaSlider.Layout.Column = 2;
sigmaSlider.Limits = [0.5 8];
sigmaSlider.Value = initialSigma;
sigmaSlider.MajorTicks = [0.5 2 4 6 8];
sigmaSlider.ValueChangingFcn = @(src, event) updateComparison( ...
    event.Value, comparison, originalImage, sigmaLabel);
sigmaSlider.ValueChangedFcn = @(src, event) updateComparison( ...
    src.Value, comparison, originalImage, sigmaLabel);

function updateComparison(sigma, comparison, originalImage, sigmaLabel)
% Update the displayed result and title when the filter strength changes.

comparison.Image2 = imgaussfilt(originalImage, sigma);
comparison.Title2 = sprintf("Gaussian filtered (sigma = %.1f)", sigma);
sigmaLabel.Text = sprintf("sigma = %.1f", sigma);
end
