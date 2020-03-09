//
//  Timer.hpp
//  Timer
//
//  Created by Kirill Varshamov on 28/06/2019.
//

#ifndef Timer_hpp
#define Timer_hpp

#include <iostream>
#include <chrono>
#include <string>

class Timer {
public:
    typedef std::chrono::high_resolution_clock::time_point timePoint; //too long type :)
    
    Timer(std::string blockName);
    ~Timer();
private:
    timePoint start;
    timePoint end;
    std::chrono::duration<double> duration_of_programm;

    std::string blockName;
    
    timePoint checkTimeEnd();
};


#endif /* Timer_hpp */
