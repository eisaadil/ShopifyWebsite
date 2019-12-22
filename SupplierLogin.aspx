<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="SupplierLogin.aspx.cs" Inherits="SupplierLogin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        .auto-style2 {
            width: 91px;
        }
        .auto-style3 {
            width: 535px;
        }
        .auto-style4 {
            width: 91px;
            height: 23px;
        }
        .auto-style5 {
            width: 535px;
            height: 23px;
        }
        .auto-style6 {
            width: 138px;
        }
        .auto-style7 {
            width: 100%;
            height: 119px;
        }
        .auto-style8 {
            width: 138px;
            height: 23px;
        }
        .auto-style9 {
            height: 23px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


    <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
      <asp:View ID="View1" runat="server">
       <div class="container">
        <div class="row ">
            <div class="col-md-4 py-5 bg-primary text-white text-center ">
                <div class=" ">
                    <div class="card-body">
                        <img src="Images/user-icon.png" style="height:100px;width:100px">
                        <h2 class="py-3">Login</h2>
                        <p></p>
                    </div>
                </div>
            </div>
            <div class="col-md-8 py-5 border">
                <h4 class="pb-4">Please fill with your details</h4>
                    <div class="form-row">
                        <asp:Label ID="LoginError" runat="server" CssClass="alert alert-danger" Text="Incorrect username or password combination" Visible="false"></asp:Label>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                          <asp:TextBox ID="LoginEmail" runat="server" CssClass="form-control" placeholder="Email" TextMode="email"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                          <asp:TextBox ID="LoginPassword" runat="server" CssClass="form-control" placeholder="Password" TextMode="Password"></asp:TextBox>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <asp:Button ID="SignInButton" runat="server" Text="Sign In" CssClass="btn" OnClick="SignInButton_Click" style="color:white;background-color:#14A697;margin-left:5px" />
                    </div>
                    <br />
                    Don't have an account? <asp:LinkButton ID="goToRegistration" runat="server" OnClick="goToRegistration_Click">Register!</asp:LinkButton><br />
            </div>
        </div>
    </div>
        </asp:View>
        <asp:View ID="View2" runat="server">

        <div class="container">
        <div class="row ">
            <div class="col-md-4 py-5 bg-primary text-white text-center ">
                <div class=" ">
                    <div class="card-body">
                        <img src="Images/user-icon.png" style="height:100px;width:100px">
                        <h2 class="py-3">Registration</h2>
                        <p></p>
                    </div>
                </div>
            </div>
            <div class="col-md-8 py-5 border">
                <h4 class="pb-4">Please fill in your details</h4>
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="alert alert-danger" />
                    <div class="form-row">
                        <div class="form-group col-md-6">
                          <asp:TextBox ID="FullName" runat="server" CssClass="form-control" placeholder="Full Name"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="FullNameValidator" runat="server" ControlToValidate="FullName" Display="None" ErrorMessage="Full Name is required"></asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group col-md-6">
                          <asp:TextBox ID="Email" runat="server" CssClass="form-control" placeholder="Email" TextMode="email"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="EmailRequiredValidator" runat="server" ControlToValidate="Email" Display="None" ErrorMessage="Email is required"></asp:RequiredFieldValidator>
                        </div>
                      </div>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <asp:TextBox ID="Phone" runat="server" CssClass="form-control" placeholder="Phone" TextMode="Phone"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="PhoneRequiredValidator" runat="server" ControlToValidate="Phone" Display="None" ErrorMessage="Phone Number required"></asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group col-md-6">
                            <asp:DropDownList ID="Emirate" runat="server" CssClass="form-control">
                                <asp:ListItem Selected="True">Dubai</asp:ListItem>
                                <asp:ListItem>Abu Dhabi</asp:ListItem>
                                <asp:ListItem>Sharjah</asp:ListItem>
                                <asp:ListItem>Al Ain</asp:ListItem>
                                <asp:ListItem>Umm Al Qwain</asp:ListItem>
                                <asp:ListItem>Fujairah</asp:ListItem>
                                <asp:ListItem>Ajman</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                          <asp:TextBox ID="Password" runat="server" CssClass="form-control" placeholder="Password" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="PasswordRequiredValidator" runat="server" ControlToValidate="Password" Display="None" ErrorMessage="Password is required"></asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="PassMatchValidator" runat="server" ControlToCompare="Password2" ControlToValidate="Password" Display="None" ErrorMessage="Passwords do not match"></asp:CompareValidator>
                        </div>
                        <div class="form-group col-md-6">
                          <asp:TextBox ID="Password2" runat="server" CssClass="form-control" placeholder="Confirm Password" TextMode="Password"></asp:TextBox>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <asp:Button ID="SignUpButton" runat="server" Text="Create User" CssClass="btn" OnClick="SignUpButton_Click" style="color:white;background-color:#14A697;margin-left:5px"/>
                    </div>
                    <br />
                    Already have an account? <asp:LinkButton ID="goToLogin" runat="server" OnClick="goToLogin_Click" ValidationGroup="2">Login!</asp:LinkButton><br />
            </div>
        </div>
    </div>

            
            <br />
            
        </asp:View>
    </asp:MultiView>


</asp:Content>

