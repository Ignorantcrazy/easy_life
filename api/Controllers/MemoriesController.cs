using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using api.Models;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;

namespace api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MemoriesController : BaseController
    {
        private readonly IConfiguration _configuration;
        private readonly EasyLifeContext _context;
        public MemoriesController(IConfiguration configuration, EasyLifeContext context)
        {
            this._configuration = configuration;
            this._context = context;
        }
        [HttpGet]
        public async Task<ActionResult<List<MemoriesViewModel>>> Get()
        {
            var models = await _context.Memories.ToListAsync();
            return MemoriesListViewModel(models);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<MemoriesViewModel>> Get(int id)
        {
            var model = await _context.Memories.FindAsync(id);
            return MemoriesViewModel(model);
        }

        // GET api/memories/next/5
        [HttpGet("next/{nextNum}")]
        public async Task<ActionResult<MemoriesViewModel>> GetNext(string nextNum)
        {
            int index = 0;
            int indexLenght = _context.Memories.Count() - 1;
            if (!int.TryParse(nextNum, out int nextIndex))
            {
                Random rdom = new Random();
                index = rdom.Next(0, indexLenght);
            }
            else
            {
                if (nextIndex <= indexLenght)
                {
                    index = nextIndex;
                }
            }
            var model = await _context.Memories.Skip(index).FirstOrDefaultAsync();
            return MemoriesViewModel(model, index);
        }

        [HttpPost]
        [RequestSizeLimit(1073741824)]
        public async Task<IActionResult> Post(IFormFile file)
        {
            if (file.Length > 0)
            {
                var fileDataStr = Request.Form["fileData"].ToString();
                var fileData = JsonConvert.DeserializeObject<MemoriesViewModel>(fileDataStr);
                var model = new Memories()
                {
                    Title = fileData.Title,
                    Remark = fileData.Remark,
                    Tag = fileData.Tag,
                    ShowTime = fileData.ShowTime
                };

                string filePath = _configuration["Memories:resPath"];
                string fileExtension = Path.GetExtension(file.FileName);
                switch (fileExtension.ToUpper())
                {
                    case ".MP4":
                        model.IsImage = false;
                        break;
                    case ".JPG":
                    case ".PNG":
                        model.IsImage = true;
                        break;
                }
                filePath = Path.Combine(filePath, model.Title + fileExtension);
                if (System.IO.File.Exists(filePath))
                {
                    model.Title = model.Title + DateTime.Now.ToString("yyyyMMddHHmmssFFF");
                    filePath = Path.Combine(filePath, model.Title + fileExtension);
                }
                model.DataSource = "/" + model.Title + fileExtension;
                using (var stream = new FileStream(filePath, FileMode.CreateNew))
                {
                    await file.CopyToAsync(stream);
                }

                await _context.Memories.AddAsync(model);
                await _context.SaveChangesAsync();
            }
            return Ok(new { message = "sucess" });
        }
    }
}