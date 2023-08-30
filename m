Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB74078D63E
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 15:42:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbLRZ-0008Kc-K7; Wed, 30 Aug 2023 09:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qbLRX-0008Ju-1p
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 09:41:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qbLRU-0007pn-Q1
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 09:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693402867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VV7U8QDr6Rz38uDSt16RgP+Uap8nAfM694Y5zrxRJBc=;
 b=Z4gaS4DhOA5n7Vmxo9R32LjlxbZXaYISVEAFOa8U4R+KkZ2BVioXJ3SSSMpdzH4i1AE6k1
 AJGp76rA2/fgav8+ZikXv+USwpArsuAfB7tZrTAiB4ZN4RfeRKaAjqGvwUd3k85/eO+S0b
 0BVifZpCoImOcBszrpLvo1AdTIAj3Wg=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-223-DN5pIU8oP3GtZJX9Fq6QKA-1; Wed, 30 Aug 2023 09:41:06 -0400
X-MC-Unique: DN5pIU8oP3GtZJX9Fq6QKA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0C6A3C0E200;
 Wed, 30 Aug 2023 13:41:05 +0000 (UTC)
Received: from lacos-laptop-9.usersys.redhat.com (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 536F2112131B;
 Wed, 30 Aug 2023 13:41:04 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu-devel@nongnu.org,
	lersek@redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 3/7] vhost-user: factor out "vhost_user_write_sync"
Date: Wed, 30 Aug 2023 15:40:51 +0200
Message-Id: <20230830134055.106812-4-lersek@redhat.com>
In-Reply-To: <20230830134055.106812-1-lersek@redhat.com>
References: <20230830134055.106812-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
ZXZpZXdlZC1ieTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgotLS0K
Ck5vdGVzOgogICAgdjI6CiAgICAKICAgIC0gcGljayB1cCBSLWIncyBmcm9tIFBoaWwgYW5kIFN0
ZWZhbm8KICAgIAogICAgLSByZW5hbWUgInZob3N0X3VzZXJfd3JpdGVfbXNnIiB0byAidmhvc3Rf
dXNlcl93cml0ZV9zeW5jIiAoaW4gY29kZSBhbmQKICAgICAgY29tbWl0IG1lc3NhZ2UpIFtTdGVm
YW5vXQoKIGh3L3ZpcnRpby92aG9zdC11c2VyLmMgfCA2NiArKysrKysrKystLS0tLS0tLS0tLQog
MSBmaWxlIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDM4IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2h3L3ZpcnRpby92aG9zdC11c2VyLmMgYi9ody92aXJ0aW8vdmhvc3QtdXNlci5jCmlu
ZGV4IDY0ZWFjMzE3YmZiMi4uMTQ3NmIzNmYwYTZlIDEwMDY0NAotLS0gYS9ody92aXJ0aW8vdmhv
c3QtdXNlci5jCisrKyBiL2h3L3ZpcnRpby92aG9zdC11c2VyLmMKQEAgLTEzMjAsMTAgKzEzMjAs
MzUgQEAgc3RhdGljIGludCBlbmZvcmNlX3JlcGx5KHN0cnVjdCB2aG9zdF9kZXYgKmRldiwKICAg
ICByZXR1cm4gdmhvc3RfdXNlcl9nZXRfZmVhdHVyZXMoZGV2LCAmZHVtbXkpOwogfQogCisvKiBO
b3RlOiAibXNnLT5oZHIuZmxhZ3MiIG1heSBiZSBtb2RpZmllZC4gKi8KK3N0YXRpYyBpbnQgdmhv
c3RfdXNlcl93cml0ZV9zeW5jKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwgVmhvc3RVc2VyTXNnICpt
c2csCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIHdhaXRfZm9yX3JlcGx5
KQoreworICAgIGludCByZXQ7CisKKyAgICBpZiAod2FpdF9mb3JfcmVwbHkpIHsKKyAgICAgICAg
Ym9vbCByZXBseV9zdXBwb3J0ZWQgPSB2aXJ0aW9faGFzX2ZlYXR1cmUoZGV2LT5wcm90b2NvbF9m
ZWF0dXJlcywKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZIT1NU
X1VTRVJfUFJPVE9DT0xfRl9SRVBMWV9BQ0spOworICAgICAgICBpZiAocmVwbHlfc3VwcG9ydGVk
KSB7CisgICAgICAgICAgICBtc2ctPmhkci5mbGFncyB8PSBWSE9TVF9VU0VSX05FRURfUkVQTFlf
TUFTSzsKKyAgICAgICAgfQorICAgIH0KKworICAgIHJldCA9IHZob3N0X3VzZXJfd3JpdGUoZGV2
LCBtc2csIE5VTEwsIDApOworICAgIGlmIChyZXQgPCAwKSB7CisgICAgICAgIHJldHVybiByZXQ7
CisgICAgfQorCisgICAgaWYgKHdhaXRfZm9yX3JlcGx5KSB7CisgICAgICAgIHJldHVybiBlbmZv
cmNlX3JlcGx5KGRldiwgbXNnKTsKKyAgICB9CisKKyAgICByZXR1cm4gMDsKK30KKwogc3RhdGlj
IGludCB2aG9zdF91c2VyX3NldF92cmluZ19hZGRyKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwKICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgdmhvc3RfdnJpbmdfYWRk
ciAqYWRkcikKIHsKLSAgICBpbnQgcmV0OwogICAgIFZob3N0VXNlck1zZyBtc2cgPSB7CiAgICAg
ICAgIC5oZHIucmVxdWVzdCA9IFZIT1NUX1VTRVJfU0VUX1ZSSU5HX0FERFIsCiAgICAgICAgIC5o
ZHIuZmxhZ3MgPSBWSE9TVF9VU0VSX1ZFUlNJT04sCkBAIC0xMzM3LDI0ICsxMzYyLDcgQEAgc3Rh
dGljIGludCB2aG9zdF91c2VyX3NldF92cmluZ19hZGRyKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwK
ICAgICAgKi8KICAgICBib29sIHdhaXRfZm9yX3JlcGx5ID0gYWRkci0+ZmxhZ3MgJiAoMSA8PCBW
SE9TVF9WUklOR19GX0xPRyk7CiAKLSAgICBpZiAod2FpdF9mb3JfcmVwbHkpIHsKLSAgICAgICAg
Ym9vbCByZXBseV9zdXBwb3J0ZWQgPSB2aXJ0aW9faGFzX2ZlYXR1cmUoZGV2LT5wcm90b2NvbF9m
ZWF0dXJlcywKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZIT1NU
X1VTRVJfUFJPVE9DT0xfRl9SRVBMWV9BQ0spOwotICAgICAgICBpZiAocmVwbHlfc3VwcG9ydGVk
KSB7Ci0gICAgICAgICAgICBtc2cuaGRyLmZsYWdzIHw9IFZIT1NUX1VTRVJfTkVFRF9SRVBMWV9N
QVNLOwotICAgICAgICB9Ci0gICAgfQotCi0gICAgcmV0ID0gdmhvc3RfdXNlcl93cml0ZShkZXYs
ICZtc2csIE5VTEwsIDApOwotICAgIGlmIChyZXQgPCAwKSB7Ci0gICAgICAgIHJldHVybiByZXQ7
Ci0gICAgfQotCi0gICAgaWYgKHdhaXRfZm9yX3JlcGx5KSB7Ci0gICAgICAgIHJldHVybiBlbmZv
cmNlX3JlcGx5KGRldiwgJm1zZyk7Ci0gICAgfQotCi0gICAgcmV0dXJuIDA7CisgICAgcmV0dXJu
IHZob3N0X3VzZXJfd3JpdGVfc3luYyhkZXYsICZtc2csIHdhaXRfZm9yX3JlcGx5KTsKIH0KIAog
c3RhdGljIGludCB2aG9zdF91c2VyX3NldF91NjQoc3RydWN0IHZob3N0X2RldiAqZGV2LCBpbnQg
cmVxdWVzdCwgdWludDY0X3QgdTY0LApAQCAtMTM2NiwyNiArMTM3NCw4IEBAIHN0YXRpYyBpbnQg
dmhvc3RfdXNlcl9zZXRfdTY0KHN0cnVjdCB2aG9zdF9kZXYgKmRldiwgaW50IHJlcXVlc3QsIHVp
bnQ2NF90IHU2NCwKICAgICAgICAgLnBheWxvYWQudTY0ID0gdTY0LAogICAgICAgICAuaGRyLnNp
emUgPSBzaXplb2YobXNnLnBheWxvYWQudTY0KSwKICAgICB9OwotICAgIGludCByZXQ7CiAKLSAg
ICBpZiAod2FpdF9mb3JfcmVwbHkpIHsKLSAgICAgICAgYm9vbCByZXBseV9zdXBwb3J0ZWQgPSB2
aXJ0aW9faGFzX2ZlYXR1cmUoZGV2LT5wcm90b2NvbF9mZWF0dXJlcywKLSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZIT1NUX1VTRVJfUFJPVE9DT0xfRl9SRVBMWV9B
Q0spOwotICAgICAgICBpZiAocmVwbHlfc3VwcG9ydGVkKSB7Ci0gICAgICAgICAgICBtc2cuaGRy
LmZsYWdzIHw9IFZIT1NUX1VTRVJfTkVFRF9SRVBMWV9NQVNLOwotICAgICAgICB9Ci0gICAgfQot
Ci0gICAgcmV0ID0gdmhvc3RfdXNlcl93cml0ZShkZXYsICZtc2csIE5VTEwsIDApOwotICAgIGlm
IChyZXQgPCAwKSB7Ci0gICAgICAgIHJldHVybiByZXQ7Ci0gICAgfQotCi0gICAgaWYgKHdhaXRf
Zm9yX3JlcGx5KSB7Ci0gICAgICAgIHJldHVybiBlbmZvcmNlX3JlcGx5KGRldiwgJm1zZyk7Ci0g
ICAgfQotCi0gICAgcmV0dXJuIDA7CisgICAgcmV0dXJuIHZob3N0X3VzZXJfd3JpdGVfc3luYyhk
ZXYsICZtc2csIHdhaXRfZm9yX3JlcGx5KTsKIH0KIAogc3RhdGljIGludCB2aG9zdF91c2VyX3Nl
dF9zdGF0dXMoc3RydWN0IHZob3N0X2RldiAqZGV2LCB1aW50OF90IHN0YXR1cykKCg==


