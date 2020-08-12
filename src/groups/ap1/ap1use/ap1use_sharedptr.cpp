// ap1use_sharedptr.cpp                                               -*-C++-*-
#include <ap1use_sharedptr.h>

#include <bsls_ident.h>
BSLS_IDENT_RCSID(ap1use_sharedptr_cpp,"$Id$ $CSID$")

#include <bdlma_localsequentialallocator.h>

#include <bslma_managedptr.h>

#include <bsl_memory.h>
#include <bsl_string.h>

//------------------------------------------------------------GENERATOR EXTRACT
// Grab the contents of the corresponding parts extracted from the LaTeX source
//..
//  #!/bin/bash
//
//  cat ../../../../build/$1/listings/$2.lst
//--------------------------------------------------------END GENERATOR EXTRACT

namespace BloombergLP {
namespace ap1use {

void testShared()
{
    bdlma::LocalSequentialAllocator<128> alloc1;
    bdlma::LocalSequentialAllocator<128> alloc2;

//-------------------------------GENERATED EXTRACT : ap1 ap1use_sharedptr_cpp_1
// ----Listing start: ap1-body.tex:703-----
    bsl::shared_ptr<bsl::string> sharedStr =
        bsl::allocate_shared<bsl::string>(&alloc1, "hello");
    bslma::ManagedPtr<bsl::string> managedStr =
        bslma::ManagedPtrUtil::allocateManaged<bsl::string>(&alloc1, "hello");
// ----Listing done: ap1-body.tex:708-----
//---------------------------END GENERATED EXTRACT : ap1 ap1use_sharedptr_cpp_1

//-------------------------------GENERATED EXTRACT : ap1 ap1use_sharedptr_cpp_2
// ----Listing start: ap1-body.tex:712-----
    sharedStr = bsl::allocate_shared<bsl::string>(&alloc2, "world");
    managedStr =
    bslma::ManagedPtrUtil::allocateManaged<bsl::string>(&alloc2, "world");
// ----Listing done: ap1-body.tex:716-----
//---------------------------END GENERATED EXTRACT : ap1 ap1use_sharedptr_cpp_2

//-------------------------------GENERATED EXTRACT : ap1 ap1use_sharedptr_cpp_3
//---------------------------END GENERATED EXTRACT : ap1 ap1use_sharedptr_cpp_2
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
