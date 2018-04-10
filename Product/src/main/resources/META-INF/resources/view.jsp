<%@page import="com.parmar.product.productFabricService.model.ProductFabric"%>
<%@page import="com.parmar.product.productFabricService.service.ProductFabricLocalServiceUtil"%>
<%@page import="com.liferay.portal.kernel.util.ParamUtil"%>
<%@page import="com.parmar.product.category.service.ProductCategoryLocalServiceUtil"%>
<%@page import="com.parmar.product.category.model.ProductCategory"%>
<%@page import="com.parmar.product.service.service.ProductColorLocalServiceUtil"%>
<%@page import="com.parmar.product.service.model.ProductColor"%>
<%@page import="com.parmar.product.services.service.ProductLocalServiceUtil"%>
<%@page import="java.util.List"%>
<%@page import="com.parmar.product.services.model.Product"%>
<%@ include file="/init.jsp"%>
<%@page import="com.liferay.portal.kernel.util.PortalUtil"%>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet"%>
<portlet:defineObjects />
<style>
.namedot
{
  text-overflow: ellipsis;
  overflow: hidden; 
  width: 110px; 
  height: 1.2em; 
  white-space: nowrap;
}
</style>
 
<script>
$(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip();   
});
</script>

 <link rel="stylesheet" type="text/css"
	href='<%=PortalUtil.getStaticResourceURL(request, request.getContextPath() + "/css/table-custome.css")%>' />
<% 
List<Product> listProduct=ProductLocalServiceUtil.getProducts(0, ProductLocalServiceUtil.getProductsCount());
%>  

<script>
$(document).ready(function(){
  $("#serchText").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#productRecord tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    });
  });
});
</script>

<script>
function sortTable(n) {
  var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
  table = document.getElementById("productRecord");
  switching = true;
 
  dir = "asc"; 
   
  while (switching) {
    
    switching = false;
    rows = table.getElementsByTagName("TR");
    
    for (i = 0; i <(rows.length-1); i++) {
      
      shouldSwitch = false;
     
      x = rows[i].getElementsByTagName("TD")[n];
      y = rows[i + 1].getElementsByTagName("TD")[n];
      
      if (dir == "asc") {
        if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
         
          shouldSwitch= true;
          break;
        }
      } else if (dir == "desc") {
        if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
        
          shouldSwitch= true;
          break;
        }
      }
    }
    if (shouldSwitch) {
      
      rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
      switching = true;
 
      switchcount ++;      
    } else {
       
      if (switchcount == 0 && dir == "asc") {
        dir = "desc";
        switching = true;
      }
    }
  }
}
</script>
<style>
 

th {
    cursor: pointer;
}

 </style>
<%
	int index = 0;
	int firstIndex = 0;
	int secondIndex = 5;
	String stringVal = ParamUtil.getString(request, "pages");
	int getPageValue = ParamUtil.getInteger(request, "pages");
	index = getPageValue - 1;
	firstIndex = index * 5;
	secondIndex = firstIndex + 5;
	List<Product> pagination = null;
	if (stringVal.isEmpty() || stringVal.equals(null)) {
		pagination = ProductLocalServiceUtil.getProducts(0, 5);
	} else {
		pagination = ProductLocalServiceUtil.getProducts(firstIndex, secondIndex);
	}
%>
<body style="background-image: linear-gradient(to bottom, #ffffff 0%, #edeced 100%);">
	<div class="container">
		<div class="col-lg-1"></div>
		<div class="col-lg-10">
			<div class="">  
			<div class="col-lg-4">
				  <div class="form-group has-feedback">
   					<input type="text" class="form-control" placeholder="Search Color" id="serchText"/>
    				<span class="glyphicon glyphicon-search form-control-feedback"></span>
				</div>
				</div>
				<div class="col-lg-4">
				</div>
				<div class="col-lg-4"> 
				
				
				<portlet:renderURL var="click">
					<portlet:param name="jspPage" value="/addProduct.jsp"/>
					</portlet:renderURL>
				 
					<a href="${click}" class="btn btn-default btn-lg"> <span
						class="glyphicon glyphicon-plus"></span> Add Product
					</a>
					 
				</div>
				<table class="table  table-hover">
					<thead>
						<tr>
							<th onclick="sortTable(0)"><h4><b>Record..</b></h4></th>
				 
							<th onclick="sortTable(2)"><h4  data-toggle="tooltip"   data-placement="top" title="Product Name"><b> Name</b></h4></th>
							<th onclick="sortTable(3)"><h4   data-toggle="tooltip"  data-placement="top" title="Product Description"><b> Description</b></h4></th>
							<th onclick="sortTable(4)"><h4   data-toggle="tooltip"  data-placement="top" title="Product Quantity"><b> Quantity</b></h4></th>
							<th onclick="sortTable(5)"><h4   data-toggle="tooltip"  data-placement="top" title="Product Price"><b> Price</b></h4></th>
							<th onclick="sortTable(6)"><h4   data-toggle="tooltip"  data-placement="top" title="Product Category"><b> Category</b></h4></th>
							<th onclick="sortTable(7)"><h4   data-toggle="tooltip"  data-placement="top" title="Product Color"><b> Color</b></h4></th>
							<th onclick="sortTable(8)"><h4   data-toggle="tooltip"  data-placement="top" title="Product Fabric"><b> Fabric</b></h4></th>
							<th><h4><b>Edit</b></h4></th>
							<th><h4><b>Delete</b></h4></th>
						</tr>
					</thead>
					<tbody id="productRecord">
	 					<%
	 					  for(int i=0;i<pagination.size();i++)
	 					  {
	 					%>
	 					<tr>
	 					    <td><%=pagination.get(i).getProduct_Id() %> </td> 
						 	<td >  <h5 class="namedot" ><%=pagination.get(i).getProduct_Name() %></h5>
						    </td>
						  	 <td><h5 class="namedot" ><%=pagination.get(i).getProduct_Description() %></h5>
						 	  </td>
						 	<td><%=pagination.get(i).getProduct_Quantity() %></td>
						 	<td><%=pagination.get(i).getProduct_Price() %> </td>
						   <%
						 	   int getCategoryId=listProduct.get(i).getProduct_Category_Id();
						 	   ProductCategory listCategory=ProductCategoryLocalServiceUtil.getProductCategory(getCategoryId);
						 	   %>
						 	 	<td><h5 class="namedot"><%=listCategory.getProductCategory_Name() %></h5> </td>
						 	<%
						 	
						 	
						 	%>
						 	 <%
						 	    
						 	     int getColorId=listProduct.get(i).getProductColor_Id();
						 	    ProductColor listColor=ProductColorLocalServiceUtil.getProductColor(getColorId);
						 	  
						 	  %>
						 	
						 	<td><%=listColor.getProductColor_Name() %></td>
						 	
						 	
						 	 <%
						 	    
						 	     int getFabricId=listProduct.get(i).getProductFabric_Id();
						 	    ProductFabric listFabric=ProductFabricLocalServiceUtil.getProductFabric(getFabricId);
						 	  
						 	  %>
						 	
						  	<td><%=listFabric.getProductFabricName()%></td>  
						  	
						  	<portlet:renderURL var="editProduct">
						 	 <%
						 	   String colorId=String.valueOf(getColorId);
						 	   String categID=String.valueOf(getCategoryId);
						 	   String fabricId=String.valueOf(getFabricId);
							 	 
						 	   
						 	   
						 	 %>
						 	 <portlet:param name="colorId" value="<%=colorId %>"/>
						 	  <portlet:param name="cateId" value="<%=categID %>"/>
						 	  <portlet:param name="fabricId" value="<%=fabricId %>"/>
						 	 <portlet:param name="jspPage" value="/editProduct.jsp"/>
						 	 <%
						 	   String productId=String.valueOf(listProduct.get(i).getProduct_Id());
						 	 %>
						 	 <portlet:param name="productId" value="<%=productId %>"/>
						 	 
						 	</portlet:renderURL>
						 	 
						 	<td><a  href="${editProduct}" class="btn btn-info" >Edit</a></td>
						 	<portlet:renderURL var="DeleteProduct">
						 	 <%
						 	   String productId=String.valueOf(listProduct.get(i).getProduct_Id());
						 	 %>
						 	 <portlet:param name="productId" value="<%=productId %>"/>
						 	 
						 	</portlet:renderURL>
						 	
						 	
						 	
						 	<td><a href="${DeleteProduct}" class="btn btn-danger">Delete</a></a></td>
						 	  
						</tr>
					<%
					}
					%>	
		</tbody>
		 </table>
		  <div class="col-lg-4"></div>
				<div class="col-lg-4"></div>
				<div class="col-lg-4" style="margin-top: -30px;">
					<table>
						<tbody>
							<%
								int totalRecord = listProduct.size();
								int totalPages=0;
								if(totalRecord % 5 == 0)
								{
									totalPages=(totalRecord /5);
								}
								else
								{
									totalPages=(totalRecord /5)+1;
								}
								
								
							%>
							<tr>
								<%
									for (int i = 1; i <= totalPages; i++) {
								%>
								<portlet:renderURL var="clickPagination">
									<%
										String pageVal = String.valueOf(i);
									%>
									<portlet:param name="jspPage" value="/view.jsp" />
									<portlet:param name="pages" value="<%=pageVal%>" />
								</portlet:renderURL>

								<td><ul class="pagination pagination-lg">
										<li><a href="${clickPagination}"><%=i%></a></li>
									</ul></td>
								<%
									}
								%>
							</tr>
						</tbody>
					</table>
				</div>
		</div>
		</div>
		</div>
	</body>
	 