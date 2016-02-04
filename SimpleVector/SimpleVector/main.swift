//
//  main.swift
//  SimpleVector
//
//  Created by Ankit Kumar on 2/4/16.
//  Copyright © 2016 Ankit Kumar. All rights reserved.
//

import Foundation

print("Testing Started")

var a = SimpleVector()

// show initial size and capacity of SimpleVector a
print("Size of SimpleVector a: \(a.size())")

// add 10 items to SimpleVector a (add at the end of the list)
for i in 0..<10
{
    a.add(i)
    print("Added \(i), Size of simpleVector a: \(a.size())")
}

for i in 0..<10
{
    print("Item at index \(i) = \(a.get(i)!)")
}
// remove an item from SimpleVector a
let item = a.get(5)
var k = a.remove(a.get(5))
if k
{
    print("Removed item at index \(item), Size of SimpleVector a: \(a.size())")
}
else
{
    print("Failed to Remove item at index \(item), Size of SimpleVector a: \(a.size())")
}

for var i = 0;  i < a.size();  ++i
{
    print( "Item at index \(i) = \(a.get(i)!)")
}

// insert an item at a particular position in SimpleVector a
a.add(999);

print( "Added \(999) at index \(a.indexOf(999)), Size of SimpleVector a: \(a.size())")

for var i = 0;  i < a.size(); ++i
{
    print( "Item at index \(i) = \(a.get(i)!)");
}

// clear out SimpleVector a (remove from end for efficiency)
while a.size() > 0
{
    a.remove(a.get(a.size() - 1));
}

var vectorObj = a.description()

print("Demonstartion of description \(vectorObj)")

a.descriptionPrint()

// check clear
if a.isEmpty()
{
    print( "SimpleVector a is now empty" )
}
else
{
    print( "SimpleVector a now contains \(a.size()) items")
}

print( "Testing Ended" );
