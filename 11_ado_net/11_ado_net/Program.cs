
using System.Data;
using System.Runtime.CompilerServices;
using System.Text;
using Microsoft.Data.SqlClient;

const string connString = @"Server=.\SQLEXPRESS;Database=p41_ef_adonet_db;Trusted_Connection=True;Encrypt=False;";
const string connStringWithoutPooling = @"Server=.\SQLEXPRESS;Database=p41_ef_adonet_db;Trusted_Connection=True;Encrypt=False;Pooling=False";
const string connString2 = @"Server=.\SQLEXPRESS;Database=p41_portal_db;Trusted_Connection=True;Encrypt=False;";


#region Connection

//using SqlConnection conn = new SqlConnection(connString);

//try
//{
//	conn.Open();

//    Console.WriteLine("Connection OK");
//    Console.WriteLine(conn.ConnectionString);
//    Console.WriteLine(conn.State);
//    Console.WriteLine(conn.ServerVersion);

//    string query = @"CREATE TABLE roles (
//                        id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
//                        title varchar(50) NOT NULL
//                    );";

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

#endregion

#region Pooling

//using (SqlConnection conn = new SqlConnection(connString))
//{
//    conn.Open();
//    Console.WriteLine($"id: {conn.ClientConnectionId}");
//};

//using (SqlConnection conn = new SqlConnection(connString))
//{
//    conn.Open();
//    Console.WriteLine($"id: {conn.ClientConnectionId}");
//};

//Console.WriteLine("----------------");

//using (SqlConnection conn = new SqlConnection(connStringWithoutPooling))
//{
//    conn.Open();
//    Console.WriteLine($"id: {conn.ClientConnectionId}");
//};

//using (SqlConnection conn = new SqlConnection(connStringWithoutPooling))
//{
//    conn.Open();
//    Console.WriteLine($"id: {conn.ClientConnectionId}");
//};

#endregion

#region Command

////===================== EXECUTENONQUERY

//using SqlConnection conn = new SqlConnection(connString);

//try
//{
//    conn.Open();

//    Console.WriteLine("Connection OK");

//    string query = @"CREATE TABLE permissions (
//                            id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
//                            title varchar(50) NOT NULL
//                        );";

//    SqlCommand cmd = new SqlCommand()
//    {
//        Connection = conn,
//        CommandText = query,
//        CommandType = System.Data.CommandType.Text
//    };

//    cmd.ExecuteNonQuery();

//    // USE p41_mystat_db;
//    conn.ChangeDatabase("p41_mystat_db");

//    cmd.CommandText = @"CREATE TABLE logs (
//                            id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
//                            date datetime NOT NULL,
//                            message varchar(1024) NOT NULL
//                        );";

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




//===================== EXECUTESCALAR

//using SqlConnection conn = new SqlConnection(connString2);

//try
//{
//    conn.Open();

//    Console.WriteLine("Connection OK");

//    string query = @"SELECT MAX(id) FROM users;";
//    SqlCommand cmd = new SqlCommand(query, conn);
//    int maxId = (int)cmd.ExecuteScalar();

//    Console.WriteLine($"MaxID = {maxId}");
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



// ===================== EXECUTEREADER

using SqlConnection conn = new SqlConnection(connString2);

try
{
    conn.Open();
    Console.WriteLine("Connection OK");

    string query = @"SELECT id AS [ID], email AS [EMAIL], password AS [PASSWORD] FROM users;";

    SqlCommand cmd = new SqlCommand(query, conn);
    using (SqlDataReader reader = cmd.ExecuteReader())
    {
        using FileStream fs = new FileStream("users.csv", FileMode.OpenOrCreate);
        using StreamWriter sw = new StreamWriter(fs);

        Console.WriteLine($"{reader.GetName(0)}\t\t{reader.GetName(1)}\t\t{reader.GetName(2)}");
        AppentToFile(sw, $"{reader.GetName(0)};{reader.GetName(1)};{reader.GetName(2)}");

        // 1 способ
        //while(reader.Read())
        //{
        //    // int id = (int)reader[0];
        //    // int id = (int)reader["id"];
        //    // int id = reader.GetInt32(0);
        //    // int id = (int)reader.GetValue(0);
        //    int id = reader.GetFieldValue<int>(0);

        //    string email = reader.GetFieldValue<string>(1);

        //    string password = reader.GetFieldValue<string>(2);

        //    Console.WriteLine($"{id}\t\t{email}\t\t{password}");
        //    AppentToFile(sw, $"{id};{email};{password}");
        //}


        // 2 способ
        DataTable dt = new DataTable();
        dt.Load(reader);

        foreach(DataRow row in dt.Rows)
        {
            Console.WriteLine($"{row["ID"]}\t\t{row["EMAIL"]}\t\t{row["PASSWORD"]}");
            AppentToFile(sw, $"{row["ID"]};{row["EMAIL"]};{row["PASSWORD"]}");
        }
    }
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

void AppentToFile(StreamWriter sw, string content)
{
    sw.WriteLine(content);
}


#endregion

#region Stream

//const string filePath = "data.txt";
//const string content = "Hello from application";

// WRITING
//using FileStream fs = new FileStream(filePath, FileMode.OpenOrCreate);
//byte[] binaryData = Encoding.UTF8.GetBytes(content);
//fs.Write(binaryData, 0, binaryData.Length);

//using FileStream fs = new FileStream(filePath, FileMode.OpenOrCreate);
//using StreamWriter sw = new StreamWriter(fs);
//sw.WriteLine(content);



// READING
//using FileStream fs = new FileStream(filePath, FileMode.Open);
//byte[] binaryData = new byte[fs.Length];
//fs.Read(binaryData, 0, (int)fs.Length);
//string data = Encoding.UTF8.GetString(binaryData);
//Console.WriteLine(data);

//using FileStream fs = new FileStream(filePath, FileMode.Open);
//using StreamReader sr = new StreamReader(fs);
//Console.WriteLine(sr.ReadToEnd());



#endregion



