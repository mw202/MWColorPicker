# MWColorPicker

[![CI Status](https://img.shields.io/travis/mw202/MWColorPicker.svg?style=flat)](https://travis-ci.org/mw202/MWColorPicker)
[![Version](https://img.shields.io/cocoapods/v/MWColorPicker.svg?style=flat)](https://cocoapods.org/pods/MWColorPicker)
[![License](https://img.shields.io/cocoapods/l/MWColorPicker.svg?style=flat)](https://cocoapods.org/pods/MWColorPicker)
[![Platform](https://img.shields.io/cocoapods/p/MWColorPicker.svg?style=flat)](https://cocoapods.org/pods/MWColorPicker)

## 说明

swift颜色选择器

[screenshot1.png](/docs/screenshot1.png)

## 使用

使用dataSource设置选中状态。如果返回nil，不会显示选中状态

```swift
func colorPickerViewShowSelectBox(_ view: MWColorPickerView) -> MWColorPickerSelectBoxStyle?
```

使用delegate获取选中项。color返回字符串形式的十六进制颜色值，如 `000FFF`

```swift
func colorPickerView(_ view: MWColorPickerView, didSelectAt index: Int, color: String)
```

或者使用Block

```swift
func bindBlock(selected index: Int, block: Block? = nil)
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

MWColorPicker is available through [CocoaPods](https://cocoapods.org). To install

it, simply add the following line to your Podfile:

```ruby
pod 'MWColorPicker'
```

## Author

mw202, 250230331@qq.com

## License

MWColorPicker is available under the MIT license. See the LICENSE file for more info.
