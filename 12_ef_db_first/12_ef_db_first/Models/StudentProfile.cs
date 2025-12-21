using System;
using System.Collections.Generic;

namespace _12_ef_db_first.Models;

public partial class StudentProfile
{
    public int Id { get; set; }

    public string FirstName { get; set; } = null!;

    public string LastName { get; set; } = null!;

    public string? Phone { get; set; }

    public virtual User IdNavigation { get; set; } = null!;
}
