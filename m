Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D27C77065BD
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 12:56:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzEp3-0002xz-Ao; Wed, 17 May 2023 06:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yu.chen@h3c.com>) id 1pzEoo-0002vZ-3L
 for qemu-devel@nongnu.org; Wed, 17 May 2023 06:55:43 -0400
Received: from smtp.h3c.com ([60.191.123.56] helo=h3cspam01-ex.h3c.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yu.chen@h3c.com>) id 1pzEok-0002t3-L4
 for qemu-devel@nongnu.org; Wed, 17 May 2023 06:55:41 -0400
Received: from mail.maildlp.com ([172.25.15.155])
 by h3cspam01-ex.h3c.com with ESMTP id 34HAtCwP049402;
 Wed, 17 May 2023 18:55:12 +0800 (GMT-8)
 (envelope-from yu.chen@h3c.com)
Received: from DAG2EX08-IDC.srv.huawei-3com.com (unknown [172.20.54.131])
 by mail.maildlp.com (Postfix) with ESMTP id 6C0DF222E3C7;
 Wed, 17 May 2023 18:59:09 +0800 (CST)
Received: from DAG2EX10-IDC.srv.huawei-3com.com (172.20.54.133) by
 DAG2EX08-IDC.srv.huawei-3com.com (172.20.54.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.6; Wed, 17 May 2023 18:55:14 +0800
Received: from DAG2EX10-IDC.srv.huawei-3com.com ([fe80::e886:502d:5063:7e2b])
 by DAG2EX10-IDC.srv.huawei-3com.com ([fe80::e886:502d:5063:7e2b%10])
 with mapi id 15.01.2507.021; Wed, 17 May 2023 18:55:14 +0800
From: Yuchen <yu.chen@h3c.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net"
 <rth@twiddle.net>, "ehabkost@redhat.com" <ehabkost@redhat.com>, Chengchiwen
 <chengchiwen@h3c.com>
Subject: [PATCH] target/i386: Clear xsave pkru bit when KVM XCR0 not support
Thread-Topic: [PATCH] target/i386: Clear xsave pkru bit when KVM XCR0 not
 support
Thread-Index: AdmH10nRMdIv88FeTxmtO8yhX/g2Mg==
Date: Wed, 17 May 2023 10:55:13 +0000
Message-ID: <914d4bfc6901485c9f029ce26ceb7d10@h3c.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.196.41]
x-sender-location: DAG2
Content-Type: multipart/alternative;
 boundary="_000_914d4bfc6901485c9f029ce26ceb7d10h3ccom_"
MIME-Version: 1.0
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: h3cspam01-ex.h3c.com 34HAtCwP049402
Received-SPF: pass client-ip=60.191.123.56; envelope-from=yu.chen@h3c.com;
 helo=h3cspam01-ex.h3c.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

--_000_914d4bfc6901485c9f029ce26ceb7d10h3ccom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Migrating guest from Intel new CPU (as Gold 6230) to old CPU (as
E5-2650 v4) will pause on the destination host. Because old CPU
not support xsave pkru feature, and KVM KVM_SET_XSAVE ioctl
return EINVAL.

This kernel commit introduces the problem:
ea4d6938d4c0 x86/fpu: Replace KVMs home brewed FPU copy from user

Signed-off-by: YuChen <yu.chen@h3c.com>
---
target/i386/xsave_helper.c | 8 ++++++++
1 file changed, 8 insertions(+)

diff --git a/target/i386/xsave_helper.c b/target/i386/xsave_helper.c
index 996e9f3bfe..64e2b969fe 100644
--- a/target/i386/xsave_helper.c
+++ b/target/i386/xsave_helper.c
@@ -6,6 +6,8 @@
 #include "cpu.h"
+static bool has_xsave_pkru;
+
void x86_cpu_xsave_all_areas(X86CPU *cpu, void *buf, uint32_t buflen)
{
     CPUX86State *env =3D &cpu->env;
@@ -47,6 +49,9 @@ void x86_cpu_xsave_all_areas(X86CPU *cpu, void *buf, uint=
32_t buflen)
         stq_p(xmm + 8, env->xmm_regs[i].ZMM_Q(1));
     }
+    if (!has_xsave_pkru) {
+        env->xstate_bv &=3D ~XSTATE_PKRU_MASK;
+    }
     header->xstate_bv =3D env->xstate_bv;
     e =3D &x86_ext_save_areas[XSTATE_YMM_BIT];
@@ -181,6 +186,9 @@ void x86_cpu_xrstor_all_areas(X86CPU *cpu, const void *=
buf, uint32_t buflen)
         env->xmm_regs[i].ZMM_Q(1) =3D ldq_p(xmm + 8);
     }
+    if (xsave->header.xstate_bv & XSTATE_PKRU_MASK) {
+        has_xsave_pkru =3D true;
+    }
     env->xstate_bv =3D header->xstate_bv;
     e =3D &x86_ext_save_areas[XSTATE_YMM_BIT];
--
2.34.1
---------------------------------------------------------------------------=
----------------------------------------------------------
?????????????????????????????????
????????????????????????????????????????
????????????????????????????????????????
???
This e-mail and its attachments contain confidential information from New H=
3C, which is
intended only for the person or entity whose address is listed above. Any u=
se of the
information contained herein in any way (including, but not limited to, tot=
al or partial
disclosure, reproduction, or dissemination) by persons other than the inten=
ded
recipient(s) is prohibited. If you receive this e-mail in error, please not=
ify the sender
by phone or email immediately and delete it!

--_000_914d4bfc6901485c9f029ce26ceb7d10h3ccom_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:x=3D"urn:schemas-microsoft-com:office:excel" xmlns:m=3D"http://schema=
s.microsoft.com/office/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html=
40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:"Microsoft YaHei";
	panose-1:2 11 5 3 2 2 4 2 2 4;}
@font-face
	{font-family:"Microsoft YaHei";}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:DengXian;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"????",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:DengXian;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word;text-justify-trim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif">Migrating guest from Intel n=
ew CPU (as Gold 6230) to old CPU (as<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif">E5-2650 v4) will pause on th=
e destination host. Because old CPU<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif">not support xsave pkru featu=
re, and KVM KVM_SET_XSAVE ioctl<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif">return EINVAL.<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif">This kernel commit introduce=
s the problem:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif">ea4d6938d4c0 x86/fpu: Replac=
e KVMs home brewed FPU copy from user<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif">Signed-off-by: YuChen &lt;yu=
.chen@h3c.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif">---<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif">target/i386/xsave_helper.c |=
 8 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif">1 file changed, 8 insertions=
(&#43;)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif">diff --git a/target/i386/xsa=
ve_helper.c b/target/i386/xsave_helper.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif">index 996e9f3bfe..64e2b969fe=
 100644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif">--- a/target/i386/xsave_help=
er.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif">&#43;&#43;&#43; b/target/i38=
6/xsave_helper.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif">@@ -6,6 &#43;6,8 @@<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif">&nbsp;#include &quot;cpu.h&q=
uot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif">&#43;static bool has_xsave_p=
kru;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif">&#43;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif">void x86_cpu_xsave_all_areas=
(X86CPU *cpu, void *buf, uint32_t buflen)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif">{<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp; CPU=
X86State *env =3D &amp;cpu-&gt;env;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif">@@ -47,6 &#43;49,9 @@ void x=
86_cpu_xsave_all_areas(X86CPU *cpu, void *buf, uint32_t buflen)<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; stq_p(xmm &#43; 8, env-&gt;xmm_regs[i].ZMM_Q(1));<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp; }<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif">&#43;&nbsp;&nbsp;&nbsp; if (=
!has_xsave_pkru) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif">&#43;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; env-&gt;xstate_bv &amp;=3D ~XSTATE_PKRU_MASK;<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif">&#43;&nbsp;&nbsp;&nbsp; }<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp; hea=
der-&gt;xstate_bv =3D env-&gt;xstate_bv;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;e =3D &amp;x86_ext_save_areas[XSTATE_YMM_BIT];<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif">@@ -181,6 &#43;186,9 @@ void=
 x86_cpu_xrstor_all_areas(X86CPU *cpu, const void *buf, uint32_t buflen)<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; env-&gt;xmm_regs[i].ZMM_Q(1) =3D ldq_p(xmm &#43; 8);<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp; }<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif">&#43;&nbsp;&nbsp;&nbsp; if (=
xsave-&gt;header.xstate_bv &amp; XSTATE_PKRU_MASK) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif">&#43;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; has_xsave_pkru =3D true;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif">&#43;&nbsp;&nbsp;&nbsp; }<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp; env=
-&gt;xstate_bv =3D header-&gt;xstate_bv;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;e =3D &amp;x86_ext_save_areas[XSTATE_YMM_BIT];<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif">-- <o:p>
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;&#24=
494;&#36719;&#38597;&#40657;&quot;,sans-serif">2.34.1<o:p></o:p></span></p>
</div>
<span style=3D"font-size:7.5pt;font-family:&#21326;&#25991;&#32454;&#40657;=
;color:gray"><span lang=3D"EN-US">-----------------------------------------=
---------------------------------------------------------------------------=
-----------------<br>
</span>&#26412;&#37038;&#20214;&#21450;&#20854;&#38468;&#20214;&#21547;&#26=
377;&#26032;&#21326;&#19977;&#38598;&#22242;&#30340;&#20445;&#23494;&#20449=
;&#24687;&#65292;&#20165;&#38480;&#20110;&#21457;&#36865;&#32473;&#19978;&#=
38754;&#22320;&#22336;&#20013;&#21015;&#20986;<span lang=3D"EN-US"><br>
</span>&#30340;&#20010;&#20154;&#25110;&#32676;&#32452;&#12290;&#31105;&#27=
490;&#20219;&#20309;&#20854;&#20182;&#20154;&#20197;&#20219;&#20309;&#24418=
;&#24335;&#20351;&#29992;&#65288;&#21253;&#25324;&#20294;&#19981;&#38480;&#=
20110;&#20840;&#37096;&#25110;&#37096;&#20998;&#22320;&#27844;&#38706;&#122=
89;&#22797;&#21046;&#12289;<span lang=3D"EN-US"><br>
</span>&#25110;&#25955;&#21457;&#65289;&#26412;&#37038;&#20214;&#20013;&#30=
340;&#20449;&#24687;&#12290;&#22914;&#26524;&#24744;&#38169;&#25910;&#20102=
;&#26412;&#37038;&#20214;&#65292;&#35831;&#24744;&#31435;&#21363;&#30005;&#=
35805;&#25110;&#37038;&#20214;&#36890;&#30693;&#21457;&#20214;&#20154;&#241=
82;&#21024;&#38500;&#26412;<span lang=3D"EN-US"><br>
</span>&#37038;&#20214;&#65281;<span lang=3D"EN-US"><br>
</span></span><span lang=3D"EN-US" style=3D"font-size:7.5pt;font-family:&qu=
ot;Arial&quot;,&quot;sans-serif&quot;;color:gray">This e-mail and its attac=
hments contain confidential information from New H3C, which is
<br>
intended only for the person or entity whose address is listed above. Any u=
se of the
<br>
information contained herein in any way (including, but not limited to, tot=
al or partial
<br>
disclosure, reproduction, or dissemination) by persons other than the inten=
ded <br>
recipient(s) is prohibited. If you receive this e-mail in error, please not=
ify the sender
<br>
by phone or email immediately and delete it!</span>
</body>
</html>

--_000_914d4bfc6901485c9f029ce26ceb7d10h3ccom_--

