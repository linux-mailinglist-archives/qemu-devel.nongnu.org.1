Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 858D87B5C25
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 22:34:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnPat-0003SQ-NP; Mon, 02 Oct 2023 16:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qnPar-0003Rw-Rz
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 16:32:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qnPaq-0001Tv-3Z
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 16:32:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696278759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FNxOG/drRlkY3d6uhvoOfPq4VgCa4J4atWRHGxUXUNo=;
 b=gYu+RcGdaa0+e+n4eKIw0QIhluGHlMjcFk5Fhlut5I32PseVYph94bhiY5iYFUaJSKlAp5
 d8tmYyHKvmkBDIVDrsCn/GQ5WdHVq8Ymt0M/6Vs3uIISvA20pGA5ovm9EKanyGOidZ873D
 sevWmlFhUbOFySKdslEAxwXV/KYF5fI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-18-4C9K9IekOE-sXpyArf8PyQ-1; Mon, 02 Oct 2023 16:32:38 -0400
X-MC-Unique: 4C9K9IekOE-sXpyArf8PyQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A1810858F1B;
 Mon,  2 Oct 2023 20:32:37 +0000 (UTC)
Received: from lacos-laptop-9.usersys.redhat.com (unknown [10.39.192.119])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F76840C6EBF;
 Mon,  2 Oct 2023 20:32:35 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu-devel@nongnu.org,
	lersek@redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v3 3/7] vhost-user: factor out "vhost_user_write_sync"
Date: Mon,  2 Oct 2023 22:32:17 +0200
Message-Id: <20231002203221.17241-4-lersek@redhat.com>
In-Reply-To: <20231002203221.17241-1-lersek@redhat.com>
References: <20231002203221.17241-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X3VzZXJfd3JpdGVfc3luYyIuCgpUaGlzIGlzIHB1cmVseSByZWZhY3RvcmluZyAtLSBubyBvYnNl
cnZhYmxlIGNoYW5nZS4KCkNjOiAiTWljaGFlbCBTLiBUc2lya2luIiA8bXN0QHJlZGhhdC5jb20+
IChzdXBwb3J0ZXI6dmhvc3QpCkNjOiBFdWdlbmlvIFBlcmV6IE1hcnRpbiA8ZXBlcmV6bWFAcmVk
aGF0LmNvbT4KQ2M6IEdlcm1hbiBNYWdsaW9uZSA8Z21hZ2xpb25lQHJlZGhhdC5jb20+CkNjOiBM
aXUgSmlhbmcgPGdlcnJ5QGxpbnV4LmFsaWJhYmEuY29tPgpDYzogU2VyZ2lvIExvcGV6IFBhc2N1
YWwgPHNscEByZWRoYXQuY29tPgpDYzogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRo
YXQuY29tPgpTaWduZWQtb2ZmLWJ5OiBMYXN6bG8gRXJzZWsgPGxlcnNla0ByZWRoYXQuY29tPgpS
ZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPgpS
ZXZpZXdlZC1ieTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgpUZXN0
ZWQtYnk6IEFsYmVydCBFc3RldmUgPGFlc3RldmVAcmVkaGF0LmNvbT4KUmV2aWV3ZWQtYnk6IEV1
Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUByZWRoYXQuY29tPgotLS0KCk5vdGVzOgogICAgdjM6CiAg
ICAKICAgIC0gcGljayB1cCBSLWIgZnJvbSBFdWdlbmlvLCBULWIgZnJvbSBBbGJlcnQKICAgIAog
ICAgdjI6CiAgICAKICAgIC0gcGljayB1cCBSLWIncyBmcm9tIFBoaWwgYW5kIFN0ZWZhbm8KICAg
IAogICAgLSByZW5hbWUgInZob3N0X3VzZXJfd3JpdGVfbXNnIiB0byAidmhvc3RfdXNlcl93cml0
ZV9zeW5jIiAoaW4gY29kZSBhbmQKICAgICAgY29tbWl0IG1lc3NhZ2UpIFtTdGVmYW5vXQoKIGh3
L3ZpcnRpby92aG9zdC11c2VyLmMgfCA2NiArKysrKysrKystLS0tLS0tLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDM4IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2h3
L3ZpcnRpby92aG9zdC11c2VyLmMgYi9ody92aXJ0aW8vdmhvc3QtdXNlci5jCmluZGV4IDY0ZWFj
MzE3YmZiMi4uMTQ3NmIzNmYwYTZlIDEwMDY0NAotLS0gYS9ody92aXJ0aW8vdmhvc3QtdXNlci5j
CisrKyBiL2h3L3ZpcnRpby92aG9zdC11c2VyLmMKQEAgLTEzMjAsMTAgKzEzMjAsMzUgQEAgc3Rh
dGljIGludCBlbmZvcmNlX3JlcGx5KHN0cnVjdCB2aG9zdF9kZXYgKmRldiwKICAgICByZXR1cm4g
dmhvc3RfdXNlcl9nZXRfZmVhdHVyZXMoZGV2LCAmZHVtbXkpOwogfQogCisvKiBOb3RlOiAibXNn
LT5oZHIuZmxhZ3MiIG1heSBiZSBtb2RpZmllZC4gKi8KK3N0YXRpYyBpbnQgdmhvc3RfdXNlcl93
cml0ZV9zeW5jKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwgVmhvc3RVc2VyTXNnICptc2csCisgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIHdhaXRfZm9yX3JlcGx5KQoreworICAg
IGludCByZXQ7CisKKyAgICBpZiAod2FpdF9mb3JfcmVwbHkpIHsKKyAgICAgICAgYm9vbCByZXBs
eV9zdXBwb3J0ZWQgPSB2aXJ0aW9faGFzX2ZlYXR1cmUoZGV2LT5wcm90b2NvbF9mZWF0dXJlcywK
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZIT1NUX1VTRVJfUFJP
VE9DT0xfRl9SRVBMWV9BQ0spOworICAgICAgICBpZiAocmVwbHlfc3VwcG9ydGVkKSB7CisgICAg
ICAgICAgICBtc2ctPmhkci5mbGFncyB8PSBWSE9TVF9VU0VSX05FRURfUkVQTFlfTUFTSzsKKyAg
ICAgICAgfQorICAgIH0KKworICAgIHJldCA9IHZob3N0X3VzZXJfd3JpdGUoZGV2LCBtc2csIE5V
TEwsIDApOworICAgIGlmIChyZXQgPCAwKSB7CisgICAgICAgIHJldHVybiByZXQ7CisgICAgfQor
CisgICAgaWYgKHdhaXRfZm9yX3JlcGx5KSB7CisgICAgICAgIHJldHVybiBlbmZvcmNlX3JlcGx5
KGRldiwgbXNnKTsKKyAgICB9CisKKyAgICByZXR1cm4gMDsKK30KKwogc3RhdGljIGludCB2aG9z
dF91c2VyX3NldF92cmluZ19hZGRyKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgdmhvc3RfdnJpbmdfYWRkciAqYWRkcikK
IHsKLSAgICBpbnQgcmV0OwogICAgIFZob3N0VXNlck1zZyBtc2cgPSB7CiAgICAgICAgIC5oZHIu
cmVxdWVzdCA9IFZIT1NUX1VTRVJfU0VUX1ZSSU5HX0FERFIsCiAgICAgICAgIC5oZHIuZmxhZ3Mg
PSBWSE9TVF9VU0VSX1ZFUlNJT04sCkBAIC0xMzM3LDI0ICsxMzYyLDcgQEAgc3RhdGljIGludCB2
aG9zdF91c2VyX3NldF92cmluZ19hZGRyKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwKICAgICAgKi8K
ICAgICBib29sIHdhaXRfZm9yX3JlcGx5ID0gYWRkci0+ZmxhZ3MgJiAoMSA8PCBWSE9TVF9WUklO
R19GX0xPRyk7CiAKLSAgICBpZiAod2FpdF9mb3JfcmVwbHkpIHsKLSAgICAgICAgYm9vbCByZXBs
eV9zdXBwb3J0ZWQgPSB2aXJ0aW9faGFzX2ZlYXR1cmUoZGV2LT5wcm90b2NvbF9mZWF0dXJlcywK
LSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZIT1NUX1VTRVJfUFJP
VE9DT0xfRl9SRVBMWV9BQ0spOwotICAgICAgICBpZiAocmVwbHlfc3VwcG9ydGVkKSB7Ci0gICAg
ICAgICAgICBtc2cuaGRyLmZsYWdzIHw9IFZIT1NUX1VTRVJfTkVFRF9SRVBMWV9NQVNLOwotICAg
ICAgICB9Ci0gICAgfQotCi0gICAgcmV0ID0gdmhvc3RfdXNlcl93cml0ZShkZXYsICZtc2csIE5V
TEwsIDApOwotICAgIGlmIChyZXQgPCAwKSB7Ci0gICAgICAgIHJldHVybiByZXQ7Ci0gICAgfQot
Ci0gICAgaWYgKHdhaXRfZm9yX3JlcGx5KSB7Ci0gICAgICAgIHJldHVybiBlbmZvcmNlX3JlcGx5
KGRldiwgJm1zZyk7Ci0gICAgfQotCi0gICAgcmV0dXJuIDA7CisgICAgcmV0dXJuIHZob3N0X3Vz
ZXJfd3JpdGVfc3luYyhkZXYsICZtc2csIHdhaXRfZm9yX3JlcGx5KTsKIH0KIAogc3RhdGljIGlu
dCB2aG9zdF91c2VyX3NldF91NjQoc3RydWN0IHZob3N0X2RldiAqZGV2LCBpbnQgcmVxdWVzdCwg
dWludDY0X3QgdTY0LApAQCAtMTM2NiwyNiArMTM3NCw4IEBAIHN0YXRpYyBpbnQgdmhvc3RfdXNl
cl9zZXRfdTY0KHN0cnVjdCB2aG9zdF9kZXYgKmRldiwgaW50IHJlcXVlc3QsIHVpbnQ2NF90IHU2
NCwKICAgICAgICAgLnBheWxvYWQudTY0ID0gdTY0LAogICAgICAgICAuaGRyLnNpemUgPSBzaXpl
b2YobXNnLnBheWxvYWQudTY0KSwKICAgICB9OwotICAgIGludCByZXQ7CiAKLSAgICBpZiAod2Fp
dF9mb3JfcmVwbHkpIHsKLSAgICAgICAgYm9vbCByZXBseV9zdXBwb3J0ZWQgPSB2aXJ0aW9faGFz
X2ZlYXR1cmUoZGV2LT5wcm90b2NvbF9mZWF0dXJlcywKLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFZIT1NUX1VTRVJfUFJPVE9DT0xfRl9SRVBMWV9BQ0spOwotICAg
ICAgICBpZiAocmVwbHlfc3VwcG9ydGVkKSB7Ci0gICAgICAgICAgICBtc2cuaGRyLmZsYWdzIHw9
IFZIT1NUX1VTRVJfTkVFRF9SRVBMWV9NQVNLOwotICAgICAgICB9Ci0gICAgfQotCi0gICAgcmV0
ID0gdmhvc3RfdXNlcl93cml0ZShkZXYsICZtc2csIE5VTEwsIDApOwotICAgIGlmIChyZXQgPCAw
KSB7Ci0gICAgICAgIHJldHVybiByZXQ7Ci0gICAgfQotCi0gICAgaWYgKHdhaXRfZm9yX3JlcGx5
KSB7Ci0gICAgICAgIHJldHVybiBlbmZvcmNlX3JlcGx5KGRldiwgJm1zZyk7Ci0gICAgfQotCi0g
ICAgcmV0dXJuIDA7CisgICAgcmV0dXJuIHZob3N0X3VzZXJfd3JpdGVfc3luYyhkZXYsICZtc2cs
IHdhaXRfZm9yX3JlcGx5KTsKIH0KIAogc3RhdGljIGludCB2aG9zdF91c2VyX3NldF9zdGF0dXMo
c3RydWN0IHZob3N0X2RldiAqZGV2LCB1aW50OF90IHN0YXR1cykKCg==


