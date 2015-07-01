class ResourceURIBuilder
  PATH_SEPARATOR='/'
  
  def set_context(context='')
    if context.kind_of?(Class)
      @context=context.name.downcase+'s'
    else context.kind_of?(String)
      @context=context.to_s.downcase
    end
    
    self
  end
  
  def set_action(action='')
    @action=action.to_s
    self
  end
  
  def context
    @context.to_s
  end
  
  def action
    @action.to_s
  end
  
  def build
    uri=''
    uri=PATH_SEPARATOR+context if context.length>0
    uri << PATH_SEPARATOR+action if action.length>0
    uri
  end
end