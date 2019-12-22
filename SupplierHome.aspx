<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="SupplierHome.aspx.cs" Inherits="SupplierHome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="navbar" Runat="Server">
        <asp:Button ID="LogoutSupplierButton" runat="server" Text="Logout" CssClass="btn btn-danger my-2 my-sm-0" OnClick="LogoutSupplierButton_Click" ValidationGroup="10" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="container-fluid" style="width:95%">
        <ul class="nav nav-tabs" style="margin-bottom:5px">
            <li class="nav-item">
              <asp:LinkButton ID="ViewProductLink" runat="server" CssClass="nav-link" OnClick="ViewProductLink_Click" ValidationGroup="2">My Products</asp:LinkButton>
            </li>
            <li class="nav-item">
              <asp:LinkButton ID="NewProductLink" runat="server" CssClass="nav-link" OnClick="NewProductLink_Click" ValidationGroup="3">Add Product</asp:LinkButton>
            </li>
        </ul>

        <asp:MultiView ID="SupplierHomeMultiView" runat="server" ActiveViewIndex="0">
            <asp:View ID="ViewProduct" runat="server">
                <div style="overflow-x:scroll;width:100%">
                <asp:GridView ID="ProductsOfSupplierGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="p_id,c_id1,b_id1" DataSourceID="ProductsOfSupplier" AllowPaging="True" AllowSorting="True" CssClass="table gridView table-striped">
                    <Columns>
                        <asp:TemplateField HeaderText="ID" InsertVisible="False" SortExpression="p_id">
                            <EditItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("p_id") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("p_id") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="p_name" HeaderText="Product Name" SortExpression="p_name" />
                        <asp:TemplateField HeaderText="Category" SortExpression="c_name">
                            <EditItemTemplate>
                                <asp:DropDownList ID="EditCategoriesDropdown" runat="server" DataSourceID="EditCategoriesData" SelectedValue='<%# Bind("c_id") %>' DataTextField="c_name" DataValueField="c_id"></asp:DropDownList>
                                <asp:SqlDataSource ID="EditCategoriesData" runat="server" ConnectionString="<%$ ConnectionStrings:ITProjectConnectionString %>" SelectCommand="SELECT * FROM [Category]"></asp:SqlDataSource>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("c_name") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Brand" SortExpression="b_name">
                            <EditItemTemplate>
                                <asp:DropDownList ID="EditBrandsDropdown" runat="server" DataSourceID="EditBrandsData" SelectedValue='<%# Bind("b_id") %>' DataTextField="b_name" DataValueField="b_id"></asp:DropDownList>
                                <asp:SqlDataSource ID="EditBrandsData" runat="server" ConnectionString="<%$ ConnectionStrings:ITProjectConnectionString %>" SelectCommand="SELECT * FROM [Brand]"></asp:SqlDataSource>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("b_name") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="p_price" HeaderText="Price" SortExpression="p_price" />
                        <asp:TemplateField HeaderText="Image" SortExpression="p_image_link">
                            <EditItemTemplate>
                                <asp:Image ID="Image1" runat="server" Height="<%# 50 %>" ImageUrl='<%# "~/productImages/"+Eval("p_image_link") %>' Width="<%# 50 %>" />
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Image ID="Image1" runat="server" Height="<%# 50 %>" ImageUrl='<%# "~/productImages/"+Eval("p_image_link") %>' Width="<%# 50 %>" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="p_color" HeaderText="Color" SortExpression="p_color" />
                        <asp:BoundField DataField="p_posted_date" HeaderText="Posted On" SortExpression="p_posted_date" ReadOnly="True" />
                        <asp:TemplateField ShowHeader="False">
                            <EditItemTemplate>
                                <asp:Button ID="LinkButton5" runat="server" CausesValidation="True" CommandName="Update" Text="Update" CssClass="btn btn-success"></asp:Button><br />
                                <asp:Button ID="LinkButton6" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-danger" style="margin-top: 5px;width: 100%;"></asp:Button>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Button ID="LinkButton4" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" CssClass="btn btn-info"></asp:Button>

                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:Button ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" CssClass="btn btn-danger"></asp:Button>

                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        No products have been created yet
                    </EmptyDataTemplate>
                </asp:GridView>
                </div>
                <asp:SqlDataSource ID="ProductsOfSupplier" runat="server" ConnectionString="<%$ ConnectionStrings:ITProjectConnectionString %>" SelectCommand="SELECT Product.[p_id], Product.[p_name], Product.[b_id], Product.[c_id], Product.[p_price], Product.[p_image_link], Product.[p_color], Product.[p_posted_date], Product.[s_id], Category.[c_id], Category.[c_name], Brand.[b_id], Brand.[b_name] FROM [Product], [Category], [Brand] WHERE (Product.[s_id] = @s_id AND Brand.[b_id] = Product.[b_id] AND Product.[c_id] = Category.[c_id]) ORDER BY CONVERT(datetime, Product.p_posted_date) desc" UpdateCommand="Update Product set p_name=@p_name, b_id=@b_id, c_id=@c_id, p_price=@p_price,p_color=@p_color WHERE p_id=@p_id" DeleteCommand="DELETE from Product where p_id=@p_id">
                    <SelectParameters>
                        <asp:SessionParameter Name="s_id" SessionField="supplier_id" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </asp:View>
            <asp:View ID="InsertNewProduct" runat="server">
                        <!-- INSERT NEW PRODUCT -->
                        <div class="container" style="margin-top:7px">
                        <div class="row ">
                            <div class="col-md-4 py-5 bg-primary text-white text-center ">
                                <div class=" ">
                                    <div class="card-body">
                                        <img src="Images/screen.png" style="height:100px;width:100px">
                                        <h2 class="py-3">Add Product</h2>
                                        <p></p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-8 py-5 border">
                                <h4 class="pb-4">Please fill details about the new product</h4>
                                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="alert alert-danger"/>
                                    <div class="form-row">
                                        <div class="form-group col-md-12">
                                          <asp:TextBox ID="ProductName" runat="server" CssClass="form-control" placeholder="Product Name (eg Galaxy S8)"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="ProductNameValidator" runat="server" ControlToValidate="ProductName" Display="None" ErrorMessage="Product Name is required"></asp:RequiredFieldValidator>
                                        </div>
                        
                                      </div>
                                    <div class="form-row">
                                        <div class="form-group col-md-6">
                                            <asp:DropDownList ID="Category" runat="server" CssClass="form-control" DataSourceID="CategoriesUnique" DataTextField="c_name" DataValueField="c_id">
                                           </asp:DropDownList>
                                            <asp:SqlDataSource ID="CategoriesUnique" runat="server" ConnectionString="<%$ ConnectionStrings:ITProjectConnectionString %>" SelectCommand="SELECT DISTINCT [c_id], [c_name] FROM [Category]"></asp:SqlDataSource>
                                        </div>
                                        <div class="form-group col-md-6">
                                            <asp:DropDownList ID="Brand" runat="server" CssClass="form-control" DataSourceID="BrandsDataSource" DataTextField="b_name" DataValueField="b_id">
                                
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="BrandsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ITProjectConnectionString %>" SelectCommand="SELECT DISTINCT * FROM [Brand]"></asp:SqlDataSource>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="form-group col-md-6">
                                          <asp:TextBox ID="Price" runat="server" CssClass="form-control" placeholder="Price (in AED)" TextMode="Number"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="PriceRequiredValidator" runat="server" ControlToValidate="Price" Display="None" ErrorMessage="Product price is required"></asp:RequiredFieldValidator>
                                        </div>
                                        <div class="form-group col-md-6">
                                          <asp:TextBox ID="Color" runat="server" CssClass="form-control" placeholder="Color (eg Yellow)"></asp:TextBox>
                                          <asp:RequiredFieldValidator ID="ColorValidator" runat="server" ControlToValidate="Color" Display="None" ErrorMessage="Color is required"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="form-group col-md-12">
                                          <asp:FileUpload ID="ProductImage" CssClass="form-control" runat="server" />
                                          <asp:RegularExpressionValidator ID="ProductImageTypeValidator" runat="server" ErrorMessage="File uploaded must be an image"  ControlToValidate="ProductImage" Display ="None" ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w].*))+(.jpg|.JPG|.gif|.GIF|.png|.PNG|.bmp|.BMP)$"></asp:RegularExpressionValidator>
                                          <asp:RequiredFieldValidator ID="ProductImageRequiredValidator" runat="server" ControlToValidate="ProductImage" Display="None" ErrorMessage="Image upload is required"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                    
                                    <div class="form-row">
                                        <asp:Button ID="SubmitProduct" runat="server" Text="Create New Product" CssClass="btn btn-danger" OnClick="SubmitProduct_Click" style="background-color:#14A697;margin:5px;border:1px solid #14A697;"/>
                                    </div>
                            </div>
                        </div>
                    </div>
            </asp:View>
        </asp:MultiView>
    </div>
        


</asp:Content>

