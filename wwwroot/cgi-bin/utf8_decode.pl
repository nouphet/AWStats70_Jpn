#!/usr/bin/perl

#
# 日本語版AWStats用検索キーワードデコード + Alphaスクリプト
#
# Modified by makoto_hobbit 2006.4.5
# Modified by Ryu 2011.2.10 to reflect the URL change of Google cache.

use Jcode;

$GoogleCacheClientIP = "0.0.0.0";	# google cache接続元IPダミー初期値.
$GoogleCacheClientLastIP = "1.1.1.1";	# google cache接続元IPダミー初期値.
$YahooCurrentCacheID = "abcdefghij";	# yahooのcache判定変数ダミー初期値.
$YahooLastCacheID = "klmnopqrst";	# yahooのcache判定変数ダミー初期値.
$MySearchCurrentCacheID = "abcdefghij";	# yahooのcache判定変数ダミー初期値.
$MySearchLastCacheID = "klmnopqrst";	# yahooのcache判定変数ダミー初期値.
$Myhost = "starplatinum\.jp";		# 自ホストのchcheかの判定用.

while(<STDIN>){
	if (/\\x90\\x02\\xb1\\x02\\xb1\\x02\\xb1\\x02\\xb1/ | /NULL\.IDA\?CCCCCCCCCCCCCCCC/) {
		next;
	}
	# googleのキャッシュからのアクセスを、本来に形に戻す.
	if ((/http.*search\?.*?q\=cache/) || (/216\.239\.(39\.104|41\.104|57\.104|59\.104|63\.104)/) || (/64\.233\.(161\.104|179\.104|167\.104|187\.104)/) || (/66\.102\.(7\.104|9\.104|11\.104)/)){
		# 一連のcacheかどうかを接続元IPで判断する.
		/[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/; # SourceIP 
		$GoogleCacheClientIP = $&;
		if ($GoogleCacheClientIP ne $GoogleCacheClientLastIP) {	# 初出
			$GoogleCacheClientLastIP = $GoogleCacheClientIP;
			# 普通のGoogleからのアクセスに認識されるよう変換
			s/webcache.*?\+/www\.google\.co\.jp\/search\?q\=/;
			& DecodeEncodedStringIMGOOUTF8;
			&PrintLine;
		} elsif ($GoogleCacheClientIP eq $GoogleCacheClientLastIP) {	# 既出
			# 普通のGoogleからのアクセスに認識されるよう変換
			s/(http.*?google.*?cache\:.*?\:)(.*?)(\+.*?\")(.*)/http\:\/\/$2"$4/;
			& PackPercent;
			chomp;
			&PrintLine;
			# Imageファイルが本体よりも先にGETされる場合があります
		}
	} elsif ((/216\.109\.125\.130\/search\/cache/)||(/66\.218\.69\.11\/search\/cache/)){
		if (/$Myhost/) {
			# 一連のcacheかどうかをまず判断する.
			/(\&d\=)(\w{10})/;	# CacheIDの検出
			$YahooCurrentCacheID = $2;
			if ($YahooCurrentCacheID ne $YahooLastCacheID) {	# 初出
				$YahooLastCacheID = $2;
				# HTMLファイルのGETを強引に生成, 検索語を検出可能にする
				s/(.*?\"GET )(.*)( HTTP.*?\?u\=)([^\/]*)(.*)(\&w\=.*)/$1$5$3$4$5$6/;
				& DecodeEncodedStringYAHOOFSUTF8;
				& DecodeEncodedStringYAHOO;
				& PrintLine;
			}
		}
	} elsif (/http.*cache\.yahoofs/){
		if (/$Myhost/) {
			# 一連のcacheかどうかをまず判断する.
			/(\&d\=)(\w{10})/;	# CacheIDの検出
			$YahooCurrentCacheID = $2;
			if ($YahooCurrentCacheID ne $YahooLastCacheID) {	# 初出
				$YahooLastCacheID = $2;
				# HTMLファイルのGETを強引に生成, 検索語を検出可能にする
				s/(.*?\"GET )(.*)( HTTP.*?\?u\=)([^\/]*)(.*)(\&w\=.*)/$1$5$3$4$5$6/;
				& DecodeEncodedStringYAHOOFSUTF8;
				& DecodeEncodedStringYAHOO;
				& PrintLine;
			}
		}
	} elsif (/http.*kd\.mysearch\.myway\.com\/jsp\/GGcres\.jsp/){
		# 一連のcacheかどうかをまず判断する.
		/(id\=)(\w{12})/;	# CacheIDの検出
		$MySearchCurrentCacheID = $2;
		if ($MySearchCurrentCacheID ne $MySearchLastCacheID) {	# 初出
			$MySearchLastCacheID = $2;
			# HTMLファイルのGETを強引に生成, 検索語を検出可能にする
#			s/(.*?\"GET )(.*)( HTTP.*?\?u\=)([^\/]*)(.*)(\&searchfor\=.*)/$1$5$3$4$5$6/;
			& DecodeEncodedStringYAHOOFSUTF8;
			& DecodeEncodedStringYAHOO;
			& PrintLine;
		}

	} elsif (/http.*kr\.search\.yahoo\./){
		& DecodeEncodedStringYAHOOkr;
		& PrintLine;
	} elsif (/http.*hk\.search\.yahoo\./){
		& DecodeEncodedStringYAHOOhk;
		& PrintLine;
	} elsif (/http.*search\.yahoo\.co\.jp/){
		& DecodeEncodedStringYAHOOjp;
		& PrintLine;
	} elsif (/http.*search\.yahoo\./ || /216\.109\.125\.130/){
		& DecodeEncodedStringYAHOOUTF8;
		& PrintLine;
	} elsif (/http.*bsearch\.goo\.ne/){
		& DecodeEncodedStringUTF8;
		& DecodeEncodedStringGOO;
		& DecodeEncodedStringGOOMT;
		& DecodeEncodedStringGOOMT;
		& PrintLine;
	} elsif (/http.*images\.google\./){
		& DecodeEncodedStringUTF8;
		& DecodeEncodedStringIMGOOUTF8;
		& PrintLine;
	} elsif ((/http.*www\.google\./)){
		& DecodeEncodedStringUTF8google;
		& PrintLine;
	} elsif (/http.*search\.msn\.com/){
		& DecodeEncodedStringMSNcomUTF8;
		& DecodeEncodedStringMSN;
		& PrintLine;
	} elsif (/http.*search\.msn\./){
		& DecodeEncodedStringMSNUTF8;
		& DecodeEncodedStringMSN;
		& PrintLine;
	} elsif (/http.*excite\.co\.jp/){
		& DecodeEncodedStringExcite;
		& PrintLine;
	} else {
		& DecodeEncodedString;
		& PrintLine;
	}
}

sub PrintLine {
	s/　/ /g;
	print;
	print "\n";
}

sub PackPercent {	# %22 を " に変換するとシンタクスエラーになるので
	s/%([013456789A-Fa-f][0-9A-Fa-f])/pack("H2", $1)/eg;
	s/%(2[013456789A-Fa-f])/pack("H2", $1)/eg;
}

sub DecodeEncodedStringExcite {
	chomp;
	& PackPercent;
	if (/charset\=euc-jp/i) {
		Jcode::convert(\$_,'utf8','euc');
	} else {
		Jcode::convert(\$_,'utf8','sjis');
	}
	return;
}

sub DecodeEncodedString {
	chomp;
	s/\\x/%/g;	#googleで"lr=lang_ja"時のデコード対応
	& PackPercent;
	Jcode::convert(\$_,'utf8');
	s/([\x80-\xff][\x80-\xff]|[\x00-\x7f])/($1 eq "\xa1\xa1") ? " " : $1/eg;
	return;
}

sub DecodeEncodedStringUTF8 {
	chomp;
	& PackPercent;
	Jcode::convert(\$_,'utf8');
#	s/([\x80-\xff][\x80-\xff]|[\x00-\x7f])/($1 eq "\xa1\xa1") ? " " : $1/eg;
	return;
}


sub DecodeEncodedStringIMGOOUTF8 {
	chomp;
	& PackPercent;
	if (/ie\=Shift_JIS/i) {
		Jcode::convert(\$_,'utf8','sjis');
	} elsif  (/ie\=EUC-JP/i) {
		Jcode::convert(\$_,'utf8','euc');
	}
#	s/([\x80-\xff][\x80-\xff]|[\x00-\x7f])/($1 eq "\xa1\xa1") ? " " : $1/eg;
	return;
}

sub DecodeEncodedStringYAHOOUTF8 {
	chomp;
	& PackPercent;
	if (/ei\=UTF-8/) {
		;
	} else {
		Jcode::convert(\$_,'utf8');
	}
#	s/([\x80-\xff][\x80-\xff]|[\x00-\x7f])/($1 eq "\xa1\xa1") ? " " : $1/eg;
	return;
}

sub DecodeEncodedStringYAHOOhk {
	chomp;
	& PackPercent;
	if (/ei\=BIG5/) {
		use Encode;
		Encode::from_to($_, "big5", "utf8");
	}
	return;
}

sub DecodeEncodedStringYAHOOkr {
	chomp;
	& PackPercent;
	Encode::from_to($_, "euc-kr", "utf8");
	return;
}

sub DecodeEncodedStringYAHOOjp {
	s/\\x/%/g;
	chomp;
	& PackPercent;
	if (/ei\=UTF-8/) {
		;
	} else {
		Jcode::convert(\$_, "utf8");
	}
	return;
}

sub DecodeEncodedStringYAHOOFSUTF8 {
	chomp;
	& PackPercent;
#	Jcode::convert(\$_,'utf8');
#	s/([\x80-\xff][\x80-\xff]|[\x00-\x7f])/($1 eq "\xa1\xa1") ? " " : $1/eg;
	return;
}

sub DecodeEncodedStringUTF8google {
	chomp;
	if ($_ =~ /\\x8/) {
		s/\\x/%/g;
		if ($_ =~ /[\&\?_]q\=([^\&^"]+)/) {
			$a = $1;
			$b = $a;
			$a =~ s/%([013456789A-Fa-f][0-9A-Fa-f])/pack("H2", $1)/eg;
			$a =~ s/%(2[013456789A-Fa-f])/pack("H2", $1)/eg;
			$c = Jcode::convert($a,'utf8','sjis');
			$b =~ s/([\+\*\.\?\^\$\[\-\]\|\(\)\\])/\\$1/g;
			$_ =~ s/$b/$c/;
		}
	} elsif ($_ =~ /[\&\?_]q\=([^\&^"]+)/) {
		$a = $1;
		$b = $a;
		$a =~ s/%([013456789A-Fa-f][0-9A-Fa-f])/pack("H2", $1)/eg;
		$a =~ s/%(2[013456789A-Fa-f])/pack("H2", $1)/eg;
		if (/ie\=EUC-JP/i) {
			$c = Jcode::convert($a,'utf8','euc');
		} elsif (/ie\=windows-1251/i) {
			$c = $a;
			Encode::from_to($c,"windows-1251",'utf8');
		} elsif (/ie\=ISO-8859-2/i) {
			$c = $a;
			Encode::from_to($c,"ISO-8859-2",'utf8');
		} elsif (/ie\=ISO-8859-1/i) {
			$c = $a;
			Encode::from_to($c,"ISO-8859-1",'utf8');
		} elsif (/ie\=UTF-8/i) {
			$c = $a;
		} elsif ((/ie\=Shift_JIS/)|| (/ie\=ShiftJIS/) || (/ie\=sjis/i) || (/sourceid\=navclient\-menuext/)) {
			$c = Jcode::convert($a,'utf8','sjis');
		} elsif (/hl\=ja/) {
			$code = Jcode::getcode( $a );
			if ($code eq "") {
				$c = $a;
			} else {
				$c = Jcode::convert($a,'utf8');
			}
		} else {
			$c = $a;
		}
		$b =~ s/([\+\*\.\?\^\$\[\-\]\|\(\)\\])/\\$1/g;
		$_ =~ s/$b/$c/;
	}
	if ($_ =~ /pq\=([^\&^"]+)/) {
		$a = $1;
		$b = $a;
		$a =~ s/%([013456789A-Fa-f][0-9A-Fa-f])/pack("H2", $1)/eg;
		$a =~ s/%(2[013456789A-Fa-f])/pack("H2", $1)/eg;
		if (/ie\=EUC-JP/i) {
			$c = Jcode::convert($a,'utf8','euc');
		} elsif (/ie\=windows-1251/i) {
			$c = $a;
			Encode::from_to($c,"windows-1251",'utf8');
		} elsif (/ie\=ISO-8859-2/i) {
			$c = $a;
			Encode::from_to($c,"ISO-8859-2",'utf8');
		} elsif (/ie\=ISO-8859-1/i) {
			$c = $a;
			Encode::from_to($c,"ISO-8859-1",'utf8');
		} elsif (/ie\=UTF-8/i) {
			$c = $a;
		} elsif ((/ie\=Shift_JIS/)|| (/ie\=ShiftJIS/) || (/ie\=sjis/i) || (/sourceid\=navclient\-menuext/)) {
			$c = Jcode::convert($a,'utf8','sjis');
		} elsif (/hl\=ja/) {
			$code = Jcode::getcode( $a );
			if ($code eq "") {
				$c = $a;
			} else {
				$c = Jcode::convert($a,'utf8');
			}
		} else {
			$c = $a;
		}
		$b =~ s/([\+\*\.\?\^\$\[\-\]\|\(\)\\])/\\$1/g;
		$_ =~ s/$b/$c/;
	}
	if ($_ =~ /G\=([^\&]+)/) {
		$a = $1;
		$b = $a;
		$a =~ s/%([013456789A-Fa-f][0-9A-Fa-f])/pack("H2", $1)/eg;
		$a =~ s/%(2[013456789A-Fa-f])/pack("H2", $1)/eg;
		if ((/ie\=Shift_JIS/)|| (/ie\=ShiftJIS/) || (/ie\=sjis/i)) {
			$c = Jcode::convert($a,'utf8','sjis');
		} elsif  (/ie\=EUC-JP/i) {
			$c = Jcode::convert($a,'utf8','euc');
		} elsif  (/ie\=windows-1251/i) {
			$c = $a;
			Encode::from_to($c,"windows-1251",'utf8');
		} elsif  (/ie\=ISO-8859-1/i) {
			$c = $a;
			Encode::from_to($c,"ISO-8859-1",'utf8');
		} elsif  (/ie\=ISO-8859-2/i) {
			$c = $a;
			Encode::from_to($c,"ISO-8859-2",'utf8');
		} elsif (/hl\=ja/) {
			$code = Jcode::getcode( $a );
			if ($code eq "") {
				$c = $a;
			} else {
				$c = Jcode::convert($a,'utf8');
			}
		} else {
			$c = $a;
		}
		$b =~ s/([\+\*\.\?\^\$\[\-\]\|\(\)\\])/\\$1/g;
		$_ =~ s/$b/$c/;
	}
	return;
}

sub DecodeEncodedStringYAHOO {
	chomp;
	if ($_ =~ /p\=([^\&]+)/) {
		$a = $1;
		$b = $a;
		$a =~ s/%([013456789A-Fa-f][0-9A-Fa-f])/pack("H2", $1)/eg;
		$a =~ s/%(2[013456789A-Fa-f])/pack("H2", $1)/eg;
		if (/ei\=UTF-8/) {
			$c = $a;
		} else {
			$c = Jcode::convert($a,'utf8','euc');
		}
		$b =~ s/([\+\*\.\?\^\$\[\-\]\|\(\)\\])/\\$1/g;
		$_ =~ s/$b/$c/;
	}
	return;
}

sub DecodeEncodedStringGOO {
	chomp;
	if ($_ =~ /\&MT\=([^\&]+)/) {
		$a = $1;
		$b = $a;
		if ($b =~ /%/) {
			$a =~ s/%([013456789A-Fa-f][0-9A-Fa-f])/pack("H2", $1)/eg;
			$a =~ s/%(2[013456789A-Fa-f])/pack("H2", $1)/eg;
			$c = Jcode::convert($a,'utf8','euc');
			$b =~ s/([\+\*\.\?\^\$\[\-\]\|\(\)\\])/\\$1/g;
			$_ =~ s/$b/$c/;
		}
	}
	return;
}

sub DecodeEncodedStringGOOUEMT {
	chomp;
	if ($_ =~ /UEMT\=(%[^\&]+)/) {
		$a = $1;
		$b = $a;
		if ($b =~ /%/) {
			$a =~ s/%([013456789A-Fa-f][0-9A-Fa-f])/pack("H2", $1)/eg;
			$a =~ s/%(2[013456789A-Fa-f])/pack("H2", $1)/eg;
			$c = Jcode::convert($a,'utf8','euc');
			$c =~ s/%([013456789A-Fa-f][0-9A-Fa-f])/pack("H2", $1)/eg;
			$c =~ s/%(2[013456789A-Fa-f])/pack("H2", $1)/eg;
			$c = Jcode::convert($c,'utf8','euc');
			$b =~ s/([\+\*\.\?\^\$\[\-\]\|\(\)\\])/\\$1/g;
			$_ =~ s/$b/$c/;
		}
	}
	return;
}

sub DecodeEncodedStringGOOMT {
	chomp;
	if ($_ =~ /MT\=(%[^\&]+)/) {
		$a = $1;
		$b = $a;
		if ($b =~ /%/) {
			$a =~ s/%([013456789A-Fa-f][0-9A-Fa-f])/pack("H2", $1)/eg;
			$a =~ s/%(2[013456789A-Fa-f])/pack("H2", $1)/eg;
			$c = Jcode::convert($a,'utf8','euc');
			$b =~ s/([\+\*\.\?\^\$\[\-\]\|\(\)\\])/\\$1/g;
			$_ =~ s/$b/$c/;
		}
	}
	return;
}

sub DecodeEncodedStringMSNcomUTF8 {
	chomp;
	& PackPercent;
	Jcode::convert(\$_,'utf8','sjis');
#	s/([\x80-\xff][\x80-\xff]|[\x00-\x7f])/($1 eq "\xa1\xa1") ? " " : $1/eg;
	return;
}

sub DecodeEncodedStringMSNUTF8 {
	chomp;
	& PackPercent;
	if (/cp\=932/) {
		Jcode::convert(\$_,'utf8','sjis');
	}
#	s/([\x80-\xff][\x80-\xff]|[\x00-\x7f])/($1 eq "\xa1\xa1") ? " " : $1/eg;
	return;
}

sub DecodeEncodedStringMSN {
	chomp;
	if ($_ =~ /aq\=([^\&]+)/) {
		$a = $1;
		$b = $a;
		if ($b =~ /%/) {
			$a =~ s/%([0-9A-F][0-9A-F])/pack("H2", $1)/eg;
			$b =~ s/([\+\*\.\?\^\$\[\-\]\|\(\)\\])/\\$1/g;
			$_ =~ s/$b/$a/;
		}
	}
	return;
}

