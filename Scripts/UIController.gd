extends Control

signal gridWithValueChange(newValue)
signal gridHeigthValueChange(newValue)
signal scaleValueChange(newValue)
signal heigthScaleValueChange(newValue)
signal offSetXValueChange(newValue)
signal offSetZValueChange(newValue)

func onGridWidthSliderValueChange(newValue):
	emit_signal("gridWithValueChange", newValue)

func onGridHeigthSliderValueChange(newValue):
	emit_signal("gridHeigthValueChange", newValue)

func onScaleValueChange(newValue):
	emit_signal("scaleValueChange", newValue)

func onHeigthScaleSliderValueChange(newValue):
	emit_signal("heigthScaleValueChange", newValue)

func onOffsetXSliderValueChange(newValue):
	emit_signal("offSetXValueChange", newValue)

func onOffsetZSliderValueChange(newValue):
	emit_signal("offSetZValueChange", newValue)
