// ap1all_sequential.cpp                                              -*-C++-*-
#include <ap1all_sequential.h>

#include <bsls_ident.h>
BSLS_IDENT_RCSID(ap1all_sequential_cpp,"$Id$ $CSID$")

#include <bdlma_sequentialallocator.h>

//------------------------------------------------------------GENERATOR EXTRACT
// Grab the contents of the corresponding parts extracted from the LaTeX source
//..
//  #!/bin/bash
//
//  cat ../../../../build/$1/listings/$2.lst
//--------------------------------------------------------END GENERATOR EXTRACT

namespace BloombergLP {
namespace ap1all {
void sequentialSample()
{
    static const int N = 17;
//--------------------------------GENERATED EXTRACT : ap1 ap1all_sequential_cpp
// ----Listing start: ap1-body.tex:318-----
    bdlma::SequentialAllocator alloc;
    for (int i = 0; i < N; ++i) {
        alloc.rewind(); // Don't forget to do this!
        // ... use alloc ...
    }
    alloc.release(); // optional (if alloc won't be destroyed soon)
// ----Listing done: ap1-body.tex:325-----
//----------------------------END GENERATED EXTRACT : ap1 ap1all_sequential_cpp
}
}  // close package namespace
}  // close enterprise namespace

// ----------------------------------------------------------------------------
// Copyright 2015 Bloomberg Finance L.P.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// ----------------------------- END-OF-FILE ----------------------------------
