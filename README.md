# Objective-C KVO Crash Bug

This repository demonstrates a common, yet subtle, bug related to Key-Value Observing (KVO) in Objective-C.  The bug occurs when an observer is added to an object that is deallocated before the observer is removed, often leading to unexpected crashes or behavior.

## Problem Description

The core issue arises from improper management of object lifecycles and strong references within the observer pattern.  Specifically, if an observer holds a strong reference to the observed object, and the observed object's lifetime is shorter than the observer's, then the observer will attempt to access a deallocated object.  This results in a crash.

## Solution

The solution involves ensuring that the observer is removed before the observed object is deallocated. This typically involves using `removeObserver:` in the observer's `dealloc` method or using a weak reference to the observed object within the observer.

## How to reproduce:

1. Clone this repository.
2. Open the project in Xcode.
3. Run the project.  The buggy version will likely crash; the corrected version will run without issue. 
