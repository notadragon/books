// ap1all_local.cpp                                                   -*-C++-*-
#include <ap1all_local.h>

#include <bsls_ident.h>
BSLS_IDENT_RCSID(ap1all_local_cpp,"$Id$ $CSID$")

#include <bdlma_localsequentialallocator.h>

#include <bsl_string.h>

//------------------------------------------------------------GENERATOR EXTRACT
// Grab the contents of the corresponding parts extracted from the LaTeX source
//..
//  #!/bin/bash
//
//  cat ../../../../build/$1/listings/$2.lst
//--------------------------------------------------------END GENERATOR EXTRACT

namespace BloombergLP {
namespace ap1all {
void localSample()
{
//-------------------------------------GENERATED EXTRACT : ap1 ap1all_local_cpp
// ----Listing start: ap1-body.tex:336-----
    // No allocation from the heap unless tempStr grows larger than 128 bytes
    bdlma::LocalSequentialAllocator<128> stackAlloc;
    bsl::string tempStr(&stackAlloc);
    // Code that builds up tempStr
// ----Listing done: ap1-body.tex:341-----
//---------------------------------END GENERATED EXTRACT : ap1 ap1all_local_cpp
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
