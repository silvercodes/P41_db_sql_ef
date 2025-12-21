using System;
using System.Collections.Generic;

namespace _12_ef_db_first.Models;

public partial class Group
{
    public int Id { get; set; }

    public string Title { get; set; } = null!;

    public byte Status { get; set; }

    public int FlowId { get; set; }

    public virtual Flow Flow { get; set; } = null!;

    public virtual ICollection<Pair> Pairs { get; set; } = new List<Pair>();
}
