Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD3278D6C1
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 16:59:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbMec-0001wG-T4; Wed, 30 Aug 2023 10:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=599fd62c5=graf@amazon.de>)
 id 1qbMea-0001vy-Nr; Wed, 30 Aug 2023 10:58:44 -0400
Received: from smtp-fw-52003.amazon.com ([52.119.213.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=599fd62c5=graf@amazon.de>)
 id 1qbMeW-0001nm-Tm; Wed, 30 Aug 2023 10:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1693407521; x=1724943521;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=r/HPMTJk6dp3XM/SXn8KqltP7i7cQN1WskDvy/MnlBE=;
 b=NT8C2WLuMZIS8SkZHJCLtbHmaylrntzgM/E+Aae5+BXxREGlBUy75UXk
 Xnxk45ofNJy1w+8zyt7pCaIsYwL9zLfUFB+WuASTU0tqzQ1L7igpKIFbS
 DLWx6CgDWjYPZLyfP2ZcihdTVVhLzFu1o6+6PXiMtgIgddLV7Pq7DRb9/ M=;
X-IronPort-AV: E=Sophos;i="6.02,214,1688428800"; d="scan'208";a="605174950"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-pdx-2c-m6i4x-fad5e78e.us-west-2.amazon.com) ([10.43.8.6])
 by smtp-border-fw-52003.iad7.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 14:58:35 +0000
Received: from EX19MTAUWC001.ant.amazon.com
 (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
 by email-inbound-relay-pdx-2c-m6i4x-fad5e78e.us-west-2.amazon.com (Postfix)
 with ESMTPS id 72505A0AAA; Wed, 30 Aug 2023 14:58:33 +0000 (UTC)
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 30 Aug 2023 14:58:33 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Wed, 30 Aug
 2023 14:58:30 +0000
Message-ID: <9fbdcca3-e965-4879-9695-84bc5785c16e@amazon.com>
Date: Wed, 30 Aug 2023 16:58:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] hw/vmapple/vmapple: Add vmapple machine type
Content-Language: en-GB
To: Bernhard Beschow <shentey@gmail.com>, <qemu-devel@nongnu.org>
CC: <qemu-block@nongnu.org>, <qemu-arm@nongnu.org>, Cameron Esfahani
 <dirty@apple.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20230614224038.86148-1-graf>
 <20230614225734.806-1-graf@amazon.com> <20230614225734.806-3-graf@amazon.com>
 <4854EBDC-AB24-45AD-A890-06382993F507@gmail.com>
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <4854EBDC-AB24-45AD-A890-06382993F507@gmail.com>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D037UWC004.ant.amazon.com (10.13.139.254) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Precedence: Bulk
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=52.119.213.152;
 envelope-from=prvs=599fd62c5=graf@amazon.de; helo=smtp-fw-52003.amazon.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Ck9uIDIwLjA2LjIzIDE5OjM1LCBCZXJuaGFyZCBCZXNjaG93IHdyb3RlOgo+Cj4KPiBBbSAxNC4g
SnVuaSAyMDIzIDIyOjU3OjM0IFVUQyBzY2hyaWViIEFsZXhhbmRlciBHcmFmIDxncmFmQGFtYXpv
bi5jb20+Ogo+PiBBcHBsZSBkZWZpbmVzIGEgbmV3ICJ2bWFwcGxlIiBtYWNoaW5lIHR5cGUgYXMg
cGFydCBvZiBpdHMgcHJvcHJpZXRhcnkKPj4gbWFjT1MgVmlydHVhbGl6YXRpb24uRnJhbWV3b3Jr
IHZtbS4gVGhpcyBtYWNoaW5lIHR5cGUgaXMgc2ltaWxhciB0byB0aGUKPj4gdmlydCBvbmUsIGJ1
dCB3aXRoIHN1YnRsZSBkaWZmZXJlbmNlcyBpbiBiYXNlIGRldmljZXMsIGEgZmV3IHNwZWNpYWwK
Pj4gdm1hcHBsZSBkZXZpY2UgYWRkaXRpb25zIGFuZCBhIHZhc3RseSBkaWZmZXJlbnQgYm9vdCBj
aGFpbi4KPj4KPj4gVGhpcyBwYXRjaCByZWltcGxlbWVudHMgdGhpcyBtYWNoaW5lIHR5cGUgaW4g
UUVNVS4gVG8gdXNlIGl0LCB5b3UKPj4gaGF2ZSB0byBoYXZlIGEgcmVhZGlseSBpbnN0YWxsZWQg
dmVyc2lvbiBvZiBtYWNPUyBmb3IgVk1BcHBsZSwKPj4gcnVuIG9uIG1hY09TIHdpdGggLWFjY2Vs
IGh2ZiwgcGFzcyB0aGUgVmlydHVhbGl6YXRpb24uRnJhbWV3b3JrCj4+IGJvb3Qgcm9tIChBVlBC
b290ZXIpIGluIHZpYSAtYmlvcywgcGFzcyB0aGUgYXV4IGFuZCByb290IHZvbHVtZSBhcyBwZmxh
c2gKPj4gYW5kIHBhc3MgYXV4IGFuZCByb290IHZvbHVtZSBhcyB2aXJ0aW8gZHJpdmVzLiBJbiBh
ZGRpdGlvbiwgeW91IGFsc28KPj4gbmVlZCB0byBmaW5kIHRoZSBtYWNoaW5lIFVVSUQgYW5kIHBh
c3MgdGhhdCBhcyAtTSB2bWFwcGxlLHV1aWQ9IHBhcmFtZXRlcjoKPj4KPj4gJCBxZW11LXN5c3Rl
bS1hYXJjaDY0IC1hY2NlbCBodmYgLU0gdm1hcHBsZSx1dWlkPTB4MTIzNCAtbSA0RyBcCj4+ICAg
ICAtYmlvcyAvU3lzdGVtL0xpYnJhcnkvRnJhbWV3b3Jrcy9WaXJ0dWFsaXphdGlvbi5mcmFtZXdv
cmsvVmVyc2lvbnMvQS9SZXNvdXJjZXMvQVZQQm9vdGVyLnZtYXBwbGUyLmJpbgo+PiAgICAgLWRy
aXZlIGZpbGU9YXV4LGlmPXBmbGFzaCxmb3JtYXQ9cmF3IFwKPj4gICAgIC1kcml2ZSBmaWxlPXJv
b3QsaWY9cGZsYXNoLGZvcm1hdD1yYXcgXAo+PiAgICAgLWRyaXZlIGZpbGU9YXV4LGlmPW5vbmUs
aWQ9YXV4LGZvcm1hdD1yYXcgXAo+PiAgICAgLWRldmljZSB2aXJ0aW8tYmxrLXBjaSxkcml2ZT1h
dXgseC1hcHBsZS10eXBlPTIgXAo+PiAgICAgLWRyaXZlIGZpbGU9cm9vdCxpZj1ub25lLGlkPXJv
b3QsZm9ybWF0PXJhdyBcCj4+ICAgICAtZGV2aWNlIHZpcnRpby1ibGstcGNpLGRyaXZlPXJvb3Qs
eC1hcHBsZS10eXBlPTEKPj4KPj4gV2l0aCBhbGwgdGhlc2UgaW4gcGxhY2UsIHlvdSBzaG91bGQg
YmUgYWJsZSB0byBzZWUgbWFjT1MgYm9vdGluZwo+PiBzdWNjZXNzZnVsbHkuCj4gVGhpcyBkb2N1
bWVudGF0aW9uIHNlZW1zIHZhbHVhYmxlIGZvciB0aGUgUUVNVSBtYW51YWwuIEJ1dCBBRkFJQ1Mg
dGhlcmUgaXMgbm8gZG9jdW1lbnRhdGlvbiBsaWtlIHRoaXMgYWRkZWQgdG8gdGhlIFFFTVUgbWFu
dWFsIGluIHRoaXMgc2VyaWVzLiBUaGlzIG1lYW5zIHRoYXQgaXQnbGwgZ2V0ICJsb3N0Ii4gSG93
IGFib3V0IGFkZGluZyBpdCwgcG9zc2libHkgaW4gdGhpcyBwYXRjaD8KCgpUaGFua3MsIEkgbG92
ZSB0aGUgaWRlYSA6KS4gTGV0IG1lIGRvIHRoYXQgZm9yIHYyIQoKCj4KPiBOb3RlIHRoYXQgSSdt
IG5vdCBhYmxlIHRvIHRlc3QgdGhpcyBzZXJpZXMuIEknbSBqdXN0IHNlZWluZyB0aGUgdmFsdWFi
bGUtaW5mb3JtYXRpb24taW4tdGhlLWNvbW1pdC1tZXNzYWdlLXdoaWNoLXdpbGwtZ2V0LWxvc3Qg
cGF0dGVybi4KPgo+PiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kZXIgR3JhZiA8Z3JhZkBhbWF6b24u
Y29tPgo+PiAtLS0KPj4gaHcvdm1hcHBsZS9LY29uZmlnICAgICB8ICAxOSArKwo+PiBody92bWFw
cGxlL21lc29uLmJ1aWxkIHwgICAxICsKPj4gaHcvdm1hcHBsZS92bWFwcGxlLmMgICB8IDY2MSAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+PiAzIGZpbGVzIGNoYW5n
ZWQsIDY4MSBpbnNlcnRpb25zKCspCj4+IGNyZWF0ZSBtb2RlIDEwMDY0NCBody92bWFwcGxlL3Zt
YXBwbGUuYwo+Pgo+PiBkaWZmIC0tZ2l0IGEvaHcvdm1hcHBsZS9LY29uZmlnIGIvaHcvdm1hcHBs
ZS9LY29uZmlnCj4+IGluZGV4IGJhMzdmYzViODEuLjdhMjM3NWRjOTUgMTAwNjQ0Cj4+IC0tLSBh
L2h3L3ZtYXBwbGUvS2NvbmZpZwo+PiArKysgYi9ody92bWFwcGxlL0tjb25maWcKPj4gQEAgLTks
MyArOSwyMiBAQCBjb25maWcgVk1BUFBMRV9DRkcKPj4KPj4gY29uZmlnIFZNQVBQTEVfUFZHCj4+
ICAgICAgYm9vbAo+PiArCj4+ICtjb25maWcgVk1BUFBMRQo+PiArICAgIGJvb2wKPj4gKyAgICBk
ZXBlbmRzIG9uIEFSTSAmJiBIVkYKPj4gKyAgICBkZWZhdWx0IHkgaWYgQVJNICYmIEhWRgo+PiAr
ICAgIGltcGx5IFBDSV9ERVZJQ0VTCj4+ICsgICAgc2VsZWN0IEFSTV9HSUMKPj4gKyAgICBzZWxl
Y3QgUExBVEZPUk1fQlVTCj4+ICsgICAgc2VsZWN0IFBDSV9FWFBSRVNTCj4+ICsgICAgc2VsZWN0
IFBDSV9FWFBSRVNTX0dFTkVSSUNfQlJJREdFCj4+ICsgICAgc2VsZWN0IFBMMDExICMgVUFSVAo+
PiArICAgIHNlbGVjdCBQTDAzMSAjIFJUQwo+PiArICAgIHNlbGVjdCBQTDA2MSAjIEdQSU8KPj4g
KyAgICBzZWxlY3QgR1BJT19QV1IKPj4gKyAgICBzZWxlY3QgUFZQQU5JQ19NTUlPCj4+ICsgICAg
c2VsZWN0IFZNQVBQTEVfQUVTCj4+ICsgICAgc2VsZWN0IFZNQVBQTEVfQkRJRgo+PiArICAgIHNl
bGVjdCBWTUFQUExFX0NGRwo+PiArICAgIHNlbGVjdCBWTUFQUExFX1BWRwo+PiBkaWZmIC0tZ2l0
IGEvaHcvdm1hcHBsZS9tZXNvbi5idWlsZCBiL2h3L3ZtYXBwbGUvbWVzb24uYnVpbGQKPj4gaW5k
ZXggMzFmZWM4NzE1Ni4uZDczMjg3M2QzNSAxMDA2NDQKPj4gLS0tIGEvaHcvdm1hcHBsZS9tZXNv
bi5idWlsZAo+PiArKysgYi9ody92bWFwcGxlL21lc29uLmJ1aWxkCj4+IEBAIC0yLDMgKzIsNCBA
QCBzb2Z0bW11X3NzLmFkZCh3aGVuOiAnQ09ORklHX1ZNQVBQTEVfQUVTJywgIGlmX3RydWU6IGZp
bGVzKCdhZXMuYycpKQo+PiBzb2Z0bW11X3NzLmFkZCh3aGVuOiAnQ09ORklHX1ZNQVBQTEVfQkRJ
RicsIGlmX3RydWU6IGZpbGVzKCdiZGlmLmMnKSkKPj4gc29mdG1tdV9zcy5hZGQod2hlbjogJ0NP
TkZJR19WTUFQUExFX0NGRycsICBpZl90cnVlOiBmaWxlcygnY2ZnLmMnKSkKPj4gc29mdG1tdV9z
cy5hZGQod2hlbjogJ0NPTkZJR19WTUFQUExFX1BWRycsICBpZl90cnVlOiBbZmlsZXMoJ2FwcGxl
LWdmeC5tJyksIHB2ZywgbWV0YWxdKQo+PiArc3BlY2lmaWNfc3MuYWRkKHdoZW46ICdDT05GSUdf
Vk1BUFBMRScsICAgICBpZl90cnVlOiBmaWxlcygndm1hcHBsZS5jJykpCj4+IGRpZmYgLS1naXQg
YS9ody92bWFwcGxlL3ZtYXBwbGUuYyBiL2h3L3ZtYXBwbGUvdm1hcHBsZS5jCj4+IG5ldyBmaWxl
IG1vZGUgMTAwNjQ0Cj4+IGluZGV4IDAwMDAwMDAwMDAuLjVkM2ZlNTRiOTYKPj4gLS0tIC9kZXYv
bnVsbAo+PiArKysgYi9ody92bWFwcGxlL3ZtYXBwbGUuYwo+PiBAQCAtMCwwICsxLDY2MSBAQAo+
PiArLyoKPj4gKyAqIFZNQXBwbGUgbWFjaGluZSBlbXVsYXRpb24KPj4gKyAqCj4+ICsgKiBDb3B5
cmlnaHQgwqkgMjAyMyBBbWF6b24uY29tLCBJbmMuIG9yIGl0cyBhZmZpbGlhdGVzLiBBbGwgUmln
aHRzIFJlc2VydmVkLgo+IElzIGFuICJBbGwgUmlnaHRzIFJlc2VydmVkIiB3b3JkaW5nIGNvbXBh
dGlibGUgd2l0aCB0aGUgR1BMPwoKCklBTkFMLiBZb3Ugd2lsbCBmaW5kIHRoZSBwYXR0ZXJuIGNv
bW1vbmx5IGFjcm9zcyB0aGUgY29kZSBiYXNlIGFscmVhZHkuIApNeSB1bmRlcnN0YW5kaW5nIGlz
IHRoYXQgYWxsIHJpZ2h0cyBhcmUgcmVzZXJ2ZWQsIGJ1dCBhZGRpdGlvbmFsbHkgSSAKZ3JhbnQg
eW91IHRoZSBwZXJtaXNzaW9ucyBvZiB0aGUgR1BMLgoKCkFsZXgKCgoKCgpBbWF6b24gRGV2ZWxv
cG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJsaW4KR2Vz
Y2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBKb25hdGhhbiBXZWlzcwpFaW5n
ZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMTQ5MTczIEIK
U2l0ejogQmVybGluClVzdC1JRDogREUgMjg5IDIzNyA4NzkKCgo=


