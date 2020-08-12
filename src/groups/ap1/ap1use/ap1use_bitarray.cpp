// ap1use_bitarray.cpp                                                -*-C++-*-
#include <ap1use_bitarray.h>

#include <bsls_ident.h>
BSLS_IDENT_RCSID(ap1use_bitarray_cpp,"$Id$ $CSID$")

#include <bdlc_bitarray.h>

#include <bdlma_localsequentialallocator.h>

//------------------------------------------------------------GENERATOR EXTRACT
// Grab the contents of the corresponding parts extracted from the LaTeX source
//..
//  #!/bin/bash
//
//  cat ../../../../build/$1/listings/$2.lst
//--------------------------------------------------------END GENERATOR EXTRACT

namespace BloombergLP {
namespace ap1use {

void noAllocBitArray()
{
//--------------------------------GENERATED EXTRACT : ap1 ap1use_bitarray_cpp_1
// ----Listing start: ap1-body.tex:464-----
    bdlc::BitArray ba(96); // bit array of length 96 using default allocation
// ----Listing done: ap1-body.tex:466-----
//----------------------------END GENERATED EXTRACT : ap1 ap1use_bitarray_cpp_1
}

void allocBitArray()
{
//--------------------------------GENERATED EXTRACT : ap1 ap1use_bitarray_cpp_2
// ----Listing start: ap1-body.tex:472-----
    bdlma::LocalSequentialAllocator<128> alloc;
    bdlc::BitArray ba(96, &alloc); // Bit array using custom allocation
// ----Listing done: ap1-body.tex:475-----
//----------------------------END GENERATED EXTRACT : ap1 ap1use_bitarray_cpp_2
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
