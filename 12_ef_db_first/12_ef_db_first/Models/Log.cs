using System;
using System.Collections.Generic;

namespace _12_ef_db_first.Models;

public partial class Log
{
    public int Id { get; set; }

    public DateTime Date { get; set; }

    public string Message { get; set; } = null!;
}
