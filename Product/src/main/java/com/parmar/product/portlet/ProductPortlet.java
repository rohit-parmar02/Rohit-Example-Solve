package com.parmar.product.portlet;
 
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.Portlet;
import javax.portlet.PortletException;
import javax.portlet.ProcessAction;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

import com.liferay.document.library.kernel.model.DLFileEntry;
import com.liferay.document.library.kernel.model.DLFolder;
import com.liferay.document.library.kernel.service.DLAppLocalServiceUtil;
import com.liferay.document.library.kernel.service.DLAppServiceUtil;
import com.liferay.document.library.kernel.util.DLUtil;
import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCPortlet;
import com.liferay.portal.kernel.repository.model.FileEntry;
import com.liferay.portal.kernel.repository.model.Folder;
import com.liferay.portal.kernel.service.ServiceContext;
import com.liferay.portal.kernel.service.ServiceContextFactory;
import com.liferay.portal.kernel.theme.ThemeDisplay;
import com.liferay.portal.kernel.upload.UploadPortletRequest;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.PortalUtil;
import com.liferay.portal.kernel.util.StringPool;
import com.liferay.portal.kernel.util.WebKeys;
import com.parmar.product.constants.ProductPortletKeys;
import com.parmar.product.services.model.Product;
import com.parmar.product.services.service.ProductLocalService;
import com.parmar.product.services.service.ProductLocalServiceUtil;
 
 
 
/**
 * @author rohit.parmar
 */
@Component(
	immediate = true,
	property = {
		"com.liferay.portlet.display-category=category.product",
		"com.liferay.portlet.instanceable=true",
		"javax.portlet.display-name=Product Portlet",
		"javax.portlet.init-param.template-path=/",
		"javax.portlet.init-param.view-template=/view.jsp",
		"javax.portlet.name=" + ProductPortletKeys.Product,
		"javax.portlet.resource-bundle=content.Language",
		"javax.portlet.security-role-ref=power-user,user",
		"com.liferay.portlet.requires-namespaced-parameters=false"
	},
	service = Portlet.class
)
public class ProductPortlet extends MVCPortlet {
	
	@Override
	public void render(RenderRequest renderRequest, RenderResponse renderResponse)
			throws IOException, PortletException {
 
		try{
			int getProductId=ParamUtil.getInteger(renderRequest, "productId");
			  if(getProductId > 0)
			  {
				    ProductLocalServiceUtil.deleteProduct(getProductId);
				    
			  }
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		super.render(renderRequest, renderResponse);
	}
	
	ProductLocalService productService;
	
	
	
	/*@Override
	public void render(RenderRequest renderRequest, RenderResponse renderResponse)
			throws IOException, PortletException {
		// TODO Auto-generated method stub
		List<Product> productList = ProductLocalServiceUtil.getProduct(new int[]{1,2}, new int[]{1,3}, new int[]{2,3});
		for(Product product:productList){
			System.out.println(product.getProduct_Name() +", Category: "+ product.getProduct_Category_Id() 
			+ ", Fabric: "+ product.getProductFabric_Id()
			+", Color: "+ product.getProductColor_Id());
		}
		super.render(renderRequest, renderResponse);
	}*/
	
	public ProductLocalService getProductService() {
		return productService;
	}
	
	@Reference
	public void setProductService(ProductLocalService productService) {
		this.productService = productService;
	}

	private static final long PARENT_FOLDER_ID = 101130;
	private static final String ROOT_FOLDER_NAME = "parmar-sarees-images";
	private static final String ROOT_FOLDER_DESCRIPTION = "parmar-sarees-images-display";
	@ProcessAction(name="insertValue")
	public void insertValue(ActionRequest actionRequest,ActionResponse actionResponse) throws IOException
	{
 		String productName=ParamUtil.getString(actionRequest, "productName");
		String productDescription=ParamUtil.getString(actionRequest, "productDescription");
		//String productImage;
	 	int productQuantity=ParamUtil.getInteger(actionRequest, "productQuantity");
		int productPrice=ParamUtil.getInteger(actionRequest, "productPrice"); 
		int productCatId=ParamUtil.getInteger(actionRequest, "selectProductCategory"); 
		int productColId=ParamUtil.getInteger(actionRequest, "selectPoductColor"); 
		int productMaterialId=ParamUtil.getInteger(actionRequest, "selectProductMaterial");
		
		try{
			ThemeDisplay themeDisplay = (ThemeDisplay) actionRequest.getAttribute(WebKeys.THEME_DISPLAY);
			createFolder(actionRequest, themeDisplay);
			String url = fileUpload(themeDisplay, actionRequest);
			System.out.println("---------url is---------"+url);
		 
			  int pid=1;
			 Product product=ProductLocalServiceUtil.createProduct(pid);
			product.setProduct_Name(productName);
			product.setProduct_Description(productDescription);
			product.setProduct_Quantity(productQuantity);
			product.setProduct_Price(productPrice);
			product.setProduct_Image(url);
			product.setProduct_Category_Id(productCatId);
			product.setProductColor_Id(productColId);
			product.setProductFabric_Id(productMaterialId);
			ProductLocalServiceUtil.addProduct(product);  
			
			
			System.out.println("<h1>Fabric id is </h1>"+productMaterialId);
	     	System.out.println("productName --> "+productName);
			System.out.println("productDescription --->"+productDescription);
			System.out.println("productQuantity --> "+productQuantity);
			System.out.println("productPrice -- >"+productPrice);
			System.out.println("productCatId --> "+productCatId);
			System.out.println("productColId --> "+productColId); 
		 
 
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
   }
	public Folder createFolder(ActionRequest actionRequest, ThemeDisplay themeDisplay) {
		boolean folderExist = isFolderExist(themeDisplay);
		System.out.println("Folder Exist==>" + folderExist);

		Folder folder = null;
		if (!folderExist) {
			long repositoryId = themeDisplay.getScopeGroupId();
			try {
				ServiceContext serviceContext = ServiceContextFactory.getInstance(DLFolder.class.getName(),
						actionRequest);

				folder = DLAppServiceUtil.addFolder(repositoryId, PARENT_FOLDER_ID, ROOT_FOLDER_NAME,
						ROOT_FOLDER_DESCRIPTION, serviceContext);
			} catch (PortalException e1) {
				e1.printStackTrace();
			} catch (SystemException e1) {
				e1.printStackTrace();
			}
		}
		return folder;
	}
	public boolean isFolderExist(ThemeDisplay themeDisplay) {
		boolean folderExist = false;
		try {
			DLAppServiceUtil.getFolder(themeDisplay.getScopeGroupId(), PARENT_FOLDER_ID, ROOT_FOLDER_NAME);
			folderExist = true;
			System.out.println("Folder is already Exist");
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return folderExist;
	}
	public String fileUpload(ThemeDisplay themeDisplay, ActionRequest actionRequest) {
		String img_path = null;
		UploadPortletRequest uploadPortletRequest = PortalUtil.getUploadPortletRequest(actionRequest);
		String fileName = uploadPortletRequest.getFileName("productFile");
		File file = uploadPortletRequest.getFile("productFile");
	 
		String mimeType = uploadPortletRequest.getContentType("productFile");
		String title = fileName;
		String description = fileName + " is added programatically";
		
		long repositoryId = themeDisplay.getScopeGroupId();
		try {
			Folder folder = getFolder(themeDisplay);
			ServiceContext serviceContext = ServiceContextFactory.getInstance(DLFileEntry.class.getName(),
					actionRequest);
			InputStream is = new FileInputStream(file);
			
			FileEntry fileEntry = DLAppLocalServiceUtil.addFileEntry(themeDisplay.getDefaultUserId(), repositoryId, folder.getFolderId(), fileName, mimeType, fileName, fileName, fileName, file, serviceContext);
 	
			//FileEntry fileEntry = DLAppServiceUtil.addFileEntry(repositoryId, folder.getFolderId(), fileName, mimeType,
			//		title, description, "", is, file.getTotalSpace(), serviceContext);
			img_path = DLUtil.getPreviewURL(fileEntry, fileEntry.getFileVersion(), themeDisplay, StringPool.BLANK,
					false, true);
			System.out.println("Image Path is==>" + img_path + "and Length==>" + img_path.length());
			return img_path;
 
		} catch (Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		return img_path;
	}
	public Folder getFolder(ThemeDisplay themeDisplay) {
		Folder folder = null;
		try {
			folder = DLAppServiceUtil.getFolder(themeDisplay.getScopeGroupId(), PARENT_FOLDER_ID, ROOT_FOLDER_NAME);
			System.out.println("----Folder Id............." + folder.getFolderId());
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return folder;
	}
	@ProcessAction(name = "editProductUrl")
	public void editProductUrl(ActionRequest actionRequest, ActionResponse actionResponse) throws PortalException {
		int getProductID=ParamUtil.getInteger(actionRequest, "productId");
		String productName=ParamUtil.getString(actionRequest, "productName");
		String productDescription=ParamUtil.getString(actionRequest, "productDescription");
		int productPrice=ParamUtil.getInteger(actionRequest, "productPrice");
		int productQuantity=ParamUtil.getInteger(actionRequest, "productQuantity");
		String productColor=ParamUtil.getString(actionRequest, "productColor");
		String productCategory=ParamUtil.getString(actionRequest, "productCategory");
		String productMaterial=ParamUtil.getString(actionRequest, "productMaterial");
	 
		int changeColor=ParamUtil.getInteger(actionRequest,"changeColor");
		int changeMaterial=ParamUtil.getInteger(actionRequest, "changeMaterial");
		int changeCategory=ParamUtil.getInteger(actionRequest, "changeCategory");
		 
		
	  try
	  {
		  
	 
	 
	 	
		Product productObj=ProductLocalServiceUtil.getProduct(getProductID);
		productObj.setProduct_Name(productName);
		productObj.setProduct_Description(productDescription);
		productObj.setProduct_Price(productPrice);
		productObj.setProduct_Quantity(productQuantity);
		if(changeColor != 0)
		{
			productObj.setProductColor_Id(changeColor);
		}
		else
		{
			productObj.setProductColor_Id(productObj.getProductColor_Id());
		} 
		
		if(changeMaterial != 0)
		{
			productObj.setProductFabric_Id(changeMaterial);
		}
		else
		{
			productObj.setProductFabric_Id(productObj.getProductFabric_Id());
			
		}
		if(changeCategory != 0)
		{
			productObj.setProduct_Category_Id(changeCategory);
		}
		else
		{
			productObj.setProduct_Category_Id(productObj.getProduct_Category_Id());
		}
		
		
		ProductLocalServiceUtil.updateProduct(productObj);
	
	  }
		
		 catch(Exception e)
		  {
			  	e.printStackTrace();
		  }
		
	 	System.out.println("productID"+getProductID);
		System.out.println("Name"+productName);
		System.out.println("description"+productDescription);
		System.out.println("price"+productPrice);
		System.out.println("quantity"+productQuantity);
		
	  
		
		System.out.println("color"+productColor); 
	  
		System.out.println("Change Color is " +ParamUtil.getInteger(actionRequest, "changeColor"));
		
		
		
		System.out.println("category id"+productCategory);
		System.out.println("material id"+productMaterial);
		 
		
		
		
		
		
		
	}
	 
}