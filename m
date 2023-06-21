Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 401A17384D7
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 15:21:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBxl9-00056e-PO; Wed, 21 Jun 2023 09:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=5293a3739=graf@amazon.de>)
 id 1qBxkx-00055Q-FX; Wed, 21 Jun 2023 09:20:20 -0400
Received: from smtp-fw-80006.amazon.com ([99.78.197.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=5293a3739=graf@amazon.de>)
 id 1qBxku-00036g-Eu; Wed, 21 Jun 2023 09:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1687353616; x=1718889616;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ChdMVO6hIeqzhzR+Fi2JW9s1dUepDYM/+ocHKejoxOs=;
 b=jb9/9S9EyJGORHzhPrOsCJmRnmdvSGmjJkVdjdf7HMsyB9NcqxT5I5Zt
 6+5UH4HLjqgnC3P9Fz3l8zStcdGHc2zSf9IPZUH+DWNyKPvGGiAbiLcqR
 85zCnJ083rEabTv8/bne9em4tipEQ4Kw/gaypzf5QvOW87Ga27QMvVFmA 4=;
X-IronPort-AV: E=Sophos;i="6.00,260,1681171200"; d="scan'208";a="222011390"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO
 email-inbound-relay-iad-1e-m6i4x-0aba4706.us-east-1.amazon.com)
 ([10.25.36.210]) by smtp-border-fw-80006.pdx80.corp.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 13:20:08 +0000
Received: from EX19MTAUWA002.ant.amazon.com
 (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
 by email-inbound-relay-iad-1e-m6i4x-0aba4706.us-east-1.amazon.com (Postfix)
 with ESMTPS id 8CED5A31BA; Wed, 21 Jun 2023 13:20:04 +0000 (UTC)
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 21 Jun 2023 13:20:02 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Wed, 21 Jun
 2023 13:19:59 +0000
Message-ID: <cc7e16c0-da7d-a494-0354-9c5ca4718d3e@amazon.com>
Date: Wed, 21 Jun 2023 15:19:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 03/12] hvf: Increase number of possible memory slots
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
CC: <qemu-block@nongnu.org>, <qemu-arm@nongnu.org>, Cameron Esfahani
 <dirty@apple.com>, Roman Bolshakov <r.bolshakov@yadro.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Peter
 Maydell" <peter.maydell@linaro.org>
References: <20230614224038.86148-1-graf@amazon.com>
 <20230614224038.86148-4-graf@amazon.com>
 <7f606624-7744-6c1f-c5bb-fb62f4e65495@linaro.org>
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <7f606624-7744-6c1f-c5bb-fb62f4e65495@linaro.org>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D042UWB002.ant.amazon.com (10.13.139.175) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Precedence: Bulk
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=99.78.197.217;
 envelope-from=prvs=5293a3739=graf@amazon.de; helo=smtp-fw-80006.amazon.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.093,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

SGkgUGhpbGlwcGUsCgoKT24gMTYuMDYuMjMgMTI6MjgsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOp
IHdyb3RlOgoKPgo+IE9uIDE1LzYvMjMgMDA6NDAsIEFsZXhhbmRlciBHcmFmIHdyb3RlOgo+PiBG
b3IgUFZHIHdlIHdpbGwgbmVlZCBtb3JlIHRoYW4gdGhlIGN1cnJlbnQgMzIgcG9zc2libGUgbWVt
b3J5IHNsb3RzLgo+PiBCdW1wIHRoZSBsaW1pdCB0byA1MTIgaW5zdGVhZC4KPj4KPj4gU2lnbmVk
LW9mZi1ieTogQWxleGFuZGVyIEdyYWYgPGdyYWZAYW1hem9uLmNvbT4KPj4gLS0tCj4+IMKgIGFj
Y2VsL2h2Zi9odmYtYWNjZWwtb3BzLmMgfCAyICstCj4+IMKgIGluY2x1ZGUvc3lzZW11L2h2Zl9p
bnQuaMKgIHwgMiArLQo+PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2FjY2VsL2h2Zi9odmYtYWNjZWwtb3BzLmMg
Yi9hY2NlbC9odmYvaHZmLWFjY2VsLW9wcy5jCj4+IGluZGV4IDljM2RhMDNjOTQuLmJmMGNhYWE4
NTIgMTAwNjQ0Cj4+IC0tLSBhL2FjY2VsL2h2Zi9odmYtYWNjZWwtb3BzLmMKPj4gKysrIGIvYWNj
ZWwvaHZmL2h2Zi1hY2NlbC1vcHMuYwo+PiBAQCAtODgsNyArODgsNyBAQCBzdHJ1Y3QgbWFjX3Ns
b3Qgewo+PiDCoMKgwqDCoMKgIHVpbnQ2NF90IGd2YTsKPj4gwqAgfTsKPj4KPj4gLXN0cnVjdCBt
YWNfc2xvdCBtYWNfc2xvdHNbMzJdOwo+PiArc3RydWN0IG1hY19zbG90IG1hY19zbG90c1s1MTJd
Owo+Pgo+PiDCoCBzdGF0aWMgaW50IGRvX2h2Zl9zZXRfbWVtb3J5KGh2Zl9zbG90ICpzbG90LCBo
dl9tZW1vcnlfZmxhZ3NfdCBmbGFncykKPj4gwqAgewo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9z
eXNlbXUvaHZmX2ludC5oIGIvaW5jbHVkZS9zeXNlbXUvaHZmX2ludC5oCj4+IGluZGV4IDZhYjEx
OWU0OWYuLmM3NjIzYTJjMDkgMTAwNjQ0Cj4+IC0tLSBhL2luY2x1ZGUvc3lzZW11L2h2Zl9pbnQu
aAo+PiArKysgYi9pbmNsdWRlL3N5c2VtdS9odmZfaW50LmgKPj4gQEAgLTQwLDcgKzQwLDcgQEAg
dHlwZWRlZiBzdHJ1Y3QgaHZmX3ZjcHVfY2FwcyB7Cj4+Cj4+IMKgIHN0cnVjdCBIVkZTdGF0ZSB7
Cj4+IMKgwqDCoMKgwqAgQWNjZWxTdGF0ZSBwYXJlbnQ7Cj4+IC3CoMKgwqAgaHZmX3Nsb3Qgc2xv
dHNbMzJdOwo+PiArwqDCoMKgIGh2Zl9zbG90IHNsb3RzWzUxMl07Cj4+IMKgwqDCoMKgwqAgaW50
IG51bV9zbG90czsKPj4KPj4gwqDCoMKgwqDCoCBodmZfdmNwdV9jYXBzICpodmZfY2FwczsKPgo+
IFBsZWFzZSBhZGQgYSBkZWZpbml0aW9uIGluIHRoaXMgaGVhZGVyICh1c2luZyBpbiBvcHMuYyku
CgoKSGFwcHkgdG8gOikKCgo+Cj4gSW4gb3JkZXIgdG8gc2F2ZSBtZW1vcnkgYW5kIHdvb2RzLCB3
aGF0IGFib3V0IGtlZXBpbmcKPiAzMiBvbiB4ODYgYW5kIG9ubHkgcmFpc2luZyB0byA1MTIgb24g
YXJtPwoKCkkgYW0gaG9waW5nIHRoYXQgc29tZW9uZSB0YWtlcyB0aGUgYXBwbGUtZ2Z4IGRyaXZl
ciBhbmQgZW5hYmxlcyBpdCBmb3IgCng4NiBhcyB3ZWxsLCBzbyBJJ2QgcmF0aGVyIGtlZXAgdGhl
bSBjb25zaXN0ZW50LgoKQWxleAoKCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55
IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hy
aXN0aWFuIFNjaGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmlj
aHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDE0OTE3MyBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6
IERFIDI4OSAyMzcgODc5CgoK


