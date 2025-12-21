
using Microsoft.Data.SqlClient;

const string connString = @"Server=.\SQLEXPRESS;Database=p41_ef_adonet_db;Trusted_Connection=True;Encrypt=False;";
const string connStringWithoutPooling = @"Server=.\SQLEXPRESS;Database=p41_ef_adonet_db;Trusted_Connection=True;Encrypt=False;Pooling=False";
const string connString2 = @"Server=.\SQLEXPRESS;Database=p41_portal_db;Trusted_Connection=True;Encrypt=False;";
const string connString3 = @"Server=.\SQLEXPRESS;Database=p41_mystat_db;Trusted_Connection=True;Encrypt=False;";

//using SqlConnection conn = new SqlConnection(connString3);

//// string title = "COUNTRY_3";
//string title = "my_title'); INSERT INTO countries(title) VALUES('admin looser!!!";

//try
//{
//    conn.Open();
//    Console.WriteLine("Connection OK");

//    string query = @$"INSERT INTO countries(title) VALUES('{title}')";
//    Console.WriteLine(query);

//    SqlCommand cmd = new SqlCommand(query, conn);
//    cmd.ExecuteNonQuery();
//}
//catch (Exception ex)
//{
//    Console.WriteLine($"Error: {ex.Message}");
//}
//finally
//{
//    if (conn.State == System.Data.ConnectionState.Open)
//    {
//        conn.Close();
//        Console.WriteLine("Connection closed");
//    }
//}







//using SqlConnection conn = new SqlConnection(connString3);

//// string title = "COUNTRY_3";
//string title = "my_title'); INSERT INTO countries(title) VALUES('admin looser!!!";

//try
//{
//    conn.Open();
//    Console.WriteLine("Connection OK");

//    string query = @$"INSERT INTO countries(title) VALUES(@title)";

//    SqlCommand cmd = new SqlCommand(query, conn);
//    SqlParameter prm = new SqlParameter("@title", title)
//    {
//        SqlDbType = System.Data.SqlDbType.NVarChar,
//        Size = 256
//    };
//    cmd.Parameters.Add(prm);

//    cmd.ExecuteNonQuery();
//}
//catch (Exception ex)
//{
//    Console.WriteLine($"Error: {ex.Message}");
//}
//finally
//{
//    if (conn.State == System.Data.ConnectionState.Open)
//    {
//        conn.Close();
//        Console.WriteLine("Connection closed");
//    }
//}






using SqlConnection conn = new SqlConnection(connString3);

int number = 203;
string title = "Robotics";
int branchId = 1;

try
{
    conn.Open();
    Console.WriteLine("Connection OK");

    string query = @"
        INSERT INTO classrooms (number, title, branch_id)
        VALUES (@number, @title, @branch_id);
        SET @last_id = SCOPE_IDENTITY();
    ";

    SqlCommand cmd = new SqlCommand(query, conn);

    cmd.Parameters.Add(new SqlParameter("@number", number)
    {
        SqlDbType = System.Data.SqlDbType.NVarChar,
        Size = 32
    });

    cmd.Parameters.Add(new SqlParameter("@title", System.Data.SqlDbType.NVarChar)
    {
        Size = 64,
        Value = title
    });

    cmd.Parameters.Add(new SqlParameter("@branch_id", branchId)
    {
        SqlDbType = System.Data.SqlDbType.Int
    });

    SqlParameter idPrm = new SqlParameter()
    {
        ParameterName = "@last_id",
        SqlDbType = System.Data.SqlDbType.Int,
        Direction = System.Data.ParameterDirection.Output,
    };
    cmd.Parameters.Add(idPrm);

    cmd.ExecuteNonQuery();

    Console.WriteLine($"LAST ID: {idPrm.Value}");
}
catch (Exception ex)
{
    Console.WriteLine($"Error: {ex.Message}");
}
finally
{
    if (conn.State == System.Data.ConnectionState.Open)
    {
        conn.Close();
        Console.WriteLine("Connection closed");
    }
}
