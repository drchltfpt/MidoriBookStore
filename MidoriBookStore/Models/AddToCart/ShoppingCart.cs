using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace MidoriBookStore.Models.AddToCart
{
    public class ShoppingCart
    {
        public List<CartItem> items { get; set; }

        public CartItem GetCartItemByProductID(int id)
        {
            CartItem c = null;
            foreach (CartItem item in items)
            {
                if (item.BookId == id)
                {
                    c = item;
                    return c;
                }
            }
            return c;
        }

        public ShoppingCart(List<CartItem> cartItems)
        {
            items = cartItems;
        }

        public void AddItem(CartItem c)
        {
            System.Diagnostics.Debug.WriteLine("first");
            if (items.Count == 0 || !SearchCartItem(c))
            {
                System.Diagnostics.Debug.WriteLine("Added");
                items.Add(c);
            }
            else
            {
                ChangeQuantityCartItem(c, "increase");
            }
        }

        public void RemoveCartItem(CartItem c)
        {
            if (SearchCartItem(c))
            {
                System.Diagnostics.Debug.WriteLine("Remove successful");
                items.Remove(c);
            }
            else
            {
                System.Diagnostics.Debug.WriteLine("Unable to remove this product");
            }
        }

        public void ChangeQuantityCartItem(CartItem c, string s)
        {
            for (int i = 0; i < items.Count; i++)
            {
                if (c.Equals(items[i]))
                {
                    if (s == "increase")
                    {
                        items[i].Quantity++;
                        System.Diagnostics.Debug.WriteLine("Increasing ", items[i].Quantity.ToString());
                        break;
                    }
                    else if (s == "decrease")
                    {
                        items[i].Quantity--;
                        if (items[i].Quantity == 0) RemoveCartItem(c);
                        break;
                    }
                }
            }

        }

        protected Boolean SearchCartItem(CartItem c)
        {
            foreach (CartItem ci in items)
            {
                if (c.Equals(ci))
                {
                    return true;
                }
            }
            return false;
        }

        public Double GetTotalPrice()
        {
            double total = 0;
            foreach (CartItem ci in items)
            {
                total += ci.BookPrice * ci.Quantity;
            }
            return total;
        }

        public void UpdateQuantityCartItem(CartItem ci, int quantity)
        {
            foreach (CartItem c in items)
            {
                if (c.BookId == ci.BookId)
                {
                    c.Quantity = quantity;
                    return;
                }
            }
        }

        public int GetTotalBook()
        {
            int t = 0;
            foreach (CartItem c in items) t += c.Quantity;
            return t;
        }


    }
}