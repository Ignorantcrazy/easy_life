using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace api.Models
{
    public class EasyLifeContext : DbContext
    {
        public EasyLifeContext(DbContextOptions options) : base(options)
        {
        }

        public DbSet<Memories> Memories { get; set; }
    }

    public class Memories
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public long ID { get; set; }
        public string Title { get; set; }
        public string Tag { get; set; }
        public string Remark { get; set; }
        public string ShowTime { get; set; }
        public bool IsImage { get; set; }
        public string DataSource { get; set; }
    }
}