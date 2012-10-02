class Layout < MonitisClient

  def add_page(title, options={})
    arg_opts = {title: title}.merge(options)
    addPage(arg_opts)
  end

  def delete_page(page_id)
    deletePage(pageId: page_id)
  end

  def add_page_module(name, id, column, row, data_module_id, options={})
    arg_opts = {moduleName: name, pageId: id, column: column, row: row,
                dataModuleId: data_module_id}.merge(options)
    addPageModule(arg_opts)
  end

  def delete_page_module(page_module_id)
    deletePageModule(pageModuleId: page_module_id)
  end

  def page_modules(page_name)
    pageModules(pageName: page_name)
  end
  
end

