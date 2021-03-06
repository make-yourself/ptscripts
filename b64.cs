using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace b64
{
    class Program
    {
        public static string Base64Encode(string plainText)
        {
            var plainTextBytes = System.Text.Encoding.UTF8.GetBytes(plainText);
            return System.Convert.ToBase64String(plainTextBytes);
        }

        public static string Base64Decode(string base64EncodedData)
        {
            var base64EncodedBytes = System.Convert.FromBase64String(base64EncodedData);
            return System.Text.Encoding.UTF8.GetString(base64EncodedBytes);
        }
        static void Main(string[] args)
        {
            string outtext = "";
            if (args.Length == 0)
            {
                System.Console.WriteLine("b64 usage:");
                System.Console.WriteLine("-e plaintext to encode");
                System.Console.WriteLine("-d base64 to decode");
            }
            else
            {
                string intext = string.Join(" ", args, 1, count: args.Length - 1);
                if (args[0] == "-d")
                {
                    outtext = Base64Decode(intext);
                }
                if (args[0] == "-e")
                {
                    outtext = Base64Encode(intext);
                }
                System.Console.WriteLine("{0}", outtext);
            }
        }
    }
}