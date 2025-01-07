return {
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
            formatters_by_ft = {
                ["cpp"] = { "clang_format" },
                ["verilog"] = { "verible" },
            },
            formatters = {
                clang_format = {
                    prepend_args = { "-style=Microsoft" },
                },
                verible = {
                    command = "verible-verilog-format", -- Verible 的命令
                    args = {
                        "--column_limit=120",
                        "--indentation_spaces=4",
                        "--line_break_penalty=4",
                        "--over_column_limit_penalty=120",
                        "--assignment_statement_alignment=align",
                        "--case_items_alignment=align",
                        "--class_member_variable_alignment=align",
                        "--distribution_items_alignment=align",
                        "--enum_assignment_statement_alignment=align",
                        "--formal_parameters_alignment=align",
                        "--module_net_variable_alignment=align",
                        "--named_parameter_alignment=align",
                        "--named_port_alignment=align",
                        "--port_declarations_alignment=align",
                        "--port_declarations_right_align_packed_dimensions=true",
                        "--port_declarations_right_align_unpacked_dimensions=true",
                        "--struct_union_members_alignment=align",
                        -- 添加其他所需的参数
                        "-",
                    },
                    stdin = true,
                },
            },
        },
    },
}
