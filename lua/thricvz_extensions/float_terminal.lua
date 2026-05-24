
--fl_term  = {
--  buffer = fl_term_buffer,
--  window = fl_term_window
-- }

-- open a floating terminal
vim.keymap.set({'n'}, 'T', 
  function()
      create_floating_terminal()
  end
)

--open a compilation terminal
vim.keymap.set({'n'}, 'E', 
  function()
      local fl_term = create_floating_terminal()
      execute_build(fl_term.buffer, "cmake --build")
  end
)

function execute_build(term_buffer, build_command)
  local build_directory_paths = get_directory_path({"Build", "build"})

  for _ , build_directory in ipairs(build_directory_paths) do
      local build_command = build_command .. " " .. build_directory 
      send_command_with_enter(term_buffer, build_command)
  end
end 

function get_directory_path(subdir_list)
    local cwd = vim.fn.getcwd()
    local found_paths = {}
    
    for _, subdir_name in ipairs(subdir_list) do
        local full_path = cwd .. "/" .. subdir_name
        if vim.fn.isdirectory(full_path) == 1 then
            table.insert(found_paths, full_path)
        end
    end
    
    return found_paths
end

function send_command_with_enter(bufnr, command)
    vim.fn.chansend(vim.bo[bufnr].channel, command .. "\r")
end


function create_floating_terminal()
    local main_win = vim.api.nvim_get_current_win()

    local fl_term_buffer = vim.api.nvim_create_buf(false, false)

    vim.api.nvim_buf_call(fl_term_buffer , 
      function()
        vim.api.nvim_command("Sh")
      end 
    )

    local fl_term_window = vim.api.nvim_open_win(
      fl_term_buffer, true,
      {
        relative='win',
        row = math.floor(vim.go.lines * 0.1),
        col = math.floor(vim.go.columns * 0.1),
        width= fl_terminal_width(main_win),
        height= fl_terminal_height(main_win),
        border = "rounded"
      }
    )
   
    return {
      buffer = fl_term_buffer,
      window = fl_term_window
    }
end 


function fl_terminal_width(window)
  -- later use an adaptive window
  local width = vim.go.columns
  return math.floor( width * 0.8)
end

function fl_terminal_height(window)
  -- later use an adaptive window
  local height = vim.go.lines
  return math.floor( height * 0.8)
end

 

-- adaptive window size
-- commands for compiling
-- commands for executing
