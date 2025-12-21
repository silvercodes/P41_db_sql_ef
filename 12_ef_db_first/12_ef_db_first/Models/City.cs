using System;
using System.Collections.Generic;

namespace _12_ef_db_first.Models;

public partial class City
{
    public int Id { get; set; }

    public string? Title { get; set; }

    public int CountryId { get; set; }

    public virtual ICollection<Branch> Branches { get; set; } = new List<Branch>();

    public virtual Country Country { get; set; } = null!;
}
