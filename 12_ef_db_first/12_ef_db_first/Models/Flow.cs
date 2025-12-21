using System;
using System.Collections.Generic;

namespace _12_ef_db_first.Models;

public partial class Flow
{
    public int Id { get; set; }

    public string Title { get; set; } = null!;

    public DateTime CreatedAt { get; set; }

    public DateTime? DeletedAt { get; set; }

    public virtual ICollection<Group> Groups { get; set; } = new List<Group>();

    public virtual ICollection<Subject> Subjects { get; set; } = new List<Subject>();
}
