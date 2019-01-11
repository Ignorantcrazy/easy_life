using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using api.Models;
using api.Util;

namespace api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MemoriesController : ControllerBase
    {

        IConfiguration configuration;
        public MemoriesController(IConfiguration configuration)
        {
            this.configuration = configuration;
        }
        [HttpGet]
        public async Task<ActionResult<List<OnlineModel>>> Get()
        {
            var dirPath = configuration.GetSection("Memories")["resPath"];
            if (!Directory.Exists(dirPath))
            {
                return null;
            }

            List<OnlineModel> oList = new List<OnlineModel>();
            oList = await FileHelper.GetResData(dirPath, oList);

            return oList;
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<OnlineModel>> Get(int id)
        {
            var dirPath = configuration.GetSection("Memories")["resPath"];
            if (!Directory.Exists(dirPath))
            {
                return null;
            }

            List<OnlineModel> oList = new List<OnlineModel>();
            oList = await FileHelper.GetResData(dirPath, oList);
            int index = 0;
            if (id >= oList.Count)
            {
                index = 0;
            }
            else
            {
                index = id;
            }
            if (id == 99999)
            {
                Random rdom = new Random();
                index = rdom.Next(0, oList.Count - 1);
            }
            var model = oList[index];
            model.Index = index;
            return model;
        }

        [HttpPost]
        public async Task<IActionResult> Post(IFormFile file)
        {
            if (file.Length > 0)
            {
                string filePath = configuration.GetSection("Memories")["resPath"];
                filePath = Path.Combine(filePath, file.FileName);
                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    await file.CopyToAsync(stream);
                }
            }
            return Ok(new { message = "sucess" });
        }
    }
}