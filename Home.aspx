 <%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Home" MaintainScrollPositionOnPostback="true"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>Home</title>
    <style>
        .container-fluid h2, .container-fluid h3 {
            font-weight: bolder;
            color: #0268A6;
        }

         .carousel-control-prev-icon, .carousel-control-next-icon {
            height: 100px;
            width: 100px;
            background-size: 100%, 100%;
            background-image: none;
        }

        .carousel-control-next-icon:after
        {
            content: '>';
            font-size: 30px;
            color: #0268A6;
        }

        .carousel-control-prev-icon:after {
            content: '<';
            font-size: 30px;
            color: #0268A6;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="navbar" Runat="Server">
        <asp:LinkButton ID="GoToSupplierLoginButton" runat="server" Text="Are you a Supplier?" CssClass="my-2 my-sm-0 go-login-supplier" OnClick="GoToSupplierLoginButton_Click" style="color:#fff"/>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container-fluid" style="width:80%;margin-bottom:5px">
        <h2>Latest Products</h2>
    </div>
    <div class="container-fluid" style="width:50%;margin-bottom:5px">
        <asp:Repeater ID="LatestFiveRepeater" runat="server" DataSourceID="LatestFiveDS">
              <HeaderTemplate>
                  <div class="carousel slide" id="five-product-carousel" data-ride="carousel" style="margin-bottom:5px">
                    <div class="carousel-inner">
              </HeaderTemplate>
              <ItemTemplate>
                  <div class="carousel-item"> 
                      <asp:ImageButton ID="ProductInCarousel" runat="server" ImageUrl='<%# "productImages/"+Eval("p_image_link") %>' CssClass="d-block carousel-image" PostBackUrl='<%# "ProductDetails.aspx?pid="+Eval("p_id") %>' />
                      <br />
                      <h5 style="text-align:center"><%# "<b>"+Eval("p_name") + "</b> - AED "+ Eval("p_price") +"" %></h5>  
                  </div>
              </ItemTemplate>
              <FooterTemplate>
                    </div>
                    <a class="carousel-control-prev" href="#five-product-carousel" role="button" data-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="sr-only">Previous</span>
                      </a>
                     <a class="carousel-control-next" href="#five-product-carousel" role="button" data-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="sr-only">Next</span>
                     </a>
                  </div>
              </FooterTemplate>
        </asp:Repeater>
        <asp:SqlDataSource ID="LatestFiveDS" runat="server" ConnectionString="<%$ ConnectionStrings:ITProjectConnectionString %>" SelectCommand="SELECT * FROM Product ORDER BY p_posted_date DESC offset 0 rows fetch next 5 rows only"></asp:SqlDataSource>
    </div>
    <div class="container-fluid" style="width:80%;margin-bottom:5px">
        <h2>Search Product</h2>
        <div class="form-row" style="width:100%">
            <div class="form-group col-md-4">
                <asp:TextBox ID="SearchBox" runat="server" CssClass="form-control" AutoCompleteType="Search" placeholder="Search for product (eg Galaxy S8)"></asp:TextBox>
            </div>
            <div class="form-group col-md-3 form-row">
                <div class="form-group col-md-2" style="text-align:right;padding-top:5px">
                Price:
                </div>
                <div class="form-group col-md-5">
                    <asp:TextBox ID="MinRange" runat="server" CssClass="form-control" placeholder="Min" TextMode="Number"></asp:TextBox>
                </div>
                <div class="form-group col-md-5">
                    <asp:TextBox ID="MaxRange" runat="server" CssClass="form-control" placeholder="Max" TextMode="Number"></asp:TextBox>
                </div>
            </div>
            
            <div class="form-group col-md-2">
                <asp:DropDownList ID="CategorySearch" runat="server" CssClass="form-control" DataSourceID="CategoriesUnique" DataTextField="c_name" DataValueField="c_id">
                </asp:DropDownList>
                <asp:SqlDataSource ID="CategoriesUnique" runat="server" ConnectionString="<%$ ConnectionStrings:ITProjectConnectionString %>" SelectCommand="SELECT DISTINCT [c_id], [c_name] FROM [Category]"></asp:SqlDataSource>
            </div>
            <div class="form-group col-md-2">
                <asp:DropDownList ID="BrandSearch" runat="server" CssClass="form-control" DataSourceID="BrandsDataSource" DataTextField="b_name" DataValueField="b_id">
                </asp:DropDownList>
                <asp:SqlDataSource ID="BrandsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ITProjectConnectionString %>" SelectCommand="SELECT DISTINCT * FROM [Brand]"></asp:SqlDataSource>
            </div>
            <div class="form-group col-md-1">
                <asp:Button ID="SearchButton" runat="server" Text="Go!" CssClass="btn btn-outline-success" OnClick="SearchButton_Click" />
            </div>
        </div>
        <asp:Repeater ID="SearchRepeater" runat="server" DataSourceID="SearchRepeaterDataSource" EnableViewState="false">
            <HeaderTemplate>
                <div class ="row" style="text-align:center">
            </HeaderTemplate>
            <ItemTemplate>
                <div class="col-sm-3" style="text-align:center">
                    <a href='<%# "ProductDetails.aspx?pid="+Eval("p_id") %>'>
                        <div class="card" style="margin-top:5px">
                          <img class="card-img-top mx-auto img-fluid" src='<%# "productImages/"+Eval("p_image_link") %>' style="height:100px;width:100px;margin:5px" alt="Card image cap">
                          <div class="card-body">
                            <h5 class="card-title"><%# Eval("p_name") %></h5>
                            <h6 class="card-subtitle mb-2 text-muted"><%# "AED "+Eval("p_price") %></h6>   
                            <p class="card-text"><%# Eval("c_name")+" - "+Eval("b_name") %></p>
                          </div>
                        </div>
                    </a>
                </div>
            </ItemTemplate>
            <FooterTemplate>
                </div>
                <asp:Label ID="defaultItem" runat="server" Visible='<%# SearchRepeater.Items.Count == 0 %>' Text="No products found" />
            </FooterTemplate>
        </asp:Repeater>
        <asp:SqlDataSource ID="SearchRepeaterDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ITProjectConnectionString %>" >
    </asp:SqlDataSource>
    </div>
    <asp:Label runat="server" ID="Label1"></asp:Label>

    <!--<div class="form-check w-100" style="text-align:center">
        <input class="form-check-input" type="checkbox" value="" id="showAllProducts" onchange="showAllProductsChange(this)">
        <label class="form-check-label" for="showAllProducts">
            Show All Products
        </label>
    </div>-->

    <div class="form-check w-100" style="text-align:center">
        <label class="form-check-label form-check-inline" for="switch">
            Show All Products
        </label>
        <label class="switch form-check-inline">
           <input class="form-check-input" type="checkbox" value="" id="showAllProducts" onchange="showAllProductsChange(this)">
            <span class="slider round"></span>
        </label>
    </div>

    <div class="container-fluid" id="allProductsDiv" style="display:none;width:80%;padding-bottom:10px">
    <asp:Label ID="allProductsHeading" runat="server" Text="<h2>All Products</h2>"></asp:Label>
    <asp:Repeater ID="ProductViewRepeater" runat="server" DataSourceID="AllProducts">
        <HeaderTemplate>
            <div class ="row" style="text-align:center">
        </HeaderTemplate>
        <ItemTemplate>
            <div class="col-sm-3" style="text-align:center">
                <a href='<%# "ProductDetails.aspx?pid="+Eval("p_id") %>'>
                    <div class="card" style="margin-top:5px">
                      <img class="card-img-top mx-auto img-fluid" src='<%# "productImages/"+Eval("p_image_link") %>' style="height:100px;width:100px;margin:5px" alt="Card image cap">
                      <div class="card-body">
                        <h5 class="card-title"><%# Eval("p_name") %></h5>
                        <h6 class="card-subtitle mb-2 text-muted"><%# "AED "+Eval("p_price") %></h6>   
                        <p class="card-text"><%# Eval("c_name")+" - "+Eval("b_name") %></p>
                      </div>
                    </div>
                </a>
            </div>
        </ItemTemplate>
        <FooterTemplate>
            </div>
        </FooterTemplate>
    </asp:Repeater>
    <asp:SqlDataSource ID="AllProducts" runat="server" ConnectionString="<%$ ConnectionStrings:ITProjectConnectionString %>" SelectCommand="SELECT Product.[p_id], Product.[p_name], Product.[b_id], Product.[c_id], Product.[p_price], Product.[p_image_link], Product.[p_color], Product.[p_posted_date], Product.[s_id], Category.[c_id], Category.[c_name], Brand.[b_id], Brand.[b_name] FROM [Product], [Category], [Brand] WHERE (Brand.[b_id] = Product.[b_id] AND Product.[c_id] = Category.[c_id]) ORDER BY CONVERT(datetime, Product.p_posted_date) desc">
    </asp:SqlDataSource>
</div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="PutScriptHere" Runat="Server">
    <script>
        $(document).ready(function () {
            $('.carousel-inner .carousel-item:first').addClass('active');

            $('#five-product-carousel').carousel({
                interval: 3000
            });

            $('#five-product-carousel').carousel('cycle');
        });

        $('#showAllProdcuts').click(function() {
            $("#txtAge").toggle(this.checked);
        });

        function showAllProductsChange(showAllProductsCheckbox) {
            if (showAllProductsCheckbox.checked == true) {
                document.getElementById("allProductsDiv").style.display = "block";
            }else{
                document.getElementById("allProductsDiv").style.display = "none";
           }
        }
        </script>
</asp:Content>
