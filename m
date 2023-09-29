Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4C47B2B38
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 07:31:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm65Q-0001QV-2Y; Fri, 29 Sep 2023 01:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm65G-0001I4-4o
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 01:30:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm65C-00014g-WA
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 01:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695965433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xu5f/12AdPBPzYXW/E3zFpwxIlVTPb1Ab2Mz0nukwHs=;
 b=SAUno1auXB01WNqFKhsgXlGlEcRz0MtbL4ZkihguWesw1iHJ5pm4ekrOFegthWCsFOapNY
 3I8dlmKapFCs/ys+WlPNG5TqKW6Rmd5bOwl9kib6GNuxIimd4KKTEOV/ec5E3mQLq3QNqv
 fSclkWHVI9GZZlG4K2ShfNRLmaGQWnw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-31-HEtBFt2xObqIifIW3alYsA-1; Fri, 29 Sep 2023 01:30:27 -0400
X-MC-Unique: HEtBFt2xObqIifIW3alYsA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E373101A550;
 Fri, 29 Sep 2023 05:30:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CCC5B40C6EBF;
 Fri, 29 Sep 2023 05:30:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 10D0721E6904; Fri, 29 Sep 2023 07:30:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,  qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org,  Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,  Nicholas Piggin
 <npiggin@gmail.com>
Subject: Re: [PATCH 2/8] pnv/psi: Clean up local variable shadowing
References: <20230918145850.241074-1-clg@kaod.org>
 <20230918145850.241074-3-clg@kaod.org>
 <01ba6d06-79ae-18a3-5835-a364cadbb9fd@linux.ibm.com>
 <752e55c4-0a81-3f7e-905e-53f89674dfdd@kaod.org>
Date: Fri, 29 Sep 2023 07:30:25 +0200
In-Reply-To: <752e55c4-0a81-3f7e-905e-53f89674dfdd@kaod.org>
 (=?utf-8?Q?=22C=C3=A9dric?= Le
 Goater"'s message of "Tue, 19 Sep 2023 11:03:11 +0200")
Message-ID: <874jjdlf66.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Q8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0BrYW9kLm9yZz4gd3JpdGVzOg0KDQo+IE9uIDkvMTkvMjMg
MDg6NTcsIEhhcnNoIFByYXRlZWsgQm9yYSB3cm90ZToNCj4+IE9uIDkvMTgvMjMgMjA6MjgsIEPD
qWRyaWMgTGUgR29hdGVyIHdyb3RlOg0KPj4+IHRvIGZpeCA6DQo+Pj4NCj4+PiDCoMKgIC4uL2h3
L3BwYy9wbnZfcHNpLmM6IEluIGZ1bmN0aW9uIOKAmHBudl9wc2lfcDlfbW1pb193cml0ZeKAmToN
Cj4+PiDCoMKgIC4uL2h3L3BwYy9wbnZfcHNpLmM6NzQxOjI0OiB3YXJuaW5nOiBkZWNsYXJhdGlv
biBvZiDigJhhZGRy4oCZIHNoYWRvd3MgYSBwYXJhbWV0ZXIgWy1Xc2hhZG93PWNvbXBhdGlibGUt
bG9jYWxdDQo+Pj4gwqDCoMKgwqAgNzQxIHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBod2FkZHIgYWRkciA9IHZhbCAmIH4oUFNJSEI5X0VTQl9DSV9WQUxJRCB8IFBTSUhCMTBfRVNC
X0NJXzY0Syk7DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBefn5+DQo+Pj4gwqDCoCAuLi9ody9wcGMvcG52X3BzaS5j
OjcwMjo1Njogbm90ZTogc2hhZG93ZWQgZGVjbGFyYXRpb24gaXMgaGVyZQ0KPj4+IMKgwqDCoMKg
IDcwMiB8IHN0YXRpYyB2b2lkIHBudl9wc2lfcDlfbW1pb193cml0ZSh2b2lkICpvcGFxdWUsIGh3
YWRkciBhZGRyLA0KPj4+IMKgwqDCoMKgwqDCoMKgwqAgfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB+fn5+fn5+Xn5+fg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogQ8Op
ZHJpYyBMZSBHb2F0ZXIgPGNsZ0BrYW9kLm9yZz4NCj4+PiAtLS0NCj4+PiDCoCBody9wcGMvcG52
X3BzaS5jIHwgNSArKystLQ0KPj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvaHcvcHBjL3Budl9wc2kuYyBi
L2h3L3BwYy9wbnZfcHNpLmMNCj4+PiBpbmRleCBkYWFhMmYwNTc1ZmQuLjI2NDYwZDIxMGRlYiAx
MDA2NDQNCj4+PiAtLS0gYS9ody9wcGMvcG52X3BzaS5jDQo+Pj4gKysrIGIvaHcvcHBjL3Budl9w
c2kuYw0KPj4+IEBAIC03MzgsOCArNzM4LDkgQEAgc3RhdGljIHZvaWQgcG52X3BzaV9wOV9tbWlv
X3dyaXRlKHZvaWQgKm9wYXF1ZSwgaHdhZGRyIGFkZHIsDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfQ0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB9IGVsc2Ugew0KPj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGlmICghKHBzaS0+cmVnc1tyZWddICYgUFNJSEI5X0VTQl9DSV9W
QUxJRCkpIHsNCj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGh3YWRkciBhZGRy
ID0gdmFsICYgfihQU0lIQjlfRVNCX0NJX1ZBTElEIHwgUFNJSEIxMF9FU0JfQ0lfNjRLKTsNCj4+
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1lbW9yeV9yZWdpb25fYWRkX3N1YnJl
Z2lvbihzeXNtZW0sIGFkZHIsDQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBo
d2FkZHIgZXNiX2FkZHIgPQ0KPj4NCj4+IFdoaWxlIGF0IGl0LCB3ZSBtYXkgd2FudCB0byBtb3Zl
IHRoZSBkZWNsYXJhdGlvbiB0byB0aGUgYmVnaW5uaW5nIG9mIHRoZSBmdW5jdGlvbi4gDQo+DQo+
IEkgYW0gbW9yZSBpbiBmYXZvciBvZiBkZWNsYXJpbmcgdGhlIHZhcmlhYmxlcyB3aGVyZSB0aGV5
IGFyZSBuZWVkZWQuDQo+IEkgdGhpbmsgaXQgaXMgYmV0dGVyIHByYXRpY2Ugc2luY2UgaXQgaWRl
bnRpZmllcyBhIGZ1bmN0aW9uYWwgYmxvY2sNCj4gd2hpY2ggY291bGQgYmUgbW92ZSBpbiBhIGV4
dGVybmFsIHJvdXRpbmUgYXQgc29tZSBwb2ludCBpZiBpdCBiZWNvbWVzDQo+IHRvbyBjb21wbGV4
Lg0KDQpJJ20gb2xkLWZhc2hpb25lZCBhbmQgcHJlZmVyIG15IGRlY2xhcmF0aW9ucyBpbiBvbmUg
cGxhY2UsIHdoZXJlIEkgY2FuDQpmaW5kIHRoZW0gZWFzaWx5LCBleGNlcHQgcGVyaGFwcyBmb3Ig
Zm9yLWxvb3AgY291bnRlcnMuICBJIHN1c3BlY3Qgd2hlbg0KYSBmdW5jdGlvbiBpcyBiaWcgZW5v
dWdoIHNvIHRoYXQgbW92aW5nIGRlY2xhcmF0aW9ucyB0byBpbm5lciBibG9ja3MNCmltcHJvdmVz
IGl0LCBmYWN0b3Jpbmcgb3V0IHRoZXNlIGlubmVyIGJsb2NrcyB3b3VsZCBpbXByb3ZlIGl0IG1v
cmUuDQoNCk15IG90aGVyIHJlYXNvbiBpcyB0aGUgcmlzayBmb3IgYWNjaWRlbnRhbCBzaGFkb3dp
bmcsIGJ1dCB1cyBlbmFibGluZw0KLVdzaGFkb3c9bG9jYWwgd2lsbCByZW5kZXIgdGhhdCBwb2lu
dCBtb290Lg0KDQpNYWludGFpbmVycyBnZXQgdG8gZGVjaWRlIHN1Y2ggbWF0dGVycyBvZiB0YXN0
ZSwgYW5kIEknbSBub3QgdGhlDQptYWludGFpbmVyIGhlcmUgOikNCg0KPj4gQW55d2F5cywNCj4+
IFJldmlld2VkLWJ5OiBIYXJzaCBQcmF0ZWVrIEJvcmEgPGhhcnNocGJAbGludXguaWJtLmNvbT4N
Cj4NCj4NCj4gVGhhbmtzLA0KPg0KPiBDLg0KPg0KPg0KPj4gDQo+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZhbCAmIH4oUFNJSEI5X0VTQl9DSV9WQUxJRCB8IFBT
SUhCMTBfRVNCX0NJXzY0Syk7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBt
ZW1vcnlfcmVnaW9uX2FkZF9zdWJyZWdpb24oc3lzbWVtLCBlc2JfYWRkciwNCj4+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJnBzaTktPnNvdXJjZS5lc2JfbW1pbyk7DQo+Pj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB9DQo=


