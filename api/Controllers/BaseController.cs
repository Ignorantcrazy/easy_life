using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using api.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;

namespace api.Controllers
{
    [Controller]
    public class BaseController : ControllerBase
    {
        public ActionResult<MemoriesViewModel> MemoriesViewModel(Memories model, int skipNum = 0)
        {
            return new MemoriesViewModel()
            {
                ID = model.ID,
                Title = model.Title,
                Tag = model.Tag,
                Remark = model.Remark,
                ShowTime = model.ShowTime,
                IsImage = model.IsImage,
                DataSource = model.DataSource,
                SkipNum = skipNum
            };
        }

        public ActionResult<List<MemoriesViewModel>> MemoriesListViewModel(List<Memories> models)
        {
            var viewmodels = new List<MemoriesViewModel>();
            foreach (var model in models)
            {
                viewmodels.Add(new MemoriesViewModel()
                {
                    ID = model.ID,
                    Title = model.Title,
                    Tag = model.Tag,
                    Remark = model.Remark,
                    ShowTime = model.ShowTime,
                    IsImage = model.IsImage,
                    DataSource = model.DataSource,
                    SkipNum = 0
                });
            }
            return viewmodels;
        }
    }
}