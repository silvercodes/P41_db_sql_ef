using System;
using System.Collections.Generic;

namespace _12_ef_db_first.Models;

public partial class User
{
    public int Id { get; set; }

    public string Email { get; set; } = null!;

    public string PassHash { get; set; } = null!;

    public DateTime CreatedAt { get; set; }

    public DateTime? DeletedAt { get; set; }

    public virtual EmployeeProfile? EmployeeProfile { get; set; }

    public virtual StudentProfile? StudentProfile { get; set; }

    public virtual ICollection<Permission> Permissions { get; set; } = new List<Permission>();

    public virtual ICollection<Role> Roles { get; set; } = new List<Role>();
}
