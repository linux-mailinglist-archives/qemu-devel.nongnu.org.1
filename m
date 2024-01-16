Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 517AE82F061
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 15:16:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPkEJ-0007QH-21; Tue, 16 Jan 2024 09:15:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yezengruan@126.com>)
 id 1rPdz5-0004h0-Vz; Tue, 16 Jan 2024 02:35:45 -0500
Received: from m16.mail.126.com ([220.197.31.9])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yezengruan@126.com>)
 id 1rPdz2-0004PF-L0; Tue, 16 Jan 2024 02:35:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=VBO8vqRyrQZ+2V4bkbs3W6qcMaxcPGj89OMR6U6nx7k=; b=G
 IUCL96zgZo9nQKlfgwl/48XCcFCtrhFWRHn3bt6fIsM2RtZJUWN7uW2pUPsgiLpT
 /EQUz/73gwXBZQAY1LLFJPl/mzssQJEaQUJKqDAi6Elhqw0gzC0gWxf9aX7kwaK+
 gATtMuaZtaqVew1oCjPeCttsgiDgUzmezdy3331Z5M=
Received: from yezengruan$126.com ( [119.3.118.251] ) by
 ajax-webmail-wmsvr-41-106 (Coremail) ; Tue, 16 Jan 2024 15:33:15 +0800
 (CST)
X-Originating-IP: [119.3.118.251]
Date: Tue, 16 Jan 2024 15:33:15 +0800 (CST)
From: =?UTF-8?B?5Y+25aKe6L2v?= <yezengruan@126.com>
To: qemu-arm@nongnu.org, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Subject: =?UTF-8?Q?=E2=80=8B[Qemu-arm]_Windows_11_guest_Fast_startup_cannot_work?=
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 126com
X-NTES-SC: AL_Qu2bB/+Sv0si4yKRZukfm04Qj+4/UMq1ufsk1IZSPJtwjDvj4gkRdHJOIlrt1dC1BBuGoRWaWzVW5OljY6x0fLAXQ/w0iQ0NcnO32Kffxa90dQ==
Content-Type: multipart/alternative; 
 boundary="----=_Part_81548_14305477.1705390395296"
MIME-Version: 1.0
Message-ID: <704c07e7.50fc.18d11304fa0.Coremail.yezengruan@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: _____wD33087MaZlLbkjAA--.42415W
X-CM-SenderInfo: p1h2v0pjuxt0a6rslhhfrp/1tbi5gRngGVLYZCwhQADss
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=220.197.31.9; envelope-from=yezengruan@126.com;
 helo=m16.mail.126.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, URI_TRY_3LD=1.999 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 16 Jan 2024 09:15:43 -0500
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

------=_Part_81548_14305477.1705390395296
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

SGksCgpJIHdhbnQgdG8gaW1wcm92ZSB0aGUgc3RhcnR1cCBzcGVlZCBvZiBXaW5kb3dzIFZNLiBP
biB0aGUgeDg2IGFyY2hpdGVjdHVyZSwgUUVNVSdzIFdpbmRvd3MxMSBWTSBjYW4gZW5hYmxlIHRo
ZSBGYXN0IHN0YXJ0dXAgZnVuY3Rpb24sIGJ1dCBpdCBjYW5ub3Qgd29yayBvbiB0aGUgQVJNIGFy
Y2hpdGVjdHVyZS4gSW4gYWRkaXRpb24sIFdpbmRvd3MgY2FuIGFsc28gZW5hYmxlIHRoZSBGYXN0
IHN0YXJ0dXAgZnVuY3Rpb24gb24gdGhlIEFSTSBob3N0LiAKCklzIHRoZXJlIGFueXRoaW5nIG1p
c3NpbmcgaW4gUUVNVSdzIEFSTSBhcmNoaXRlY3R1cmUgZm9yIFdpbmRvd3MgZ3Vlc3Q/CgpNeSBl
bnZpcm9ubWVudGFsIGluZm9ybWF0aW9uOgpMaW51eCA1LjEwClFFTVUgNi4yLjAKR3Vlc3Q6IFdp
bmRvd3MxMSBBUk0KCgpRRU1VIGNvbW1hbmQgbGluZToKcWVtdS1zeXN0ZW0tYWFyY2g2NCAtbm9k
ZWZhdWx0cyAtbWFjaGluZSB2aXJ0LGtlcm5lbC1pcnFjaGlwPW9uLHZpcnR1YWxpemF0aW9uPW9m
ZixnaWMtdmVyc2lvbj0zLGl0cz1vZmYgLWFjY2VsIGt2bSAtY3B1IGhvc3QgLW0gNjE0NCAtc21w
IDYgLWJpb3MgL3Vzci9zaGFyZS9lZGsyL2FhcmNoNjQvUUVNVV9FRkktcGZsYXNoLnJhdyAtZHJp
dmUgaWY9bm9uZSxpZD1zeXN0ZW0sZm9ybWF0PXFjb3cyLGZpbGU9L2RhdGEvaW1hZ2VzL3dpbjEx
X2Rpc2sucWNvdzIgLWRldmljZSB2aXJ0aW8tYmxrLXBjaSxkcml2ZT1zeXN0ZW0gLWRldmljZSBu
ZWMtdXNiLXhoY2ksbXNpeD1vZmYsbXNpPW9mZiAtZGV2aWNlIHVzYi1rYmQgLWRldmljZSB1c2It
dGFibGV0IC1kZXZpY2UgcmFtZmIgLWRpc3BsYXkgZ3RrIC1uYW1lIFdpbmRvd3MgLXFtcCB1bml4
Oi90bXAvcW1wLnNvY2tldCxzZXJ2ZXIsbm93YWl0IC1kIGFsbCAtRCAvdG1wL3FlbXUubG9nIC1t
c2cgdGltZXN0YW1wPW9uIAoKClJlZmVyIHRvIHRoZSBGYXN0IHN0YXJ0dXAgbGluayBiZWxvdzoK
aHR0cHM6Ly9sZWFybi5taWNyb3NvZnQuY29tL2VuLXVzL3dpbmRvd3MtaGFyZHdhcmUvdGVzdC93
ZWcvZGVsaXZlcmluZy1hLWdyZWF0LXN0YXJ0dXAtYW5kLXNodXRkb3duLWV4cGVyaWVuY2UKCgpU
aGFuayB5b3UuClplbmdydWFuIFll
------=_Part_81548_14305477.1705390395296
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS43O2NvbG9yOiMwMDAwMDA7Zm9udC1zaXplOjE0cHg7
Zm9udC1mYW1pbHk6QXJpYWwiPjxwIHN0eWxlPSJtYXJnaW46MDsiPkhpLDwvcD48cCBzdHlsZT0i
d29yZC1icmVhazogYnJlYWstd29yZCAhaW1wb3J0YW50OyI+SSB3YW50IHRvIGltcHJvdmUgdGhl
IHN0YXJ0dXAgc3BlZWQgb2YgV2luZG93cyBWTS4gT24gdGhlIHg4NiBhcmNoaXRlY3R1cmUsIFFF
TVUncyBXaW5kb3dzMTEgVk0gY2FuIGVuYWJsZSB0aGUgRmFzdCBzdGFydHVwIGZ1bmN0aW9uLCBi
dXQgaXQgY2Fubm90IHdvcmsgb24gdGhlIEFSTSBhcmNoaXRlY3R1cmUuIEluIGFkZGl0aW9uLCBX
aW5kb3dzIGNhbiBhbHNvIGVuYWJsZSB0aGUgRmFzdCBzdGFydHVwIGZ1bmN0aW9uIG9uIHRoZSBB
Uk0gaG9zdC4mbmJzcDs8L3A+PHAgc3R5bGU9IndvcmQtYnJlYWs6IGJyZWFrLXdvcmQgIWltcG9y
dGFudDsiPklzIHRoZXJlIGFueXRoaW5nIG1pc3NpbmcgaW4gUUVNVSdzIEFSTSBhcmNoaXRlY3R1
cmUgZm9yIFdpbmRvd3MgZ3Vlc3Q/PC9wPjxkaXYgc3R5bGU9IndvcmQtYnJlYWs6IGJyZWFrLXdv
cmQgIWltcG9ydGFudDsiPk15IGVudmlyb25tZW50YWwgaW5mb3JtYXRpb246PC9kaXY+PGRpdiBz
dHlsZT0id29yZC1icmVhazogYnJlYWstd29yZCAhaW1wb3J0YW50OyI+TGludXggNS4xMDwvZGl2
PjxkaXYgc3R5bGU9IndvcmQtYnJlYWs6IGJyZWFrLXdvcmQgIWltcG9ydGFudDsiPlFFTVUgNi4y
LjA8L2Rpdj48ZGl2IHN0eWxlPSJ3b3JkLWJyZWFrOiBicmVhay13b3JkICFpbXBvcnRhbnQ7Ij5H
dWVzdDogV2luZG93czExIEFSTTwvZGl2PjxkaXYgc3R5bGU9IndvcmQtYnJlYWs6IGJyZWFrLXdv
cmQgIWltcG9ydGFudDsiPjxiciBzdHlsZT0id29yZC1icmVhazogYnJlYWstd29yZCAhaW1wb3J0
YW50OyI+PC9kaXY+PGRpdiBzdHlsZT0id29yZC1icmVhazogYnJlYWstd29yZCAhaW1wb3J0YW50
OyI+UUVNVSBjb21tYW5kIGxpbmU6PC9kaXY+PGRpdiBzdHlsZT0id29yZC1icmVhazogYnJlYWst
d29yZCAhaW1wb3J0YW50OyI+cWVtdS1zeXN0ZW0tYWFyY2g2NCAtbm9kZWZhdWx0cyAtbWFjaGlu
ZSB2aXJ0LGtlcm5lbC1pcnFjaGlwPW9uLHZpcnR1YWxpemF0aW9uPW9mZixnaWMtdmVyc2lvbj0z
LGl0cz1vZmYgLWFjY2VsIGt2bSAtY3B1IGhvc3QgLW0gNjE0NCAtc21wIDYgLWJpb3MgL3Vzci9z
aGFyZS9lZGsyL2FhcmNoNjQvUUVNVV9FRkktcGZsYXNoLnJhdyAtZHJpdmUgaWY9bm9uZSxpZD1z
eXN0ZW0sZm9ybWF0PXFjb3cyLGZpbGU9L2RhdGEvaW1hZ2VzL3dpbjExX2Rpc2sucWNvdzIgLWRl
dmljZSB2aXJ0aW8tYmxrLXBjaSxkcml2ZT1zeXN0ZW0gLWRldmljZSBuZWMtdXNiLXhoY2ksbXNp
eD1vZmYsbXNpPW9mZiAtZGV2aWNlIHVzYi1rYmQgLWRldmljZSB1c2ItdGFibGV0IC1kZXZpY2Ug
cmFtZmIgLWRpc3BsYXkgZ3RrIC1uYW1lIFdpbmRvd3MgLXFtcCB1bml4Oi90bXAvcW1wLnNvY2tl
dCxzZXJ2ZXIsbm93YWl0IC1kIGFsbCAtRCAvdG1wL3FlbXUubG9nIC1tc2cgdGltZXN0YW1wPW9u
Jm5ic3A7PC9kaXY+PGRpdiBzdHlsZT0id29yZC1icmVhazogYnJlYWstd29yZCAhaW1wb3J0YW50
OyI+PGJyIHN0eWxlPSJ3b3JkLWJyZWFrOiBicmVhay13b3JkICFpbXBvcnRhbnQ7Ij48L2Rpdj48
ZGl2IHN0eWxlPSJ3b3JkLWJyZWFrOiBicmVhay13b3JkICFpbXBvcnRhbnQ7Ij5SZWZlciB0byB0
aGUgRmFzdCBzdGFydHVwIGxpbmsgYmVsb3c6PC9kaXY+PGRpdiBzdHlsZT0id29yZC1icmVhazog
YnJlYWstd29yZCAhaW1wb3J0YW50OyI+PGEgX3NyYz0iaHR0cHM6Ly9sZWFybi5taWNyb3NvZnQu
Y29tL2VuLXVzL3dpbmRvd3MtaGFyZHdhcmUvdGVzdC93ZWcvZGVsaXZlcmluZy1hLWdyZWF0LXN0
YXJ0dXAtYW5kLXNodXRkb3duLWV4cGVyaWVuY2UiIGhyZWY9Imh0dHBzOi8vbGVhcm4ubWljcm9z
b2Z0LmNvbS9lbi11cy93aW5kb3dzLWhhcmR3YXJlL3Rlc3Qvd2VnL2RlbGl2ZXJpbmctYS1ncmVh
dC1zdGFydHVwLWFuZC1zaHV0ZG93bi1leHBlcmllbmNlIiBzdHlsZT0iY29sb3I6IHJnYig0MSwg
MTU4LCA4OSk7IHdvcmQtYnJlYWs6IGJyZWFrLXdvcmQgIWltcG9ydGFudDsiPmh0dHBzOi8vbGVh
cm4ubWljcm9zb2Z0LmNvbS9lbi11cy93aW5kb3dzLWhhcmR3YXJlL3Rlc3Qvd2VnL2RlbGl2ZXJp
bmctYS1ncmVhdC1zdGFydHVwLWFuZC1zaHV0ZG93bi1leHBlcmllbmNlPC9hPjwvZGl2PjxkaXYg
c3R5bGU9IndvcmQtYnJlYWs6IGJyZWFrLXdvcmQgIWltcG9ydGFudDsiPjxiciBzdHlsZT0id29y
ZC1icmVhazogYnJlYWstd29yZCAhaW1wb3J0YW50OyI+PC9kaXY+PGRpdiBzdHlsZT0id29yZC1i
cmVhazogYnJlYWstd29yZCAhaW1wb3J0YW50OyI+VGhhbmsgeW91LjwvZGl2PjxkaXYgc3R5bGU9
IndvcmQtYnJlYWs6IGJyZWFrLXdvcmQgIWltcG9ydGFudDsiPlplbmdydWFuIFllPC9kaXY+PGRp
diBzdHlsZT0icG9zaXRpb246cmVsYXRpdmU7em9vbToxIj48ZGl2IHN0eWxlPSJjbGVhcjpib3Ro
Ij48L2Rpdj48L2Rpdj48L2Rpdj4=
------=_Part_81548_14305477.1705390395296--


