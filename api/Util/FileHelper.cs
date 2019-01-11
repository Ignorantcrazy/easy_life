using System;
using System.Collections.Generic;
using System.IO;
using System.Threading.Tasks;
using api.Models;

namespace api.Util
{
    public class FileHelper
    {
        public static async Task<List<OnlineModel>> GetResData(string dirPath, List<OnlineModel> oList)
        {
            var dInfo = new DirectoryInfo(dirPath);
            var files = dInfo.GetFiles();
            var dirs = dInfo.GetDirectories();
            foreach (var file in files)
            {
                if (file.Extension.ToUpper() == ".MP4")
                {
                    oList.Add(new OnlineModel()
                    {
                        DataSource = file.FullName.Replace(dirPath, ""),
                        Tag = "",
                        ShowTime = DateTime.Now.ToShortDateString(),
                        IsImage = false
                    });
                }
                if (file.Extension.ToUpper() == ".JPG" || file.Extension.ToUpper() == ".PNG")
                {
                    oList.Add(new OnlineModel()
                    {
                        DataSource = file.FullName.Replace(dirPath, "").Replace("\\","/"),
                        Tag = "",
                        ShowTime = DateTime.Now.ToShortDateString(),
                        IsImage = true
                    });
                }
            }
            foreach (var dir in dirs)
            {
                await GetResData(dir.FullName, oList);
            }

            return oList;
        }
    }
}