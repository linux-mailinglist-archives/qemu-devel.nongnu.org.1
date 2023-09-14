Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA017A0474
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 14:52:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgloU-0006td-Cw; Thu, 14 Sep 2023 08:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mironov@fintech.ru>)
 id 1qgj4t-0003kk-JV
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 05:56:03 -0400
Received: from exchange.fintech.ru ([195.54.195.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mironov@fintech.ru>)
 id 1qgj4r-0003qH-W3
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 05:56:03 -0400
Received: from Ex16-02.fintech.ru (10.0.10.19) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 14 Sep
 2023 12:44:16 +0300
Received: from Ex16-02.fintech.ru (10.0.10.19) by Ex16-02.fintech.ru
 (10.0.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 14 Sep
 2023 12:44:16 +0300
Received: from Ex16-02.fintech.ru ([fe80::18b6:cd4a:a259:613c]) by
 Ex16-02.fintech.ru ([fe80::18b6:cd4a:a259:613c%3]) with mapi id
 15.01.2242.004; Thu, 14 Sep 2023 12:44:16 +0300
From: =?koi8-r?B?7cnSz87P1yDzxdLHxcog98zBxMnNydLP18ne?= <mironov@fintech.ru>
To: "libvirt-security@redhat.com" <libvirt-security@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "libvir-list@redhat.com"
 <libvir-list@redhat.com>
CC: "sdl.qemu@linuxtesting.org" <sdl.qemu@linuxtesting.org>
Subject: [sdl-qemu] [PATCH 1/1] No checks, dereferencing possible
Thread-Topic: [sdl-qemu] [PATCH 1/1] No checks, dereferencing possible
Thread-Index: AQHZ5u5CEniT5U+quEGn3D2g2r/RJw==
Date: Thu, 14 Sep 2023 09:44:16 +0000
Message-ID: <59e6590ea8a04de788f69709ea4c54f8@fintech.ru>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.1.141]
Content-Type: multipart/alternative;
 boundary="_000_59e6590ea8a04de788f69709ea4c54f8fintechru_"
MIME-Version: 1.0
Received-SPF: pass client-ip=195.54.195.159; envelope-from=mironov@fintech.ru;
 helo=exchange.fintech.ru
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 14 Sep 2023 08:51:14 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

--_000_59e6590ea8a04de788f69709ea4c54f8fintechru_
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable

No checks, dereferencing possible.


Return value of a function 'virDomainChrSourceDefNew'
is dereferenced at qemu_command.c without checking
for NULL, but it is usually checked for this function.


Found by Linux Verification Center (linuxtesting.org) with SVACE.


Fixes: 1f85f0967b ("ci: jobs.sh: Add back '--no-suite syntax-check --print-=
errorlogs'")

Signed-off-by: Sergey Mironov <mironov@fintech.ru>

---
src/qemu/qemu_command.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/qemu/qemu_command.c b/src/qemu/qemu_command.c
index e84374b4cf..8d11972c88 100644
--- a/src/qemu/qemu_command.c
+++ b/src/qemu/qemu_command.c
@@ -4698,6 +4698,8 @@ qemuBuildVideoCommandLine(virCommand *cmd,
             g_autofree char *name =3D g_strdup_printf("%s-vhost-user", vid=
eo->info.alias);
             qemuDomainChrSourcePrivate *chrsrcpriv =3D QEMU_DOMAIN_CHR_SOU=
RCE_PRIVATE(chrsrc);

+           if (chrsrc =3D=3D NULL)
+                   return -1;
             chrsrc->type =3D VIR_DOMAIN_CHR_TYPE_UNIX;
             chrsrcpriv->directfd =3D qemuFDPassDirectNew(name, &videopriv-=
>vhost_user_fd);
--
2.31.1

--_000_59e6590ea8a04de788f69709ea4c54f8fintechru_
Content-Type: text/html; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dkoi8-r">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:rgb(0,0,0); font-family:Calibri,Helvetica,sans-serif,EmojiFont,&quot;Apple=
 Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI=
 Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols">
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:rgb(0,0,0); font-family:Calibri,Helvetica,sans-serif,EmojiFont,&quot;Apple=
 Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI=
 Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols">
<p></p>
<p><span style=3D"color:rgb(33,33,33); font-family:Calibri,Helvetica,sans-s=
erif; font-size:14.6667px"><span>No checks, dereferencing possible</span>.<=
/span><br>
</p>
<p><br>
</p>
<p><span style=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_normal,&quot=
;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFon=
t; font-size:13.3333px"><span style=3D"font-family:Calibri,Helvetica,sans-s=
erif; font-size:11pt"></span></span></p>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-family:Calibri,H=
elvetica,sans-serif,EmojiFont,&quot;Apple Color Emoji&quot;,&quot;Segoe UI =
Emoji&quot;,NotoColorEmoji,&quot;Segoe UI Symbol&quot;,&quot;Android Emoji&=
quot;,EmojiSymbols; font-size:12pt">
<span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:11pt">Re=
turn value of a function 'virDomainChrSourceDefNew'&nbsp;</span></div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-family:Calibri,H=
elvetica,sans-serif,EmojiFont,&quot;Apple Color Emoji&quot;,&quot;Segoe UI =
Emoji&quot;,NotoColorEmoji,&quot;Segoe UI Symbol&quot;,&quot;Android Emoji&=
quot;,EmojiSymbols; font-size:12pt">
<span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:11pt">is=
 dereferenced at qemu_command.c without checking&nbsp;</span></div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-family:Calibri,H=
elvetica,sans-serif,EmojiFont,&quot;Apple Color Emoji&quot;,&quot;Segoe UI =
Emoji&quot;,NotoColorEmoji,&quot;Segoe UI Symbol&quot;,&quot;Android Emoji&=
quot;,EmojiSymbols; font-size:12pt">
<span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:11pt">fo=
r NULL, but it is usually checked for this function</span><span style=3D"fo=
nt-family:Calibri,Helvetica,sans-serif; font-size:11pt">.</span></div>
</div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:rgb(0,0,0); font-family:Calibri,Helvetica,sans-serif,EmojiFont,&quot;Apple=
 Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI=
 Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols">
<span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:11pt"></=
span>
<p style=3D"font-family:Calibri,Helvetica,sans-serif,EmojiFont,&quot;Apple =
Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI =
Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols; font-size:16px">
<br>
</p>
<p></p>
<p><span style=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_normal,&quot=
;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFon=
t; font-size:13.3333px">Found by Linux Verification Center (linuxtesting.or=
g) with SVACE.</span><br>
</p>
<p><span style=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_normal,&quot=
;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFon=
t; font-size:13.3333px"><br>
</span></p>
<p><span style=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_normal,&quot=
;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFon=
t; font-size:13.3333px">Fixes: 1f85f0967b (&quot;ci: jobs.sh: Add back '--n=
o-suite syntax-check --print-errorlogs'&quot;)<br>
</span></p>
<p><span style=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_normal,&quot=
;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFon=
t; font-size:13.3333px">Signed-off-by: Sergey Mironov &lt;mironov@fintech.r=
u&gt;<br>
</span></p>
<p><span style=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_normal,&quot=
;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFon=
t; font-size:13.3333px"></span></p>
<div>
<div></div>
<span style=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_normal,&quot;Se=
goe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont; =
font-size:13.3333px">---</span></div>
<div><span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:11p=
t"><span style=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_normal,&quot=
;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFon=
t; font-size:13.3333px">
<div style=3D"font-family:Calibri,Helvetica,sans-serif,EmojiFont,&quot;Appl=
e Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe U=
I Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols; font-size:16px">
<span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:11pt"><s=
pan id=3D"ms-rterangepaste-start"></span><span>src/qemu/qemu_command.c | 2 =
&#43;&#43;</span><span id=3D"ms-rterangepaste-end"></span></span></div>
<span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:11pt"></=
span>
<div style=3D"font-family:Calibri,Helvetica,sans-serif,EmojiFont,&quot;Appl=
e Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe U=
I Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols; font-size:16px">
<span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:11pt">&n=
bsp;1 file changed, 2 insertions(&#43;)</span></div>
</span></span></div>
<div><span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:11p=
t"></span></div>
<div><span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:11p=
t; color:rgb(33,33,33)"><br>
<div>diff --git a/src/qemu/qemu_command.c b/src/qemu/qemu_command.c</div>
<div>index e84374b4cf..8d11972c88 100644</div>
<div>--- a/src/qemu/qemu_command.c</div>
<div>&#43;&#43;&#43; b/src/qemu/qemu_command.c</div>
<div>@@ -4698,6 &#43;4698,8 @@ qemuBuildVideoCommandLine(virCommand *cmd,</=
div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;g_autofree char *name =
=3D g_strdup_printf(&quot;%s-vhost-user&quot;, video-&gt;info.alias);</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;qemuDomainChrSourcePri=
vate *chrsrcpriv =3D QEMU_DOMAIN_CHR_SOURCE_PRIVATE(chrsrc);</div>
<div>&nbsp;</div>
<div>&#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (chrsrc =3D=3D NULL)<=
/div>
<div>&#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp;return -1;</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;chrsrc-&gt;type =3D VI=
R_DOMAIN_CHR_TYPE_UNIX;</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;chrsrcpriv-&gt;directf=
d =3D qemuFDPassDirectNew(name, &amp;videopriv-&gt;vhost_user_fd);</div>
</span></div>
<div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif,EmojiFont,&quot;Appl=
e Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe U=
I Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols; font-size:16px">
<span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:11pt"><s=
pan style=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_normal,&quot;Sego=
e UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont; fo=
nt-size:13.3333px">
<div style=3D"font-family:Calibri,Helvetica,sans-serif,EmojiFont,&quot;Appl=
e Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe U=
I Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols; font-size:16px">
<div><span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:11p=
t"></span></div>
<span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:11pt"></=
span></div>
<span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:11pt"></=
span>
<div style=3D"font-family:Calibri,Helvetica,sans-serif,EmojiFont,&quot;Appl=
e Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe U=
I Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols; font-size:16px">
<span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:11pt">--=
</span></div>
<span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:11pt"></=
span>
<div style=3D"font-family:Calibri,Helvetica,sans-serif,EmojiFont,&quot;Appl=
e Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe U=
I Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols; font-size:16px">
<span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:11pt">2.=
31.1</span></div>
</span></span></div>
</div>
</div>
</div>
</body>
</html>

--_000_59e6590ea8a04de788f69709ea4c54f8fintechru_--

