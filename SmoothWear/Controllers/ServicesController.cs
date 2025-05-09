using SmoothWear.Models;
using System.Linq;
using System.Web.Mvc;

public class ServicesController : Controller
{
    SmoothWear_DBEntities db = new SmoothWear_DBEntities();

    public ActionResult Ironing()
    {
        ViewBag.Title = "Ironing Services";
        var products = db.Tbl_ProductDetails
                         .Where(p => p.ProductCategory == "Ironing" && p.IsActive==true)
                         .ToList();
        return View("ServiceList", products);
    }

    public ActionResult Washing()
    {
        ViewBag.Title = "Washing Services";
        var products = db.Tbl_ProductDetails
                         .Where(p => p.ProductCategory == "Washing" && p.IsActive==true)
                         .ToList();
        return View("ServiceList", products);
    }

    public ActionResult WashAndIron()
    {
        ViewBag.Title = "Wash And Iron Services";
        var products = db.Tbl_ProductDetails
                         .Where(p => p.ProductCategory == "Both" && p.IsActive==true)
                         .ToList();
        return View("ServiceList", products);
    }

    public ActionResult AllServices()
    {
        ViewBag.Title = "All Services";
        var products = db.Tbl_ProductDetails
                         .Where(p => p.IsActive==true)
                         .ToList();
        return View("ServiceList", products);
    }
}
