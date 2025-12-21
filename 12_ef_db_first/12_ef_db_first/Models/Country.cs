using System;
using System.Collections.Generic;

namespace _12_ef_db_first.Models;

public partial class Country
{
    public int Id { get; set; }

    public string? Title { get; set; }

    public virtual ICollection<City> Cities { get; set; } = new List<City>();
}
