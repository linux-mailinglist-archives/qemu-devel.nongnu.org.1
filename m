Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF7878A104
	for <lists+qemu-devel@lfdr.de>; Sun, 27 Aug 2023 20:31:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaKWL-00079e-6Z; Sun, 27 Aug 2023 14:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qaKWJ-00075R-0J
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 14:29:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qaKWG-0004a5-VZ
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 14:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693160992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=npmlCi7Dwvg49ltOJ4nTDOFuGLl47ki2RTfn33quhdw=;
 b=Zj3fD3CT7uv8bP4j0MB1wtMzJedW3k04Gq4Yrr5p/2eEWWUYKl1Qx3vJ2ny6sRv3dHD4YM
 M1W2OSWuGFxVP+aipYdjfFhBCZJS9Ehlau74a9a8RrUxIfZAQ6wUtf57xr67b54EzsScYT
 AWk5AKLlgOnPT2lNqwPEs56v3jV2u3w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-47-RxarlRqWMAWRmh8jrv8veA-1; Sun, 27 Aug 2023 14:29:48 -0400
X-MC-Unique: RxarlRqWMAWRmh8jrv8veA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F2B03101A52E;
 Sun, 27 Aug 2023 18:29:47 +0000 (UTC)
Received: from lacos-laptop-9.usersys.redhat.com (unknown [10.39.192.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 81A14140E950;
 Sun, 27 Aug 2023 18:29:46 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu-devel@nongnu.org,
	lersek@redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 4/7] vhost-user: flatten "enforce_reply" into
 "vhost_user_write_msg"
Date: Sun, 27 Aug 2023 20:29:34 +0200
Message-Id: <20230827182937.146450-5-lersek@redhat.com>
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

QXQgdGhpcyBwb2ludCwgb25seSAidmhvc3RfdXNlcl93cml0ZV9tc2ciIGNhbGxzICJlbmZvcmNl
X3JlcGx5IjsgZW1iZWQKdGhlIGxhdHRlciBpbnRvIHRoZSBmb3JtZXIuCgpUaGlzIGlzIHB1cmVs
eSByZWZhY3RvcmluZyAtLSBubyBvYnNlcnZhYmxlIGNoYW5nZS4KCkNjOiAiTWljaGFlbCBTLiBU
c2lya2luIiA8bXN0QHJlZGhhdC5jb20+IChzdXBwb3J0ZXI6dmhvc3QpCkNjOiBFdWdlbmlvIFBl
cmV6IE1hcnRpbiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KQ2M6IEdlcm1hbiBNYWdsaW9uZSA8Z21h
Z2xpb25lQHJlZGhhdC5jb20+CkNjOiBMaXUgSmlhbmcgPGdlcnJ5QGxpbnV4LmFsaWJhYmEuY29t
PgpDYzogU2VyZ2lvIExvcGV6IFBhc2N1YWwgPHNscEByZWRoYXQuY29tPgpDYzogU3RlZmFubyBH
YXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgpTaWduZWQtb2ZmLWJ5OiBMYXN6bG8gRXJz
ZWsgPGxlcnNla0ByZWRoYXQuY29tPgotLS0KIGh3L3ZpcnRpby92aG9zdC11c2VyLmMgfCAzMiAr
KysrKysrKy0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDE5
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92aG9zdC11c2VyLmMgYi9ody92
aXJ0aW8vdmhvc3QtdXNlci5jCmluZGV4IDM2Zjk5YjY2YTY0NC4uOGViN2ZkMDk0YzQzIDEwMDY0
NAotLS0gYS9ody92aXJ0aW8vdmhvc3QtdXNlci5jCisrKyBiL2h3L3ZpcnRpby92aG9zdC11c2Vy
LmMKQEAgLTEzMDIsMjQgKzEzMDIsNiBAQCBzdGF0aWMgaW50IHZob3N0X3VzZXJfZ2V0X2ZlYXR1
cmVzKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwgdWludDY0X3QgKmZlYXR1cmVzKQogICAgIHJldHVy
biAwOwogfQogCi1zdGF0aWMgaW50IGVuZm9yY2VfcmVwbHkoc3RydWN0IHZob3N0X2RldiAqZGV2
LAotICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IFZob3N0VXNlck1zZyAqbXNnKQotewot
ICAgIHVpbnQ2NF90IGR1bW15OwotCi0gICAgaWYgKG1zZy0+aGRyLmZsYWdzICYgVkhPU1RfVVNF
Ul9ORUVEX1JFUExZX01BU0spIHsKLSAgICAgICAgcmV0dXJuIHByb2Nlc3NfbWVzc2FnZV9yZXBs
eShkZXYsIG1zZyk7Ci0gICAgfQotCi0gICAvKgotICAgICogV2UgbmVlZCB0byB3YWl0IGZvciBh
IHJlcGx5IGJ1dCB0aGUgYmFja2VuZCBkb2VzIG5vdAotICAgICogc3VwcG9ydCByZXBsaWVzIGZv
ciB0aGUgY29tbWFuZCB3ZSBqdXN0IHNlbnQuCi0gICAgKiBTZW5kIFZIT1NUX1VTRVJfR0VUX0ZF
QVRVUkVTIHdoaWNoIG1ha2VzIGFsbCBiYWNrZW5kcwotICAgICogc2VuZCBhIHJlcGx5LgotICAg
ICovCi0gICAgcmV0dXJuIHZob3N0X3VzZXJfZ2V0X2ZlYXR1cmVzKGRldiwgJmR1bW15KTsKLX0K
LQogLyogTm90ZTogIm1zZy0+aGRyLmZsYWdzIiBtYXkgYmUgbW9kaWZpZWQuICovCiBzdGF0aWMg
aW50IHZob3N0X3VzZXJfd3JpdGVfbXNnKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwgVmhvc3RVc2Vy
TXNnICptc2csCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgd2FpdF9mb3Jf
cmVwbHkpCkBAIC0xMzQwLDcgKzEzMjIsMTkgQEAgc3RhdGljIGludCB2aG9zdF91c2VyX3dyaXRl
X21zZyhzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIFZob3N0VXNlck1zZyAqbXNnLAogICAgIH0KIAog
ICAgIGlmICh3YWl0X2Zvcl9yZXBseSkgewotICAgICAgICByZXR1cm4gZW5mb3JjZV9yZXBseShk
ZXYsIG1zZyk7CisgICAgICAgIHVpbnQ2NF90IGR1bW15OworCisgICAgICAgIGlmIChtc2ctPmhk
ci5mbGFncyAmIFZIT1NUX1VTRVJfTkVFRF9SRVBMWV9NQVNLKSB7CisgICAgICAgICAgICByZXR1
cm4gcHJvY2Vzc19tZXNzYWdlX3JlcGx5KGRldiwgbXNnKTsKKyAgICAgICAgfQorCisgICAgICAg
LyoKKyAgICAgICAgKiBXZSBuZWVkIHRvIHdhaXQgZm9yIGEgcmVwbHkgYnV0IHRoZSBiYWNrZW5k
IGRvZXMgbm90CisgICAgICAgICogc3VwcG9ydCByZXBsaWVzIGZvciB0aGUgY29tbWFuZCB3ZSBq
dXN0IHNlbnQuCisgICAgICAgICogU2VuZCBWSE9TVF9VU0VSX0dFVF9GRUFUVVJFUyB3aGljaCBt
YWtlcyBhbGwgYmFja2VuZHMKKyAgICAgICAgKiBzZW5kIGEgcmVwbHkuCisgICAgICAgICovCisg
ICAgICAgIHJldHVybiB2aG9zdF91c2VyX2dldF9mZWF0dXJlcyhkZXYsICZkdW1teSk7CiAgICAg
fQogCiAgICAgcmV0dXJuIDA7Cgo=


