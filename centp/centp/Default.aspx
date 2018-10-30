<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="centp.Default" %>

<%--<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>--%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h3><asp:DropDownList ID="ddlList" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlList_SelectedIndexChanged">
            <asp:ListItem Value="Select">--Select--</asp:ListItem>
            <asp:ListItem Value="Item"></asp:ListItem>
            <asp:ListItem Value="Bincode"></asp:ListItem>
            <asp:ListItem Value="Consumption"></asp:ListItem>
        </asp:DropDownList></h3>
        <br />
        <br />
        <asp:Panel ID="panelItem" runat="server" Visible="false">      
             <asp:TextBox ID="txtItem" runat="server"></asp:TextBox>
            <asp:Button ID="btnAddItem" runat="server" OnClick="btnAddItem_Click" /> 
        </asp:Panel>
        <asp:Panel ID="panelBincode" runat="server" Visible="false">            
            Select an Item<br /><asp:DropDownList ID="ddlBinItem" runat="server" DataSourceID="item" DataTextField="item" DataValueField="item"></asp:DropDownList>
            <br />Bincode to add<br /><asp:TextBox ID="txtBincode" runat="server" placeholder="-Bincode-"></asp:TextBox>
            <asp:SqlDataSource ID="item" runat="server" ConnectionString="Data Source=centpur.mssql.somee.com;Initial Catalog=centpur;Persist Security Info=True;User ID=anago_SQLLogin_1;Password=test1234;Packet Size=4096;Workstation ID=centpur.mssql.somee.com" ProviderName="System.Data.SqlClient" SelectCommand="SELECT DISTINCT [item], [item_Id] FROM [items]"></asp:SqlDataSource>
            <br />Bincode Description <br /><asp:TextBox ID="txtBinDesc" runat="server" placeholder="-Bincode Description-"></asp:TextBox>
            <br />Bincode Details  <br /><asp:TextBox ID="txtBinDetails" runat="server" placeholder="-Bincode Details-"></asp:TextBox>
            <br /><br /><asp:Button ID="btnAddBincode" runat="server" Text="Add Bincode" OnClick="btnAddItem_Click" /> 
        </asp:Panel>
         <asp:Panel ID="panelConYear" runat="server" Visible="false">      
             <br />Select Bincode<asp:DropDownList ID="ddlCYBinCode" runat="server" DataSourceID="bin" DataValueField="description" DataTextField="bincode"  OnSelectedIndexChanged="ddlCYBinCode_SelectedIndexChanged" AutoPostBack="true">
                 <asp:ListItem Value="Select">--Select--</asp:ListItem>
             </asp:DropDownList>
             <asp:SqlDataSource ID="bin" runat="server" ConnectionString="Data Source=centpur.mssql.somee.com;Initial Catalog=centpur;Persist Security Info=True;User ID=anago_SQLLogin_1;Password=test1234;Packet Size=4096;Workstation ID=centpur.mssql.somee.com" ProviderName="System.Data.SqlClient" SelectCommand="SELECT DISTINCT [bincode], [item], [description] FROM [Item]"></asp:SqlDataSource>
             <asp:TextBox ID="txtCYBinDesc" runat="server"></asp:TextBox>
             <br />
             <br />Consumption year<br /> <asp:DropDownList ID="ddlCYYear" runat="server" DataSourceID="years" DataTextField="year" DataValueField="year"></asp:DropDownList>
             <asp:SqlDataSource ID="years" runat="server" ConnectionString="<%$ ConnectionStrings:centpurCON %>" SelectCommand="SELECT DISTINCT [year], [Id] FROM [years]"></asp:SqlDataSource>
             <br /> <asp:TextBox ID="txtCYPROCUREMENT" runat="server" placeholder="-PROCUREMENT-"></asp:TextBox>  
             <br /><asp:TextBox ID="txtCYConsumption" runat="server" placeholder="-CONSUMPTION-"></asp:TextBox>             
             <br /><asp:Button ID="btnAddConYear" runat="server" OnClick="btnAddItem_Click"  Text="Add"/> 
             <br /><asp:GridView ID="grdCYBin" runat="server" AutoGenerateColumns="False" DataSourceID="cyear" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal" DataKeyNames="Id">
                 <AlternatingRowStyle BackColor="#F7F7F7" />
                 <Columns>
                     <asp:CommandField ShowEditButton="True" />
                     <asp:BoundField DataField="bincode" HeaderText="bincode" SortExpression="bincode" />
                     <asp:BoundField DataField="year" HeaderText="year" SortExpression="year" />
                     <asp:BoundField DataField="proc" HeaderText="proc" SortExpression="proc" />
                     <asp:BoundField DataField="consum" HeaderText="consum" SortExpression="consum" />
                     <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" SortExpression="Id" />
                 </Columns>
                 <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                 <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                 <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                 <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                 <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                 <SortedAscendingCellStyle BackColor="#F4F4FD" />
                 <SortedAscendingHeaderStyle BackColor="#5A4C9D" />
                 <SortedDescendingCellStyle BackColor="#D8D8F0" />
                 <SortedDescendingHeaderStyle BackColor="#3E3277" />
             </asp:GridView>
             <asp:SqlDataSource ID="cyear" runat="server" ConnectionString="<%$ ConnectionStrings:centpurCON %>" SelectCommand="SELECT [bincode], [year], [proc], [consum], [Id] FROM [procurement] WHERE ([bincode] = @bincode)" ConflictDetection="CompareAllValues" DeleteCommand="DELETE FROM [procurement] WHERE [Id] = @original_Id AND (([bincode] = @original_bincode) OR ([bincode] IS NULL AND @original_bincode IS NULL)) AND (([year] = @original_year) OR ([year] IS NULL AND @original_year IS NULL)) AND (([proc] = @original_proc) OR ([proc] IS NULL AND @original_proc IS NULL)) AND (([consum] = @original_consum) OR ([consum] IS NULL AND @original_consum IS NULL))" InsertCommand="INSERT INTO [procurement] ([bincode], [year], [proc], [consum], [Id]) VALUES (@bincode, @year, @proc, @consum, @Id)" OldValuesParameterFormatString="original_{0}" UpdateCommand="UPDATE [procurement] SET [bincode] = @bincode, [year] = @year, [proc] = @proc, [consum] = @consum WHERE [Id] = @original_Id AND (([bincode] = @original_bincode) OR ([bincode] IS NULL AND @original_bincode IS NULL)) AND (([year] = @original_year) OR ([year] IS NULL AND @original_year IS NULL)) AND (([proc] = @original_proc) OR ([proc] IS NULL AND @original_proc IS NULL)) AND (([consum] = @original_consum) OR ([consum] IS NULL AND @original_consum IS NULL))">
                 <DeleteParameters>
                     <asp:Parameter Name="original_Id" Type="Int32" />
                     <asp:Parameter Name="original_bincode" Type="String" />
                     <asp:Parameter Name="original_year" Type="String" />
                     <asp:Parameter Name="original_proc" Type="String" />
                     <asp:Parameter Name="original_consum" Type="String" />
                 </DeleteParameters>
                 <InsertParameters>
                     <asp:Parameter Name="bincode" Type="String" />
                     <asp:Parameter Name="year" Type="String" />
                     <asp:Parameter Name="proc" Type="String" />
                     <asp:Parameter Name="consum" Type="String" />
                     <asp:Parameter Name="Id" Type="Int32" />
                 </InsertParameters>
                 <SelectParameters>
                     <asp:ControlParameter ControlID="ddlCYBinCode" DefaultValue="7130310652" Name="bincode" PropertyName="SelectedValue" Type="String" />
                 </SelectParameters>
                 <UpdateParameters>
                     <asp:Parameter Name="bincode" Type="String" />
                     <asp:Parameter Name="year" Type="String" />
                     <asp:Parameter Name="proc" Type="String" />
                     <asp:Parameter Name="consum" Type="String" />
                     <asp:Parameter Name="original_Id" Type="Int32" />
                     <asp:Parameter Name="original_bincode" Type="String" />
                     <asp:Parameter Name="original_year" Type="String" />
                     <asp:Parameter Name="original_proc" Type="String" />
                     <asp:Parameter Name="original_consum" Type="String" />
                 </UpdateParameters>
             </asp:SqlDataSource>
        </asp:Panel>
    </div>
        <asp:Literal ID="litBottomInfo" runat="server"></asp:Literal>
    </form>
</body>
</html>
