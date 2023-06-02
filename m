Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F1071F8E8
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 05:25:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4vOs-0006Ig-FF; Thu, 01 Jun 2023 23:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1q4vOp-0006HW-AR; Thu, 01 Jun 2023 23:24:23 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1q4vOl-00068q-7S; Thu, 01 Jun 2023 23:24:23 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwCHaJN5YHlko7DjAQ--.7949S2;
 Fri, 02 Jun 2023 11:22:33 +0800 (CST)
Received: from wangyuquan1236$phytium.com.cn ( [218.76.62.144] ) by
 ajax-webmail-mail (Coremail) ; Fri, 2 Jun 2023 11:24:11 +0800 (GMT+08:00)
X-Originating-IP: [218.76.62.144]
Date: Fri, 2 Jun 2023 11:24:11 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Yuquan Wang" <wangyuquan1236@phytium.com.cn>
To: "Leif Lindholm" <quic_llindhol@quicinc.com>
Cc: "Peter Maydell" <peter.maydell@linaro.org>,
 "Graeme Gregory" <graeme@xora.org.uk>, chenbaozi@phytium.com.cn,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH 1/1] hw/arm/sbsa-ref: use XHCI to replace EHCI
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230428(d6537451) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-76b96e3b-3ecc-44d5-9200-de81e6d4c242-
In-Reply-To: <ZHjcnHMWM9/Rl9lv@qc-i7.hemma.eciton.net>
References: <20230531070229.334124-1-wangyuquan1236@phytium.com.cn>
 <20230531070229.334124-2-wangyuquan1236@phytium.com.cn>
 <lfcmvvqjp64wngrdk33bvkb3k7op53l24lcoslah2evsyh3esc@at7jnsnrto7h>
 <CAFEAcA8h9-YWUYsvuERttmsEK3xi+K+xasFdoWmnFm26S6npNw@mail.gmail.com>
 <b663fb55-dc8e-9fd8-9d82-7e693c3c4ad3@quicinc.com>
 <CAFEAcA_9Prr1xV2s1q2+GpWEnrsEEFT57bbLDnop5Hw3MaxM0A@mail.gmail.com>
 <ZHjcnHMWM9/Rl9lv@qc-i7.hemma.eciton.net>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: WCIs42Zvb3Rlcl90eHQ9MTc4OTozODM=
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <20408f0d.c9.1887a225830.Coremail.wangyuquan1236@phytium.com.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwDHLCHbYHlkxEIAAA--.112W
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQASAWR47awBA
	wACsP
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
 1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7Zr1kAFW3urWftFWkuFy7Awb_yoW8ArWDpF
 W3Ga1FkF4DtFySvFZavw1FqF4YyF4xAF1rAwn8try0kFs0gFySgrWIkw1Y93Zxurn7Kr1j
 vrySyrW7Zrn8AF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=wangyuquan1236@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

SGksIExlaWYKCk9uIFRodSwgMSBKdW4gMjAyMyAxODo1OTo1NiArMDEwMCwgTGVpZiBMaW5kaG9s
bSB3cm90ZToKPiAKPiArQXJkCj4gCj4gT24gVGh1LCBKdW4gMDEsIDIwMjMgYXQgMTY6MDE6NDMg
KzAxMDAsIFBldGVyIE1heWRlbGwgd3JvdGU6Cj4gPiA+ID4+IEFsc28gaGFzIEVIQ0kgbmV2ZXIg
d29ya2VkLCBvciBoYXMgaXQgd29ya2VkIGluIHNvbWUgbW9kZXMgYW5kIHNvIHRoaXMKPiA+ID4g
Pj4gY2hhbmdlIHNob3VsZCBiZSB2ZXJzaW9uZWQ/Cj4gPiA+ID4KPiA+ID4gPiBBSVVJLCBFSENJ
IGhhcyBuZXZlciB3b3JrZWQgYW5kIGNhbiBuZXZlciBoYXZlIHdvcmtlZCwgYmVjYXVzZQo+ID4g
PiA+IHRoaXMgYm9hcmQncyBSQU0gaXMgYWxsIGFib3ZlIDRHIGFuZCB0aGUgUUVNVSBFSENJIGNv
bnRyb2xsZXIKPiA+ID4gPiBpbXBsZW1lbnRhdGlvbiBvbmx5IGFsbG93cyBETUEgZGVzY3JpcHRv
cnMgd2l0aCAzMi1iaXQgYWRkcmVzc2VzLgo+ID4gPiA+Cj4gPiA+ID4gTG9va2luZyBiYWNrIGF0
IHRoZSBhcmNoaXZlcywgaXQgc2VlbXMgd2UgZGlzY3Vzc2VkIFhIQ0kgdnMKPiA+ID4gPiBFSENJ
IHdoZW4gdGhlIHNic2EtcmVmIGJvYXJkIHdlbnQgaW4sIGFuZCB0aGUgY29uY2x1c2lvbiB3YXMK
PiA+ID4gPiB0aGF0IFhIQ0kgd291bGQgYmUgYmV0dGVyLiBCdXQgdGhlcmUgd2Fzbid0IGEgc3lz
YnVzIFhIQ0kgZGV2aWNlCj4gPiA+ID4gYXQgdGhhdCBwb2ludCwgc28gd2UgZW5kZWQgdXAgY29t
bWl0dGluZyB0aGUgc2JzYS1yZWYgYm9hcmQKPiA+ID4gPiB3aXRoIEVIQ0kgYW5kIGEgcGxhbiB0
byBzd2l0Y2ggdG8gWEhDSSB3aGVuIHRoZSBzeXNidXMteGhjaQo+ID4gPiA+IGRldmljZSB3YXMg
ZG9uZSwgd2hpY2ggd2UgdGhlbiBmb3Jnb3QgYWJvdXQ6Cj4gPiA+ID4gaHR0cHM6Ly9tYWlsLmdu
dS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtYXJtLzIwMTgtMTEvbXNnMDA2MzguaHRtbAo+ID4gPgo+
ID4gPiBBaCwgdGhhbmtzISBUaGF0IGV4cGxhaW5zIHdoeSB3ZSBkaWQgdGhlIHRoaW5nIHRoYXQg
bWFkZSBubyBzZW5zZSA6KQo+ID4gPgo+ID4gPiBUbyBza2lwIHRoZSBtaWdyYXRpb24gaGF6YXJk
LCBteSBwcmVmZXJuZWNlIGlzIHdlIGp1c3QgbGVhdmUgdGhlIEVIQ0kKPiA+ID4gZGV2aWNlIGlu
IGZvciBub3csIGFuZCBhZGQgYSBzZXBhcmF0ZSBYSENJIG9uIFBDSWUuIFdlIGNhbiBkcm9wIHRo
ZQo+ID4gPiBFSENJIGRldmljZSBhdCBzb21lIHBvaW50IGluIHRoZSBmdXR1cmUuCj4gPiAKPiA+
IFdoeSBQQ0llIGZvciB0aGUgWEhDSSBhbmQgbm90IHN5c2J1cz8gQXQgdGhlIHRpbWUgdGhlIGJv
YXJkCj4gPiB3YXMgb3JpZ2luYWxseSBhZGRlZCB0aGUgYXJndW1lbnQgd2FzIGluIGZhdm91ciBv
ZiB1c2luZwo+ID4gYSBzeXNidXMgVVNCIGNvbnRyb2xsZXIgKHlvdSBjYW4gc2VlIEFyZCBtYWtp
bmcgdGhhdCBwb2ludAo+ID4gaW4gdGhlIGxpbmtlZCBhcmNoaXZlIHRocmVhZCkuCj4gCj4gVGhl
IG9yaWdpbmFsIGFyZ3VtZW50IHdhcyB0aGF0IGhhdmluZyB0aGUgZGV2aWNlIG9uIHRoZSBzeXNi
dXMKPiAxKSBlbmFibGVkIGNvZGVwYXRocyB3ZSB3YW50ZWQgdG8gZXhlcmNpc2UgYW5kCgpTb3Jy
eSwgZm9yIG15IHBvb3IgZW5naW5lZXJpbmcgZXhwZXJpZW5jZSwgSSBhbSBjb25mdXNlZCBhYm91
dCB0aGUgbWVhbmluZyAKb2YgImVuYWJsZWQgY29kZXBhdGhzIiBoZXJlLiBJcyBpdCBsaWtlIGEg
Y29kZSB0YXJnZXQgdGhhdCB0byByZWFsaXplIHRoZSAKb3JpZ2luYWwgcHVycG9zZSBvZiB0aGlz
IGJvYXJkID8KCll1cXVhbgoKCgoKCg0KDQrkv6Hmga/lronlhajlo7DmmI7vvJrmnKzpgq7ku7bl
jIXlkKvkv6Hmga/lvZLlj5Hku7bkurrmiYDlnKjnu4Tnu4fmiYDmnIks5Y+R5Lu25Lq65omA5Zyo
57uE57uH5a+56K+l6YKu5Lu25oul5pyJ5omA5pyJ5p2D5Yip44CC6K+35o6l5pS26ICF5rOo5oSP
5L+d5a+GLOacque7j+WPkeS7tuS6uuS5pumdouiuuOWPryzkuI3lvpflkJHku7vkvZXnrKzkuInm
lrnnu4Tnu4flkozkuKrkurrpgI/pnLLmnKzpgq7ku7bmiYDlkKvkv6Hmga/jgIINCkluZm9ybWF0
aW9uIFNlY3VyaXR5IE5vdGljZTogVGhlIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBpbiB0aGlzIG1h
aWwgaXMgc29sZWx5IHByb3BlcnR5IG9mIHRoZSBzZW5kZXIncyBvcmdhbml6YXRpb24uVGhpcyBt
YWlsIGNvbW11bmljYXRpb24gaXMgY29uZmlkZW50aWFsLlJlY2lwaWVudHMgbmFtZWQgYWJvdmUg
YXJlIG9ibGlnYXRlZCB0byBtYWludGFpbiBzZWNyZWN5IGFuZCBhcmUgbm90IHBlcm1pdHRlZCB0
byBkaXNjbG9zZSB0aGUgY29udGVudHMgb2YgdGhpcyBjb21tdW5pY2F0aW9uIHRvIG90aGVycy4=


