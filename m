Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A3F79D56D
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 17:57:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg5kG-00067z-9I; Tue, 12 Sep 2023 11:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qg5kB-00067e-9x
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 11:56:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qg5k8-0007xI-Uq
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 11:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694534160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=vLiTQI2ctp7aBuz8sVg5RitrZJwufaJgbCFj8rPDCNA=;
 b=QVAFs+U4rpC40XVHOcbb51MyANqP9kuUHHlZVQ1ZCqhA9vnOFv7jZkkzm9mprTk/GZieUP
 S7k1eFMaWZowaH72zXjrVgSz04VPUbIw/zrY/sIV69U/AicKSmx6eK3hSM+8xJQzO25wXa
 13jpHZg6KnCf0o7XWeEh5YGrBVUJoKM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-LSEM45LkMWuh4VggqH1s5w-1; Tue, 12 Sep 2023 11:55:56 -0400
X-MC-Unique: LSEM45LkMWuh4VggqH1s5w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E2168019DC;
 Tue, 12 Sep 2023 15:55:56 +0000 (UTC)
Received: from lacos-laptop-9.usersys.redhat.com (unknown [10.39.193.227])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B5C2C10F1BE7;
 Tue, 12 Sep 2023 15:55:54 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu-devel@nongnu.org,
	lersek@redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-trivial@nongnu.org
Subject: [PATCH v2] hw/i386/pc: fix code comment on cumulative flash size
Date: Tue, 12 Sep 2023 17:55:53 +0200
Message-Id: <20230912155553.82514-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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
QXJndWFibHksIGl0J3MgYWxzbyBiZXR0ZXIgdG8gYmUgY29uc2lzdGVudCB3aXRoIHRoZSBiaW5h
cnkgdW5pdHMgKHN1Y2ggYXMKIk1pQiIpIHRoYXQgUUVNVSB1c2VzIG5vd2FkYXlzLgoKQ2M6ICJN
aWNoYWVsIFMuIFRzaXJraW4iIDxtc3RAcmVkaGF0LmNvbT4gKHN1cHBvcnRlcjpQQykKQ2M6IE1h
cmNlbCBBcGZlbGJhdW0gPG1hcmNlbC5hcGZlbGJhdW1AZ21haWwuY29tPiAoc3VwcG9ydGVyOlBD
KQpDYzogUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4gKG1haW50YWluZXI6WDg2
IFRDRyBDUFVzKQpDYzogUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFy
by5vcmc+IChtYWludGFpbmVyOlg4NiBUQ0cgQ1BVcykKQ2M6IEVkdWFyZG8gSGFia29zdCA8ZWR1
YXJkb0BoYWJrb3N0Lm5ldD4gKG1haW50YWluZXI6WDg2IFRDRyBDUFVzKQpDYzogcWVtdS10cml2
aWFsQG5vbmdudS5vcmcKRml4ZXM6IDA2NTdjNjU3ZWIzNwpTaWduZWQtb2ZmLWJ5OiBMYXN6bG8g
RXJzZWsgPGxlcnNla0ByZWRoYXQuY29tPgotLS0KCk5vdGVzOgogICAgdjI6CiAgICAKICAgIC0g
dXNlIHRoZSBiaW5hcnkgdW5pdHMgTWlCLCBLaUIsIEdpQiBjb21wcmVoZW5zaXZlbHkgaW4gdGhl
IGNvbW1lbnQKCiBody9pMzg2L3BjLmMgfCAxMiArKysrKystLS0tLS0KIDEgZmlsZSBjaGFuZ2Vk
LCA2IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9w
Yy5jIGIvaHcvaTM4Ni9wYy5jCmluZGV4IDU0ODM4YzBjNDExZC4uMGI2NDJlOGFmNTkwIDEwMDY0
NAotLS0gYS9ody9pMzg2L3BjLmMKKysrIGIvaHcvaTM4Ni9wYy5jCkBAIC0xNzQ2LDEyICsxNzQ2
LDEyIEBAIHN0YXRpYyB2b2lkIHBjX21hY2hpbmVfc2V0X21heF9md19zaXplKE9iamVjdCAqb2Jq
LCBWaXNpdG9yICp2LAogICAgIH0KIAogICAgIC8qCi0gICAgKiBXZSBkb24ndCBoYXZlIGEgdGhl
b3JldGljYWxseSBqdXN0aWZpYWJsZSBleGFjdCBsb3dlciBib3VuZCBvbiB0aGUgYmFzZQotICAg
ICogYWRkcmVzcyBvZiBhbnkgZmxhc2ggbWFwcGluZy4gSW4gcHJhY3RpY2UsIHRoZSBJTy1BUElD
IE1NSU8gcmFuZ2UgaXMKLSAgICAqIFsweEZFRTAwMDAwLi4weEZFRTAxMDAwXSAtLSBzZWUgSU9f
QVBJQ19ERUZBVUxUX0FERFJFU1MgLS0sIGxlYXZpbmcgZnJlZQotICAgICogb25seSAxOE1CLTRL
QiBiZWxvdyA0Ry4gRm9yIG5vdywgcmVzdHJpY3QgdGhlIGN1bXVsYXRpdmUgbWFwcGluZyB0byA4
TUIgaW4KLSAgICAqIHNpemUuCi0gICAgKi8KKyAgICAgKiBXZSBkb24ndCBoYXZlIGEgdGhlb3Jl
dGljYWxseSBqdXN0aWZpYWJsZSBleGFjdCBsb3dlciBib3VuZCBvbiB0aGUgYmFzZQorICAgICAq
IGFkZHJlc3Mgb2YgYW55IGZsYXNoIG1hcHBpbmcuIEluIHByYWN0aWNlLCB0aGUgSU8tQVBJQyBN
TUlPIHJhbmdlIGlzCisgICAgICogWzB4RkVFMDAwMDAuLjB4RkVFMDEwMDBdIC0tIHNlZSBJT19B
UElDX0RFRkFVTFRfQUREUkVTUyAtLSwgbGVhdmluZyBmcmVlCisgICAgICogb25seSAxOE1pQi00
S2lCIGJlbG93IDRHaUIuIEZvciBub3csIHJlc3RyaWN0IHRoZSBjdW11bGF0aXZlIG1hcHBpbmcg
dG8KKyAgICAgKiAxNk1pQiBpbiBzaXplLgorICAgICAqLwogICAgIGlmICh2YWx1ZSA+IDE2ICog
TWlCKSB7CiAgICAgICAgIGVycm9yX3NldGcoZXJycCwKICAgICAgICAgICAgICAgICAgICAiVXNl
ciBzcGVjaWZpZWQgbWF4IGFsbG93ZWQgZmlybXdhcmUgc2l6ZSAlIiBQUkl1NjQgIiBpcyAiCg==


