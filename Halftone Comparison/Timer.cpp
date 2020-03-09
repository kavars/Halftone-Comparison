//
//  Timer.cpp
//  Timer
//
//  Created by Kirill Varshamov on 28/06/2019.
//

#include "Timer.hpp"

Timer::Timer(std::string blockName):
start(std::chrono::high_resolution_clock::now()), blockName(blockName) //catch start point
{ }

Timer::timePoint Timer::checkTimeEnd()
{
    end = std::chrono::high_resolution_clock::now(); //catch end point
    return end;
}

Timer::~Timer()
{
    duration_of_programm = checkTimeEnd() - start; //duration calculation 
    std::cout << "Your block '" << blockName << "' worked: " << duration_of_programm.count() * 1000.0 << " millisecond(s) or " << duration_of_programm.count() << " second(s)" << std::endl;
}
