import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/web_view_news.dart';
Widget defaultFormText({
  required TextEditingController controller,
  required TextInputType type,
  required dynamic validator,
  Function? onSubmit,
  Function? onChanged,
  Function? onTap,
  bool isPassword = false,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function()? suffixClicked,
}) => TextFormField(
  controller: controller,
  keyboardType: type,
  validator: validator,
  onFieldSubmitted: (s) {
    onSubmit!(s);
  },
  onTap: () {
    onTap!();
  },
  obscureText: isPassword,
  onChanged: (value) {
    onChanged!(value);
  },
  decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(prefix),
      suffixIcon: suffix != null
          ? IconButton(
        onPressed: () {
          suffixClicked!();
        },
        icon: Icon(suffix),
      )
          : null,
      border: OutlineInputBorder()),
);
Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);
Widget buildArticle(article,context)=>InkWell(
  onTap: ()
  {
    navigateTo(context, WebViewScreen(article['url']));
  },
  child:   Padding(
  
    padding: const EdgeInsets.all(20.0),
  
    child: Row(
  
      children: [
  
        Container(
  
          height: 120,
  
          width: 120,
  
          decoration: BoxDecoration(
  
              borderRadius: BorderRadius.circular(10),
  
              image: DecorationImage(
  
                image: NetworkImage(
  
                    '${article['urlToImage']}'),
  
                fit: BoxFit.cover,
  
              )),
  
        ),
  
        SizedBox(
  
          width: 20,
  
        ),
  
        Expanded(
  
          child: Container(
  
            height: 120,
  
            child: Column(
  
  
  
              crossAxisAlignment: CrossAxisAlignment.start,
  
              mainAxisAlignment: MainAxisAlignment.start,
  
              children: [
  
                Expanded(
  
                  child: Text(
  
                    '${article['title']}',
  
                    style: Theme.of(context).textTheme.bodyText1,
  
                    maxLines: 3,
  
                    overflow: TextOverflow.ellipsis,
  
                  ),
  
                ),
  
                Text(
  
                  '${article['publishedAt']}',
  
                  style: TextStyle(
  
  // fontWeight: FontWeight.w900,
  
  // fontSize: 18,
  
                    color: Colors.grey,
  
                  ),
  
                ),
  
              ],
  
            ),
  
          ),
  
        )
  
      ],
  
    ),
  
  ),
);

Widget buildNewsScreen(list,{isSearch=false})=>ConditionalBuilder(
condition: list.length>0,
builder: (context)=> ListView.separated(itemBuilder: ((context, index) => buildArticle(list[index],context)), separatorBuilder: (context, index) =>myDivider() , itemCount: list.length),
fallback: (context)=> isSearch ? Container(): Center(child: CircularProgressIndicator())
);

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);