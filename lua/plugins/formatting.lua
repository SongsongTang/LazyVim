return {
    {
        "stevearc/conform.nvim",
        event = "InsertEnter",
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
                        "--column_limit=100",
                        "--indentation_spaces=4",
                        "--wrap_spaces=4",
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
                        "--struct_union_members_alignment=align",
                        "--try_wrap_long_lines=true",
                        "--wrap_end_else_clauses=true",
                        "-",
                    },
                    stdin = true,
                },
            },
        },
    },
}
