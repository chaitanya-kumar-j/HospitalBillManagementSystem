<%@ Page Title="" Language="C#" MasterPageFile="~/BillManagement.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="HospitalBillManagement.WebForms.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../StyleSheets/Dashboard.css" rel="stylesheet" runat="server" type="text/css"/>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="form-content">
        <div class="row-content heading">
            <h3>Hospital Bill</h3>
        </div>
        <div class="row-content">
            <asp:Label ID="lbl_BillNo" class="field-labels lbl_BillNo" runat="server" Text="Bill Number"></asp:Label>
            <asp:TextBox ID="txt_BillNo" runat="server" Enabled="False"></asp:TextBox>
            <asp:Label ID="lbl_BillDate" class="field-labels lbl_BillDate" runat="server" Text="Bill Date"></asp:Label>
            <asp:TextBox ID="txt_BillDate" runat="server" TextMode="Date" Enabled="False"></asp:TextBox>
        </div>
        <div class="row-content">
            <asp:Label ID="lbl_PatientName" class="field-labels lbl_PatientName" runat="server" Text="Patient Name"></asp:Label>
            <asp:TextBox ID="txt_PatientName" runat="server" OnTextChanged="txt_PatientName_TextChanged"></asp:TextBox>
            <asp:Label ID="lbl_Gender" class="field-labels lbl_Gender" runat="server" Text="Gender"></asp:Label>
            <asp:DropDownList ID="ddl_Gender" runat="server">
                <asp:ListItem>Male</asp:ListItem>
                <asp:ListItem>Female</asp:ListItem>
                <asp:ListItem Selected="True" Value="-1" Text=" ">  </asp:ListItem>
            </asp:DropDownList>
            <asp:Label ID="lbl_DateOfBirth" class="field-labels lbl_DateOfBirth" runat="server" Text="Date of Birth"></asp:Label>
            <asp:TextBox ID="txt_DateOfBirth" runat="server" TextMode="Date"></asp:TextBox>
        </div>
        <div class="row-content">
            <asp:Label ID="lbl_Address" class="field-labels lbl_Address" runat="server" Text="Address"></asp:Label>
            <asp:TextBox ID="txt_Address" class="txt_Address" runat="server" TextMode="MultiLine"></asp:TextBox>
            <asp:Label ID="lbl_Email" class="field-labels lbl_Email" runat="server" Text="Email"></asp:Label>
            <asp:TextBox ID="txt_Email" runat="server" TextMode="Email"></asp:TextBox>
            <asp:Label ID="lbl_MobileNumber" class="field-labels lbl_MobileNumber" runat="server" Text="Mobile Number"></asp:Label>
            <asp:TextBox ID="txt_MobileNumber" runat="server" TextMode="Phone"></asp:TextBox>
        </div>
        <div class="row-content">
            <asp:Label ID="lbl_Investigation" class="field-labels lbl_Investigation" runat="server" Text="Investigation"></asp:Label>
            <asp:DropDownList ID="ddl_Investigation" runat="server">
                <asp:ListItem>Investigation1</asp:ListItem>
                <asp:ListItem>Investigation2</asp:ListItem>
                <asp:ListItem Selected="True" Value="-1" Text=" ">  </asp:ListItem>
            </asp:DropDownList>
            <asp:Label ID="lbl_Fee" class="field-labels lbl_Fee" runat="server" Text="Fee"></asp:Label>
            <asp:TextBox ID="txt_Fee" runat="server" Enabled="False"></asp:TextBox>
            <asp:Button ID="btn_AddToGrid" class="btn_AddToGrid" runat="server" Text="Add To Grid" BackColor="#0066CC" BorderColor="#0066CC" BorderStyle="Solid" ForeColor="White" OnClick="btn_AddToGrid_Click" />
            <%--<asp:ImageButton ID="ImageButton1" runat="server" />--%>
        </div>
    </div>
    <div class`="gridview-content">
        <asp:GridView ID="gv_PatientBillsData" class="gv_PatientBillsData" runat="server" AutoGenerateColumns="False" 
            OnRowEditing="gv_PatientBillsData_RowEditing" 
            OnRowDeleting="gv_PatientBillsData_RowDeleting" 
            OnRowCancelingEdit="gv_PatientBillsData_RowCancelingEdit" 
            OnRowUpdating="gv_PatientBillsData_RowUpdating">
            <RowStyle HorizontalAlign="Center"/>
            <Columns>
                <asp:TemplateField HeaderText="Bill Number">
                    <ItemTemplate>
                        <asp:Label Text='<%# Eval("BillNumber") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txt_BillNumberEdit" runat="server" Text='<%# Eval("BillNumber") %>' Enabled="false"></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Patient Name">
                    <ItemTemplate>
                        <asp:Label Text='<%# Eval("PatientName") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txt_PatientNameEdit" Text='<%# Eval("PatientName") %>' runat="server"></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Gender">
                    <ItemTemplate>
                        <asp:Label Text='<%# Eval("Gender") %>' runat="server" ></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList ID="dd_GenderEdit" runat="server">
                            <asp:ListItem>Male</asp:ListItem>
                            <asp:ListItem>Female</asp:ListItem>
                            <asp:ListItem Selected="True" Value="-1" Text=" ">  </asp:ListItem>
                        </asp:DropDownList>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Date of Birth">
                    <ItemTemplate>
                        <asp:Label Text='<%# Eval("DateOfBirth", "{0:dd/M/yyyy}") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txt_DateOfBirthEdit" runat="server" TextMode="Date" Text='<%# Eval("DateOfBirth", "{0:dd/M/yyyy}") %>'></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Address">
                    <ItemTemplate>
                        <asp:Label Text='<%# Eval("Address") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txt_AddressEdit" Text='<%# Eval("Address") %>' runat="server" TextMode="MultiLine"></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Email">
                    <ItemTemplate>
                        <asp:Label Text='<%# Eval("Email") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txt_AddressEdit" Text='<%# Eval("Email") %>' runat="server" TextMode="Email"></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Mobile Number">
                    <ItemTemplate>
                        <asp:Label Text='<%# Eval("MobileNumber") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txt_AddressEdit" Text='<%# Eval("MobileNumber") %>' runat="server" TextMode="Phone"></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Investigation">
                    <ItemTemplate>
                        <asp:Label Text='<%# Eval("Investigation") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList ID="dd_InvestigationEdit" runat="server">
                            <asp:ListItem>Investigation1</asp:ListItem>
                            <asp:ListItem>Investigation2</asp:ListItem>
                            <asp:ListItem Selected="True" Value="-1" Text=" "></asp:ListItem>
                        </asp:DropDownList>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Bill Date">
                    <ItemTemplate>
                        <asp:Label Text='<%# Eval("BillDate", "{0:dd/M/yyyy}") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txt_BillDateEdit" runat="server" TextMode="Date" Text='<%# Eval("BillDate") %>'></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <asp:ImageButton ID="ImageButton1" ImageUrl="~/Assets/icons/create-black-18dp.svg" CommandName="Edit" ToolTip="Edit" runat="server" />
                        <asp:ImageButton ID="ImageButton2" ImageUrl="~/Assets/icons/delete-black-18dp.svg" CommandName="Delete" ToolTip="Delete" runat="server" />
                    </ItemTemplate>
                    <EditItemTemplate>

                    </EditItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <div class="buttons-content">

        </div>
    </div>
</asp:Content>
