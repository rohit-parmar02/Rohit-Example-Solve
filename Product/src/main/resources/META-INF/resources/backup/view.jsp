 <%@page import="com.parmar.product.service.service.ProductColorLocalServiceUtil"%>
<%@page import="com.parmar.product.service.model.ProductColor"%>
<%@page import="com.parmar.product.category.service.ProductCategoryLocalServiceUtil"%>
<%@page import="com.parmar.product.category.model.ProductCategory"%>
<%@page import="java.util.List"%>
<%@page import="com.liferay.portal.kernel.util.PortalUtil"%>
<%@ include file="/init.jsp"%>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet"%>
<portlet:defineObjects />
<link rel="stylesheet" type="text/css"
	href='<%=PortalUtil.getStaticResourceURL(request, request.getContextPath() + "/css/custome.css")%>' />
 <style>
 #logoRegister{
    margin-left:420px;
	width: 207px;
    height: 193px;
 }
 </style>
 <%
	List<ProductCategory> userList = ProductCategoryLocalServiceUtil.getProductCategories(0,
			ProductCategoryLocalServiceUtil.getProductCategoriesCount());
	List<ProductColor> listProductColor = ProductColorLocalServiceUtil.getProductColors(0,
			ProductColorLocalServiceUtil.getProductColorsCount());
%>
 <portlet:actionURL name="insertValue" var="uploadImage"> </portlet:actionURL>
 
 <body>


	<div class="container" id="container">
 
		<div class="col-lg-12">
		
			<div class="jumbotron">
				<img id="logoRegister"
					src="<%=PortalUtil.getStaticResourceURL(request, request.getContextPath() + "/p.jpg")%>" />

				<form id="loginForm" method="post" action="${uploadImage}">
 					<div class="form-group">
						<input type="text" name="productName" placeholder="Enter Product Name"
							class="form-control" required="required" />
					</div>
					<div class="col-lg-6">
					<div class="form-group">
						<select style="height: 50px" name="selectProductCategory"
							class="form-control" id="Category" name="Category">
							<option value="0">Select Sarees Category</option>
							<%
								for (int i = 0; i < userList.size(); i++) {
							%>
							<option value="<%=userList.get(i).getProductCategory_Id()%>"><%=userList.get(i).getProductCategory_Name()%></option>
							<%
								}
							%>
						</select> 
					</div></div>
					<div class="col-lg-6">
					<div class="form-group">
						 	<select style="height: 50px" class="form-control" id="Category"
							name="Category">
							<option value="0" style="color: red">Please Add Fabric</option>

						</select>
					</div>
					</div>
					<div class="col-lg-6">
					<div class="form-group">
						 <select style="height: 50px" name="selectPoductColor"
							class="form-control" id="Color" name="Color">
							<option value="0">Select Sarees Color</option>
							<%
								for (int i = 0; i < listProductColor.size(); i++) {
							%>
							<option value="<%=listProductColor.get(i).getProductColor_Id()%>"><%=listProductColor.get(i).getProductColor_Name()%></option>
							<%
								}
							%>
						</select>
					</div></div>
					<div class="col-lg-6">
					<div class="form-group">

					<input type="number" name="productQuantity"  max="24" min="0"  value="0" placeholder="Enter ProductQuantity "
							class="form-control" required="required" />
					 

					</div></div>
					<div class="col-lg-6">
					<div class="form-group">
						<input type="text" name="productPrice"
							placeholder="Enter Product Price" class="form-control"
							required="required" />
					</div></div>
					<div class="col-lg-6">
					<div class="form-group">
						 <textarea rows="2"  name="productDescription" cols="0" class="form-control"></textarea>
					</div></div>
				 <div class="col-lg-6">
                   <div class="form-group">
						<input type="file" name="productFile"
							placeholder="Enter File Name" class="form-control"
							required="required" />
					</div> 
					  </div>
					<input type="submit" id="submitForm" value="Add Product"
						class="btn" />
						 
				</form>
			</div>
		</div>
	 

</div>
</body>
 