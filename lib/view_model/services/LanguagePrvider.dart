import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/main.dart';
import 'package:mvvm/view_model/services/GlobalVal.dart';


class Language extends ChangeNotifier {
  String langg = language;
  String Color = "";

  setColor(String Color) async {
    this.Color = Color;

    notifyListeners();
  }
  getLanguage() {
    return langg;
  }

  setLanguage(String langl) async {
    langg = langl;
    // final SharedPreferences sp = await SharedPreferences.getInstance();
    // sp.setString('Lan', langl);
      await DatabaseHelper.updateLang(langl);

    notifyListeners();
  }

  TextDirection getDirection() {
    String languageCode = getLanguage(); //Platform.localeName.split('_')[0];

    if (languageCode == "AR") return TextDirection.rtl;
    return TextDirection.ltr;
  }

  Alignment Align() {
    String languageCode = getLanguage(); //Platform.localeName.split('_')[0];

    if (languageCode == "AR") return Alignment.topRight;
    return Alignment.topLeft;
  }

  String Llanguage(String l) {
    String txt = '';
    getLanguage() == 'AR' ? txt = ar[l].toString() : txt = en[l].toString();
    return txt;
  }
  //"Top Doctors :",

  static Map<String, Object?> ar = {
    "NoData":"لا يوجد بيانات",
    "salary": "الراتب",
    "TimeLine":"الجدول الزمني ",
    "Birthdays":"اعياد الميلاد",
    "OfficialTasks":"مهام الرسمية",
    "PlzSelectDate":"الرجاء اختيار التاريخ",
    "Back":"عودة",
    "WorkingStatus":"حالة الدوام",
    "Subdepartment": "القسم الفرعي",
    "confirm":"تأكيد",
    "Confirmfingerprintexit":"هل انت متأكد من بصمة نهاية الدوام ؟",
    "Confirmfingerprintentry":"هل انت متأكد من بصمة بداية الدوام ؟",
    "uploadimage":"اختر الصورة",
    "wrongpassword":"كلمة المرور المدخلة غير صحيحة",
    "knowpassword":"يمكنك مراجعة المسؤل في حال عدم معرفة كلمة المرور",
    "gotoip":"الذهاب",
    "SaveIP":"حفظ الايبي",
    "IpAddress":"الايبي الخاص بالسيرفر",
    "PleaseEnterIP":" الرجاء ادخال الايبي الخاص بالسيرفر", 
    "todayattendance":"حضور اليوم",
    "loginerror":"كلمة المرور او اسم المستخدم غير صحيح",
    "ontime":"في الوقت",
    "txxt":"هل أنت متأكد أنك تريد تسجيل الخروج ؟",
    "Days":"يوم",
    "finger":"تسجيل الدخول باستخدام البصمه",
    "cancel":"إلغاء",
    "RememberMe":"تذكرني",
    "Baselalzaben":"باسل الزبن",
    "Feedback":"حول الطبيق",
    "Sendfeedback":"إرسال رأيك",
    "callus":"اتصل بنا",
    "general":"عام",
    "nextaction":"الحدث التالي ",
    "inpass":"دخول",
    "outpass":"خروج",
    "Image":"المرفقات",
    "supposed":"وقت خروج المفترض ",
    "previous":"وقت خروج السابق",
    "empreq":"طلبات الموظف",
    "emp":"الموظف",
    "vac":"أجازة ",
    "leave":"مغادرة",
    "Hours":"ساعة",
    "leavet":"نوع المغادرة",
    "Task":"المهام :",
    "Request":"طلباتي ",
    "Requests1":"طلبات ",
    "language": "تغيير اللغه",
    "loading": "يجب الانتظار لحين جلب الوقت...",
    "previoustime": "وقت الانصراف السابق",
    "aboutcompany": "وقت الانصراف السابق",
    "notask": "لا يتوفر لديك مهام الان",
    "MyRequest": "طلباتي",
    "checkin": "تسجيل الدخول",
    "checkout": "تسجيل الخروج",
    "late": "متاخر",
    "Absence": "الغياب بدون عذر",
    "fullwork": "دوام كامل",
    "timeline": "الخط الزمني",
    "WorkInfoScreen": "الحضور و الانصراف",
    "sickleave": "مرضيه",
    "sick": "مرضيه",
    "company": "المؤسسة",
    "Attendancetoday": "وقت الحضور اليوم",
    "settings": "الاعدادات",
    "Home": "الرئيسية",
    "empcalender": "روزنامة الموظف",
    "aboutcompany":
    "مجموعة غالاكسي الدولية (GI - Group) هي شركة لتكنولوجيا المعلومات تأسست عام 1992 بفروع مختلفة",
    "annual": "سنوية",
    "vacations": "رصيدي",
    "basel": "باسل خلف الزبن",
    "wanttologout": "هل تريد تسجيل الخروج ؟",
    "finget": "استخدام البصمة",
    "username": "اسم المستخدم",
    "password": "رمز المرور",
    "login": "تسجيل الدخول",
    "profile": "الملف الشخصي",
    "sender": "المرسل",
    "app": "صاحب الطلب",
    "defaultend": "'وقت نهايه الدوام المفترض'",
    "departures": " : المغادرات",
   // "vacations": " ",
    "acceptable": "مقبولة",
    "Additional": "الاضافات",
    "rejected": "مرفوضة",
    "pending": "قيد الانتظار",

    "new": "جديد",
    "delete": "حذف",
    "workinmonth": "حاله الدوام",
    "light": "فاتح",
    "dark": "الوضع الليلي",
    "timeimprint": "بصمة الدوام",
    "workingstate": "الدوام",
    "Logout": "تسجيل الخروج",
    "log": " جار تسجيل الدخول يرجى الانتظار",
    "logerror": " رقم المستخدم او رمز المرور خطأ",
    "distancesafe": "المسافة المسموح بها",
    "distancedang": "  المسافة الى الشركة   ",
    "leaverequest": "طلب مغادرة",
    "vacationrequest": "طلب اجازة",
    "Name": "الاسـم : ",
    "Leaving": "مغادره",
    "Departuretype": "نوع المغادرة",
    "Departuredate": "وقت المغادرة",
    "Departurestarttime": " بداية المغادرة",
    "Departureendtime": " نهاية المغادرة",
    "Send": "أرسال",
    "notes": "الملاحظات",
    "notesM": "الملاحظات المشرف",
    "Departuretime": "مدة",

    "vactioncount": "عدد ايام الاجازة",
    "vactiontype": "نوع الاجازة",
    "datestartvaction": " بداية الاجازة",
    "dateendvaction": " نهاية الاجازة",
    "EndWork": " نهاية الدوام :",
    "StartWork": " بداية الدوام :",
    "hoursdifference": " فرق الساعات :",
    "delay1": " تأخير :",
    "earlyexit": " الخروج مبكر :",
    "workinghours": " ساعات العمل :",
    "emmployees": "الموظف البديل",
    "phoneanddetails": "العنوان ورقم الهاتف ",
    "selectimage": "اختيار صورة",
    "Administration": "الادارة",
    "Directresponsible": "المسؤول المباشر",
    "Qualification": "المؤهل العلمي",
    "employeestatus": "حالة الموظف",
    "reqstatus": "حالة الطلب",
    "reqstatus2": "حالة ",
    "YearsofExperience": "عدد سنوات الخبرة",
    "department": "القسم",
    "myreqD": "تفاصيل طلباتي",
    "reqDate": "تاريخ ",
    "history": "سجل الطلب",
    "Requestcertificate": "طلب شهادة",
    "notifications": "الاشعارات",
    "basicsalary": "الراتب الاساسي",
    "otherrequests": "طلبات اخرى",
    "to": "موجهة الى",
    "certificationtype": "نوع الشهادة",
    "thereasons": "الاسباب",
    "Certificatestatement": "بيان الشهادة",
    "documents": "الوثائق",
    "Salaryslip": " قسيمة الراتب",
    "detailedSalaryslip": " تضم المعلومات التفصيلية الخاصة بالراتب",
    "Order": "طلب",
    "requesttype": "نوع الطلب ",
    "requesttype2": "نوع ",
    "request": "الطلب",
    "request": "طلب اجازه",
    "IN": "دخول",
    "OUT": "خروج",
    "fingett": "البصمة",
    "selectcolor": "اختيار الالوان",
    "ChangeColor": "تغير الالوان",
    "metr": "متر",
    "Email": "إيميل",
    "nonotification": "لا يوجد اشعارات حاليا",
    "distancerange": "يجب ان تكون ضمن نطاق المسافه المسموح بها",
    "distancerangeit": "يجب ان تكون ضمن نطاق المسافه المسموح بها وهي",
    "myrequest": "طلباتي",
    "checkat": "تم تسجيل الدخول اليوم في الساعة 8",
    "netsalary": "صافي الراتب",
    "bonuses": "العلاوات",
    "onmonth": "خلال الشهر",
    "year": "السنة",
    "month": " الشهر",
    "absence": "الاجازات",
    "sendrequest": " طلب",
    "DeductPermenent": "الاقتطاعات",
    "Discount": "الخصومات",
    "task": "المهام",
    "Totalentitlements": "مجموع الاستحقاقات",
    "Totaldiscounts": "مجموع الخصومات",
    "All":"الجميع",
    "finished":"منتهية",
    "Notfinished":"غير منتهية",
    "fromdate": "من تاريخ",
    "delay": "تأخير صباحي",
    "todate": "الى تاريخ",
    "checkinout": "تسجيل الحضور / المغادرة",
    "Gangepasswor":"تغيير كلمه المرور",
    "oldpassword": "كلمة المرور القديمة",
    "Newpassword": "كلمة المرور الجديدة",
    "confirmpassword": "تأكيد كلمة المرور الجديدة",
    "changePass": "تغير كلمة المرور",
    "MSG":"كلمة المرور غير متطابقة",
  };

  static Map<String, Object?> en = {
    "NoData":"No Data",
    "salary": "Salary",
    "TimeLine":"Time Line",
    "Birthdays":"Birthdays",
    "OfficialTasks":"Official Tasks",
    "PlzSelectDate":"Please Select Date",
    "Back":"Back",
    "WorkingStatus":"Working Status",
    "Subdepartment": "Sub department",
    "confirm":"Confirm",
    "Confirmfingerprintexit":"Are you sure about the end-of-work fingerprint ?",
    "Confirmfingerprintentry":"Are you sure about the fingerprint at the start of work ?",
    "uploadimage":"Select Image",
    "wrongpassword":"The password you entered is incorrect",
    "knowpassword":"If you don't know your password, you can contact the responsible person",
    "gotoip":"Go",
    "SaveIP":"Save IP",
    "IpAddress":"Server IP",
    "ipwrong":"If you enter the wrong IP, you cannot edit it unless you contact the responsible person.",
    "ifNoIP":"If you don't know your IP, please contact one of the responsible",
    "PleaseEnterIP":"Please Enter Your IP for the server",
    "todayattendance":"Today Attendance",

    "txxt":"Are you sure you want to logout ?",
    "cancel":"Cancel",
    "ontime":"On Time",
    "loginerror":"The password or username is incorrect",
    "reqDate": " Date",
    "general":"General",
    "Gangepasswor":"Change Password",
    "bonuses":"Allowances",
    "changePass":"Change Password",
    "Feedback":"About the application",
    "Baselalzaben":"Basel alzaben",
      "RememberMe":"Remember Me",
      "MSG":"Password does not match",
    "finger":"Sign In With Your Biometric Id ",
    "Sendfeedback":"Send feedback",
    "callus":"call us",
    "year": "Year",
    "month": " Month",
    "SeeAll":"See All",
    "Totalentitlements":"Total entitlements",
    "nextaction":"Next Action",
    "inpass":"InPass",
    "Totaldiscounts":"Total discounts",
    "All":"All",
    "StartWork": " Start Work :",
    "hoursdifference": " Hours Difference :",
    "delay1": " Delay :",
    "earlyexit": " Early Exit :",
    "workinghours": " Working Hours :",
    "Image":"Attachments",
    "finished":"Finished",
    "Notfinished":"Not Finished",
    "Requests1":"Requests ",
    "netsalary":"Net salary",
    "outpass":"OutPass",
    "delay":"Delay Morning",
    "Days":"Days",
    "Hours":"Hours",
    "Discount":"Discount",
    "notifications":"Notifications",
    "supposed":"The Supposed End Time",
    "DeductPermenent":"Deduct Permenent",
    "previous":"Previous Exit Time",
    "Additional":"Additional",
    "empreq":"Employee Requests",
    "emp":"Employee",
    "notesM": "Manger Notes",

    "vac":"Vacation",
    "leave":"Leave ",
    "basicsalary":"basic salary ",
    "leavet":"Leave Type",
    "Task":"Task :",
    "Request":"My Request",
    "username": "Username ",
    "metr": "mtr",
    "IN": "IN",
    "OUT": "OUT",
    "checkin": "check in",
    "Absence": "Absence without excuse",
    "fullwork": "Full-time",
    "late": "Late",
    "departures": "departures :",
    "vacations": "My Balance",
    "checkout": "check out",
    "notask": "You don't have any assignments right now",
    "history": "History",
    "Leaving": "Leaving",
    "task": "Task",
    "sendrequest": "Submit",
    "absence": "absence",
    "onmonth": "in month",
    "selectcolor": "Select color",
    "ChangeColor": "Change Color",
    "acceptable": "acceptable",
    "rejected": "rejected",

    "new": "New",
    "sender": "Sender ",
    "app": "Applicant :",
    "pending": "pending",
    "workinmonth": "Working Status",
    "checkinout": "Attendance / departure registration",
    "nonotification": "There are currently no notifications",
    "checkat": "Checked in at 8:00 PM",
    "defaultend": "default end time",
    "password": "Password",
    "EndWork": " End Work :",
    "oldpassword": "Old Password",
    "Newpassword": "New Password",
    "confirmpassword": "Confirm Password",
    "distancerangeit": "It must be within the permitted distance range",
    "distancerange": "It must be within the allowed distance range",
    "loading": "You have to wait until the time comes...",
    "fingett": "finger print",
    "sickleave": "sick leave",
    "sick": "sick",
    "aboutcompany":
    "Galaxy International Group (GI - Group) is an Information Technology Company established in 1992 with different branches",
    "WorkInfoScreen": "Attend and leave",
    "MyRequest": "My Request",
    "previoustime": "previous dismissal time",
    "myrequest": "My Request",
    "company": "Enterprise",
    "timeline": "time line",
    "Attendancetoday": "Attendance time today",
    "annual": "annual",
    "Home": "Home",
    "wanttologout": "Are you sure you want to logout?؟",
    "empcalender": "Employee Calendar",
    "settings": "Settings",
    "login": "LogIn",
    "basel": "basel khalaf alzaben",
    "finget": "fingerprint use",
    "profile": "Profile",
    "fromdate": "From Date",
    "todate": "To Date",
    "timeimprint": "time imprint",
    "workingstate": "Attendance",
    "delete": "Delete",
    "Logout": "Logout",
    "light": "Light",
    "dark": "Dark",
    "language": "Change language",
    "log": "Signing in",
    "logerror": "Wrong user number or passcode",
    "distancesafe": "Allowed distance",
    "distancedang": "The distance to the company",
    "leaverequest": "leave request",
    "vacationrequest": "Vacation Request",
    "Name": "Name : ",
    "Departuretype": "Departure type",
    "Departuredate": "Departure Date",
    "Departurestarttime": " start time",
    "Departureendtime": " end time",
    "notes": "Comment",
    "Departuretime": "Departure",
    "Send": "Send",
    "vactiontype": "vacation Type",
    "datestartvaction": "Start Date",
    "Salaryslip": " Salary slip",
    "detailedSalaryslip": "Includes detailed salary information",
    "dateendvaction": "End Date",
    "vactioncount": "number of vacation days",
    "phoneanddetails": "Address and phone number ",
    "emmployees": "substitute employee",
    "selectimage": "Select Images",
    "Administration": "Administration",
    "Directresponsible": "Direct responsible",
    "Qualification": "Qualification",
    "employeestatus": "employee status",
    "reqstatus": "Request Status",
    "reqstatus2": " Status",
    "YearsofExperience": "Years of Experience",
    "department": "department",
    "myreqD": "My Requests Details",
    "Requestcertificate": "Request a certificate",
    "otherrequests": "other requests",
    "to": "to",
    "certificationtype": "certificationtype",
    "thereasons": "the reasons",
    "Email": "Email",

    "Certificatestatement": "Certificate statement",
    "Order": "Order",
    "requesttype": "Request Type",
    "requesttype2": " Type",
    "request": "request",
    "documents": "documents"
  };
}
