Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 196B482F063
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 15:16:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPkEC-0007Ns-W4; Tue, 16 Jan 2024 09:15:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yezengruan@126.com>)
 id 1rPdj0-0003Ek-MI; Tue, 16 Jan 2024 02:19:06 -0500
Received: from m15.mail.126.com ([45.254.50.223])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yezengruan@126.com>)
 id 1rPdix-0001vl-S8; Tue, 16 Jan 2024 02:19:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=68K3OiPyi1wmxbXKVPK6Rq2PpKH3K91k1PymycU+GYw=; b=m
 QhbGajgvTlFPi6EdNi5bfa9LHOKq0r9tnOu2dtoQYoUdSAoQdZ6npapXD8T+o49k
 dxtQX529Dyi+f8C3DO7g7AQF6vgzXW4FRs6E/LssdJDOg1NeNBHV1MJIdg/Tcwe5
 zKSobfyoMJYAFV3+lnUfv+N9GIZ8rmPAOfczyqa2qY=
Received: from yezengruan$126.com ( [119.3.118.251] ) by
 ajax-webmail-wmsvr-41-106 (Coremail) ; Tue, 16 Jan 2024 15:18:45 +0800
 (CST)
X-Originating-IP: [119.3.118.251]
Date: Tue, 16 Jan 2024 15:18:45 +0800 (CST)
From: =?UTF-8?B?5Y+25aKe6L2v?= <yezengruan@126.com>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org, qemu-arm@nongnu.org
Subject: =?UTF-8?Q?=E2=80=8B[Qemu-arm]_Windows_11_guest_Fast_startup_cannot_work?=
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 126com
X-NTES-SC: AL_Qu2bB/+Ttk0p4yaYYekfm04Qj+4/UMq1ufsk1IZSPJtwjDvj4gkRdHJOIlrt1dC1BBuGoRWaWzVW5OljY6x0fLAXbfecxhfQF2ME9KrcBLJ7iA==
Content-Type: multipart/alternative; 
 boundary="----=_Part_78125_1362291615.1705389525611"
MIME-Version: 1.0
Message-ID: <2b8a530a.4d83.18d11230a6c.Coremail.yezengruan@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: _____wD3fyLWLaZlIDcfAA--.35268W
X-CM-SenderInfo: p1h2v0pjuxt0a6rslhhfrp/1tbi5gRngGVLYZCwhQABsu
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=45.254.50.223; envelope-from=yezengruan@126.com;
 helo=m15.mail.126.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 URI_TRY_3LD=1.999 autolearn=no autolearn_force=no
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

------=_Part_78125_1362291615.1705389525611
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
------=_Part_78125_1362291615.1705389525611
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS43O2NvbG9yOiMwMDAwMDA7Zm9udC1zaXplOjE0cHg7
Zm9udC1mYW1pbHk6QXJpYWwiPjxwPkhpLDwvcD48cD5JIHdhbnQgdG8gaW1wcm92ZSB0aGUgc3Rh
cnR1cCBzcGVlZCBvZiBXaW5kb3dzIFZNLiBPbiB0aGUgeDg2IGFyY2hpdGVjdHVyZSwgUUVNVSdz
IFdpbmRvd3MxMSBWTSBjYW4gZW5hYmxlIHRoZSBGYXN0IHN0YXJ0dXAgZnVuY3Rpb24sIGJ1dCBp
dCBjYW5ub3Qgd29yayBvbiB0aGUgQVJNIGFyY2hpdGVjdHVyZS4gSW4gYWRkaXRpb24sIFdpbmRv
d3MgY2FuIGFsc28gZW5hYmxlIHRoZSBGYXN0IHN0YXJ0dXAgZnVuY3Rpb24gb24gdGhlIEFSTSBo
b3N0LiZuYnNwOzwvcD48cD5JcyB0aGVyZSBhbnl0aGluZyBtaXNzaW5nIGluIFFFTVUncyBBUk0g
YXJjaGl0ZWN0dXJlIGZvciBXaW5kb3dzIGd1ZXN0PzwvcD48ZGl2Pk15IGVudmlyb25tZW50YWwg
aW5mb3JtYXRpb246PC9kaXY+PGRpdj5MaW51eCA1LjEwPC9kaXY+PGRpdj5RRU1VIDYuMi4wPC9k
aXY+PGRpdj5HdWVzdDogV2luZG93czExIEFSTTwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+UUVN
VSBjb21tYW5kIGxpbmU6PC9kaXY+PGRpdj5xZW11LXN5c3RlbS1hYXJjaDY0IC1ub2RlZmF1bHRz
IC1tYWNoaW5lIHZpcnQsa2VybmVsLWlycWNoaXA9b24sdmlydHVhbGl6YXRpb249b2ZmLGdpYy12
ZXJzaW9uPTMsaXRzPW9mZiAtYWNjZWwga3ZtIC1jcHUgaG9zdCAtbSA2MTQ0IC1zbXAgNiAtYmlv
cyAvdXNyL3NoYXJlL2VkazIvYWFyY2g2NC9RRU1VX0VGSS1wZmxhc2gucmF3IC1kcml2ZSBpZj1u
b25lLGlkPXN5c3RlbSxmb3JtYXQ9cWNvdzIsZmlsZT0vZGF0YS9pbWFnZXMvd2luMTFfZGlzay5x
Y293MiAtZGV2aWNlIHZpcnRpby1ibGstcGNpLGRyaXZlPXN5c3RlbSAtZGV2aWNlIG5lYy11c2It
eGhjaSxtc2l4PW9mZixtc2k9b2ZmIC1kZXZpY2UgdXNiLWtiZCAtZGV2aWNlIHVzYi10YWJsZXQg
LWRldmljZSByYW1mYiAtZGlzcGxheSBndGsgLW5hbWUgV2luZG93cyAtcW1wIHVuaXg6L3RtcC9x
bXAuc29ja2V0LHNlcnZlcixub3dhaXQgLWQgYWxsIC1EIC90bXAvcWVtdS5sb2cgLW1zZyB0aW1l
c3RhbXA9b24mbmJzcDs8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlJlZmVyIHRvIHRoZSBGYXN0
IHN0YXJ0dXAgbGluayBiZWxvdzo8L2Rpdj48ZGl2PjxhIGhyZWY9Imh0dHBzOi8vbGVhcm4ubWlj
cm9zb2Z0LmNvbS9lbi11cy93aW5kb3dzLWhhcmR3YXJlL3Rlc3Qvd2VnL2RlbGl2ZXJpbmctYS1n
cmVhdC1zdGFydHVwLWFuZC1zaHV0ZG93bi1leHBlcmllbmNlIiBfc3JjPSJodHRwczovL2xlYXJu
Lm1pY3Jvc29mdC5jb20vZW4tdXMvd2luZG93cy1oYXJkd2FyZS90ZXN0L3dlZy9kZWxpdmVyaW5n
LWEtZ3JlYXQtc3RhcnR1cC1hbmQtc2h1dGRvd24tZXhwZXJpZW5jZSI+aHR0cHM6Ly9sZWFybi5t
aWNyb3NvZnQuY29tL2VuLXVzL3dpbmRvd3MtaGFyZHdhcmUvdGVzdC93ZWcvZGVsaXZlcmluZy1h
LWdyZWF0LXN0YXJ0dXAtYW5kLXNodXRkb3duLWV4cGVyaWVuY2U8L2E+PC9kaXY+PGRpdj48YnI+
PC9kaXY+PGRpdj5UaGFuayB5b3UuPC9kaXY+PGRpdj5aZW5ncnVhbiBZZTwvZGl2PjwvZGl2Pg==

------=_Part_78125_1362291615.1705389525611--


