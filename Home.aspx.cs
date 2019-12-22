using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Home : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            CategoriesUnique.DataBind();
            CategorySearch.DataBind();
            CategorySearch.Items.Insert(0, new ListItem("Select Category", "-1"));
            CategorySearch.SelectedIndex = 0;

            BrandsDataSource.DataBind();
            BrandSearch.DataBind();
            BrandSearch.Items.Insert(0, new ListItem("Select Brand", "-1"));
            BrandSearch.SelectedIndex = 0;
        }
        DataView allProductsDv = (DataView)AllProducts.Select(DataSourceSelectArguments.Empty);
        allProductsHeading.Text = "<h2>All Products ("+allProductsDv.Count.ToString()+")</h2>";
    }

    protected void GoToSupplierLoginButton_Click(object sender, EventArgs e)
    {
        Response.Redirect("SupplierLogin.aspx");
    }

    protected void SearchButton_Click(object sender, EventArgs e)
    {
        //SelectCommand="SELECT Product.[p_id], Product.[p_name], Product.[b_id], Product.[c_id], Product.[p_price], Product.[p_image_link], Product.[p_color], Product.[p_posted_date], Product.[s_id], Category.[c_id], Category.[c_name], Brand.[b_id], Brand.[b_name] FROM [Product], [Category], [Brand] WHERE (Brand.[b_id] = Product.[b_id] AND Product.[c_id] = Category.[c_id]) ORDER BY CONVERT(datetime, Product.p_posted_date) desc"
        string searchKeyword = SearchBox.Text;
        string categoryId = CategorySearch.SelectedValue;
        string brandId = BrandSearch.SelectedValue;
        int minPrice = 0;
        int maxPrice = 0;
        if (MinRange.Text.Equals(""))
            minPrice = 0;
        else
            minPrice = Convert.ToInt32(MinRange.Text);
        if (MaxRange.Text.Equals(""))
            maxPrice = 0;
        else
            maxPrice = Convert.ToInt32(MaxRange.Text);
        string whereClauseLike = $"(Product.p_name LIKE '%{searchKeyword}%' OR Product.p_color LIKE '%{searchKeyword}' OR Category.c_name LIKE '%{searchKeyword}' OR Brand.b_name LIKE '%{searchKeyword}')";
        if (minPrice > 0)
            whereClauseLike += $" AND (Product.p_price >= {minPrice})";
        if (maxPrice > 0)
            whereClauseLike += $" AND (Product.p_price <= {maxPrice})";
        if (!CategorySearch.SelectedValue.Equals("-1"))
            whereClauseLike += $" AND (Category.c_id = {categoryId})";
        if (!BrandSearch.SelectedValue.Equals("-1"))
            whereClauseLike += $" AND (Brand.b_id = {brandId})";
        SearchRepeaterDataSource.SelectCommand = "SELECT Product.[p_id], Product.[p_name], Product.[b_id], Product.[c_id], Product.[p_price], Product.[p_image_link], Product.[p_color], Product.[p_posted_date], Product.[s_id], Category.[c_id], Category.[c_name], Brand.[b_id], Brand.[b_name] FROM[Product], [Category], [Brand] WHERE(Brand.[b_id] = Product.[b_id] AND Product.[c_id] = Category.[c_id] AND "+whereClauseLike+") ORDER BY CONVERT(datetime, Product.p_posted_date) desc";
        SearchRepeaterDataSource.DataBind();
        SearchRepeater.DataBind();
    }
}