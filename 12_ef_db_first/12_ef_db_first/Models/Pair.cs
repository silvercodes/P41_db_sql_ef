using System;
using System.Collections.Generic;

namespace _12_ef_db_first.Models;

public partial class Pair
{
    public int Id { get; set; }

    public DateOnly PairDate { get; set; }

    public bool IsOnline { get; set; }

    public int ScheduleItemId { get; set; }

    public int SubjectId { get; set; }

    public int ClassroomId { get; set; }

    public int TeacherId { get; set; }

    public virtual Classroom Classroom { get; set; } = null!;

    public virtual ScheduleItem ScheduleItem { get; set; } = null!;

    public virtual Subject Subject { get; set; } = null!;

    public virtual EmployeeProfile Teacher { get; set; } = null!;

    public virtual ICollection<Group> Groups { get; set; } = new List<Group>();
}
