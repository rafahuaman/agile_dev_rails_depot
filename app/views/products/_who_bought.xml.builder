format.xml { render :xml => @product.to_xml(include: :orders) }