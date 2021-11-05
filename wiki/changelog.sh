#!/usr/bin/env bash
sitemap_dir=/home/wwwroot/wangheng.org/html
sitemap=sitemap.html

#==============START=================

cd $sitemap_dir
rm $sitemap

links=$(ls -r *.html|sed 's/\t/\n/g')

function get_links()
{
	file=$1
	title=$(cat $file |grep '<title>'|sed -n 's/.*<title>\(.*\)<\/title>.*/\1/p')
	echo -ne "\n"
	echo -ne "<li>\n"
	echo -ne "<a href='$file'>$title</a>\n\n"
}

links_html=""
for link in $links;	
		do 
			links_html="$links_html$(get_links $link)";
done

#`cat sitemap.tpl|sed 's/LINKS_TPL/'$links_html'/g'>$sitemap`
cat > $sitemap <<EOF
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<title>站点地图</title>
	<link rel="stylesheet" type="text/css" href="theme/bright/style.css" />
	<link rel="stylesheet" type="text/css" href="css/highlight.css" />
	<link rel="stylesheet" type="text/css" href="css/highlight_monokai.css" />
	<script src="js/highlight.pack.js"></script>
</head>

<body>
<header id="header">
	<top_group>
		<div id="logo" style="font-size: 22pt"><a href="http://wangheng.org/wiki/">王恒的笔记</a></div>
	</top_group>
</header>
<div id="wrap">
	<div id="content">	
	

<h1 id="toc_1">Links</h1>

$links_html

</ul>

	</div>
</div>

<!--this is my footer-->
<div id="footer">
	<img alt="知识共享许可协议" height="31" width="80" style="border-width:0" src="img/cc_80x31.png" /> 本作品采用知识共享署名-非商业性使用-禁止演绎 3.0 Unported <a name="license" rel="license" href="http://creativecommons.org/licenses/by-nc-nd/3.0/">许可协议</a>进行许可。
</div>

<!--Baidu Analysis-->
<script type="text/javascript">
var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F6bad7b5881000f711c6b1e1e6d286a52' type='text/javascript'%3E%3C/script%3E"));

<!-- Code Highlight -->
hljs.initHighlightingOnLoad();

</script>
</body>
</html>

EOF