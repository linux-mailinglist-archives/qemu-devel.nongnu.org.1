Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C6C732917
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 09:44:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA47f-0002QJ-Rr; Fri, 16 Jun 2023 03:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1qA47a-0002O0-Fm; Fri, 16 Jun 2023 03:43:50 -0400
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1qA47T-0007vP-Vi; Fri, 16 Jun 2023 03:43:49 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwAnrF04Eoxk0yU6AA--.29718S2;
 Fri, 16 Jun 2023 15:41:44 +0800 (CST)
Received: from WYQ-S (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwA3dAahEoxkR3IAAA--.1739S3;
 Fri, 16 Jun 2023 15:43:30 +0800 (CST)
Date: Fri, 16 Jun 2023 15:43:31 +0800
From: "Yuquan Wang" <wangyuquan1236@phytium.com.cn>
To: jonathan.cameron <jonathan.cameron@huawei.com>, 
 "Gregory Price" <gregory.price@memverge.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, 
	qemu-devel <qemu-devel@nongnu.org>
Subject: A confusion about CXL in arm virt machine
X-Priority: 3
X-GUID: 1CA737B7-7292-4BAB-85B6-16F638FABB2E
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.228[cn]
Mime-Version: 1.0
Message-ID: <2023061615433049315231@phytium.com.cn>
Content-Type: multipart/alternative;
 boundary="----=_001_NextPart601833761820_=----"
X-CM-TRANSID: AQAAfwA3dAahEoxkR3IAAA--.1739S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAMAWSLYqgCrgABsE
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
 1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=wangyuquan1236@phytium.com.cn;
 helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, HTML_FONT_LOW_CONTRAST=0.001,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_KAM_HTML_FONT_INVALID=0.01,
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

This is a multi-part message in MIME format.

------=_001_NextPart601833761820_=----
Content-Type: text/plain;
	charset="GB2312"
Content-Transfer-Encoding: base64

SGksIEdyZWdvcnkNCg0KVGhlcmUgaXMgb25lIGNvbmZ1c2lvbiBhYm91dCBDWEwgaW4gUUVNVSBJ
IGhvcGUgdG8gY29uc3VsdC4gDQpJZiB5b3UgaGF2ZSBzb21lIHRpbWUgdG8gbG9vayBhdCB0aGlz
IGVtYWlsLCBJIHdvdWxkIGhhdmUgYmV0dGVyIHVuZGVyc3RhbmRpbmcgb2YgQ1hMIA0KZW11bGF0
aW9uIGluIFFFTVUuDQoNCk9uIGRvY3Mvc3lzdGVtL2RldmljZXMvY3hsLnJzdCAsICBHcmVnb3J5
IHdyb3RlOg0KQSB2ZXJ5IHNpbXBsZSBzZXR1cCB3aXRoIGp1c3Qgb25lIGRpcmVjdGx5IGF0dGFj
aGVkIENYTCBUeXBlIDMgVm9sYXRpbGUgTWVtb3J5IGRldmljZTo6DQpxZW11LXN5c3RlbS1hYXJj
aDY0IC1NIHZpcnQsZ2ljLXZlcnNpb249MyxjeGw9b24gLW0gNGcsbWF4bWVtPThHLHNsb3RzPTgg
LWNwdSBtYXggXA0KLi4uLi4uDQoNCkFzIHRoZSBjdXJyZW50IG1hc3RlciBicmFuY2ggb2YgUUVN
VSBoYXMgbm90IHlldCBjb21wbGVtZW50ZWQgdGhlIENYTCBvcHRpb24vZXhwYW5zaW9uIA0KaW4g
YXJtIHZpcnQgbWFjaGluZSwgaG93IHRoaXMgZXhhbXBsZSBjb21tYW5kIGxpbmVzIHdvcmtlZD8g
T3IgaGVyZSB1c2VkIGFub3RoZXIgYnJhbmNoIA0KcmF0aGVyIHRoYW4gbWFzdGVyPw0KDQpNYW55
IHRoYW5rcw0KWXVxdWFuDQo=

------=_001_NextPart601833761820_=----
Content-Type: text/html;
	charset="GB2312"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charse=
t=3DGB2312"><style>body { line-height: 1.5; }blockquote { margin-top: 0px;=
 margin-bottom: 0px; margin-left: 0.5em; }div.FoxDiv20230616153421567746 {=
 }body { font-size: 13px; font-family: "Times New Roman"; color: rgb(0, 0,=
 0); line-height: 1.5; }</style></head><body>=0A<div><span></span></div><b=
lockquote style=3D"margin-Top: 0px; margin-Bottom: 0px; margin-Left: 0.5em=
; margin-Right: inherit"><div><span style=3D"background-color: transparent=
;">Hi,&nbsp;</span><span style=3D"background-color: transparent;">G</span>=
<span style=3D"background-color: transparent;">regory</span></div><div><di=
v class=3D"FoxDiv20230616153421567746"><div><span style=3D"background-colo=
r: transparent;"><br></span></div><div><span style=3D"background-color: tr=
ansparent;">There is one confusion about CXL in QEMU&nbsp;</span><span sty=
le=3D"background-color: transparent;">I hope to consult</span><span style=
=3D"background-color: transparent;">.&nbsp;</span></div><div><span style=
=3D"background-color: transparent;">If you have some time&nbsp;</span><spa=
n style=3D"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">to&nb=
sp;look&nbsp;at&nbsp;this email,&nbsp;</span><span style=3D"color: rgb(0, =
0, 0); background-color: rgba(0, 0, 0, 0);">I would have better understand=
ing of CXL&nbsp;</span></div><div><span style=3D"color: rgb(0, 0, 0); back=
ground-color: rgba(0, 0, 0, 0);">emulation in QEMU.</span></div><div><span=
 style=3D"background-color: rgba(0, 0, 0, 0); color: rgb(0, 0, 0);"><br></=
span></div>=0AOn&nbsp;docs/system/devices/cxl.rst&nbsp;,&nbsp; G<span>rego=
ry</span>&nbsp;wrote:<div><span style=3D"background-color: rgba(0, 0, 0, 0=
); color: rgb(0, 0, 0);">A&nbsp;very&nbsp;simple&nbsp;setup&nbsp;with&nbsp=
;just&nbsp;one&nbsp;directly&nbsp;attached&nbsp;CXL&nbsp;Type&nbsp;3&nbsp;=
Volatile&nbsp;Memory&nbsp;device::</span></div><div><span style=3D"color: =
rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">qemu-system-aarch64&nbs=
p;-M&nbsp;virt,gic-version=3D3,cxl=3Don&nbsp;-m&nbsp;4g,maxmem=3D8G,slots=
=3D8&nbsp;-cpu&nbsp;max&nbsp;\</span><br><div></div><div>......</div><div>=
<br></div><div>As the current master branch of&nbsp;<span style=3D"backgro=
und-color: transparent;">QEMU has not yet complemented the CXL option/</sp=
an><span style=3D"background-color: transparent;">expansion&nbsp;</span></=
div><div><span style=3D"background-color: transparent;">in arm virt machin=
e, how this e</span><span style=3D"background-color: rgba(0, 0, 0, 0); col=
or: rgb(0, 0, 0);">xample&nbsp;command&nbsp;lines worked? Or here used ano=
ther branch&nbsp;</span></div><div><span style=3D"background-color: rgba(0=
, 0, 0, 0); color: rgb(0, 0, 0);">rather than master?</span></div><div><br=
></div><div>Many thanks</div><div>Yuquan</div></div></div></div></blockquo=
te>=0A</body></html>
------=_001_NextPart601833761820_=------


