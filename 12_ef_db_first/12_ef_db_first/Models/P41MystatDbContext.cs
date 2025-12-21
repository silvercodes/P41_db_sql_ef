using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace _12_ef_db_first.Models;

public partial class P41MystatDbContext : DbContext
{
    public P41MystatDbContext()
    {
    }

    public P41MystatDbContext(DbContextOptions<P41MystatDbContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Branch> Branches { get; set; }

    public virtual DbSet<City> Cities { get; set; }

    public virtual DbSet<Classroom> Classrooms { get; set; }

    public virtual DbSet<Country> Countries { get; set; }

    public virtual DbSet<EmployeeProfile> EmployeeProfiles { get; set; }

    public virtual DbSet<Flow> Flows { get; set; }

    public virtual DbSet<Group> Groups { get; set; }

    public virtual DbSet<Log> Logs { get; set; }

    public virtual DbSet<Pair> Pairs { get; set; }

    public virtual DbSet<Permission> Permissions { get; set; }

    public virtual DbSet<Role> Roles { get; set; }

    public virtual DbSet<ScheduleItem> ScheduleItems { get; set; }

    public virtual DbSet<StudentProfile> StudentProfiles { get; set; }

    public virtual DbSet<Subject> Subjects { get; set; }

    public virtual DbSet<User> Users { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Server=.\\SQLEXPRESS;Database=p41_mystat_db;Trusted_Connection=True;Encrypt=False;");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Branch>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__branches__3213E83F42A56E62");

            entity.ToTable("branches");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.CityId).HasColumnName("city_id");
            entity.Property(e => e.Title)
                .HasMaxLength(64)
                .HasColumnName("title");

            entity.HasOne(d => d.City).WithMany(p => p.Branches)
                .HasForeignKey(d => d.CityId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_branches_city");
        });

        modelBuilder.Entity<City>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__cities__3213E83F80AB3DFD");

            entity.ToTable("cities");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.CountryId).HasColumnName("country_id");
            entity.Property(e => e.Title)
                .HasMaxLength(64)
                .HasColumnName("title");

            entity.HasOne(d => d.Country).WithMany(p => p.Cities)
                .HasForeignKey(d => d.CountryId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_cities_country");
        });

        modelBuilder.Entity<Classroom>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__classroo__3213E83FF0A237BF");

            entity.ToTable("classrooms");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.BranchId).HasColumnName("branch_id");
            entity.Property(e => e.Number)
                .HasMaxLength(32)
                .HasColumnName("number");
            entity.Property(e => e.Title)
                .HasMaxLength(64)
                .HasColumnName("title");

            entity.HasOne(d => d.Branch).WithMany(p => p.Classrooms)
                .HasForeignKey(d => d.BranchId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_classrooms_branch");
        });

        modelBuilder.Entity<Country>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__countrie__3213E83F1C4B446F");

            entity.ToTable("countries");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Title)
                .HasMaxLength(256)
                .HasColumnName("title");
        });

        modelBuilder.Entity<EmployeeProfile>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__employee__3213E83F17F634D2");

            entity.ToTable("employee_profiles");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("id");
            entity.Property(e => e.FirstName)
                .HasMaxLength(64)
                .HasColumnName("first_name");
            entity.Property(e => e.LastName)
                .HasMaxLength(64)
                .HasColumnName("last_name");
            entity.Property(e => e.Phone)
                .HasMaxLength(32)
                .IsUnicode(false)
                .HasColumnName("phone");

            entity.HasOne(d => d.IdNavigation).WithOne(p => p.EmployeeProfile)
                .HasForeignKey<EmployeeProfile>(d => d.Id)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_employee_profiles_user");
        });

        modelBuilder.Entity<Flow>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__flows__3213E83F0A5F1A53");

            entity.ToTable("flows");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.DeletedAt)
                .HasColumnType("datetime")
                .HasColumnName("deleted_at");
            entity.Property(e => e.Title)
                .HasMaxLength(128)
                .HasColumnName("title");
        });

        modelBuilder.Entity<Group>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__groups__3213E83FE29DD542");

            entity.ToTable("groups");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.FlowId).HasColumnName("flow_id");
            entity.Property(e => e.Status)
                .HasDefaultValue((byte)1)
                .HasColumnName("status");
            entity.Property(e => e.Title)
                .HasMaxLength(32)
                .HasColumnName("title");

            entity.HasOne(d => d.Flow).WithMany(p => p.Groups)
                .HasForeignKey(d => d.FlowId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_groups_flow");

            entity.HasMany(d => d.Pairs).WithMany(p => p.Groups)
                .UsingEntity<Dictionary<string, object>>(
                    "GroupsPair",
                    r => r.HasOne<Pair>().WithMany()
                        .HasForeignKey("PairId")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("FK_groups_pairs_pair"),
                    l => l.HasOne<Group>().WithMany()
                        .HasForeignKey("GroupId")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("FK_groups_pairs_group"),
                    j =>
                    {
                        j.HasKey("GroupId", "PairId");
                        j.ToTable("groups_pairs");
                        j.IndexerProperty<int>("GroupId").HasColumnName("group_id");
                        j.IndexerProperty<int>("PairId").HasColumnName("pair_id");
                    });
        });

        modelBuilder.Entity<Log>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__logs__3213E83FD977F3C3");

            entity.ToTable("logs");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Date)
                .HasColumnType("datetime")
                .HasColumnName("date");
            entity.Property(e => e.Message)
                .HasMaxLength(1024)
                .IsUnicode(false)
                .HasColumnName("message");
        });

        modelBuilder.Entity<Pair>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__pairs__3213E83F6691A05C");

            entity.ToTable("pairs");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.ClassroomId).HasColumnName("classroom_id");
            entity.Property(e => e.IsOnline)
                .HasDefaultValue(true)
                .HasColumnName("is_online");
            entity.Property(e => e.PairDate).HasColumnName("pair_date");
            entity.Property(e => e.ScheduleItemId).HasColumnName("schedule_item_id");
            entity.Property(e => e.SubjectId).HasColumnName("subject_id");
            entity.Property(e => e.TeacherId).HasColumnName("teacher_id");

            entity.HasOne(d => d.Classroom).WithMany(p => p.Pairs)
                .HasForeignKey(d => d.ClassroomId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_pairs_classrooms");

            entity.HasOne(d => d.ScheduleItem).WithMany(p => p.Pairs)
                .HasForeignKey(d => d.ScheduleItemId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_pairs_schedule_item");

            entity.HasOne(d => d.Subject).WithMany(p => p.Pairs)
                .HasForeignKey(d => d.SubjectId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_pairs_schedule_subject");

            entity.HasOne(d => d.Teacher).WithMany(p => p.Pairs)
                .HasForeignKey(d => d.TeacherId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_pairs_teacher");
        });

        modelBuilder.Entity<Permission>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__permissi__3213E83F1BE782DE");

            entity.ToTable("permissions");

            entity.HasIndex(e => e.Slug, "UQ__permissi__32DD1E4CDCE7C7FD").IsUnique();

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Slug)
                .HasMaxLength(128)
                .IsUnicode(false)
                .HasColumnName("slug");
            entity.Property(e => e.Title)
                .HasMaxLength(128)
                .HasColumnName("title");

            entity.HasMany(d => d.Roles).WithMany(p => p.Permissions)
                .UsingEntity<Dictionary<string, object>>(
                    "PermissionsRole",
                    r => r.HasOne<Role>().WithMany()
                        .HasForeignKey("RoleId")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("FK_permissions_roles_role"),
                    l => l.HasOne<Permission>().WithMany()
                        .HasForeignKey("PermissionId")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("FK_permissions_roles_permission"),
                    j =>
                    {
                        j.HasKey("PermissionId", "RoleId");
                        j.ToTable("permissions_roles");
                        j.IndexerProperty<int>("PermissionId").HasColumnName("permission_id");
                        j.IndexerProperty<int>("RoleId").HasColumnName("role_id");
                    });

            entity.HasMany(d => d.Users).WithMany(p => p.Permissions)
                .UsingEntity<Dictionary<string, object>>(
                    "PermissionsUser",
                    r => r.HasOne<User>().WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("FK_permissions_users_user"),
                    l => l.HasOne<Permission>().WithMany()
                        .HasForeignKey("PermissionId")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("FK_permissions_users_permission"),
                    j =>
                    {
                        j.HasKey("PermissionId", "UserId");
                        j.ToTable("permissions_users");
                        j.IndexerProperty<int>("PermissionId").HasColumnName("permission_id");
                        j.IndexerProperty<int>("UserId").HasColumnName("user_id");
                    });
        });

        modelBuilder.Entity<Role>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__roles__3213E83FC3C99688");

            entity.ToTable("roles");

            entity.HasIndex(e => e.Slug, "UQ__roles__32DD1E4C264D24FA").IsUnique();

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Slug)
                .HasMaxLength(32)
                .IsUnicode(false)
                .HasColumnName("slug");
            entity.Property(e => e.Title)
                .HasMaxLength(32)
                .HasColumnName("title");

            entity.HasMany(d => d.Users).WithMany(p => p.Roles)
                .UsingEntity<Dictionary<string, object>>(
                    "RolesUser",
                    r => r.HasOne<User>().WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("FK_roles_users_user"),
                    l => l.HasOne<Role>().WithMany()
                        .HasForeignKey("RoleId")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("FK_roles_users_role"),
                    j =>
                    {
                        j.HasKey("RoleId", "UserId");
                        j.ToTable("roles_users");
                        j.IndexerProperty<int>("RoleId").HasColumnName("role_id");
                        j.IndexerProperty<int>("UserId").HasColumnName("user_id");
                    });
        });

        modelBuilder.Entity<ScheduleItem>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__schedule__3213E83F43B2C7ED");

            entity.ToTable("schedule_items");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.ItemEnd).HasColumnName("item_end");
            entity.Property(e => e.ItemStart).HasColumnName("item_start");
            entity.Property(e => e.Number).HasColumnName("number");
            entity.Property(e => e.Status)
                .HasDefaultValue((byte)1)
                .HasColumnName("status");
        });

        modelBuilder.Entity<StudentProfile>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__student___3213E83F50C99C70");

            entity.ToTable("student_profiles");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("id");
            entity.Property(e => e.FirstName)
                .HasMaxLength(64)
                .HasColumnName("first_name");
            entity.Property(e => e.LastName)
                .HasMaxLength(64)
                .HasColumnName("last_name");
            entity.Property(e => e.Phone)
                .HasMaxLength(32)
                .IsUnicode(false)
                .HasColumnName("phone");

            entity.HasOne(d => d.IdNavigation).WithOne(p => p.StudentProfile)
                .HasForeignKey<StudentProfile>(d => d.Id)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_student_profiles_user");
        });

        modelBuilder.Entity<Subject>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__subjects__3213E83F33298FC5");

            entity.ToTable("subjects");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.DeletedAt)
                .HasColumnType("datetime")
                .HasColumnName("deleted_at");
            entity.Property(e => e.FlowId).HasColumnName("flow_id");
            entity.Property(e => e.Title)
                .HasMaxLength(128)
                .HasColumnName("title");

            entity.HasOne(d => d.Flow).WithMany(p => p.Subjects)
                .HasForeignKey(d => d.FlowId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_subjects_flow");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__users__3213E83F20A53EAC");

            entity.ToTable("users");

            entity.HasIndex(e => e.Email, "UQ__users__AB6E616418F57A9F").IsUnique();

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.DeletedAt)
                .HasColumnType("datetime")
                .HasColumnName("deleted_at");
            entity.Property(e => e.Email)
                .HasMaxLength(128)
                .IsUnicode(false)
                .HasColumnName("email");
            entity.Property(e => e.PassHash)
                .HasMaxLength(256)
                .IsUnicode(false)
                .IsFixedLength()
                .HasColumnName("pass_hash");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
