Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CB078A0FE
	for <lists+qemu-devel@lfdr.de>; Sun, 27 Aug 2023 20:30:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaKWI-00071s-JX; Sun, 27 Aug 2023 14:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qaKWG-00071F-3r
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 14:29:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qaKWD-0004YL-Nc
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 14:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693160989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rY6/WBbxuVP6DO58arUc8+KWr8V2yCJ/tPngL2fqWoE=;
 b=PMk/AfuJAH4GMsB347gb8dxhbaNTYnya6w1Sy0HUb8u244uHFY29BzQ6pbr7EUq9NNyv3D
 7Vtbl/PK3AI84yVCrnQK0BwvW5muv0biXEXME1/Fo2GJG3dnnH6rjTr9szgrpPEpi0oCoE
 1MK00ysj84kI5HGKMF9jWuVNp3zme6s=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-agCGooAHN727OJDETF8CAw-1; Sun, 27 Aug 2023 14:29:46 -0400
X-MC-Unique: agCGooAHN727OJDETF8CAw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 407F529AA3A5;
 Sun, 27 Aug 2023 18:29:46 +0000 (UTC)
Received: from lacos-laptop-9.usersys.redhat.com (unknown [10.39.192.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C45B8140E950;
 Sun, 27 Aug 2023 18:29:44 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu-devel@nongnu.org,
	lersek@redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 3/7] vhost-user: factor out "vhost_user_write_msg"
Date: Sun, 27 Aug 2023 20:29:33 +0200
Message-Id: <20230827182937.146450-4-lersek@redhat.com>
In-Reply-To: <20230827182937.146450-1-lersek@redhat.com>
References: <20230827182937.146450-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lersek@redhat.com;
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

VGhlIHRhaWxzIG9mIHRoZSAidmhvc3RfdXNlcl9zZXRfdnJpbmdfYWRkciIgYW5kICJ2aG9zdF91
c2VyX3NldF91NjQiCmZ1bmN0aW9ucyBhcmUgbm93IGJ5dGUtZm9yLWJ5dGUgaWRlbnRpY2FsLiBG
YWN0b3IgdGhlIGNvbW1vbiB0YWlsIG91dCB0byBhCm5ldyBmdW5jdGlvbiBjYWxsZWQgInZob3N0
X3VzZXJfd3JpdGVfbXNnIi4KClRoaXMgaXMgcHVyZWx5IHJlZmFjdG9yaW5nIC0tIG5vIG9ic2Vy
dmFibGUgY2hhbmdlLgoKQ2M6ICJNaWNoYWVsIFMuIFRzaXJraW4iIDxtc3RAcmVkaGF0LmNvbT4g
KHN1cHBvcnRlcjp2aG9zdCkKQ2M6IEV1Z2VuaW8gUGVyZXogTWFydGluIDxlcGVyZXptYUByZWRo
YXQuY29tPgpDYzogR2VybWFuIE1hZ2xpb25lIDxnbWFnbGlvbmVAcmVkaGF0LmNvbT4KQ2M6IExp
dSBKaWFuZyA8Z2VycnlAbGludXguYWxpYmFiYS5jb20+CkNjOiBTZXJnaW8gTG9wZXogUGFzY3Vh
bCA8c2xwQHJlZGhhdC5jb20+CkNjOiBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhh
dC5jb20+ClNpZ25lZC1vZmYtYnk6IExhc3psbyBFcnNlayA8bGVyc2VrQHJlZGhhdC5jb20+Ci0t
LQogaHcvdmlydGlvL3Zob3N0LXVzZXIuYyB8IDY2ICsrKysrKysrKy0tLS0tLS0tLS0tCiAxIGZp
bGUgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKSwgMzggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvaHcvdmlydGlvL3Zob3N0LXVzZXIuYyBiL2h3L3ZpcnRpby92aG9zdC11c2VyLmMKaW5kZXgg
NjRlYWMzMTdiZmIyLi4zNmY5OWI2NmE2NDQgMTAwNjQ0Ci0tLSBhL2h3L3ZpcnRpby92aG9zdC11
c2VyLmMKKysrIGIvaHcvdmlydGlvL3Zob3N0LXVzZXIuYwpAQCAtMTMyMCwxMCArMTMyMCwzNSBA
QCBzdGF0aWMgaW50IGVuZm9yY2VfcmVwbHkoc3RydWN0IHZob3N0X2RldiAqZGV2LAogICAgIHJl
dHVybiB2aG9zdF91c2VyX2dldF9mZWF0dXJlcyhkZXYsICZkdW1teSk7CiB9CiAKKy8qIE5vdGU6
ICJtc2ctPmhkci5mbGFncyIgbWF5IGJlIG1vZGlmaWVkLiAqLworc3RhdGljIGludCB2aG9zdF91
c2VyX3dyaXRlX21zZyhzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIFZob3N0VXNlck1zZyAqbXNnLAor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIHdhaXRfZm9yX3JlcGx5KQorewor
ICAgIGludCByZXQ7CisKKyAgICBpZiAod2FpdF9mb3JfcmVwbHkpIHsKKyAgICAgICAgYm9vbCBy
ZXBseV9zdXBwb3J0ZWQgPSB2aXJ0aW9faGFzX2ZlYXR1cmUoZGV2LT5wcm90b2NvbF9mZWF0dXJl
cywKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZIT1NUX1VTRVJf
UFJPVE9DT0xfRl9SRVBMWV9BQ0spOworICAgICAgICBpZiAocmVwbHlfc3VwcG9ydGVkKSB7Cisg
ICAgICAgICAgICBtc2ctPmhkci5mbGFncyB8PSBWSE9TVF9VU0VSX05FRURfUkVQTFlfTUFTSzsK
KyAgICAgICAgfQorICAgIH0KKworICAgIHJldCA9IHZob3N0X3VzZXJfd3JpdGUoZGV2LCBtc2cs
IE5VTEwsIDApOworICAgIGlmIChyZXQgPCAwKSB7CisgICAgICAgIHJldHVybiByZXQ7CisgICAg
fQorCisgICAgaWYgKHdhaXRfZm9yX3JlcGx5KSB7CisgICAgICAgIHJldHVybiBlbmZvcmNlX3Jl
cGx5KGRldiwgbXNnKTsKKyAgICB9CisKKyAgICByZXR1cm4gMDsKK30KKwogc3RhdGljIGludCB2
aG9zdF91c2VyX3NldF92cmluZ19hZGRyKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgdmhvc3RfdnJpbmdfYWRkciAqYWRk
cikKIHsKLSAgICBpbnQgcmV0OwogICAgIFZob3N0VXNlck1zZyBtc2cgPSB7CiAgICAgICAgIC5o
ZHIucmVxdWVzdCA9IFZIT1NUX1VTRVJfU0VUX1ZSSU5HX0FERFIsCiAgICAgICAgIC5oZHIuZmxh
Z3MgPSBWSE9TVF9VU0VSX1ZFUlNJT04sCkBAIC0xMzM3LDI0ICsxMzYyLDcgQEAgc3RhdGljIGlu
dCB2aG9zdF91c2VyX3NldF92cmluZ19hZGRyKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwKICAgICAg
Ki8KICAgICBib29sIHdhaXRfZm9yX3JlcGx5ID0gYWRkci0+ZmxhZ3MgJiAoMSA8PCBWSE9TVF9W
UklOR19GX0xPRyk7CiAKLSAgICBpZiAod2FpdF9mb3JfcmVwbHkpIHsKLSAgICAgICAgYm9vbCBy
ZXBseV9zdXBwb3J0ZWQgPSB2aXJ0aW9faGFzX2ZlYXR1cmUoZGV2LT5wcm90b2NvbF9mZWF0dXJl
cywKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZIT1NUX1VTRVJf
UFJPVE9DT0xfRl9SRVBMWV9BQ0spOwotICAgICAgICBpZiAocmVwbHlfc3VwcG9ydGVkKSB7Ci0g
ICAgICAgICAgICBtc2cuaGRyLmZsYWdzIHw9IFZIT1NUX1VTRVJfTkVFRF9SRVBMWV9NQVNLOwot
ICAgICAgICB9Ci0gICAgfQotCi0gICAgcmV0ID0gdmhvc3RfdXNlcl93cml0ZShkZXYsICZtc2cs
IE5VTEwsIDApOwotICAgIGlmIChyZXQgPCAwKSB7Ci0gICAgICAgIHJldHVybiByZXQ7Ci0gICAg
fQotCi0gICAgaWYgKHdhaXRfZm9yX3JlcGx5KSB7Ci0gICAgICAgIHJldHVybiBlbmZvcmNlX3Jl
cGx5KGRldiwgJm1zZyk7Ci0gICAgfQotCi0gICAgcmV0dXJuIDA7CisgICAgcmV0dXJuIHZob3N0
X3VzZXJfd3JpdGVfbXNnKGRldiwgJm1zZywgd2FpdF9mb3JfcmVwbHkpOwogfQogCiBzdGF0aWMg
aW50IHZob3N0X3VzZXJfc2V0X3U2NChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIGludCByZXF1ZXN0
LCB1aW50NjRfdCB1NjQsCkBAIC0xMzY2LDI2ICsxMzc0LDggQEAgc3RhdGljIGludCB2aG9zdF91
c2VyX3NldF91NjQoc3RydWN0IHZob3N0X2RldiAqZGV2LCBpbnQgcmVxdWVzdCwgdWludDY0X3Qg
dTY0LAogICAgICAgICAucGF5bG9hZC51NjQgPSB1NjQsCiAgICAgICAgIC5oZHIuc2l6ZSA9IHNp
emVvZihtc2cucGF5bG9hZC51NjQpLAogICAgIH07Ci0gICAgaW50IHJldDsKIAotICAgIGlmICh3
YWl0X2Zvcl9yZXBseSkgewotICAgICAgICBib29sIHJlcGx5X3N1cHBvcnRlZCA9IHZpcnRpb19o
YXNfZmVhdHVyZShkZXYtPnByb3RvY29sX2ZlYXR1cmVzLAotICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgVkhPU1RfVVNFUl9QUk9UT0NPTF9GX1JFUExZX0FDSyk7Ci0g
ICAgICAgIGlmIChyZXBseV9zdXBwb3J0ZWQpIHsKLSAgICAgICAgICAgIG1zZy5oZHIuZmxhZ3Mg
fD0gVkhPU1RfVVNFUl9ORUVEX1JFUExZX01BU0s7Ci0gICAgICAgIH0KLSAgICB9Ci0KLSAgICBy
ZXQgPSB2aG9zdF91c2VyX3dyaXRlKGRldiwgJm1zZywgTlVMTCwgMCk7Ci0gICAgaWYgKHJldCA8
IDApIHsKLSAgICAgICAgcmV0dXJuIHJldDsKLSAgICB9Ci0KLSAgICBpZiAod2FpdF9mb3JfcmVw
bHkpIHsKLSAgICAgICAgcmV0dXJuIGVuZm9yY2VfcmVwbHkoZGV2LCAmbXNnKTsKLSAgICB9Ci0K
LSAgICByZXR1cm4gMDsKKyAgICByZXR1cm4gdmhvc3RfdXNlcl93cml0ZV9tc2coZGV2LCAmbXNn
LCB3YWl0X2Zvcl9yZXBseSk7CiB9CiAKIHN0YXRpYyBpbnQgdmhvc3RfdXNlcl9zZXRfc3RhdHVz
KHN0cnVjdCB2aG9zdF9kZXYgKmRldiwgdWludDhfdCBzdGF0dXMpCgo=


