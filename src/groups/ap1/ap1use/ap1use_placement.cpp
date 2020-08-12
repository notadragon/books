// ap1use_placement.cpp                                               -*-C++-*-
#include <ap1use_placement.h>

#include <bsls_ident.h>
BSLS_IDENT_RCSID(ap1use_placement_cpp,"$Id$ $CSID$")

#include <bslma_allocator.h>

#include <bsl_string.h>
#include <bsl_vector.h>

//------------------------------------------------------------GENERATOR EXTRACT
// Grab the contents of the corresponding parts extracted from the LaTeX source
//..
//  #!/bin/bash
//
//  cat ../../../../build/$1/listings/$2.lst
//--------------------------------------------------------END GENERATOR EXTRACT

namespace BloombergLP {
namespace ap1use {

struct my_MemoryMappingAllocator {
    static bslma::Allocator& singleton();
};

void testPlacement()
{
//---------------------------------GENERATED EXTRACT : ap1 ap1use_placement_cpp
// ----Listing start: ap1-body.tex:672-----
    typedef bsl::vector<bsl::string> VecType;
    bslma::Allocator& alloc = my_MemoryMappingAllocator::singleton();
    VecType v1(&alloc); // BAD IDEA: object footprint not in mapped memory
    VecType *v2_p = new(alloc) VecType(&alloc); // OK: mapped footprint
    v2_p->push_back("hello"); // string element in mapped memory
    // ...
    alloc.deleteObject(v2_p); // Dont forget to free the memory.
// ----Listing done: ap1-body.tex:680-----
//-----------------------------END GENERATED EXTRACT : ap1 ap1use_placement_cpp
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
