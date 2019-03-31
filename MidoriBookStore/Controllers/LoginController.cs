using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using MidoriBookStore.Models;

namespace MidoriBookStore.Controllers
{
    public class LoginController : Controller
    {
        private BookStoreDBEntities1 db = new BookStoreDBEntities1();

        // GET: Login
        public ActionResult Index()
        {
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Index(User objUser)
        {
            if (ModelState.IsValid)
            {

                var obj = db.Users.Where(a => a.Username.Equals(objUser.Username) && a.Password.Equals(objUser.Password)).FirstOrDefault();
                if (obj != null)
                {
                    Session["UserID"] = obj.UserID.ToString();
                    Session["UserName"] = obj.Username.ToString();
                    if (obj.Role.ToString().Equals("1"))
                    {
                        return RedirectToAction("Index", "Home");
                    }
                    else if (obj.Role.ToString().Equals("2"))
                    {
                        return RedirectToAction("Index", "Books");
                    }

                }

            }
            return View(objUser);
        }

        public ActionResult LogOut()
        {
            FormsAuthentication.SignOut();
            Session.Abandon(); // it will clear the session at the end of request
            return RedirectToAction("Index", "Home");
        }

        // POST: Users/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Signup([Bind(Include = "UserID,Username,DisplayName,Password,UserEmailAddress,Role,isActive")] User user)
        {
            if (ModelState.IsValid)
            {
                db.Users.Add(user);
                db.SaveChanges();
                return RedirectToAction("Index", "Home");
            }
            return RedirectToAction("Index", "Login");

        }
    }
}
