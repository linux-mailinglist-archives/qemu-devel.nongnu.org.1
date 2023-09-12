Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D0C79D548
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 17:50:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg5d6-0002qN-T2; Tue, 12 Sep 2023 11:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qg5d4-0002pz-R2
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 11:48:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qg5d1-0005Zz-Fx
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 11:48:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694533717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3IGldxBfH68CFg9FGKJW4m9ne/VJK2zzCID5ax8z9+w=;
 b=dFQwDOiZL330mpMSKeRpFy0pdoNiGVAptKieadPdyxtXjh0LSgE8iYeXwRVcJs0b7Wyc7d
 jwvP5x9iv64yGomU1KsJ6ZfHLI3003BCPVnP1/R2sHxWGDe1JD2NJnQE/r04PDYX8ylUt+
 lLqr2CH1jP0WPtWymHzkZYBiWDlvd60=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-AOge-AF8OB-sOD3SXR_Fiw-1; Tue, 12 Sep 2023 11:48:32 -0400
X-MC-Unique: AOge-AF8OB-sOD3SXR_Fiw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A30893822565;
 Tue, 12 Sep 2023 15:48:28 +0000 (UTC)
Received: from lacos-laptop-9.usersys.redhat.com (unknown [10.39.193.227])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5777364671;
 Tue, 12 Sep 2023 15:48:27 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-trivial@nongnu.org
Subject: [PATCH] hw/i386/pc: fix code comment on cumulative flash size
Date: Tue, 12 Sep 2023 17:48:25 +0200
Message-Id: <20230912154825.81568-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

LSBUaGUgY29tbWVudCBpcyBpbmNvcnJlY3RseSBpbmRlbnRlZCAvIGZvcm1hdHRlZC4KCi0gVGhl
IGNvbW1lbnQgc3RhdGVzIGEgOE1CIGxpbWl0LCBldmVuIHRob3VnaCB0aGUgY29kZSBlbmZvcmNl
cyBhIDE2TUIKICBsaW1pdC4KCkJvdGggb2YgdGhlc2Ugd2FydHMgY29tZSBmcm9tIGNvbW1pdCAw
NjU3YzY1N2ViMzcgKCJody9pMzg2L3BjOiBhZGQgbWF4CmNvbWJpbmVkIGZ3IHNpemUgYXMgbWFj
aGluZSBjb25maWd1cmF0aW9uIG9wdGlvbiIsIDIwMjAtMTItMDkpOyBjbGVhbiB0aGVtCnVwLgoK
QXJndWFibHksIGl0J3MgYWxzbyBiZXR0ZXIgdG8gYmUgY29uc2lzdGVudCB3aXRoIHRoZSAiTWlC
IiB1bml0IHRoYXQgUUVNVQp1c2VzIG5vd2FkYXlzLgoKQ2M6ICJNaWNoYWVsIFMuIFRzaXJraW4i
IDxtc3RAcmVkaGF0LmNvbT4gKHN1cHBvcnRlcjpQQykKQ2M6IE1hcmNlbCBBcGZlbGJhdW0gPG1h
cmNlbC5hcGZlbGJhdW1AZ21haWwuY29tPiAoc3VwcG9ydGVyOlBDKQpDYzogUGFvbG8gQm9uemlu
aSA8cGJvbnppbmlAcmVkaGF0LmNvbT4gKG1haW50YWluZXI6WDg2IFRDRyBDUFVzKQpDYzogUmlj
aGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+IChtYWludGFpbmVy
Olg4NiBUQ0cgQ1BVcykKQ2M6IEVkdWFyZG8gSGFia29zdCA8ZWR1YXJkb0BoYWJrb3N0Lm5ldD4g
KG1haW50YWluZXI6WDg2IFRDRyBDUFVzKQpDYzogcWVtdS10cml2aWFsQG5vbmdudS5vcmcKRml4
ZXM6IDA2NTdjNjU3ZWIzNwpTaWduZWQtb2ZmLWJ5OiBMYXN6bG8gRXJzZWsgPGxlcnNla0ByZWRo
YXQuY29tPgotLS0KIGh3L2kzODYvcGMuYyB8IDEyICsrKysrKy0tLS0tLQogMSBmaWxlIGNoYW5n
ZWQsIDYgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9ody9pMzg2
L3BjLmMgYi9ody9pMzg2L3BjLmMKaW5kZXggNTQ4MzhjMGM0MTFkLi5kMDZiOGRhNDljYWUgMTAw
NjQ0Ci0tLSBhL2h3L2kzODYvcGMuYworKysgYi9ody9pMzg2L3BjLmMKQEAgLTE3NDYsMTIgKzE3
NDYsMTIgQEAgc3RhdGljIHZvaWQgcGNfbWFjaGluZV9zZXRfbWF4X2Z3X3NpemUoT2JqZWN0ICpv
YmosIFZpc2l0b3IgKnYsCiAgICAgfQogCiAgICAgLyoKLSAgICAqIFdlIGRvbid0IGhhdmUgYSB0
aGVvcmV0aWNhbGx5IGp1c3RpZmlhYmxlIGV4YWN0IGxvd2VyIGJvdW5kIG9uIHRoZSBiYXNlCi0g
ICAgKiBhZGRyZXNzIG9mIGFueSBmbGFzaCBtYXBwaW5nLiBJbiBwcmFjdGljZSwgdGhlIElPLUFQ
SUMgTU1JTyByYW5nZSBpcwotICAgICogWzB4RkVFMDAwMDAuLjB4RkVFMDEwMDBdIC0tIHNlZSBJ
T19BUElDX0RFRkFVTFRfQUREUkVTUyAtLSwgbGVhdmluZyBmcmVlCi0gICAgKiBvbmx5IDE4TUIt
NEtCIGJlbG93IDRHLiBGb3Igbm93LCByZXN0cmljdCB0aGUgY3VtdWxhdGl2ZSBtYXBwaW5nIHRv
IDhNQiBpbgotICAgICogc2l6ZS4KLSAgICAqLworICAgICAqIFdlIGRvbid0IGhhdmUgYSB0aGVv
cmV0aWNhbGx5IGp1c3RpZmlhYmxlIGV4YWN0IGxvd2VyIGJvdW5kIG9uIHRoZSBiYXNlCisgICAg
ICogYWRkcmVzcyBvZiBhbnkgZmxhc2ggbWFwcGluZy4gSW4gcHJhY3RpY2UsIHRoZSBJTy1BUElD
IE1NSU8gcmFuZ2UgaXMKKyAgICAgKiBbMHhGRUUwMDAwMC4uMHhGRUUwMTAwMF0gLS0gc2VlIElP
X0FQSUNfREVGQVVMVF9BRERSRVNTIC0tLCBsZWF2aW5nIGZyZWUKKyAgICAgKiBvbmx5IDE4TUIt
NEtCIGJlbG93IDRHLiBGb3Igbm93LCByZXN0cmljdCB0aGUgY3VtdWxhdGl2ZSBtYXBwaW5nIHRv
IDE2TWlCCisgICAgICogaW4gc2l6ZS4KKyAgICAgKi8KICAgICBpZiAodmFsdWUgPiAxNiAqIE1p
QikgewogICAgICAgICBlcnJvcl9zZXRnKGVycnAsCiAgICAgICAgICAgICAgICAgICAgIlVzZXIg
c3BlY2lmaWVkIG1heCBhbGxvd2VkIGZpcm13YXJlIHNpemUgJSIgUFJJdTY0ICIgaXMgIgo=


