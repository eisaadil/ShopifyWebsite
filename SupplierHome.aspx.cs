using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SupplierHome : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["supplier_id"].Equals("") || Session["supplier_id"] == null)
                Response.Redirect("SupplierLogin.aspx");
        }
        catch (Exception) {
            Response.Redirect("SupplierLogin.aspx");
        }

        SupplierHomeMultiView.ActiveViewIndex = 0;
        ViewProductLink.CssClass = "nav-link active";
        NewProductLink.CssClass = "nav-link";

    }

    protected void LogoutSupplierButton_Click(object sender, EventArgs e)
    {
        Session["supplier_id"] = "";
        Response.Redirect("SupplierLogin.aspx");
    }

    protected void SubmitProduct_Click(object sender, EventArgs e)
    {
  
        String image_name_unix = DateTimeOffset.UtcNow.ToUnixTimeSeconds().ToString();
        if (ProductImage.HasFile)
        {
            try
            {
                String extension = Path.GetExtension(ProductImage.PostedFile.FileName);
                String filename = image_name_unix+extension;
                image_name_unix = filename;
                ProductImage.SaveAs(Server.MapPath("~/productImages/") + filename);
            }
            catch (Exception ex)
            {
                Response.Write("Upload status: The file could not be uploaded. The following error occured: " + ex.Message);
            }
        }
        ITProjectEntities context = new ITProjectEntities();
        Product newProduct = new Product
        {
            p_name = ProductName.Text,
            p_price = Int32.Parse(Price.Text),
            p_color = Color.Text,
            p_posted_date = DateTime.Now,
            p_image_link = image_name_unix,
            b_id = Int32.Parse(Brand.SelectedValue),
            c_id = Int32.Parse(Category.SelectedValue),
            s_id = Int32.Parse(Session["supplier_id"].ToString())
        };
        context.Products.Add(newProduct);
        context.SaveChanges();

        //clear  form
        Response.Redirect("SupplierHome.aspx");
        /*
        SupplierHomeMultiView.ActiveViewIndex = 0;
        ViewProductLink.CssClass = "nav-link active";
        NewProductLink.CssClass = "nav-link";
        ProductsOfSupplierGridView.DataBind();*/
    }
    protected void ProductImageValidate(object sender, ServerValidateEventArgs e)
    {
        String ext = Path.GetExtension(ProductImage.PostedFile.FileName);
        if (ext != ".jpg" || ext != ".png" || ext != ".gif" || ext != ".jpeg") {
            e.IsValid = false;
            Response.Write("Not an image");
        }
        else
            e.IsValid = true;
    }

    protected void ViewProductLink_Click(object sender, EventArgs e)
    {
        SupplierHomeMultiView.ActiveViewIndex = 0;
        ViewProductLink.CssClass = "nav-link active";
        NewProductLink.CssClass = "nav-link";
        ProductsOfSupplierGridView.DataBind();
    }

    protected void NewProductLink_Click(object sender, EventArgs e)
    {
        SupplierHomeMultiView.ActiveViewIndex = 1;
        NewProductLink.CssClass = "nav-link active";
        ViewProductLink.CssClass = "nav-link";


    }
}