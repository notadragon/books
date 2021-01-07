Book Proposal
 
Proposed Book Title: C++ Allocators for the Working Programmer 
Subtitle  : 
Author(s): John Lakos & Joshua Berne

Author title(s) and affiliation(s):  
John Lakos (Member of Software Infrastructure Division, Bloomberg NY)
Joshua Berne (Member of Software Infrastructure Division, Bloomberg NY)

Mailing address(es):  

John Lakos
7407 Yellowstone Drive
Frisco,Texas 75033

Joshua Berne
480 Marlborough Rd
Brooklyn, NY 11226

Phone number: 
John Lakos (cell): 908-625-1202
Joshua Berne (cell): 917-803-1538

Preferred Email address(es): 
jlakos@bloomberg.net
jberne4@bloomberg.net  

About the Author(s)
John Lakos, author of Large-Scale C++ Software Design [Pearson, 1996] and Large-Scale C++ — Volume I: Process and Architecture [Pearson, 2019],    serves at Bloomberg in New York City as a senior architect and mentor for C++ software development worldwide. He is also an active voting member of the C++ Standards Committee’s Evolution Working Group. From 1997 to 2001, Dr. Lakos directed the design and development of infrastructure libraries for proprietary analytic financial applications at Bear Stearns. From 1983 to 1997, Dr. Lakos was employed at Mentor Graphics, where he developed large frameworks and advanced ICCAD applications for which he holds multiple software patents. His academic credentials include a Ph.D. in Computer Science (1997) and an Sc.D. in Electrical Engineering (1989) from Columbia University. Dr. Lakos received his undergraduate degrees from MIT in Mathematics (1982) and Computer Science (1981).

Joshua Berne serves at Bloomberg LP as a senior software engineer on Bloomberg’s core library team. After the difficult choice to pursue a career in software engineering over research mathematics, he has been an active programmer in the financial industry, writing day trading applications in C++ for E*TRADE Capital Markets and, after that, architecting large distributed trading systems in Java for Instinet and IDC. Since joining Bloomberg in 2017, he has been an active participant in the C++ Standards Committee, seeking to bring the advancements made within Bloomberg to the C++ Standard and thus to the rest of the world.

Marketing Description
Since first being standardized, C++ has had an ever-evolving relationship with custom memory allocation for both user-defined and standard library types. Adding the STL to the library provided an initial but incomplete solution. A robust and powerful solution has now emerged in the form of polymorphic memory resources (PMR), evolving out of the allocator design used for many years at Bloomberg LP. This book is a rare opportunity to obtain the knowledge and wisdom that come from decades of use and apply them to a feature that has only recently become fully available.  
About the Topic
C++ has always been designed to provide to developers complete control over how their programs run. In particular, a stated goal of C++ is to ensure that no opportunity exists for some other architecture-independent language (such as C) to find a way to wedge itself between C++ and the hardware. Custom allocations allow mature C++ developers complete low-level control over the memory used by their containers and algorithms, maximizing potential performance gain rather than accepting only the most generic solutions. 

Understanding how to use allocators serves the performance needs of developers in four ways:
•	Programs that use allocator-aware types can be improved with careful choice of the most appropriate allocator.
•	Every C++ developer is often a writer of user-defined types, and, to take full advantage of the allocators’ benefits, the developer must know how to properly integrate allocators into a type.
•	When understanding and diagnosing software that uses allocators, a developer must also fully comprehend how those allocators are implemented.
•	Developers seeking maximal control will sometimes find it necessary to develop new custom allocation strategies, and understanding existing practice fosters “standing on the shoulders of giants” rather than “reinventing the wheel.”
Separately, consistent and principled use of allocator-aware software affords myriad collateral benefits beyond runtime efficiency, including whole-object placement, object-based metrics gathering, enhanced debugging and testing capabilities, and rapid prototyping of (off-the-shelf) library-supplied allocation strategies.

In this book, we aim to provide an in-depth study of all information related to these topics to fully explain the new, C++17 PMR allocator model from every angle, so that everyday programmers will no longer feel that widely known and substantial benefits of custom memory allocation are beyond their reach
Audience
This book is aimed at quotidian developers yet has enough meat to satisfy even the most expert and seasoned professionals; this hard-to-come-by and invaluable knowledge is presented such that every reader can employ this expertise immediately, and the more in-depth and difficult material can be digest and assimilated incrementally if and as needed.

C++ developers seeking to write better code can benefit from understanding how their code can use allocators and how those allocators work. Those who are already using an allocator-aware software infrastructure will want to know how to properly leverage and build upon it, those who are providing a library to be used extensively by others will want to give their clients the freedom to select allocators, and those who are seeking to maximize their infrastructure’s potential will want to implement their own allocators in the best way possible. Moreover, engineering managers will want to understand how they can implement and/or exploit allocator-aware infrastructures in their teams, groups, and companies.

The majority of this book will be applicable to day-to-day C++ programmers of all skill levels. Anyone seeking to write modern C++ code will learn from a significant portion of this book. Those who need to make fundamental architectural decisions about a C++ codebase and its relationship with allocators will gain a uniquely valuable understanding of the concepts we present. Later portions of the book will be written for only those who wish to dive deeply into allocators, and those parts will require the most external experience to understand fully.

What the reader will learn — and how to apply it
By the end of this book, readers will understand 
●	what it means for a class or function to be allocator-aware,
●	why allocator-aware types are advantageous,
●	case studies and examples where allocators have substantially improved performance,
●	the development costs of maintaining an allocator-aware software infrastructure, with an objective, balanced lens of real and substantial (versus imagined or perceived) costs,

and readers will know how to 

•	exploit existing allocator-aware types to improve performance,
•	leverage the allocator-aware aspect for many nonperformance related benefits,
•	mechanically transform typical C++ classes to be allocator-aware,
•	create more sophisticated allocator-aware types, e.g., involving template parameters, containers, and special semantics, 
•	design an effective local allocator itself and make it pluggable with the std::pmr model.
Keywords
C++, Allocators, PMR, performance, low-latency, interoperability, infrastructure, software, engineering
Other Book Features
Code examples in the book will be a mix of example code that is made publicly available in a book-specific github repository and open-sourced BDE implementations of standard library types already available at https://github.com/Bloomberg/bde. These examples will range from small micro benchmarks to full-blown, real-world applications.
Software Dependencies
We will focus on using C++17-compliant standard libraries, with some potential mentions of minor changes available in C++20, or sidebars indicating what is available in Bloomberg’s open source offerings. We expect that, by the time of publication, most modern software stacks will fully support the functionality we are focusing on. 

Note that work is currently underway at Bloomberg to create a proposal that would provide language support for allocator-aware software. If accepted, such a feature would remove virtually all costs associated with developing, maintaining, and using allocator-aware software as well as all impediments to interoperability associated with library-based allocator-aware types. We expect that at least a brief discussion of such a prospective language feature will appear in this book in the final chapter where we discuss this and other possible future developments.
Competing Titles
The primary competing titles that have any overlap with our planned topics tend to focus on C++17 as a whole and have only shallow coverage of allocators and their use.

1.	Nicolai Josutti. C++17 - The Complete Guide. Self-published, 2019. ISBN13: 978-3967300178. While this book covers the C++17 standard library, its coverage of the use of PMR types and allocators in general is superficial.   

2.	Bartłomiej Filipek C++17 In Detail: Learn the Exciting Features of the New C++ Standard! Self-published, 2019. ISBN13: 978-1798834060.  
This book mentions the changes that were made to add PMR to the C++ language but does so only for completeness when discussing other changes that were made. This work offers no detail about why or how to use allocators, nor about how they are implemented. 

Related O’Reilly Titles
The following books are included in the O’Reilly Online Learning subscription. 

1.	Bjarne Stroustrup. A Tour of C++, 2nd ed. Addison Wesley, 2018. ISBN13: 978-0134998053. A single brief section (13.6) discusses allocators, only in the context of using a pooled allocator to reduce fragmentation  .

2.	Marc Gregoire. Professional C++, 4th ed. John Wiley & Sons, Inc., 2018. ISBN13: 978-1119421306. This book provides an overview of the entire language and explicitly omits discussing allocators in its examples. A single small section (21) discusses allocator support in the standard library.

3.	Josh Lospinoso. C++ Crash Course. No Starch Press, 2019. ISBN13: 978-1593278885. An example (within the chapter on smart pointers) discusses creating a C++11-style allocator type, with no mention of PMR.

Book Outline   
1.	Introduction
1.1.	Motivation
1.1.1.	The History of C++ Allocators
1.1.2.	Your Future with C++ Allocators
1.2.	Technical Basics
1.2.1.	The std::pmr Interface
1.2.2.	Other Allocation-Related Aspects of Standard C++
2.	Application Developers
2.1.	What is an Allocator-Aware Type?
2.1.1.	Defining a PMR Allocator-Aware Type
2.1.2.	std::pmr Collections
2.2.	Using Allocator-Aware Types
2.2.1.	How to use a Custom Memory Resource
2.2.2.	How to Choose an Allocator
2.2.3.	Testing Code that Allocates
2.3.	Case Study 1: Unique Value Counting
2.4.	Case Study 2: Message Parsing
3.	Library Writers
3.1.	Writing Allocator-Aware Types
3.1.1.	Aggregating Other Allocator-Aware Types
3.1.2.	Doing Allocation
3.1.3.	Testing Allocator-Aware Types
3.2.	Case Study 3: PMR Optional and Variant
4.	Allocator Implementers
4.1.	Writing Allocators
4.1.1.	Learning from Global Alocators
4.1.2.	Thread-Unsafe Allocators
4.1.3.	Reuse Free Allocators
4.1.4.	Wrapping Other Allocators for Utility
4.2.	Benchmarking Allocators
4.3.	Case Study 4: A Buffered Sequential Allocator
5.	Advanced
5.1.	Modern Hardware
5.2.	Effective Benchmarking
5.3.	Optimizing Large Allocator-Aware Systems
5.4.	Designing Effective Allocator-Aware Architectures
6.	Appendix
6.1.	Other Libraries
6.1.1.	BDE
6.1.2.	Thrust
6.2.	Future Developments
6.2.1.	More PMR Types
6.2.2.	Automating Allocator Support

Specs and Schedule
How many pages do you expect the book to be?
Approximately 350 pages
Will you be using illustrations or screenshots? 
We will be providing many code examples and some diagrams but no screenshots.
Do any special considerations apply to your plans for the book, including unusual format, use of color, hard-to-get illustrations, or anything else calling for unusual resources?
No.
What do you anticipate your delivery schedule to be? Please fill out the following:
Two draft chapters to be delivered by: April 2020
Half draft manuscript to be delivered by: June 2020
Full draft manuscript ready for tech review delivered by: October 2020 
Final and full manuscript ready for production: December  2020  
