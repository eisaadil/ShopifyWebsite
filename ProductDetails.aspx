<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ProductDetails.aspx.cs" Inherits="ProductDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style1 {
            width: 79px;
            border:0px;
        }
        .auto-style2 {
            width: 79px;
            height: 51px;
        }
        .auto-style3 {
            height: 51px;
            
            border:0px;
        }
        .auto-style4 {
            height: 32px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="navbar" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container-fluid" style="text-align:center">
        <asp:FormView ID="ProductDetail" runat="server" DataSourceID="GetProductByID" DataKeyNames="p_id,c_id1,b_id1,s_id1" >
            <ItemTemplate>
                <table style="width:100%">
                    <tr>
                        <td colspan ="2" style=""><asp:Label ID="Label1" runat="server" Text='<%# "<h2>"+Eval("p_name")+"</h2>" %>' /></td>
                    </tr>
                    <tr>
                        <td style="vertical-align:middle; margin:10px;max-width: 400px;">
                            <asp:Image ID="ProductImageDetail" runat="server" ImageUrl='<%# "productImages/"+Eval("p_image_link") %>' style=" max-width:600px; height: 400px;" />

                        </td>
                        <td>
                            <table class="w-100 table" style="text-align:left">
                        <tr>
                            <td class="auto-style1" style="border-top:0px">Price</td>
                            <td style="border-top:0px">
                                <asp:Label ID="p_priceLabel" runat="server" Text='<%# "AED "+ Eval("p_price") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style1" style="border-top:0px">Category</td>
                            <td style="border-top:0px">
                                <asp:Label ID="c_nameLabel" runat="server" Text='<%# Eval("c_name") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style1" style="border-top:0px">Brand</td>
                            <td style="border-top:0px">
                                <asp:Label ID="b_nameLabel" runat="server" Text='<%# Eval("b_name") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style1" style="border-top:0px">Colour</td>
                            <td style="border-top:0px">
                                <asp:Label ID="p_colorLabel" runat="server" Text='<%# Eval("p_color") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style2" style="border-top:0px">Posted On</td>
                            <td class="auto-style3"  style="border-top:0px">
                                <asp:Label ID="p_posted_dateLabel" runat="server" Text='<%# Eval("p_posted_date") %>' />
                            </td>
                        </tr>
                                <tr>
                                    <td class="auto-style4" colspan="2" style="border-top:0px;font-weight:bold;text-decoration:underline">
                                        Supplier Information</td>
                                </tr>
                        <tr>
                            <td class="auto-style1"  style="border-top:0px">Name</td>
                            <td style="border-top:0px">
                                <asp:Label ID="s_nameLabel" runat="server" Text='<%# Eval("s_name") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style1" style="border-top:0px">Email</td>
                            <td style="border-top:0px">
                                <asp:Label ID="s_emailLabel" runat="server" Text='<%# Eval("s_email") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style1" style="border-top:0px">Phone</td>
                            <td style="border-top:0px">
                                <asp:Label ID="s_phoneLabel" runat="server" Text='<%# Eval("s_phone") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style1" style="border-top:0px">Location</td>
                            <td style="border-top:0px">
                                <asp:Label ID="s_locLabel" runat="server" Text='<%# Eval("s_loc") %>' />
                            </td>
                        </tr>
                    </table>
                        </td>
                    </tr>
                </table>

            </ItemTemplate>
        </asp:FormView>
        <asp:SqlDataSource ID="GetProductByID" runat="server" ConnectionString="<%$ ConnectionStrings:ITProjectConnectionString %>" SelectCommand="SELECT Product.[p_id], Product.[p_name], Product.[b_id], Product.[c_id], Product.[p_price], Product.[p_image_link], Product.[p_color], Product.[p_posted_date], Product.[s_id], Category.[c_id], Category.[c_name], Brand.[b_id], Brand.[b_name],Supplier.s_id,Supplier.s_name,Supplier.s_email,Supplier.s_phone,Supplier.s_loc FROM [Product], [Category], [Brand],[Supplier] WHERE (Product.[p_id] = @p_id AND Brand.[b_id] = Product.[b_id] AND Product.[c_id] = Category.[c_id] AND Product.s_id = Supplier.s_id) ORDER BY CONVERT(datetime, Product.p_posted_date) desc">
                <SelectParameters>
                    <asp:QueryStringParameter Name="p_id" QueryStringField="pid" />
                </SelectParameters>
        </asp:SqlDataSource>
    </div>
    </asp:Content>

