cmake_minimum_required(VERSION 3.8)

if (NOT CMAKE_MODULE_PATH)
    message(FATAL_ERROR "Please specify path to BDE cmake modules.")
endif()

include(cmake/UseLATEX.cmake)

get_filename_component(repoName ${CMAKE_CURRENT_LIST_DIR} NAME)

project(${repoName})

add_latex_document(${CMAKE_CURRENT_LIST_DIR}/src/books/booksample/booksample.tex)
add_latex_document(${CMAKE_CURRENT_LIST_DIR}/src/books/cawp/cawp.tex)

include(bde_workspace)

bde_process_workspace(
    ${CMAKE_CURRENT_LIST_DIR}
)

