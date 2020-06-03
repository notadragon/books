include(legacy/wafstyleout)
include(layers/package_libs)
include(layers/ufid)
include(layers/install_pkg_config)
include(layers/install_cmake_config)

bde_prefixed_override(bdeproj project_process_uors)
function(bdeproj_project_process_uors proj listDir)
    bde_assert_no_extra_args()

    bde_project_process_package_groups(
        ${proj}
        ${listDir}/src/groups/bsm
        ${listDir}/src/groups/awp
    )

    set_target_properties(awp PROPERTIES LINKER_LANGUAGE CXX)
    set_target_properties(bsm PROPERTIES LINKER_LANGUAGE CXX)
  
    bde_project_process_standalone_packages(
        ${proj}
    )

    bde_project_process_applications(
        ${proj}
    )
endfunction()
