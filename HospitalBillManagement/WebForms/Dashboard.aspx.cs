﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HospitalBillManagement.WebForms
{
    public partial class Dashboard : System.Web.UI.Page
    {
        private readonly string _connectionString = ConfigurationManager.ConnectionStrings["HospitalBillDB"].ToString();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadGridView();
            }
        }

        public void LoadGridView()
        {
            using (SqlConnection con = new SqlConnection(_connectionString))
            {
                SqlCommand cmd = new SqlCommand("spLoadGridView", con);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                //SqlDataReader dataReader = cmd.ExecuteReader();

                //gv_PatientBillsData.DataSource = dataReader;

                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(cmd);
                DataTable dataTable = new DataTable();
                sqlDataAdapter.Fill(dataTable);
                //cmd.Connection = con;
                //cmd.Connection.Open();
                gv_PatientBillsData.DataSource = dataTable;
                gv_PatientBillsData.DataBind();
            }
        }

        protected void gv_PatientBillsData_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gv_PatientBillsData.PageIndex = e.NewPageIndex;
            LoadGridView();
        }

        protected void txt_PatientName_TextChanged(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(_connectionString))
            {
                SqlCommand cmd = new SqlCommand("spGetPatientDetails", con);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                SqlDataReader dataReader = cmd.ExecuteReader();

                if (dataReader.HasRows)
                {
                    ddl_Gender.SelectedValue = (string)dataReader.GetValue(dataReader.GetOrdinal("Gender"));
                    txt_DateOfBirth.Text = (string)dataReader.GetValue(dataReader.GetOrdinal("DateOfBirth"));

                }
            }
        }

        protected void gv_PatientBillsData_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gv_PatientBillsData.EditIndex = e.NewEditIndex;
            LoadGridView();
        }

        protected void gv_PatientBillsData_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(_connectionString))
                {
                    SqlCommand cmd = new SqlCommand("spDeleteBill", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@BillNumber", Convert.ToInt32(gv_PatientBillsData.DataKeys[e.RowIndex].Value));
                    con.Open();
                    var result = cmd.ExecuteNonQuery();
                    if (result != 1)
                    {
                        throw new Exception("Deletion failed");
                    }
                    LoadGridView();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void gv_PatientBillsData_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gv_PatientBillsData.EditIndex = -1;
            LoadGridView();
        }

        protected void gv_PatientBillsData_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(_connectionString))
                {
                    SqlCommand cmd = new SqlCommand("spEditBill", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@BillNumber", Convert.ToInt32(gv_PatientBillsData.DataKeys[e.RowIndex].Value));
                    cmd.Parameters.AddWithValue("@PatientName", (gv_PatientBillsData.Rows[e.RowIndex].FindControl("txt_PatintNameEdit") as TextBox).Text.Trim());
                    cmd.Parameters.AddWithValue("@Gender", (gv_PatientBillsData.Rows[e.RowIndex].FindControl("txt_PatintNameEdit") as TextBox).Text.Trim());
                    cmd.Parameters.AddWithValue("@DateOfBirth", (gv_PatientBillsData.Rows[e.RowIndex].FindControl("txt_DateOfBirthEdit") as TextBox).Text.Trim());
                    cmd.Parameters.AddWithValue("@Address", (gv_PatientBillsData.Rows[e.RowIndex].FindControl("txt_AddressEdit") as TextBox).Text.Trim());
                    cmd.Parameters.AddWithValue("@Email", (gv_PatientBillsData.Rows[e.RowIndex].FindControl("txt_EmailEdit") as TextBox).Text.Trim());
                    cmd.Parameters.AddWithValue("@MobileNumber", (gv_PatientBillsData.Rows[e.RowIndex].FindControl("txt_MobileNumberEdit") as TextBox).Text.Trim());
                    cmd.Parameters.AddWithValue("@Investigation", (gv_PatientBillsData.Rows[e.RowIndex].FindControl("ddl_InvestigationsEdit") as TextBox).Text.Trim());
                    cmd.Parameters.AddWithValue("@Fee", 4000);
                    con.Open();
                    var result = cmd.ExecuteNonQuery();
                    if (result != 0)
                    {
                        throw new Exception("updation failed");
                    }
                    gv_PatientBillsData.EditIndex = -1;
                    LoadGridView();
                }
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }

        protected void btn_AddToGrid_Click(object sender, EventArgs e)
        {

            using (SqlConnection con = new SqlConnection(_connectionString))
            {
                SqlCommand cmd = new SqlCommand("spAddBill", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@PatientName",txt_PatientName.Text);
                cmd.Parameters.AddWithValue("@Gender", ddl_Gender.SelectedValue);
                cmd.Parameters.AddWithValue("@DateOfBirth", txt_DateOfBirth.Text);
                cmd.Parameters.AddWithValue("@Address", txt_Address.Text);
                cmd.Parameters.AddWithValue("@Email", txt_Email.Text);
                cmd.Parameters.AddWithValue("@MobileNumber", txt_MobileNumber.Text);
                cmd.Parameters.AddWithValue("@Investigation", ddl_Investigation.SelectedValue);
                con.Open();
                var result = cmd.ExecuteNonQuery();
                if (result != 1)
                {
                    throw new Exception("updation failed");
                }
                gv_PatientBillsData.EditIndex = -1;
                LoadGridView();
            }
        }

        
    }
}