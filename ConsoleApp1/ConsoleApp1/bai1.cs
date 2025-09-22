using System;

namespace ConsoleApp1
{
    class bai1
    {
        static void Main(string[] args)
        {
            Double tongdiem = 0;
            for(int i = 0;i < 1; i++)
            {
                Console.WriteLine("Nhap diem toan : ");
                Double toan = Convert.ToDouble(Console.ReadLine());
                Console.WriteLine("Nhap diem ly : ");
                Double ly = Convert.ToDouble(Console.ReadLine());
                Console.WriteLine("Nhap diem hoa : ");
                Double hoa = Convert.ToDouble(Console.ReadLine());
                tongdiem = (toan + ly + hoa) / 3;
                Console.WriteLine("Diem trung binh la : " + tongdiem);

            }
            if (tongdiem >= 8)
            {
                Console.WriteLine("hoc sinh gioi");
            }else if (tongdiem >= 6.5)
            {
                Console.WriteLine("hoc sinh kha");
            }else if (tongdiem >= 5){ 
                Console.WriteLine("hoc sinh trung binh");
            }else
            {
                Console.WriteLine("hoc sinh yeu");
            }
        }
    }
}