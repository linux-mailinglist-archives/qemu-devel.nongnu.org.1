Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF325784193
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 15:08:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYR6y-0004xn-GG; Tue, 22 Aug 2023 09:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=5918e560e=graf@amazon.de>)
 id 1qYR6w-0004xR-EF; Tue, 22 Aug 2023 09:07:54 -0400
Received: from smtp-fw-9106.amazon.com ([207.171.188.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=5918e560e=graf@amazon.de>)
 id 1qYR6t-0006d1-Jh; Tue, 22 Aug 2023 09:07:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1692709672; x=1724245672;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=XAoM68OTmHLHTVsf2NF/UQ9JdrVz9DQ1LGVJulEcurs=;
 b=R4eEutXr4hU4rwVVquQSDvbvUUmc+2aFRIKagjEtBXymn0vLKuH7iJnv
 KPvWgB/yiAf4ziRsYBXCk8Ggap+dlQQCFwJ1FU5PUU3BxVI2cRVVWuUHT
 z/A1kxC24GEeU8Lp+7kO6sQ8yAcQz7nywW/fiy/BTML9lbLol8fd9kXi3 E=;
X-IronPort-AV: E=Sophos;i="6.01,193,1684800000"; d="scan'208";a="666970357"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO
 email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com)
 ([10.25.36.210]) by smtp-border-fw-9106.sea19.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 13:07:38 +0000
Received: from EX19MTAUWA002.ant.amazon.com
 (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
 by email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com (Postfix)
 with ESMTPS id 3142B47654; Tue, 22 Aug 2023 13:07:33 +0000 (UTC)
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 22 Aug 2023 13:07:33 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 22 Aug
 2023 13:07:30 +0000
Message-ID: <d75f07d8-f39d-4653-a9fc-adb653d951fb@amazon.com>
Date: Tue, 22 Aug 2023 15:07:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] hw/vmapple/bdif: Introduce vmapple backdoor
 interface
Content-Language: en-GB
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
CC: <qemu-block@nongnu.org>, <qemu-arm@nongnu.org>, Cameron Esfahani
 <dirty@apple.com>, Roman Bolshakov <r.bolshakov@yadro.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Peter
 Maydell" <peter.maydell@linaro.org>
References: <20230614224038.86148-1-graf>
 <20230614225626.97734-1-graf@amazon.com>
 <20230614225626.97734-5-graf@amazon.com>
 <89105b1b-2c29-685c-3631-c5b0fa79962c@linaro.org>
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <89105b1b-2c29-685c-3631-c5b0fa79962c@linaro.org>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Precedence: Bulk
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.171.188.206;
 envelope-from=prvs=5918e560e=graf@amazon.de; helo=smtp-fw-9106.amazon.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
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

Ck9uIDE2LjA2LjIzIDEyOjM5LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToKPgo+IE9u
IDE1LzYvMjMgMDA6NTYsIEFsZXhhbmRlciBHcmFmIHdyb3RlOgo+PiBUaGUgVk1BcHBsZSBtYWNo
aW5lIGV4cG9zZXMgQVVYIGFuZCBST09UIGJsb2NrIGRldmljZXMgKGFzIHdlbGwgYXMgCj4+IFVT
QiBPVEcKPj4gZW11bGF0aW9uKSB2aWEgdmlydGlvLXBjaSBhcyB3ZWxsIGFzIGEgc3BlY2lhbCwg
c2ltcGxlIGJhY2tkb29yIHBsYXRmb3JtCj4+IGRldmljZS4KPj4KPj4gVGhpcyBwYXRjaCBpbXBs
ZW1lbnRzIHRoaXMgYmFja2Rvb3IgcGxhdGZvcm0gZGV2aWNlIHRvIHRoZSBiZXN0IG9mIG15Cj4+
IHVuZGVyc3RhbmRpbmcuIEkgbGVmdCBvdXQgYW55IFVTQiBPVEcgcGFydHM7IHRoZXkncmUgb25s
eSBuZWVkZWQgZm9yCj4+IGd1ZXN0IHJlY292ZXJ5IGFuZCBJIGRvbid0IHVuZGVyc3RhbmQgdGhl
IHByb3RvY29sIHlldC4KPj4KPj4gU2lnbmVkLW9mZi1ieTogQWxleGFuZGVyIEdyYWYgPGdyYWZA
YW1hem9uLmNvbT4KPj4gLS0tCj4+IMKgIGh3L3ZtYXBwbGUvS2NvbmZpZ8KgwqDCoMKgwqDCoMKg
IHzCoMKgIDIgKwo+PiDCoCBody92bWFwcGxlL2JkaWYuY8KgwqDCoMKgwqDCoMKgwqAgfCAyNDUg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPj4gwqAgaHcvdm1hcHBsZS9t
ZXNvbi5idWlsZMKgwqDCoCB8wqDCoCAxICsKPj4gwqAgaHcvdm1hcHBsZS90cmFjZS1ldmVudHPC
oMKgIHzCoMKgIDUgKwo+PiDCoCBpbmNsdWRlL2h3L3ZtYXBwbGUvYmRpZi5oIHzCoCAzMSArKysr
Kwo+Cj4gUGxlYXNlIGVuYWJsZSBzY3JpcHRzL2dpdC5vcmRlcmZpbGUgaWYgcG9zc2libGUuCgoK
U3VyZSwgaGFwcHkgdG8gOikKCgo+Cj4+ICsjZGVmaW5lIFJFR19ERVZJRF9NQVNLwqDCoMKgwqDC
oCAweGZmZmYwMDAwCj4+ICsjZGVmaW5lIERFVklEX1JPT1TCoMKgwqDCoMKgwqDCoMKgwqAgMHgw
MDAwMDAwMAo+PiArI2RlZmluZSBERVZJRF9BVVjCoMKgwqDCoMKgwqDCoMKgwqDCoCAweDAwMDEw
MDAwCj4+ICsjZGVmaW5lIERFVklEX1VTQsKgwqDCoMKgwqDCoMKgwqDCoMKgIDB4MDAxMDAwMDAK
Pj4gKwo+PiArI2RlZmluZSBSRUdfU1RBVFVTwqDCoMKgwqDCoMKgwqDCoMKgIDB4MAo+PiArI2Rl
ZmluZSBSRUdfU1RBVFVTX0FDVElWRcKgwqDCoMKgIEJJVCgwKQo+PiArI2RlZmluZSBSRUdfQ0ZH
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDB4NAo+PiArI2RlZmluZSBSRUdfQ0ZHX0FDVElWRcKg
wqDCoMKgwqDCoMKgIEJJVCgxKQo+PiArI2RlZmluZSBSRUdfVU5LMcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgMHg4Cj4+ICsjZGVmaW5lIFJFR19CVVNZwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAweDEw
Cj4+ICsjZGVmaW5lIFJFR19CVVNZX1JFQURZwqDCoMKgwqDCoMKgwqAgQklUKDApCj4+ICsjZGVm
aW5lIFJFR19VTksywqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAweDQwMAo+PiArI2RlZmluZSBSRUdf
Q01EwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDB4NDA4Cj4+ICsjZGVmaW5lIFJFR19ORVhUX0RF
VklDRcKgwqDCoMKgIDB4NDIwCj4+ICsjZGVmaW5lIFJFR19VTkszwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAweDQzNAo+Cj4KPj4gK3N0YXRpYyB1aW50NjRfdCBiZGlmX3JlYWQodm9pZCAqb3BhcXVl
LCBod2FkZHIgb2Zmc2V0LCB1bnNpZ25lZCBzaXplKQo+PiArewo+PiArwqDCoMKgIHVpbnQ2NF90
IHJldCA9IC0xOwo+PiArwqDCoMKgIHVpbnQ2NF90IGRldmlkID0gKG9mZnNldCAmIFJFR19ERVZJ
RF9NQVNLKTsKPj4gKwo+PiArwqDCoMKgIHN3aXRjaCAob2Zmc2V0ICYgflJFR19ERVZJRF9NQVNL
KSB7Cj4+ICvCoMKgwqAgY2FzZSBSRUdfU1RBVFVTOgo+PiArwqDCoMKgwqDCoMKgwqAgcmV0ID0g
UkVHX1NUQVRVU19BQ1RJVkU7Cj4+ICvCoMKgwqDCoMKgwqDCoCBicmVhazsKPj4gK8KgwqDCoCBj
YXNlIFJFR19DRkc6Cj4+ICvCoMKgwqDCoMKgwqDCoCByZXQgPSBSRUdfQ0ZHX0FDVElWRTsKPj4g
K8KgwqDCoMKgwqDCoMKgIGJyZWFrOwo+PiArwqDCoMKgIGNhc2UgUkVHX1VOSzE6Cj4+ICvCoMKg
wqDCoMKgwqDCoCByZXQgPSAweDQyMDsKPj4gK8KgwqDCoMKgwqDCoMKgIGJyZWFrOwo+PiArwqDC
oMKgIGNhc2UgUkVHX0JVU1k6Cj4+ICvCoMKgwqDCoMKgwqDCoCByZXQgPSBSRUdfQlVTWV9SRUFE
WTsKPj4gK8KgwqDCoMKgwqDCoMKgIGJyZWFrOwo+PiArwqDCoMKgIGNhc2UgUkVHX1VOSzI6Cj4+
ICvCoMKgwqDCoMKgwqDCoCByZXQgPSAweDE7Cj4+ICvCoMKgwqDCoMKgwqDCoCBicmVhazsKPj4g
K8KgwqDCoCBjYXNlIFJFR19VTkszOgo+PiArwqDCoMKgwqDCoMKgwqAgcmV0ID0gMHgwOwo+PiAr
wqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4+ICvCoMKgwqAgY2FzZSBSRUdfTkVYVF9ERVZJQ0U6Cj4+
ICvCoMKgwqDCoMKgwqDCoCBzd2l0Y2ggKGRldmlkKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCBjYXNl
IERFVklEX1JPT1Q6Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IDB4ODAwMDAwMDsK
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4+ICvCoMKgwqDCoMKgwqDCoCBjYXNl
IERFVklEX0FVWDoKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gMHgxMDAwMDsKPj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4+ICvCoMKgwqDCoMKgwqDCoCB9Cj4+ICvC
oMKgwqDCoMKgwqDCoCBicmVhazsKPj4gK8KgwqDCoCB9Cj4+ICsKPj4gK8KgwqDCoCB0cmFjZV9i
ZGlmX3JlYWQob2Zmc2V0LCBzaXplLCByZXQpOwo+PiArwqDCoMKgIHJldHVybiByZXQ7Cj4+ICt9
Cj4KPgo+PiArc3RhdGljIGNvbnN0IE1lbW9yeVJlZ2lvbk9wcyBiZGlmX29wcyA9IHsKPj4gK8Kg
wqDCoCAucmVhZCA9IGJkaWZfcmVhZCwKPj4gK8KgwqDCoCAud3JpdGUgPSBiZGlmX3dyaXRlLAo+
PiArwqDCoMKgIC5lbmRpYW5uZXNzID0gREVWSUNFX05BVElWRV9FTkRJQU4sCj4+ICvCoMKgwqAg
LnZhbGlkID0gewo+PiArwqDCoMKgwqDCoMKgwqAgLm1pbl9hY2Nlc3Nfc2l6ZSA9IDEsCj4+ICvC
oMKgwqDCoMKgwqDCoCAubWF4X2FjY2Vzc19zaXplID0gOCwKPj4gK8KgwqDCoCB9LAo+PiArwqDC
oMKgIC5pbXBsID0gewo+PiArwqDCoMKgwqDCoMKgwqAgLm1pbl9hY2Nlc3Nfc2l6ZSA9IDEsCj4+
ICvCoMKgwqDCoMKgwqDCoCAubWF4X2FjY2Vzc19zaXplID0gOCwKPgo+IElJVUMgeW91ciBpbXBs
ZW1lbnRhdGlvbiBpcyB1c2luZyAobWluLCBtYXgpID0gKDQsIDQpOgo+IGkuZS4gaWYgdGhlIGd1
ZXN0IGVtaXRzIGEgNjQtYml0IHJlYWQgYXQgb2Zmc2V0IDAsIHdlIHdhbnQgdG8gcmV0dXJuCj4g
Ym90aCBSRUdfU1RBVFVTL1JFR19DRkcgcmVnaXN0ZXJzLgoKCkkgZG9uJ3Qga25vdyBpZiB0aGUg
QkRJRiBkZXZpY2UgY2FycmllcyB0aG9zZSBzZW1hbnRpY3MuIFRvZGF5LCBJJ20gb25seSAKc2Vl
aW5nIDMyYml0IGFjY2Vzc2VzIHdoaWNoIGlzIHdoYXQgSSBjYW4gdm91Y2ggZm9yLiBXaWxsIDhi
aXQgYWNjZXNzZXMgCmdvIHRvIGEgZGlmZmVyZW50IHJlZ2lzdGVyIHNwYWNlIG9yIGp1c3QgYWNj
ZXNzIGEgc3Vic2V0IG9mIHRoZSAzMmJpdCAKcmVnaXN0ZXI/IEkgZG9uJ3Qga25vdyA6KQoKVGhl
IHNhbWUgYXBwbGllcyB0byA2NGJpdCBvbmVzLiBGb3IgYWxsIEkga25vdywgdGhleSBtaWdodCBh
cyB3ZWxsIGVuZCAKdXAgYXMgY29tcGxldGVseSBkaWZmZXJlbnQgcmVnaXN0ZXJzLgoKCkFsZXgK
CgoKCgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAz
OAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBK
b25hdGhhbiBXZWlzcwpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1
bnRlciBIUkIgMTQ5MTczIEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMjg5IDIzNyA4NzkKCgo=


