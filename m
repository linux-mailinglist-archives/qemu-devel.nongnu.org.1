Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF1A78A0FA
	for <lists+qemu-devel@lfdr.de>; Sun, 27 Aug 2023 20:30:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaKWN-0007BL-K3; Sun, 27 Aug 2023 14:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qaKWM-0007AL-HZ
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 14:29:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qaKWK-0004aX-Bg
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 14:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693160995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lwaMSqYe72AEbSUbo5vzdhBR/K5NGhaziDnR7j1YsG0=;
 b=OJXvoI+31zpMxTkt2aJT0LVIhOwT05K8j1cdAeTXmfnyiYikPYBC22N7Xr4xhfnk4lX5lR
 4ea4Px5o5aoFTBre9Td3e3fwNNiZE/esdhzZF64zjTrC7G7DU/0xzMPD0WK/AhB54krlR1
 7SKJaWKJ1CqLdevBYRsFFOS6iqqLySs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-218-zAboL_-2PEObeKSrh1_Xgw-1; Sun, 27 Aug 2023 14:29:52 -0400
X-MC-Unique: zAboL_-2PEObeKSrh1_Xgw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0BF1D185A78F;
 Sun, 27 Aug 2023 18:29:52 +0000 (UTC)
Received: from lacos-laptop-9.usersys.redhat.com (unknown [10.39.192.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 90BEB140E950;
 Sun, 27 Aug 2023 18:29:50 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu-devel@nongnu.org,
	lersek@redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 6/7] vhost-user: allow "vhost_set_vring" to wait for a reply
Date: Sun, 27 Aug 2023 20:29:36 +0200
Message-Id: <20230827182937.146450-7-lersek@redhat.com>
In-Reply-To: <20230827182937.146450-1-lersek@redhat.com>
References: <20230827182937.146450-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

VGhlICJ2aG9zdF9zZXRfdnJpbmciIGZ1bmN0aW9uIGFscmVhZHkgY2VudHJhbGl6ZXMgdGhlIGNv
bW1vbiBwYXJ0cyBvZgoidmhvc3RfdXNlcl9zZXRfdnJpbmdfbnVtIiwgInZob3N0X3VzZXJfc2V0
X3ZyaW5nX2Jhc2UiIGFuZAoidmhvc3RfdXNlcl9zZXRfdnJpbmdfZW5hYmxlIi4gV2UnbGwgd2Fu
dCB0byBhbGxvdyBzb21lIG9mIHRob3NlIGNhbGxlcnMKdG8gd2FpdCBmb3IgYSByZXBseS4KClRo
ZXJlZm9yZSwgcmViYXNlICJ2aG9zdF9zZXRfdnJpbmciIGZyb20ganVzdCAidmhvc3RfdXNlcl93
cml0ZSIgdG8KInZob3N0X3VzZXJfd3JpdGVfbXNnIiwgZXhwb3NpbmcgdGhlICJ3YWl0X2Zvcl9y
ZXBseSIgcGFyYW1ldGVyLgoKVGhpcyBpcyBwdXJlbHkgcmVmYWN0b3JpbmcgLS0gdGhlcmUgaXMg
bm8gb2JzZXJ2YWJsZSBjaGFuZ2UuIFRoYXQncwpiZWNhdXNlOgoKLSBhbGwgdGhyZWUgY2FsbGVy
cyBwYXNzIGluICJmYWxzZSIgZm9yICJ3YWl0X2Zvcl9yZXBseSIsIHdoaWNoIGRpc2FibGVzCiAg
YWxsIGxvZ2ljIGluICJ2aG9zdF91c2VyX3dyaXRlX21zZyIgZXhjZXB0IHRoZSBjYWxsIHRvCiAg
InZob3N0X3VzZXJfd3JpdGUiOwoKLSB0aGUgZmRzPU5VTEwgYW5kIGZkX251bT0wIGFyZ3VtZW50
cyBvZiB0aGUgb3JpZ2luYWwgInZob3N0X3VzZXJfd3JpdGUiCiAgY2FsbCBpbnNpZGUgInZob3N0
X3NldF92cmluZyIgYXJlIGhhcmQtY29kZWQgd2l0aGluCiAgInZob3N0X3VzZXJfd3JpdGVfbXNn
Ii4KCkNjOiAiTWljaGFlbCBTLiBUc2lya2luIiA8bXN0QHJlZGhhdC5jb20+IChzdXBwb3J0ZXI6
dmhvc3QpCkNjOiBFdWdlbmlvIFBlcmV6IE1hcnRpbiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KQ2M6
IEdlcm1hbiBNYWdsaW9uZSA8Z21hZ2xpb25lQHJlZGhhdC5jb20+CkNjOiBMaXUgSmlhbmcgPGdl
cnJ5QGxpbnV4LmFsaWJhYmEuY29tPgpDYzogU2VyZ2lvIExvcGV6IFBhc2N1YWwgPHNscEByZWRo
YXQuY29tPgpDYzogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgpTaWdu
ZWQtb2ZmLWJ5OiBMYXN6bG8gRXJzZWsgPGxlcnNla0ByZWRoYXQuY29tPgotLS0KIGh3L3ZpcnRp
by92aG9zdC11c2VyLmMgfCAxMSArKysrKystLS0tLQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0
aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmhvc3QtdXNl
ci5jIGIvaHcvdmlydGlvL3Zob3N0LXVzZXIuYwppbmRleCBjYWRhZmViZDA3NjcuLmJlYjRiODMy
MjQ1ZSAxMDA2NDQKLS0tIGEvaHcvdmlydGlvL3Zob3N0LXVzZXIuYworKysgYi9ody92aXJ0aW8v
dmhvc3QtdXNlci5jCkBAIC0xMTcwLDcgKzExNzAsOCBAQCBzdGF0aWMgaW50IHZob3N0X3VzZXJf
d3JpdGVfbXNnKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwgVmhvc3RVc2VyTXNnICptc2csCiAKIHN0
YXRpYyBpbnQgdmhvc3Rfc2V0X3ZyaW5nKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcgaW50IHJlcXVlc3QsCi0gICAgICAgICAg
ICAgICAgICAgICAgICAgICBzdHJ1Y3Qgdmhvc3RfdnJpbmdfc3RhdGUgKnJpbmcpCisgICAgICAg
ICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgdmhvc3RfdnJpbmdfc3RhdGUgKnJpbmcsCisgICAg
ICAgICAgICAgICAgICAgICAgICAgICBib29sIHdhaXRfZm9yX3JlcGx5KQogewogICAgIFZob3N0
VXNlck1zZyBtc2cgPSB7CiAgICAgICAgIC5oZHIucmVxdWVzdCA9IHJlcXVlc3QsCkBAIC0xMTc5
LDEzICsxMTgwLDEzIEBAIHN0YXRpYyBpbnQgdmhvc3Rfc2V0X3ZyaW5nKHN0cnVjdCB2aG9zdF9k
ZXYgKmRldiwKICAgICAgICAgLmhkci5zaXplID0gc2l6ZW9mKG1zZy5wYXlsb2FkLnN0YXRlKSwK
ICAgICB9OwogCi0gICAgcmV0dXJuIHZob3N0X3VzZXJfd3JpdGUoZGV2LCAmbXNnLCBOVUxMLCAw
KTsKKyAgICByZXR1cm4gdmhvc3RfdXNlcl93cml0ZV9tc2coZGV2LCAmbXNnLCB3YWl0X2Zvcl9y
ZXBseSk7CiB9CiAKIHN0YXRpYyBpbnQgdmhvc3RfdXNlcl9zZXRfdnJpbmdfbnVtKHN0cnVjdCB2
aG9zdF9kZXYgKmRldiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVj
dCB2aG9zdF92cmluZ19zdGF0ZSAqcmluZykKIHsKLSAgICByZXR1cm4gdmhvc3Rfc2V0X3ZyaW5n
KGRldiwgVkhPU1RfVVNFUl9TRVRfVlJJTkdfTlVNLCByaW5nKTsKKyAgICByZXR1cm4gdmhvc3Rf
c2V0X3ZyaW5nKGRldiwgVkhPU1RfVVNFUl9TRVRfVlJJTkdfTlVNLCByaW5nLCBmYWxzZSk7CiB9
CiAKIHN0YXRpYyB2b2lkIHZob3N0X3VzZXJfaG9zdF9ub3RpZmllcl9mcmVlKFZob3N0VXNlckhv
c3ROb3RpZmllciAqbikKQEAgLTEyMTYsNyArMTIxNyw3IEBAIHN0YXRpYyB2b2lkIHZob3N0X3Vz
ZXJfaG9zdF9ub3RpZmllcl9yZW1vdmUoVmhvc3RVc2VySG9zdE5vdGlmaWVyICpuLAogc3RhdGlj
IGludCB2aG9zdF91c2VyX3NldF92cmluZ19iYXNlKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwKICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgdmhvc3RfdnJpbmdfc3Rh
dGUgKnJpbmcpCiB7Ci0gICAgcmV0dXJuIHZob3N0X3NldF92cmluZyhkZXYsIFZIT1NUX1VTRVJf
U0VUX1ZSSU5HX0JBU0UsIHJpbmcpOworICAgIHJldHVybiB2aG9zdF9zZXRfdnJpbmcoZGV2LCBW
SE9TVF9VU0VSX1NFVF9WUklOR19CQVNFLCByaW5nLCBmYWxzZSk7CiB9CiAKIHN0YXRpYyBpbnQg
dmhvc3RfdXNlcl9zZXRfdnJpbmdfZW5hYmxlKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwgaW50IGVu
YWJsZSkKQEAgLTEyMzQsNyArMTIzNSw3IEBAIHN0YXRpYyBpbnQgdmhvc3RfdXNlcl9zZXRfdnJp
bmdfZW5hYmxlKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwgaW50IGVuYWJsZSkKICAgICAgICAgICAg
IC5udW0gICA9IGVuYWJsZSwKICAgICAgICAgfTsKIAotICAgICAgICByZXQgPSB2aG9zdF9zZXRf
dnJpbmcoZGV2LCBWSE9TVF9VU0VSX1NFVF9WUklOR19FTkFCTEUsICZzdGF0ZSk7CisgICAgICAg
IHJldCA9IHZob3N0X3NldF92cmluZyhkZXYsIFZIT1NUX1VTRVJfU0VUX1ZSSU5HX0VOQUJMRSwg
JnN0YXRlLCBmYWxzZSk7CiAgICAgICAgIGlmIChyZXQgPCAwKSB7CiAgICAgICAgICAgICAvKgog
ICAgICAgICAgICAgICogUmVzdG9yaW5nIHRoZSBwcmV2aW91cyBzdGF0ZSBpcyBsaWtlbHkgaW5m
ZWFzaWJsZSwgYXMgd2VsbCBhcwoK


