using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SupplierLogin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!(Session["supplier_id"].Equals("") || Session["supplier_id"] == null))
                Response.Redirect("SupplierHome.aspx");
        }
        catch (Exception) { }
        
    }
    protected void goToLogin_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 0;
    }

    protected void goToRegistration_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 1;
    }

    protected void SignInButton_Click(object sender, EventArgs e)
    {
        ITProjectEntities context = new ITProjectEntities();
        bool auth = context.Suppliers.Any(s => s.s_email == LoginEmail.Text && s.s_password == LoginPassword.Text);//where also can be used
        if (auth)
        {
            var user = context.Suppliers.Where(s => s.s_email == LoginEmail.Text && s.s_password == LoginPassword.Text);
            Session["supplier_id"] = user.First().s_id;
            Response.Redirect("SupplierHome.aspx");
            LoginError.Visible = false;
        }
        else
        {
            LoginError.Visible = true;
        }
    }

    protected void SignUpButton_Click(object sender, EventArgs e)
    {
        ITProjectEntities context = new ITProjectEntities();
        Supplier newSupplier = new Supplier
        {
            s_name = FullName.Text,
            s_loc = Emirate.Text,
            s_email = Email.Text,
            s_password = Password.Text,
            s_phone = Phone.Text
        };
        context.Suppliers.Add(newSupplier);
        context.SaveChanges();
        Response.Redirect("SupplierLogin.aspx");
    }
}