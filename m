Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EA078E8F4
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 11:00:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbdWW-00087T-QD; Thu, 31 Aug 2023 04:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=600a63f8b=graf@amazon.de>)
 id 1qbdWU-00086S-Ce; Thu, 31 Aug 2023 04:59:30 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=600a63f8b=graf@amazon.de>)
 id 1qbdWO-0006Zb-QE; Thu, 31 Aug 2023 04:59:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1693472365; x=1725008365;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=rpZteB40Xc3krtDPWqABxcfQN04TYa31YJvNV2idAUQ=;
 b=iyNcLu6SkvpDBMOo41cC1Ln/CUpAfEVEiqSpXS2VUstdHNjgU/JkUwrI
 bBSCuYW/98ktV1Wp8YBF1vbuX1+xEkXnw6xHac6rRA4UXsmRJSUGohqpj
 TyC6uh9K3yS1Jt/UsQfoXmrYfbqqoJ1g0JCGpnAjZInMywzXiGsml8zuK A=;
X-IronPort-AV: E=Sophos;i="6.02,216,1688428800"; d="scan'208";a="302445613"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-pdx-2c-m6i4x-d2040ec1.us-west-2.amazon.com) ([10.43.8.6])
 by smtp-border-fw-33001.sea14.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 08:59:11 +0000
Received: from EX19MTAUWC002.ant.amazon.com
 (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
 by email-inbound-relay-pdx-2c-m6i4x-d2040ec1.us-west-2.amazon.com (Postfix)
 with ESMTPS id 1129C40DC2; Thu, 31 Aug 2023 08:59:09 +0000 (UTC)
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 31 Aug 2023 08:59:08 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Thu, 31 Aug
 2023 08:59:04 +0000
Message-ID: <6e98c4e8-89ea-4fd1-a6cf-e9cdcf043482@amazon.com>
Date: Thu, 31 Aug 2023 10:59:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] build: Only define OS_OBJECT_USE_OBJC with gcc
Content-Language: en-GB
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
CC: <qemu-block@nongnu.org>, <qemu-arm@nongnu.org>, Cameron Esfahani
 <dirty@apple.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S .
 Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Mads Ynddal" <mads@ynddal.dk>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Bernhard Beschow <shentey@gmail.com>, Gerd Hoffmann
 <kraxel@redhat.com>
References: <20230830161425.91946-1-graf@amazon.com>
 <20230830161425.91946-2-graf@amazon.com>
 <996b4057-6d64-3803-792b-f6c49dd9f3bf@linaro.org>
 <c933da5b-92fe-47f6-ade1-9c1e2770aa23@daynix.com>
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <c933da5b-92fe-47f6-ade1-9c1e2770aa23@daynix.com>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Precedence: Bulk
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.171.190.10;
 envelope-from=prvs=600a63f8b=graf@amazon.de; helo=smtp-fw-33001.amazon.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Ck9uIDMxLjA4LjIzIDEwOjUzLCBBa2loaWtvIE9kYWtpIHdyb3RlOgo+Cj4KPiBPbiAyMDIzLzA4
LzMxIDE3OjEyLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToKPj4gT24gMzAvOC8yMyAx
ODoxNCwgQWxleGFuZGVyIEdyYWYgd3JvdGU6Cj4+PiBSZWNlbnQgdmVyc2lvbnMgb2YgbWFjT1Mg
dXNlIGNsYW5nIGluc3RlYWQgb2YgZ2NjLiBUaGUgCj4+PiBPU19PQkpFQ1RfVVNFX09CSkMKPj4+
IGRlZmluZSBpcyBvbmx5IG5lY2Vzc2FyeSB3aGVuIGJ1aWxkaW5nIHdpdGggZ2NjLiBMZXQncyBu
b3QgZGVmaW5lIGl0IAo+Pj4gd2hlbgo+Pj4gYnVpbGRpbmcgd2l0aCBjbGFuZy4KPj4+Cj4+PiBX
aXRoIHRoaXMgcGF0Y2gsIEkgY2FuIHN1Y2Nlc3NmdWxseSBpbmNsdWRlIEdDRCBoZWFkZXJzIGlu
IFFFTVUgd2hlbgo+Pj4gYnVpbGRpbmcgd2l0aCBjbGFuZy4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5
OiBBbGV4YW5kZXIgR3JhZiA8Z3JhZkBhbWF6b24uY29tPgo+Pj4gLS0tCj4+PiDCoCBtZXNvbi5i
dWlsZCB8IDQgKysrLQo+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9tZXNvbi5idWlsZCBiL21lc29uLmJ1aWxk
Cj4+PiBpbmRleCA5OGU2OGVmMGIxLi4wZDZhMDAxNWExIDEwMDY0NAo+Pj4gLS0tIGEvbWVzb24u
YnVpbGQKPj4+ICsrKyBiL21lc29uLmJ1aWxkCj4+PiBAQCAtMjI0LDcgKzIyNCw5IEBAIHFlbXVf
bGRmbGFncyA9IFtdCj4+PiDCoCBpZiB0YXJnZXRvcyA9PSAnZGFyd2luJwo+Pj4gwqDCoMKgICMg
RGlzYWJsZSBhdHRlbXB0cyB0byB1c2UgT2JqZWN0aXZlQyBmZWF0dXJlcyBpbiBvcy9vYmplY3Qu
aCBzaW5jZQo+Pj4gdGhleQo+Pj4gwqDCoMKgICMgd29uJ3Qgd29yayB3aGVuIHdlJ3JlIGNvbXBp
bGluZyB3aXRoIGdjYyBhcyBhIEMgY29tcGlsZXIuCj4+PiAtwqAgcWVtdV9jb21tb25fZmxhZ3Mg
Kz0gJy1ET1NfT0JKRUNUX1VTRV9PQkpDPTAnCj4+PiArwqAgaWYgY29tcGlsZXIuZ2V0X2lkKCkg
PT0gJ2djYycKPj4+ICvCoMKgwqAgcWVtdV9jb21tb25fZmxhZ3MgKz0gJy1ET1NfT0JKRUNUX1VT
RV9PQkpDPTAnCj4+PiArwqAgZW5kaWYKPj4+IMKgIGVsaWYgdGFyZ2V0b3MgPT0gJ3NvbGFyaXMn
Cj4+PiDCoMKgwqAgIyBuZWVkZWQgZm9yIENNU0dfIG1hY3JvcyBpbiBzeXMvc29ja2V0LmgKPj4+
IMKgwqDCoCBxZW11X2NvbW1vbl9mbGFncyArPSAnLURfWE9QRU5fU09VUkNFPTYwMCcKPj4KPj4g
UmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4K
Pj4KPgo+IERlZmluaW5nIE9TX09CSkVDVF9VU0VfT0JKQyBkb2VzIG5vdCBsb29rIGxpa2UgYSBw
cm9wZXIgc29sdXRpb24uCj4gTG9va2luZyBhdCBvcy9vYmplY3QuaCwgaXQgc2VlbXMgT1NfT0JK
RUNUX1VTRV9PQkpDIGlzIGRlZmluZWQgYXMgMCB3aGVuOgo+ICFkZWZpbmVkKE9TX09CSkVDVF9I
QVZFX09CSkNfU1VQUE9SVCkgJiYgKCFkZWZpbmVkKF9fT0JKQ19fKSB8fAo+IGRlZmluZWQoX19P
QkpDX0dDX18pKQo+Cj4gVGhpcyBtZWFucyBPU19PQkpFQ1RfVVNFX09CSkMgaXMgYWx3YXlzIDAg
aWYgT2JqZWN0aXZlLUMgaXMgZGlzYWJsZWQuIEkKPiBhbHNvIGNvbmZpcm1lZCBvcy9vYmplY3Qu
aCB3aWxsIG5vdCB1c2UgT2JqZWN0aXZlLUMgZmVhdHVyZXMgd2hlbgo+IGNvbXBpbGVkIGFzIEMg
Y29kZSBvbiBjbGFuZyB3aXRoIHRoZSBmb2xsb3dpbmcgY29tbWFuZDoKPgo+IGNsYW5nIC1FIC14
IC1jIC0gPDxFT0YKPiAjaW5jbHVkZSA8b3Mvb2JqZWN0Lmg+Cj4gRU9GCj4KPiBJZiBjb21waWxh
dGlvbiBmYWlscyB3aXRoIEdDQyB3aGVuIG5vdCBkZWZpbmluZyBPU19PQkpFQ1RfVVNFX09CSkMs
IGl0Cj4gcHJvYmFibHkgbWVhbnMgR0NDIGluY29ycmVjdGx5IHRyZWF0cyBDIGNvZGUgYXMgT2Jq
ZWN0aXZlLUMgYW5kIHRoYXQgaXMKPiB0aGUgcHJvYmxlbSB3ZSBzaG91bGQgc29sdmUuIEkgY2Fu
bm90IGNvbmZpcm0gdGhpcyB0aGVvcnkgaG93ZXZlciBzaW5jZQo+IEkgaGF2ZSBvbmx5IGFuIEFw
cGxlIFNpbGljb24gTWFjIHRoYXQgaXMgaW5jb21wYXRpYmxlIHdpdGggR0NDLgoKCk15IHRha2Ug
b24gdGhpcyB3YXMgdG8gbWFrZSB0aGUgZ2NjIGhhY2sgYmUgYSAibGVnYWN5IiB0aGluZyB0aGF0
IHdlIHB1dCAKaW50byBpdHMgb3duIGNvcm5lciwgc28gdGhhdCBpbiBhIGZldyB5ZWFycyB3ZSBj
YW4ganVzdCBkcm9wIGl0IAphbHRvZ2V0aGVyLiBJIGRvbid0IHJlYWxseSB0aGluayBpdCdzIHdv
cnRoIHdhc3RpbmcgbXVjaCB0aW1lIG9uIHRoaXMgCndvcmthcm91bmQgYW5kIGl0cyBwb3RlbnRp
YWwgY29tcGF0aWJpbGl0eSB3aXRoIG9sZCBtYWNPUyB2ZXJzaW9ucy4KCgpBbGV4CgoKCgoKQW1h
em9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcg
QmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwgSm9uYXRoYW4g
V2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJC
IDE0OTE3MyBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDI4OSAyMzcgODc5CgoK


