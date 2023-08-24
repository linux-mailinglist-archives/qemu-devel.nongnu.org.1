Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 879BB78718F
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 16:33:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZBNK-0001ve-KZ; Thu, 24 Aug 2023 10:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=593f49040=graf@amazon.de>)
 id 1qZBMr-0000m4-BP; Thu, 24 Aug 2023 10:31:27 -0400
Received: from smtp-fw-9105.amazon.com ([207.171.188.204])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=593f49040=graf@amazon.de>)
 id 1qZBMn-0000hT-PN; Thu, 24 Aug 2023 10:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1692887482; x=1724423482;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=6w+8mWoNt4ozVo6K0va273MaItcQds2dax7nU0GGhzk=;
 b=AwnV7itPkWzSbAk4otwZ21tYa4SPXnnWuAyo8FU/IDpk2V2EYy6O74hv
 vjVEKJy2oiDgi5dBfvGMhY6Yq9ML05YR8LMDaZ1wYr3anh3fAp+/pLza8
 JJi1jedW4lWe+a8ze/KAhl79QbQo84UZAH8T9mBiMCjzWjgYJzQ22tK0o c=;
X-IronPort-AV: E=Sophos;i="6.02,195,1688428800"; d="scan'208";a="668230450"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO
 email-inbound-relay-iad-1e-m6i4x-529f0975.us-east-1.amazon.com)
 ([10.25.36.210]) by smtp-border-fw-9105.sea19.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 14:31:10 +0000
Received: from EX19MTAUWC002.ant.amazon.com
 (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
 by email-inbound-relay-iad-1e-m6i4x-529f0975.us-east-1.amazon.com (Postfix)
 with ESMTPS id AB5EA4774D; Thu, 24 Aug 2023 14:31:05 +0000 (UTC)
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 24 Aug 2023 14:30:53 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 24 Aug
 2023 14:30:50 +0000
Message-ID: <3c29312a-9d5a-4f05-8123-1591de6e7207@amazon.com>
Date: Thu, 24 Aug 2023 16:30:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] hw/virtio: Add support for apple virtio-blk
Content-Language: en-GB
To: Kevin Wolf <kwolf@redhat.com>
CC: <qemu-devel@nongnu.org>, <qemu-block@nongnu.org>, <qemu-arm@nongnu.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <r.bolshakov@yadro.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Peter
 Maydell" <peter.maydell@linaro.org>
References: <20230614224038.86148-1-graf>
 <20230614225626.97734-1-graf@amazon.com> <ZIxMIyi1KY7Ku9Xm@redhat.com>
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <ZIxMIyi1KY7Ku9Xm@redhat.com>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D042UWB003.ant.amazon.com (10.13.139.135) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Precedence: Bulk
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.171.188.204;
 envelope-from=prvs=593f49040=graf@amazon.de; helo=smtp-fw-9105.amazon.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Ck9uIDE2LjA2LjIzIDEzOjQ4LCBLZXZpbiBXb2xmIHdyb3RlOgo+Cj4gQW0gMTUuMDYuMjAyMyB1
bSAwMDo1NiBoYXQgQWxleGFuZGVyIEdyYWYgZ2VzY2hyaWViZW46Cj4+IEFwcGxlIGhhcyBpdHMg
b3duIHZpcnRpby1ibGsgUENJIGRldmljZSBJRCB3aGVyZSBpdCBkZXZpYXRlcyBmcm9tIHRoZQo+
PiBvZmZpY2lhbCB2aXJ0aW8tcGNpIHNwZWMgc2xpZ2h0bHk6IEl0IHB1dHMgYSBuZXcgImFwcGxl
IHR5cGUiCj4+IGZpZWxkIGF0IGEgc3RhdGljIG9mZnNldCBpbiBjb25maWcgc3BhY2UgYW5kIGlu
dHJvZHVjZXMgYSBuZXcgZGlzY2FyZAo+PiBjb21tYW5kLgo+IEluIG90aGVyIHdvcmRzLCBpdCdz
IGEgZGlmZmVyZW50IGRldmljZS4gV2Ugc2hvdWxkbid0IHRyeSB0bwo+IGRpZmZlcmVudGlhdGUg
b25seSB3aXRoIGEgcHJvcGVydHksIGJ1dCBhY3R1YWxseSBtb2RlbCBpdCBhcyBhIHNlcGFyYXRl
Cj4gZGV2aWNlLgoKCkkgYWdyZWUgYW5kIGlzIHdoYXQgSSB0cmllZCBhdCBmaXJzdCwgYnV0IGhv
dyBkbyBJIGNoYW5nZSBiZWhhdmlvciBvZiBhIAp2aXJ0aW8tYmxrLXBjaSBzdWJjbGFzcyBhbGwg
dGhlIHdheSBkb3duIHRvIGl0cyB2aXJ0aW8tYmxrIAppbXBsZW1lbnRhdGlvbiB3aGljaCBsaXZl
cyBjb21wbGV0ZWx5IG91dHNpZGUgb2YgdGhlIHNjb3BlIG9mIHRoZSAKcmVzcGVjdGl2ZSBjbGFz
cz8KClRoZSBiZXN0IHRoaW5nIEkgY291bGQgY29tZSB1cCB3aXRoIHdhcyB0aGUgUUVNVSBpbnRl
cm5hbCBxb20gcHJvcGVydHkgCngtYXBwbGUtdHlwZS4gSGFwcHkgdG8gc3BsaXQgdGhlbTogTWFr
ZSB0aGUgY2hhbmdlIG9mIHZpcnRpby1ibGsgCmJlaGF2aW9yIGRlcGVuZCBvbiB0aGUgcHJvcGVy
dHkgYW5kIG1ha2UgYWxsIG9mIHRoZSBQQ0kgZGV2aWNlL3ZlbmRvciAKc3dhcHBpbmcgZGVwZW5k
IG9uIGEgbmV3IGNsYXNzIHdoaWNoIHRoZW4gc2V0cyB0aGUgeC1hcHBsZS10eXBlLgoKCj4KPj4g
VGhpcyBwYXRjaCBhZGRzIGEgbmV3IHFkZXYgcHJvcGVydHkgY2FsbGVkICJhcHBsZS10eXBlIiB0
byB2aXJ0aW8tYmxrLXBjaS4KPj4gV2hlbiB0aGF0IHByb3BlcnR5IGlzIHNldCwgd2UgYXNzdW1l
IHRoZSB2aXJ0aW8tYmxrIGRldmljZSBpcyBhbiBBcHBsZSBvbmUKPj4gb2YgdGhlIHNwZWNpZmlj
IHR5cGUgYW5kIGFjdCBhY2NvcmRpbmdseS4KPiBEbyB3ZSBoYXZlIGFueSBpbmZvcm1hdGlvbiBv
biB3aGF0IHRoZSBudW1iZXIgaW4gImFwcGxlLXR5cGUiIGFjdHVhbGx5Cj4gbWVhbnMgb3IgZG8g
d2UgaGF2ZSB0byB0cmVhdCBpdCBhcyBhIGJsYWNrIGJveD8KCgpJIGhhdmUgaWRlYXMsIGJ1dCBu
byBkb2N1bWVudGF0aW9uLiBJdCdzIGFuIGVudW0gc3BhY2UgdGhhdCBkZWZpbmVzIApkaWZmZXJl
bnQgdHlwZXMgb2YgZGV2aWNlcyAoQVVYIGRldmljZSwgcm9vdCBkZXZpY2UsIGV0YykKCgo+Cj4+
IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRlciBHcmFmIDxncmFmQGFtYXpvbi5jb20+Cj4+IC0tLQo+
PiAgIGh3L2Jsb2NrL3ZpcnRpby1ibGsuYyAgICAgICAgICAgICAgICAgICAgICAgfCAyMyArKysr
KysrKysrKysrKysrKysrKysKPj4gICBody92aXJ0aW8vdmlydGlvLWJsay1wY2kuYyAgICAgICAg
ICAgICAgICAgIHwgIDcgKysrKysrKwo+PiAgIGluY2x1ZGUvaHcvcGNpL3BjaV9pZHMuaCAgICAg
ICAgICAgICAgICAgICAgfCAgMSArCj4+ICAgaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLWJsay5o
ICAgICAgICAgICAgICB8ICAxICsKPj4gICBpbmNsdWRlL3N0YW5kYXJkLWhlYWRlcnMvbGludXgv
dmlydGlvX2Jsay5oIHwgIDMgKysrCj4+ICAgNSBmaWxlcyBjaGFuZ2VkLCAzNSBpbnNlcnRpb25z
KCspCj4+Cj4+IGRpZmYgLS1naXQgYS9ody9ibG9jay92aXJ0aW8tYmxrLmMgYi9ody9ibG9jay92
aXJ0aW8tYmxrLmMKPj4gaW5kZXggMzllN2YyM2ZhYi4uNzZiODViYjNjYiAxMDA2NDQKPj4gLS0t
IGEvaHcvYmxvY2svdmlydGlvLWJsay5jCj4+ICsrKyBiL2h3L2Jsb2NrL3ZpcnRpby1ibGsuYwo+
PiBAQCAtMTEyMCw2ICsxMTIwLDIwIEBAIHN0YXRpYyBpbnQgdmlydGlvX2Jsa19oYW5kbGVfcmVx
dWVzdChWaXJ0SU9CbG9ja1JlcSAqcmVxLCBNdWx0aVJlcUJ1ZmZlciAqbXJiKQo+Pgo+PiAgICAg
ICAgICAgYnJlYWs7Cj4+ICAgICAgIH0KPj4gKyAgICBjYXNlIFZJUlRJT19CTEtfVF9BUFBMRTE6
Cj4gQ2FuIHdlIGhhdmUgYSBtb3JlIGRlc2NyaXB0aXZlIG5hbWU/Cj4KPj4gKyAgICB7Cj4+ICsg
ICAgICAgIGlmIChzLT5jb25mLnhfYXBwbGVfdHlwZSkgewo+PiArICAgICAgICAgICAgLyogT25s
eSB2YWxpZCBvbiBBcHBsZSBWaXJ0aW8gKi8KPj4gKyAgICAgICAgICAgIGNoYXIgYnVmW2lvdl9z
aXplKGluX2lvdiwgaW5fbnVtKV07Cj4+ICsgICAgICAgICAgICBtZW1zZXQoYnVmLCAwLCBzaXpl
b2YoYnVmKSk7Cj4+ICsgICAgICAgICAgICBpb3ZfZnJvbV9idWYoaW5faW92LCBpbl9udW0sIDAs
IGJ1Ziwgc2l6ZW9mKGJ1ZikpOwo+PiArICAgICAgICAgICAgdmlydGlvX2Jsa19yZXFfY29tcGxl
dGUocmVxLCBWSVJUSU9fQkxLX1NfT0spOwo+IFNvIHRoaXMgaXMgYSBjb21tYW5kIHRoYXQgc2lt
cGx5IGZpbGxzIHRoZSBndWVzdCBidWZmZXIgd2l0aCB6ZXJvcwo+IHdpdGhvdXQgYWNjZXNzaW5n
IHRoZSBkaXNrIGNvbnRlbnQ/IFdlaXJkLCBidXQgb2ssIGlmIHRoYXQncyB3aGF0IHRoZXkKPiBh
cmUgZG9pbmcuLi4KPgo+IFRoZSBjb21taXQgbWVzc2FnZSB0YWxrcyBhYm91dCBhIGRpc2NhcmQg
Y29tbWFuZC4gSSB3b3VsZCBoYXZlIGV4cGVjdGVkCj4gYSBjb21tYW5kIHRoYXQgZGlzY2FyZHMv
dW5tYXBzIGRhdGEgZnJvbSB0aGUgZGlzay4gSSB0aGluayBpdCB3b3VsZCBiZQo+IGdvb2QgdG8g
Y2FsbCBpdCBzb21ldGhpbmcgZWxzZSBpbiB0aGUgY29tbWl0IG1lc3NhZ2UgaWYgaXQgaGFzIG5v
dGhpbmcKPiB0byBkbyB3aXRoIHRoaXMuCgoKWW91J3JlIGNvbXBsZXRlbHkgcmlnaHQuIEkgbG9v
a2VkIGl0IHVwIGFnYWluIGFuZCB0dXJucyBvdXQgdGhpcyBpcyAKYWN0dWFsbHkgYSBiYXJyaWVy
IGNvbW1hbmQuIEFueSBpZGVhcyBvbiBob3cgdG8gYmVzdCBpbXBsZW1lbnQgYW4gYWN0dWFsIApi
YXJyaWVyIGluIHZpcnRpby1ibGs/IE90aGVyd2lzZSBJJ2xsIGp1c3QgaWdub3JlIGl0IGFuZCBh
bHdheXMgcmV0dXJuIApTX09LLiBObyBuZWVkIGZvciB0aGUgbWVtc2V0IG11Y2tlcnkgYWJvdmUu
CgoKPgo+PiArICAgICAgICB9IGVsc2Ugewo+PiArICAgICAgICAgICAgdmlydGlvX2Jsa19yZXFf
Y29tcGxldGUocmVxLCBWSVJUSU9fQkxLX1NfVU5TVVBQKTsKPj4gKyAgICAgICAgfQo+PiArICAg
ICAgICB2aXJ0aW9fYmxrX2ZyZWVfcmVxdWVzdChyZXEpOwo+PiArICAgICAgICBicmVhazsKPj4g
KyAgICB9Cj4+ICAgICAgIGRlZmF1bHQ6Cj4+ICAgICAgICAgICB2aXJ0aW9fYmxrX3JlcV9jb21w
bGV0ZShyZXEsIFZJUlRJT19CTEtfU19VTlNVUFApOwo+PiAgICAgICAgICAgdmlydGlvX2Jsa19m
cmVlX3JlcXVlc3QocmVxKTsKPj4gQEAgLTEzNTEsNiArMTM2NSwxMCBAQCBzdGF0aWMgdm9pZCB2
aXJ0aW9fYmxrX3VwZGF0ZV9jb25maWcoVmlydElPRGV2aWNlICp2ZGV2LCB1aW50OF90ICpjb25m
aWcpCj4+ICAgICAgIH0gZWxzZSB7Cj4+ICAgICAgICAgICBibGtjZmcuem9uZWQubW9kZWwgPSBW
SVJUSU9fQkxLX1pfTk9ORTsKPj4gICAgICAgfQo+PiArICAgIGlmIChzLT5jb25mLnhfYXBwbGVf
dHlwZSkgewo+PiArICAgICAgICAvKiBBcHBsZSBhYnVzZXMgdGhlIHNhbWUgbG9jYXRpb24gZm9y
IGl0cyB0eXBlIGlkICovCj4+ICsgICAgICAgIGJsa2NmZy5tYXhfc2VjdXJlX2VyYXNlX3NlY3Rv
cnMgPSBzLT5jb25mLnhfYXBwbGVfdHlwZTsKPiBJZGVhbGx5LCBibGtjZmcgd291bGQgY29udGFp
biBhIHVuaW9uIHRoZXJlLiBTaW5jZSB0aGlzIGlzIGEgdHlwZQo+IGltcG9ydGVkIGZyb20gdGhl
IGtlcm5lbCwgd2UgY2FuJ3QgY2hhbmdlIGl0IGluc2lkZSBvZiBRRU1VIG9ubHkuIFdvcmtzCj4g
Zm9yIG1lIHdpdGggdGhpcyBjb21tZW50Lgo+Cj4+ICsgICAgfQo+PiAgICAgICBtZW1jcHkoY29u
ZmlnLCAmYmxrY2ZnLCBzLT5jb25maWdfc2l6ZSk7Cj4+ICAgfQo+Pgo+PiBAQCAtMTYyNSw2ICsx
NjQzLDEwIEBAIHN0YXRpYyB2b2lkIHZpcnRpb19ibGtfZGV2aWNlX3JlYWxpemUoRGV2aWNlU3Rh
dGUgKmRldiwgRXJyb3IgKiplcnJwKQo+Pgo+PiAgICAgICBzLT5jb25maWdfc2l6ZSA9IHZpcnRp
b19nZXRfY29uZmlnX3NpemUoJnZpcnRpb19ibGtfY2ZnX3NpemVfcGFyYW1zLAo+PiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcy0+aG9zdF9mZWF0dXJlcyk7
Cj4+ICsgICAgaWYgKHMtPmNvbmYueF9hcHBsZV90eXBlKSB7Cj4+ICsgICAgICAgIC8qIEFwcGxl
IFZpcnRpbyBwdXRzIHRoZSBibGsgdHlwZSBhdCAweDNjLCBtYWtlIHN1cmUgd2UgaGF2ZSBzcGFj
ZS4gKi8KPj4gKyAgICAgICAgcy0+Y29uZmlnX3NpemUgPSBNQVgocy0+Y29uZmlnX3NpemUsIDB4
M2QpOwo+PiArICAgIH0KPj4gICAgICAgdmlydGlvX2luaXQodmRldiwgVklSVElPX0lEX0JMT0NL
LCBzLT5jb25maWdfc2l6ZSk7Cj4+Cj4+ICAgICAgIHMtPmJsayA9IGNvbmYtPmNvbmYuYmxrOwo+
PiBAQCAtMTczNCw2ICsxNzU2LDcgQEAgc3RhdGljIFByb3BlcnR5IHZpcnRpb19ibGtfcHJvcGVy
dGllc1tdID0gewo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgY29uZi5tYXhfd3JpdGVfemVy
b2VzX3NlY3RvcnMsIEJEUlZfUkVRVUVTVF9NQVhfU0VDVE9SUyksCj4+ICAgICAgIERFRklORV9Q
Uk9QX0JPT0woIngtZW5hYmxlLXdjZS1pZi1jb25maWctd2NlIiwgVmlydElPQmxvY2ssCj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgY29uZi54X2VuYWJsZV93Y2VfaWZfY29uZmlnX3djZSwgdHJ1
ZSksCj4+ICsgICAgREVGSU5FX1BST1BfVUlOVDMyKCJ4LWFwcGxlLXR5cGUiLCBWaXJ0SU9CbG9j
aywgY29uZi54X2FwcGxlX3R5cGUsIDApLAo+IEluIGEgc2VwYXJhdGUgZGV2aWNlLCB0aGlzIHdv
dWxkIHByb2JhYmx5IGJlIGNhbGxlZCAiYXBwbGUtdHlwZSIKPiAod2l0aG91dCAieC0iKSBsaWtl
IHByb21pc2VkIGluIHRoZSBjb21taXQgbWVzc2FnZT8KPgo+IElmIG5vdCwgd2hhdCBpcyB0aGUg
cmVhc29uIGZvciBoYXZpbmcgYW4gIngtIiBwcmVmaXg/CgoKSSB3YW50ZWQgdG8gbWFrZSBpdCBj
bGVhciB0aGF0IHRoZSBwcm9wZXJ0eSBpcyBRRU1VIGludGVybmFsIGFuZCBub3QgdG8gCmJlIHVz
ZWQgYnkgYW55b25lIGV4dGVybmFsLgoKCkFsZXgKCgoKCgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2Vu
dGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1
ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBKb25hdGhhbiBXZWlzcwpFaW5nZXRyYWdlbiBh
bSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMTQ5MTczIEIKU2l0ejogQmVy
bGluClVzdC1JRDogREUgMjg5IDIzNyA4NzkKCgo=


