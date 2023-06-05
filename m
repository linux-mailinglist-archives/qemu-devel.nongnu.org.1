Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F5A7222DE
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 12:05:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q675R-0005bF-9H; Mon, 05 Jun 2023 06:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1q675M-0005ae-9j; Mon, 05 Jun 2023 06:05:12 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1q675K-0000x2-55; Mon, 05 Jun 2023 06:05:12 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwD32pXssn1kPfFLAg--.18628S2;
 Mon, 05 Jun 2023 18:03:24 +0800 (CST)
Received: from 192.168.0.1 (unknown [10.12.1.82])
 by mail (Coremail) with SMTP id AQAAfwA3YiJEs31kbo4AAA--.746S3;
 Mon, 05 Jun 2023 18:04:53 +0800 (CST)
From: wangyuquan1236 <wangyuquan1236@phytium.com.cn>
Subject: Re: [PATCH v3 1/1] hw/arm/sbsa-ref: use XHCI to replace EHCI
Message-ID: <01278DC7-2787-4715-B0DF-BDC51525637B@phytium.com.cn>
Date: Mon, 5 Jun 2023 18:04:51 +0800
References: <20230605095536.117384-1-wangyuquan1236@phytium.com.cn>
 <20230605095536.117384-2-wangyuquan1236@phytium.com.cn>
In-Reply-To: <101d301d-d413-288e-9318-d0a226ea8715@linaro.org>
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: "rad@semihalf.com" <rad@semihalf.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "quic_llindhol@quicinc.com"
 <quic_llindhol@quicinc.com>, "chenbaozi@phytium.com.cn"
 <chenbaozi@phytium.com.cn>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
X-Mailer: MailMasterIOS/7.14.6.1944 (16.1.1)
MIME-Version: 1.0
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: AQAAfwA3YiJEs31kbo4AAA--.746S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQABAWR84icEdgACss
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
 1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoWrKryxur4DGry3Ar1kXr43Jrb_yoWkZFc_uF
 1kCr98Ww4qyw4xK39FgFsxA3yftr1jkr4UWF1kAa48Za4jqF95GrykKry8uw15Cr1vvFsF
 vF1SqrWFqryaqjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
 Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
 UUUU=
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=wangyuquan1236@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 HTML_MIME_NO_HTML_TAG=0.377, MIME_HTML_ONLY=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Sure=EF=BC=8Cbut I am handling the email problem with devel=40edk2.groups=
.io that it refused my patch email.&nbsp;<div><br></div><div>I will deal =
with it as soon as possible.</div><div id=3D=22imail=5Fsignature=22 class=
=3D=22ntes-signature=22></div><div class=3D=22ntes-mailmaster-quote=22 st=
yle=3D=22padding-top: 1px; padding-bottom: 1px=22><div style=3D=22margin-=
top: 2em;margin-bottom: 1em;font-size: 14px;line-height: 1.25;color: =237=
8787a;=22>---- Replied Message ----</div><div style=3D=22margin-bottom: 1=
em;font-size: 12px;line-height: 1.25;color: =23232324;padding: 0.5em 0.25=
em;border-radius: 0.67em;background-color: =23f0f0f0;=22><table width=3D=22=
100%=22 cellpadding=3D=220=22 cellspacing=3D=229=22 border=3D=220=22><tbo=
dy><tr><td valign=3D=22top=22 style=3D=22width: 4.25em;font-size: 12px;li=
ne-height: 1.25;color: =2378787a;=22><span style=3D=22color:=238b8d94=22>=
=46rom</span></td><td valign=3D=22top=22 style=3D=22font-size: 12px;line-=
height: 1.25;color: =23232324;word-break: break-all;=22><a class=3D=22mai=
l-from=22 style=3D=22color: =230886e8; text-decoration: none=22 href=3D=22=
mailto:marcin.juszkiewicz=40linaro.org=22>Marcin Juszkiewicz&lt;marcin.ju=
szkiewicz=40linaro.org&gt;</a></td></tr><tr><td valign=3D=22top=22 style=3D=
=22width: 4.25em;font-size: 12px;line-height: 1.25;color: =2378787a;=22><=
span style=3D=22color:=238b8d94=22>Date</span></td><td class=3D=22mail-da=
te=22 valign=3D=22top=22 style=3D=22font-size: 12px;line-height: 1.25;col=
or: =23232324;word-break: break-all;=22><span class=3D=22mail-date=22 sty=
le=3D=22color:black=22>06/05/2023 17:59</span></td></tr><tr><td valign=3D=
=22top=22 style=3D=22width: 4.25em;font-size: 12px;line-height: 1.25;colo=
r: =2378787a;=22> <span style=3D=22color:=238b8d94=22>To</span></td><td v=
align=3D=22top=22 style=3D=22font-size: 12px;line-height: 1.25;color: =23=
232324;word-break: break-all;=22><a class=3D=22mail-to=22 style=3D=22colo=
r: =230886e8; text-decoration: none=22 href=3D=22mailto:wangyuquan1236=40=
phytium.com.cn=22>Yuquan Wang&lt;wangyuquan1236=40phytium.com.cn&gt;</a>,=
<br><a class=3D=22mail-to=22 style=3D=22color: =230886e8; text-decoration=
: none=22 href=3D=22mailto:rad=40semihalf.com=22>rad=40semihalf.com&lt;ra=
d=40semihalf.com&gt;</a>,<br><a class=3D=22mail-to=22 style=3D=22color: =23=
0886e8; text-decoration: none=22 href=3D=22mailto:peter.maydell=40linaro.=
org=22>peter.maydell=40linaro.org&lt;peter.maydell=40linaro.org&gt;</a></=
td></tr><tr><td valign=3D=22top=22 style=3D=22width: 4.25em;font-size: 12=
px;line-height: 1.25;color: =2378787a;=22> <span style=3D=22color:=238b8d=
94=22>Cc</span></td><td valign=3D=22top=22 style=3D=22font-size: 12px;lin=
e-height: 1.25;color: =23232324;word-break: break-all;=22><a class=3D=22m=
ail-cc=22 style=3D=22color: =230886e8; text-decoration: none=22 href=3D=22=
mailto:quic=5Fllindhol=40quicinc.com=22>quic=5Fllindhol=40quicinc.com&lt;=
quic=5Fllindhol=40quicinc.com&gt;</a>,<br><a class=3D=22mail-cc=22 style=3D=
=22color: =230886e8; text-decoration: none=22 href=3D=22mailto:chenbaozi=40=
phytium.com.cn=22>chenbaozi=40phytium.com.cn&lt;chenbaozi=40phytium.com.c=
n&gt;</a>,<br><a class=3D=22mail-cc=22 style=3D=22color: =230886e8; text-=
decoration: none=22 href=3D=22mailto:qemu-arm=40nongnu.org=22>qemu-arm=40=
nongnu.org&lt;qemu-arm=40nongnu.org&gt;</a>,<br><a class=3D=22mail-cc=22 =
style=3D=22color: =230886e8; text-decoration: none=22 href=3D=22mailto:qe=
mu-devel=40nongnu.org=22>qemu-devel=40nongnu.org&lt;qemu-devel=40nongnu.o=
rg&gt;</a></td></tr><tr><td valign=3D=22top=22 style=3D=22width: 4.25em;f=
ont-size: 12px;line-height: 1.25;color: =2378787a;=22><span style=3D=22co=
lor:=238b8d94=22>Subject</span></td><td class=3D=22mail-subject=22 valign=
=3D=22top=22 style=3D=22font-size: 12px;line-height: 1.25;color: =2323232=
4;word-break: break-all;=22><span class=3D=22mail-subject=22 style=3D=22c=
olor:black=22>Re: =5BPATCH v3 1/1=5D hw/arm/sbsa-ref: use XHCI to replace=
 EHCI</span></td></tr></tbody></table></div><div>W dniu 5.06.2023 o&nbsp;=
11:55, Yuquan Wang pisze:
<br>&gt; The current sbsa-ref cannot use EHCI controller which is only
<br>&gt; able to do 32-bit DMA, since sbsa-ref doesn't have RAM below 4GB=
.
<br>&gt; Hence, this uses XHCI to provide a usb controller with 64-bit
<br>&gt; DMA capablity instead of EHCI.
<br>&gt; =20
<br>&gt; Signed-off-by: Yuquan Wang&lt;wangyuquan1236=40phytium.com.cn&gt=
;
<br>
<br>Can you share firmware side so it can be tested=3F
<br>
<br>The more I deal with EDK2 the more I understand why people go U-Boot.=

<br></div></div>


