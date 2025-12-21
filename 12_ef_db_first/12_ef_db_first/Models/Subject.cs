using System;
using System.Collections.Generic;

namespace _12_ef_db_first.Models;

public partial class Subject
{
    public int Id { get; set; }

    public string Title { get; set; } = null!;

    public DateTime? DeletedAt { get; set; }

    public int FlowId { get; set; }

    public virtual Flow Flow { get; set; } = null!;

    public virtual ICollection<Pair> Pairs { get; set; } = new List<Pair>();
}
