//
//  main.swift
//  Vector
//
//  Created by Ankit Kumar on 2/1/16.
//  Copyright © 2016 Ankit Kumar. All rights reserved.
//

import Foundation

public class SimpleVector{
    private var _ra : [AnyObject]
    private var _size :Int{
        return _ra.count
    }
    
    init()
    {
        self._ra = [AnyObject]()
    }
    
    public func add(e : AnyObject) -> Bool
    {
        self._ra.append(e)
        return true
        
    }
    
    func get(index :Int) -> AnyObject?
    {
        if (index >= 0 && index < self._size)
        {
            return self._ra[index]
        }
        return nil
    }
    
    public func indexOf(e : AnyObject?) -> Int
    {
        if e == nil
        {
            return -1
        }
        for index in 0...self.size()
        {
            let a = self._ra[index]
            let b = e
            if a.isEqualTo(b)
            {
                return index
            }
            
        }
        
        return -1
    }
    
    public func remove(e : AnyObject?) -> Bool
    {
        let index = indexOf(e)
        if index >= 0
        {
            self._ra.removeAtIndex(index)
            return true
        }
        return false
    }
    
    public func size() -> Int
    {
        return _size
    }
    
    public func isEmpty() -> Bool
    {
        return self._size == 0
    }
    
    public func description() ->String
    {
        return "\(self._ra)"
    }
    
    public func descriptionPrint()
    {
        print (description())
    }
}