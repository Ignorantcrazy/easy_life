using System;

namespace api.Models
{
    public class MemoriesViewModel
    {
        public long ID { get; set; }
        public string Title { get; set; }
        public string Tag { get; set; }
        public string Remark { get; set; }
        public string ShowTime { get; set; }
        public bool IsImage { get; set; }
        public string DataSource { get; set; }
        public int SkipNum { get; set; }
    }
}