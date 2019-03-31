using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace MidoriBookStore.Models.AddToCart
{
    public class AddOrderModel
    {
        public static SqlConnection GetConnection()
        {
            string conString = ConfigurationManager.ConnectionStrings["BookStoreDB"].ToString();
            SqlConnection myconnection = new SqlConnection(conString);
            return myconnection;
        }

        public static int AddOrder(int cusID, string orderDate, double total, string address, string phone)
        {
            string sql = @"INSERT [Order](UserID,OrderDate,Total,Address,PhoneNumber)
                          VALUES(@UserID, @OrderDate, @Total, @Address, @PhoneNumber);SELECT CAST(scope_identity() AS int)";
            SqlCommand command = new SqlCommand(sql, GetConnection());
            command.Connection.Open();
            //Console.WriteLine(String.Format("sdadsad{0}",customerId));
            //Console.WriteLine($"sdadsad{customerId}");
            SqlParameter param2 = new SqlParameter("@UserID", SqlDbType.Int);
            param2.Value = cusID;
            command.Parameters.Add(param2);

            SqlParameter param3 = new SqlParameter("@OrderDate", SqlDbType.DateTime);
            param3.Value = orderDate;
            command.Parameters.Add(param3);

            SqlParameter param4 = new SqlParameter("@Total", SqlDbType.Money);
            param4.Value = total;
            command.Parameters.Add(param4);

            SqlParameter param5 = new SqlParameter("@Address", SqlDbType.NVarChar);
            param5.Value = address;
            command.Parameters.Add(param5);

            SqlParameter param6 = new SqlParameter("@PhoneNumber", SqlDbType.NVarChar);
            param6.Value = phone;
            command.Parameters.Add(param6);

            int k = (int)command.ExecuteScalar();
            if (command.Connection.State == System.Data.ConnectionState.Open) command.Connection.Close();
            return k;
        }

        public static int AddOrderLine(int orderID, int bookID, double price, int quantity)
        {
            string sql = @"INSERT INTO [OrderLine] (OrderID, BookID, BookPrice, Quantity)" +
                 "VALUES (@orderID, @bookID, @price, @quantity)";

            SqlCommand command = new SqlCommand(sql, GetConnection());
            command.Connection.Open();

            SqlParameter param1 = new SqlParameter("@orderID", SqlDbType.Int);
            param1.Value = orderID;
            command.Parameters.Add(param1);

            SqlParameter param2 = new SqlParameter("@bookID", SqlDbType.Int);
            param2.Value = bookID;
            command.Parameters.Add(param2);

            SqlParameter param3 = new SqlParameter("@price", SqlDbType.Money);
            param3.Value = price;
            command.Parameters.Add(param3);

            SqlParameter param4 = new SqlParameter("@quantity", SqlDbType.Int);
            param4.Value = quantity;
            command.Parameters.Add(param4);

            int k = command.ExecuteNonQuery();
            command.Connection.Close();
            return k;
        }

    }
}