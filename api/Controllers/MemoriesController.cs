using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using api.Models;
using api.Util;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;

namespace api.Controllers
{
    [Route("api/[Controller]")]
    [ApiController]
    public class MemoriesController : ControllerBase
    {

        IConfiguration configuration;
        public MemoriesController(IConfiguration configuration)
        {
            this.configuration = configuration;
        }
        [HttpGet]
        public async Task<ActionResult<List<OnlineModel>>> Get(){
            var dirPath = configuration.GetSection("Memories")["resPath"];
            if(!Directory.Exists(dirPath)){
                return null;
            }

            List<OnlineModel> oList = new List<OnlineModel>();
            oList = await FileHelper.GetResData(dirPath, oList);
            
            return oList;
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<OnlineModel>> Get(int number){
            var dirPath = configuration.GetSection("Memories")["resPath"];
            if(!Directory.Exists(dirPath)){
                return null;
            }

            List<OnlineModel> oList = new List<OnlineModel>();
            oList = await FileHelper.GetResData(dirPath, oList);
            
            return oList.FirstOrDefault();
        }
    }
}