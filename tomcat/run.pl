#!/usr/bin/env perl
$home=`echo \$CATALINA_HOME`;
chomp $home;
if(!$home){
    print "请输入tomcat所在的目录的地址(即CATALINA_HOME的值),例如/usr/share/tomcat\n";
    print "可以通过执行tomcat家目录bin文件夹内的version.sh获得\n";
    print "CATALINA_HOME的值是:";
    $home = <STDIN>;    
    chomp $home;
}
print "CATALINA_HOME的值是:$home 确认请回车,退出请Ctrl-c:";
<STDIN>;

my @array_pre_flag = ();

$ARGC = @ARGV;
if($ARGC gt 0){
    print qq{usage: perl aj.pl};
    exit;}

# 请将bash命令放于 " 符号间.
# 请注意双引号" 和 $ 符号的转义.
$pre_cmd{'id'} = "echo result";
$pre_cmd{1} = "cat $home/conf/tomcat-users.xml | grep -v -e '^ *#' -e '^\$'";
$pre_cmd{2} = "cat $home/conf/tomcat-users.xml | grep -v -e '^ *#' -e '^\$'";
$pre_cmd{3} = "cat $home/conf/tomcat-users.xml | grep -v -e '^ *#' -e '^\$'";
$pre_cmd{4} = "cat $home/conf/tomcat-users.xml | grep -v -e '^ *#' -e '^\$'";
$pre_cmd{5.1} = "cat $home/conf/server.xml | grep -v -e '^ *#' -e '^\$'";
$pre_cmd{5.2} = "ls $home/logs | grep -v -e '^ *#' -e '^\$'";
$pre_cmd{5.3} = "cat $home/logs/localhost_access_log.2017-08-30.txt | grep -v -e '^ *#' -e '^\$'";
$pre_cmd{6} = "需手动核查,访问浏览器";
$pre_cmd{7} = "需手动核查,访问浏览器";
$pre_cmd{8} = "cat $home/conf/web.xml | grep -v -e '^ *#' -e '^\$'";
$pre_cmd{9} = "需手动核查,访问浏览器";
$pre_cmd{10} = "cat $home/conf/server.xml | grep -v -e '^ *#' -e '^\$'";




push(@array_pre_flag, 'id');
push(@array_pre_flag, 1);
push(@array_pre_flag, 2);
push(@array_pre_flag, 3);
push(@array_pre_flag, 4);
push(@array_pre_flag, 5.1);
push(@array_pre_flag, 5.2);
push(@array_pre_flag, 5.3);
push(@array_pre_flag, 6);
push(@array_pre_flag, 7);
push(@array_pre_flag, 8);
push(@array_pre_flag, 9);
push(@array_pre_flag, 10);

#end

sub add_item{
    my ($string, $flag, $value)= @_;
    $result = `$value`;
    chomp $result;
    $string .= "\t".'<item flag="'.$flag.'">'."\n";
    if ( $result eq "result" ){
        $value = "command";
    }
    $string .= "\t\t<command><![CDATA[".$value."]]></command>\n";
    $string .= "\t\t<value><![CDATA[".$result."]]></value>\n";
    $string .= "\t</item>\n";
    return $string;
}
sub generate_xml{
    my $xml_string = "";
    $xml_string .='<?xml version="1.0" encoding="UTF-8"?>'."\n";
    $xml_string .= '<result>'."\n";
    foreach $key (@array_pre_flag){
        $value = $pre_cmd{$key};
        $xml_string = &add_item( $xml_string, $key, $value );
    }
    $xml_string .= "</result>"."\n";
    $xmlfile = "result.xml";
    print "generate ".$xmlfile."\n";
    open XML,">./".$xmlfile or die "Cannot create xml file:$!";
    print XML $xml_string;
    print "Done\n";}
generate_xml();
