using MidoriBookStore.Models;
using MidoriBookStore.Models.AddToCart;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MidoriBookStore.Controllers
{
    public class AddToCartController : Controller
    {
        private BookStoreDBEntities1 db = new BookStoreDBEntities1();

        // GET: AddToCart
        public ActionResult Index()
        {
            if ((HttpContext.Session != null && Session["CartItem"] as List<CartItem> != null))
            {
                System.Diagnostics.Debug.WriteLine("123");
                ViewData["CartItem"] = (List<CartItem>)Session["CartItem"];
                return View();
            }
            else
            {
                System.Diagnostics.Debug.WriteLine("456");
                return View("_Error");
            }

        }

        public ActionResult CheckOut()
        {
            if ((HttpContext.Session != null && Session["CartItem"] as List<CartItem> != null))
            {
                ViewData["CartItem"] = (List<CartItem>)Session["CartItem"];
                return View();
            }
            else
            {
                return View("_Error");
            }

        }

        [HttpPost]
        public ActionResult CheckOut(FormCollection collection)
        {
            if (HttpContext.Session != null && Session["CartItem"] as List<CartItem> != null)
            {
                string phone = Request["phone"].ToString();
                string address = Request["address"].ToString();
                string orderDate = DateTime.Now.ToString("yyyy-MM-dd");
                int cusID = Convert.ToInt32(Session["UserID"]);

                List<CartItem> items = new List<CartItem>();
                ShoppingCart cart = new ShoppingCart(items);
                cart = new ShoppingCart((List<CartItem>)Session["CartItem"]);

                if (Session["CartItem"] != null)
                {
                    int k = AddOrderModel.AddOrder(cusID, orderDate, cart.GetTotalPrice(), address, phone);

                    if (k != 0)
                    {
                        int m = 0;
                        foreach (CartItem item in cart.items)
                        {
                            m = AddOrderModel.AddOrderLine(k, item.GetBookById().BookID, Convert.ToDouble(item.GetBookById().BookPrice), item.Quantity);
                        }

                        if (m != 0)
                        {
                            Session["CartItem"] = null;
                            return View("_Success");
                        }
                    }
                }
            }
            else
            {
                return View("_Error");
            }
            return RedirectToAction("Index", "Home");

        }

        public ActionResult ChangeQuantity(int id, string s)
        {

            List<CartItem> items = new List<CartItem>();
            ShoppingCart cart = new ShoppingCart(items);
            cart = new ShoppingCart((List<CartItem>)Session["CartItem"]);

            CartItem ci = cart.GetCartItemByProductID(id);

            cart.ChangeQuantityCartItem(ci, s);

            Session["CountCart"] = cart.GetTotalBook();
            Session["CartItem"] = cart.items;
            ViewData["CartItem"] = (List<CartItem>)Session["CartItem"];
            return View("Index");
        }

        // GET: AddToCart/Create/4
        public ActionResult Create(int id, string previousUrl)
        {
            List<CartItem> items = new List<CartItem>();
            ShoppingCart cart = new ShoppingCart(items);

            if (Session["CartItem"] == null)
            {
                cart.AddItem(new CartItem(id));
            }
            else
            {
                cart = new ShoppingCart((List<CartItem>)Session["CartItem"]);
                cart.AddItem(new CartItem(id));
            }
            System.Diagnostics.Debug.WriteLine(cart.items.Count);
            Session["CountCart"] = cart.GetTotalBook();
            Session["CartItem"] = cart.items;


            return RedirectToAction("Index", "Home");
        }


        // GET: AddToCart/Delete/5
        public ActionResult Delete(int id)
        {
            try
            {
                if (Session["CartItem"] != null)
                {
                    List<CartItem> items = new List<CartItem>();
                    ShoppingCart cart = new ShoppingCart(items);
                    cart = new ShoppingCart((List<CartItem>)Session["CartItem"]);

                    CartItem ci = cart.GetCartItemByProductID(id);
                    cart.RemoveCartItem(ci);

                    Session["CartItem"] = cart.items;
                }

                return RedirectToAction("Index");
            }
            catch
            {
                return View("_Error");
            }
        }

    }
}
