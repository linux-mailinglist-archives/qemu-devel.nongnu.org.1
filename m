Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 536B27A0473
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 14:52:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgloT-0006rJ-OU; Thu, 14 Sep 2023 08:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mironov@fintech.ru>)
 id 1qgj4r-0003Ms-Jo
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 05:56:01 -0400
Received: from exchange.fintech.ru ([195.54.195.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mironov@fintech.ru>)
 id 1qgj4p-0003qH-3Z
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 05:56:01 -0400
Received: from Ex16-02.fintech.ru (10.0.10.19) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 14 Sep
 2023 12:44:13 +0300
Received: from Ex16-02.fintech.ru (10.0.10.19) by Ex16-02.fintech.ru
 (10.0.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 14 Sep
 2023 12:44:13 +0300
Received: from Ex16-02.fintech.ru ([fe80::18b6:cd4a:a259:613c]) by
 Ex16-02.fintech.ru ([fe80::18b6:cd4a:a259:613c%3]) with mapi id
 15.01.2242.004; Thu, 14 Sep 2023 12:44:13 +0300
From: =?koi8-r?B?7cnSz87P1yDzxdLHxcog98zBxMnNydLP18ne?= <mironov@fintech.ru>
To: "libvirt-security@redhat.com" <libvirt-security@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "libvir-list@redhat.com"
 <libvir-list@redhat.com>
CC: "sdl.qemu@linuxtesting.org" <sdl.qemu@linuxtesting.org>
Subject: [sdl-qemu] [PATCH 0/1] There are no checks, virDomainChrSourceDefNew
 can return 0
Thread-Topic: [sdl-qemu] [PATCH 0/1] There are no checks,
 virDomainChrSourceDefNew can return 0
Thread-Index: AQHZ5ucq0iitK7oRi0GnkRn5iTU/ZA==
Date: Thu, 14 Sep 2023 09:44:13 +0000
Message-ID: <ace59b33a24b45dbb4075800c0922641@fintech.ru>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.1.141]
Content-Type: multipart/alternative;
 boundary="_000_ace59b33a24b45dbb4075800c0922641fintechru_"
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

--_000_ace59b33a24b45dbb4075800c0922641fintechru_
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable

There are no checks, virDomainChrSourceDefNew can return 0.


Return value of a function 'virDomainChrSourceDefNew'

is dereferenced at qemu_hotplug.c without checking for NULL,

but it is usually checked for this function.


Found by Linux Verification Center (linuxtesting.org) with SVACE.


Fixes: 1f85f0967b ("ci: jobs.sh: Add back '--no-suite syntax-check --print-=
errorlogs'")

Signed-off-by: Sergey Mironov <mironov@fintech.ru>

---
src/qemu/qemu_hotplug.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/qemu/qemu_hotplug.c b/src/qemu/qemu_hotplug.c
index 177ca87d11..09e16c2c7e 100644
--- a/src/qemu/qemu_hotplug.c
+++ b/src/qemu/qemu_hotplug.c
@@ -3207,6 +3207,8 @@ qemuDomainAttachFSDevice(virQEMUDriver *driver,
     qemuAssignDeviceFSAlias(vm->def, fs);

     chardev =3D virDomainChrSourceDefNew(priv->driver->xmlopt);
+    if (chardev =3D=3D NULL)
+           goto cleanup;
     chardev->type =3D VIR_DOMAIN_CHR_TYPE_UNIX;
     chardev->data.nix.path =3D qemuDomainGetVHostUserFSSocketPath(priv, fs=
);
--
2.31.1

--_000_ace59b33a24b45dbb4075800c0922641fintechru_
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
<p><span style=3D"color:rgb(33,33,33); font-family:Calibri,Helvetica,sans-s=
erif; font-size:14.6667px">There are no checks, virDomainChrSourceDefNew ca=
n return 0.</span><br>
</p>
<p><span><br>
</span></p>
<p><span><span style=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_normal=
,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,Em=
ojiFont; font-size:13.3333px"><span style=3D"color:rgb(33,33,33); font-fami=
ly:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Aria=
l,sans-serif,serif,EmojiFont; font-size:13.3333px"><span style=3D"color:rgb=
(33,33,33); font-family:Calibri,Helvetica,sans-serif; font-size:11pt">Retur=
n
 value of a function 'virDomainChrSourceDefNew'&nbsp;</span><span style=3D"=
color:rgb(33,33,33); font-family:Calibri,Helvetica,sans-serif,EmojiFont,&qu=
ot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;=
Segoe UI Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols; font-size:16p=
x"><span style=3D"font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot=
;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:13.3333p=
x"></span></span></span></span></span></p>
<p style=3D"font-family:Calibri,Helvetica,sans-serif,EmojiFont,&quot;Apple =
Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI =
Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols; font-size:16px">
<span style=3D"font-size:11pt; font-family:Calibri,Helvetica,sans-serif">is=
 dereferenced at qemu_hotplug.c without checking for NULL,&nbsp;</span></p>
<p style=3D"font-family:Calibri,Helvetica,sans-serif,EmojiFont,&quot;Apple =
Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI =
Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols; font-size:16px">
<span style=3D"font-size:11pt; font-family:Calibri,Helvetica,sans-serif">bu=
t it is usually checked for this function.</span><br>
</p>
<p style=3D"font-family:Calibri,Helvetica,sans-serif,EmojiFont,&quot;Apple =
Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI =
Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols; font-size:16px">
<br>
</p>
<p></p>
<p><span><span><span style=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_=
normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,se=
rif,EmojiFont; font-size:13.3333px">Found by Linux Verification Center (lin=
uxtesting.org) with SVACE.</span><br>
</span></span></p>
<p><span><span><span style=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_=
normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,se=
rif,EmojiFont; font-size:13.3333px"><br>
</span></span></span></p>
<p><span><span><span style=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_=
normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,se=
rif,EmojiFont; font-size:13.3333px"><span>Fixes: 1f85f0967b (&quot;ci: jobs=
.sh: Add back '--no-suite syntax-check --print-errorlogs'&quot;)</span><br>
</span></span></span></p>
<p><span><span><span style=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_=
normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,se=
rif,EmojiFont; font-size:13.3333px"><span style=3D"color:rgb(33,33,33); fon=
t-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahom=
a,Arial,sans-serif,serif,EmojiFont; font-size:13.3333px">Signed-off-by:
 Sergey Mironov &lt;mironov@fintech.ru&gt;</span><br>
</span></span></span></p>
<p><span><span><span style=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_=
normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,se=
rif,EmojiFont; font-size:13.3333px"></span></span></span></p>
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
<span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:11pt">sr=
c/qemu/qemu_hotplug.c | 2 &#43;&#43;</span></div>
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
diff --git a/src/qemu/qemu_hotplug.c b/src/qemu/qemu_hotplug.c</span><br>
</div>
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
t">index 177ca87d11..09e16c2c7e 100644</span></div>
<div><span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:11p=
t">--- a/src/qemu/qemu_hotplug.c</span></div>
<div><span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:11p=
t">&#43;&#43;&#43; b/src/qemu/qemu_hotplug.c</span></div>
<div><span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:11p=
t">@@ -3207,6 &#43;3207,8 @@ qemuDomainAttachFSDevice(virQEMUDriver *driver=
,</span></div>
<div><span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:11p=
t">&nbsp; &nbsp; &nbsp;qemuAssignDeviceFSAlias(vm-&gt;def, fs);</span></div=
>
<div><span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:11p=
t">&nbsp;</span></div>
<div><span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:11p=
t">&nbsp; &nbsp; &nbsp;chardev =3D virDomainChrSourceDefNew(priv-&gt;driver=
-&gt;xmlopt);</span></div>
<div><span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:11p=
t">&#43;&nbsp; &nbsp; if (chardev =3D=3D NULL)</span></div>
<div><span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:11p=
t">&#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;goto cleanup;</span></div>
<div><span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:11p=
t">&nbsp; &nbsp; &nbsp;chardev-&gt;type =3D VIR_DOMAIN_CHR_TYPE_UNIX;</span=
></div>
<div><span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:11p=
t">&nbsp; &nbsp; &nbsp;chardev-&gt;data.nix.path =3D qemuDomainGetVHostUser=
FSSocketPath(priv, fs);</span></div>
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
</body>
</html>

--_000_ace59b33a24b45dbb4075800c0922641fintechru_--

