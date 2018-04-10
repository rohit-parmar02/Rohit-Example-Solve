<%@page import="java.util.List"%>
<%@page import="com.parmar.product.productFabricService.service.ProductFabricLocalServiceUtil"%>
<%@page import="com.parmar.product.productFabricService.model.ProductFabric"%>
<%@page import="com.parmar.product.category.service.ProductCategoryLocalServiceUtil"%>
<%@ include file="/init.jsp"%>
<%@page import="com.parmar.product.category.model.ProductCategory"%>
<%@page import="com.parmar.product.service.service.ProductColorLocalServiceUtil"%>
<%@page import="com.parmar.product.service.model.ProductColor"%>
<%@page import="java.awt.Color"%>
<%@page import="com.parmar.product.services.service.ProductLocalServiceUtil"%>
<%@page import="com.parmar.product.services.model.Product"%>
<%@page import="com.liferay.portal.kernel.util.ParamUtil"%>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet"%>
<portlet:defineObjects/>
<h1 style="color:green">Product Edit Page </h1>
<%
int getProductID=ParamUtil.getInteger(request, "productId");
int getColorID=ParamUtil.getInteger(request, "colorId");
int getCategoryID=ParamUtil.getInteger(request, "cateId");
int getFabricId=ParamUtil.getInteger(request, "fabricId");
Product listProduct=null;
try
{
		 if(getProductID > 0 )	
				{
					  listProduct=ProductLocalServiceUtil.getProduct(getProductID); 
 	
				}
}
catch(Exception e)
{
	e.printStackTrace();
}
%>


<portlet:actionURL var="editProduct" name="editProductUrl">
<portlet:param name="getColorID" value="<%=String.valueOf(getColorID) %>"/>
<portlet:param name="getCategoryID" value="<%=String.valueOf(getCategoryID) %>"/>
</portlet:actionURL>
<form name="editProduct" action="${editProduct}" method="post">
 <div class="container">
 
    <input type="hidden" value="<%=getProductID%>" name="productId"/>
 		<div class="col-md-6 col-md-offset">
 		<b>Product Name:</b> 	<input type="text" name="productName" class="form-control" value="<%=listProduct.getProduct_Name() %>" />
  		</div>
  	  		<div class="col-md-6 col-md-offset">
 	
 	 	<%
 	 		int categoryId=listProduct.getProduct_Category_Id();
 	 		ProductCategory categoryList=ProductCategoryLocalServiceUtil.getProductCategory(categoryId);
 	 		
 	     %>
 	     
 	     <div class="col-md-3">
 	    <b>Product Category: </b>  
 <input type="text" readonly="readonly" name="productCategory" class="form-control" value="<%=categoryList.getProductCategory_Name() %>" />
 	     </div>
 			 
 		  <div class="col-md-3">
 		  
 	   <select class="form-control" id="categorySelect" name="changeCategory" style="margin-top: 50px">
 	 			 <option value="0">Select Edit Category</option>	
 	 			 <%
 	 			     List<ProductCategory> listCategory=ProductCategoryLocalServiceUtil.getProductCategories(0, ProductCategoryLocalServiceUtil.getProductCategoriesCount());
 	 			  %>
 	 			 <%
 	 			   for(int i=0;i<listCategory.size();i++)
 	 			   {
 	 				   %>
 	 				   <option value="<%=listCategory.get(i).getProductCategory_Id() %>" <%= categoryList.getProductCategory_Id() == listCategory.get(i).getProductCategory_Id() ? "selected style=\"color:black\"" :"" %>><%=listCategory.get(i).getProductCategory_Name()%></option>
 	 				   <% 
 	 			   }
 	 			 %>
 	 			</select>
 		  </div>
  		</div> 	
  		<div class="col-md-6 col-md-offset">
 	 
 		<b> Product Price:</b> 	<input type="text" name="productPrice" class="form-control" value="<%=listProduct.getProduct_Price() %>" />
 			 
  		</div>
  		 
  		<div class="col-md-6">
 	 
 	  <%
 	        int colorId=listProduct.getProductColor_Id();
			ProductColor colorList=ProductColorLocalServiceUtil.getProductColor(colorId);
 	  %>
 	   
 	       	    <div class="col-md-3">
 	       	    <b>Product Color</b>:   <input type="text" name="productColor" id="productColor" readonly="true" class="form-control" value="<%=colorList.getProductColor_Name() %> " />
 		  
 	       	    </div>
 	     		
 		 
 	  
 	 	    <div class="col-md-3">
 	 	    <select class="form-control" id="colorSelect" name="changeColor" style="margin-top:50px">
 	 			 <option value="0">Select Edit Color</option>	
 	 			 <%
 	 			     List<ProductColor> listColor=ProductColorLocalServiceUtil.getProductColors(0, ProductColorLocalServiceUtil.getProductColorsCount());
 	 			  %>
 	 			 <%
 	 			   for(int i=0;i<listColor.size();i++)
 	 			   {
 	 				   %>
 	 				   <option value="<%=listColor.get(i).getProductColor_Id() %>"><%=listColor.get(i).getProductColor_Name() %></option>
 	 				   <% 
 	 			   }
 	 			 %>
 	 			</select>
 	 	    </div>
 	 			
 	    
 		</div>
  		
  		<!-- extra   -->
  		<div class="col-md-6 col-md-offset">
 	 
 	  <% 
 	  
 	
 	  
 	   ProductFabric fabricList=ProductFabricLocalServiceUtil.getProductFabric(getFabricId);
		 
 	  %>
 	  
 	  
 	  <div class="col-md-3">
 	  
 	<b>	Product Material:  </b> <input type="text" readonly="readonly" name="productMaterial" class="form-control" value="<%=fabricList.getProductFabricName()%>" />
 		
 	  </div>
 	 
 	 	
 		
 	  <div class="col-md-3">
 	  	<select class="form-control" id="materialSelect" name="changeMaterial" style="margin-top: 50px">
 	  	<option>Select Change Material </option>
 	  	<%
 	  	  List<ProductFabric> fabricRecord=ProductFabricLocalServiceUtil.getProductFabrics(0, ProductFabricLocalServiceUtil.getProductFabricsCount());
 	  	%>
 	  	 <%
 	  	   for(int i=0;i<fabricRecord.size();i++)
 	  	   {
 	  		  %>
 	  		  <option value="<%=fabricRecord.get(i).getProductFabricId() %>"><%=fabricRecord.get(i).getProductFabricName() %></option>
 	  		  <%    
 	  	   }
 	  	 %>
 	  	</select>
 	  </div>
 		
 		
 		
 		
 			 
 			 
  		</div>
  	 
  		<!--  -->	
  		<div class="col-md-6 col-md-offset">
 	 
 	<b>Product Quantity:</b>	 	<input type="text" name="productQuantity" class="form-control" value="<%=listProduct.getProduct_Quantity() %>" />
 			 
  		</div>
  		
  		<div class="col-md-6 col-md-offset">
 	 
 	<b>Product Description: </b>	
 		
 		 <textarea rows="5" cols="2" name="productDescription" class="form-control"><%=listProduct.getProduct_Description() %> </textarea>
 	 		 
  		</div>
 <br>
 		<div class="col-md-6 col-md-offset">
 	 
 	<b>Product Image:</b>	  <img src="<%=listProduct.getProduct_Image() %>"  style="width: 253px;height: 260px;"/>
 			 
  		</div>
   	<div class="col-md-6 col-md-offset">
 	
 	  <input type="submit" class="btn  btn-info" value="Edit Product " style="width:253px;height:58px "/> 
  		</div>
  	
 
 </div>
 
</form>

 