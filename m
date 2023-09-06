Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 489A5793B01
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 13:24:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdqcJ-00056a-Rq; Wed, 06 Sep 2023 07:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1qdqcG-000565-T9; Wed, 06 Sep 2023 07:22:36 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1qdqcB-0006bA-TF; Wed, 06 Sep 2023 07:22:36 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwBHT2PvYPhkeLK8AQ--.18181S2;
 Wed, 06 Sep 2023 19:22:24 +0800 (CST)
Received: from WYQ-S (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwDXQzDrYPhkUnQAAA--.1901S3;
 Wed, 06 Sep 2023 19:22:19 +0800 (CST)
Date: Wed, 6 Sep 2023 19:22:19 +0800
From: "Yuquan Wang" <wangyuquan1236@phytium.com.cn>
To: jonathan.cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, 
 "gregory.price@memverge.com" <gregory.price@memverge.com>
Subject: Re: CXL Namespaces of ACPI disappearing in Qemu demo
References: <2023082215220191352877@phytium.com.cn>, 
 <2023090518450211126476@phytium.com.cn>, 
 <20230905153438.000075ff@huawei.com>
X-Priority: 3
X-GUID: 75CF43B2-0E70-4E6A-B977-F8853D34BA06
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.228[cn]
Mime-Version: 1.0
Message-ID: <2023090619221880715697@phytium.com.cn>
Content-Type: multipart/alternative;
 boundary="----=_001_NextPart608180013868_=----"
X-CM-TRANSID: AQAAfwDXQzDrYPhkUnQAAA--.1901S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAOAWT3facFVwABsU
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
 1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=wangyuquan1236@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, HTML_FONT_LOW_CONTRAST=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_KAM_HTML_FONT_INVALID=0.01 autolearn=ham autolearn_force=no
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

------=_001_NextPart608180013868_=----
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64

SGksIEpvbmF0aGFuDQpPbiAyMDIzLTA5LTA1IDIyOjM0LCAgam9uYXRoYW4uY2FtZXJvbiB3cm90
ZToNCj4gDQo+IEFzIEkgdW5kZXJzdGFuZCBpdCB0aGUgZGlzdGluY3Rpb24gaXMgbW9yZSBhYm91
dCB0aGUgZm9ybWF0IC8gY29udGVudHMgb2YgdGhhdCBtZW1vcnkNCj4gdGhhbiBob3cgeW91IGFj
Y2VzcyB0aGVtLiANCg0KWWVzLCBSQ0ggRFAgUkNSQiBpbmNsdWRlcyByZWdpc3RlcnMgZnJvbSBQ
Q0llIFR5cGUgMSBDb25maWcgSGVhZGVyIGFuZA0KUENJZSBjYXBhYmlsaXRpZXMgYW5kIGV4dGVu
ZGVkIGNhcGFiaWxpdGllcyB3aGlsZSBDSEJDUiBpbmNsdWRlcyBjb21wb25lbnQgcmVnaXN0ZXJz
IA0Kd2l0aCB0aGUgc2FtZSBsYXlvdXQgYW5kIGRpc2NvdmVyeSBtZWNoYW5pc20gaW4gb3RoZXIg
Q1hMIGNvbXBvbmVudHMuDQoNCj4gQXMgYW4gYXNpZGUsIHRoZXkgYXJlIGRlc2NyaWJlZCBieSBh
IHN0YXRpYyBBQ1BJIHRhYmxlLA0KPiBzbyB0aGV5IGNhbid0IGJlIGluIHRoZSBNTUlPIHNwYWNl
IHVzZWQgZm9yIEJBUnMgZXRjLg0KPiANCg0KSW4gQ1hMIDMuMCBTcGVjLCB0aGUgRmlndXJlIDkt
MTQgKENYTCBMaW5rL1Byb3RvY29sIFJlZ2lzdGVyIE1hcHBpbmcgaW4gYSBDWEwgVkgpDQpzaG93
cyB0aGF0IENIQkNSIGlzIG1hcHBlZCBieSAiSG9zdCBQcm9wcmlldGFyeSBTdGF0aWMgQmFyIi4g
QWNjb3JkaW5nIHRvIHlvdXIgZ3VpZGFuY2UsDQppdCBpcyBub3QgYSBzdGFuZGFyZCBQQ0llIEJB
UiB1c2luZyBQQ0llIE1NSU8gU3BhY2UsIHNvIEkgdW5kZXJzdGFuZCBpdCBpcyBhIHNwZWNpYWwg
QkFSIGZvciANCk1NSU8gb2YgYSBwbGF0Zm9ybSBkZXZpY2U/DQoNCg0KTWFueSB0aGFua3MNCll1
cXVhbg0K

------=_001_NextPart608180013868_=----
Content-Type: text/html;
	charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charse=
t=3DISO-8859-1"><style>body { line-height: 1.5; }body { font-size: 13px; f=
ont-family: "Times New Roman"; color: rgb(0, 0, 0); line-height: 1.5; }</s=
tyle></head><body>=0A =0A<div>Hi, Jonathan</div>=0AOn&nbsp;2023-09-05&nbsp=
;22:34,&nbsp;&nbsp;<span>jonathan.cameron</span>&nbsp;wrote:<div><div>&gt;=
&nbsp;</div><div>&gt; As I understand it the distinction is more about the=
 format / contents of that memory</div><div>&gt; than how you access them.=
&nbsp;</div><div><br></div><div>Yes, RCH DP RCRB includes&nbsp;<span style=
=3D"background-color: rgba(0, 0, 0, 0); color: rgb(0, 0, 0);">registers&nb=
sp;from&nbsp;PCIe&nbsp;Type&nbsp;1&nbsp;Config&nbsp;Header&nbsp;and</span>=
</div><div><span style=3D"background-color: rgba(0, 0, 0, 0); color: rgb(0=
, 0, 0);">PCIe&nbsp;capabilities&nbsp;and&nbsp;extended&nbsp;capabilities =
while CHBCR includes c</span><span style=3D"background-color: rgba(0, 0, 0=
, 0); color: rgb(0, 0, 0);">omponent&nbsp;</span><span style=3D"background=
-color: rgba(0, 0, 0, 0); color: rgb(0, 0, 0);">registers&nbsp;</span></di=
v><div><span style=3D"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0,=
 0);">with the same&nbsp;</span><span style=3D"color: rgb(0, 0, 0); backgr=
ound-color: rgba(0, 0, 0, 0);">layout&nbsp;and&nbsp;discovery&nbsp;mechani=
sm in</span><span style=3D"background-color: rgba(0, 0, 0, 0); color: rgb(=
0, 0, 0);">&nbsp;other CXL components.</span></div><div><br></div><div><sp=
an style=3D"background-color: transparent;">&gt;&nbsp;</span>As an aside, =
they are described by a static ACPI table,</div><div>&gt; so they can't be=
 in the MMIO space used for BARs etc.</div><div>&gt;&nbsp;</div><div><br><=
/div><div><span style=3D"color: rgb(0, 0, 0); background-color: rgba(0, 0,=
 0, 0);">In CXL 3.0 Spec, the Figure&nbsp;9-14 (CXL&nbsp;Link/Protocol&nbs=
p;Register&nbsp;Mapping&nbsp;in&nbsp;a&nbsp;CXL&nbsp;VH)</span></div><div>=
<span style=3D"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">s=
hows that CHBCR is mapped by "Host Proprietary Static Bar". According to y=
our&nbsp;</span><span style=3D"background-color: transparent;">guidance,</=
span></div><div><span style=3D"background-color: transparent;">it is not a=
 standard PCIe BAR using PCIe MMIO Space, so I understand it is a special =
BAR for&nbsp;</span></div><div><span style=3D"color: rgb(0, 0, 0); backgro=
und-color: rgba(0, 0, 0, 0);">MMIO of a&nbsp;platform&nbsp;device?</span><=
/div><div><br></div><div><br></div></div><div>Many thanks</div><div>Yuquan=
</div></body></html>
------=_001_NextPart608180013868_=------


