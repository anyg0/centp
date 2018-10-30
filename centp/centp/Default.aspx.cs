using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;

namespace centp
{
    public partial class Default : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["CON"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnAddItem_Click(object sender, EventArgs e)
        {
            addAct(ddlList.SelectedItem.Value.Trim());
        }

        private bool addAct(string value)
        {
            string insertQuery;
            switch (value)
            {
                case "Item":
                    insertQuery = "Insert into items(item) values('" + txtItem.Text.Trim() + "')";
                    break;
                case "Bincode":
                    insertQuery = "Insert into item(bincode,item,description,details)values('" + txtBincode.Text.Trim() + "', '" + ddlBinItem.SelectedValue.ToString().Trim() + "', '" + txtBinDesc.Text + "', '" + txtBinDetails.Text + "')";
                    break;
                default:
                    insertQuery = null;
                    break;

            }

            try
            {
                using (SqlConnection con = new SqlConnection(conStr))
                {
                    using (SqlCommand cmd = new SqlCommand(insertQuery))
                    {
                        cmd.Connection = con;
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                    }
                    litBottomInfo.Text = value + " has been added Successfuly!!";
                    Response.Redirect("~/Default.aspx");
                    return true;
                }
            }
            catch (SqlException mySqlEx)
            {
                litBottomInfo.Text = "(" + mySqlEx.Number.ToString() + ") Error in Submition!!";
                return false;
            }

        }



        protected void ddlList_SelectedIndexChanged(object sender, EventArgs e)
        {
            string strV = ddlList.SelectedItem.Value.Trim();
            switch (strV)
            {
                case "Item":
                    panelItem.Visible = true;
                    panelBincode.Visible = false;
                    panelConYear.Visible = false;
                    break;
                case "Bincode":
                    panelItem.Visible = false;
                    panelBincode.Visible = true;
                    panelConYear.Visible = false;
                    break;
                case "Consumption":
                    panelItem.Visible = false;
                    panelBincode.Visible = false;
                    panelConYear.Visible = true;
                    break;
            }
        }

        protected void ddlCYBinCode_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtCYBinDesc.Text = ddlCYBinCode.SelectedItem.Value;
        }
    }
}