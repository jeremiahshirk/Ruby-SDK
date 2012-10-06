# == Manage Layouts
# 
# Methods that take an options argument expect a Hash. The keys are the 
# optional  parameters, documented at http://www.monitis.com/api/api.html
class Layout < MonitisClient

  # Get all of a user's pages
  def pages
    get('pages')
  end

  # Add a page to a user's layout
  #
  # === Required arguments
  # * title - title of the page
  #
  # === Optional arguments
  # * columnCount - count of columns on the page
  def add_page(title, options={})
    arg_opts = {title: title}.merge(options)
    post('addPage', arg_opts)
  end

  # Delete a page from the user's layout
  #
  # === Required arguments
  # * page_id - ID of the page to delete
  def delete_page(page_id)
    post('deletePage', pageId: page_id)
  end

  # Add a module to a page
  #
  # === Required arguments
  # * name - The name of the page module
  # * id - ID of the page to add the module to
  # * name - name of the module to add, possible values are:
  #   External,
  #   Process,
  #   Drive,
  #   Memory,
  #   InternalHTTP,
  #   InternalPing,
  #   LoadAverage,
  #   CPU,
  #   Transaction,
  #   Fullpageload,
  #   VisitorsTracking,
  #   CustomMonitor
  # * column - number of the column to add module to
  # * row - number of the row to add module to
  # * height - description
  #
  # === Optional arguments
  def add_page_module(name, id, column, row, data_module_id, options={})
    arg_opts = {moduleName: name, pageId: id, column: column, row: row,
                dataModuleId: data_module_id}.merge(options)
    post('addPageModule', arg_opts)
  end

  # Delete a module from a page
  #
  # === Required arguments
  # * page_module_id - ID of the module to delete
  def delete_page_module(page_module_id)
    post('deletePageModule', pageModuleId: page_module_id)
  end

  # Get all modules for the specified page
  #
  # === Required arguments
  # * page_name - name of the page to get modules for
  def page_modules(page_name)
    get('pageModules', pageName: page_name)
  end
  
end

