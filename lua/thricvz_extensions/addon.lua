-- command for default header guard
vim.api.nvim_create_user_command('Sk', 
  function ()
    local file_name = remove_file_extension(
      remove_absolute_path(vim.api.nvim_buf_get_name(0))
    )
    
    local class_name = file_name
    local header_definition = string.upper(file_name) .. "_H"

    local templated_file = generate_full_header_guard(class_name, header_definition)

    vim.opt.paste = true
    vim.api.nvim_paste(templated_file, false , 0)
    vim.opt.paste = false

  end ,{})

function remove_absolute_path(file_name)
  local simple_file_name = "" 
  for section in string.gmatch(file_name, "[^/]+") do 
    simple_file_name = section
  end 
  return simple_file_name
end 

function remove_file_extension(file_name)
  -- returns the first occurence ex : name . extension
  for file_without_extension in string.gmatch(file_name, "[^.]+") do 
    return file_without_extension
  end 
end 



function generate_full_header_guard(class_name, header_definition)
return string.format(
[=[#ifndef %s
#define %s

class %s {
  public:

  private:

};
#endif]=], header_definition, header_definition, class_name)
end
