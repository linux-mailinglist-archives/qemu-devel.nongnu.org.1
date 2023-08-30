Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 233B178D636
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 15:41:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbLRa-0008Kt-Ug; Wed, 30 Aug 2023 09:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qbLRY-0008KV-TA
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 09:41:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qbLRV-0007q5-To
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 09:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693402869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vyNsvknF0VUozRK/KR9gJLKDhInaHr02cFO6Hr+TxQQ=;
 b=OGxjVnxPsLQ/QqbfiZM+VInGInwG+Hk62+6WnodcenTScdEG9OrtQJiLVFWXS0cBRBs7hq
 mvJKeWj5jvGndN76qhVqEwAQ6+KK8dMedadO+r/McTZt8VpLM6kLmTceLhK5V2O9FzNp3M
 NedB9/R9zi0JcWu2PDX75Y9DjS0hF7Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-ugp_6j1cO_G1lXXfbJTkAQ-1; Wed, 30 Aug 2023 09:41:08 -0400
X-MC-Unique: ugp_6j1cO_G1lXXfbJTkAQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B6E185CBED;
 Wed, 30 Aug 2023 13:41:07 +0000 (UTC)
Received: from lacos-laptop-9.usersys.redhat.com (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0DD4C1121315;
 Wed, 30 Aug 2023 13:41:05 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu-devel@nongnu.org,
	lersek@redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 4/7] vhost-user: flatten "enforce_reply" into
 "vhost_user_write_sync"
Date: Wed, 30 Aug 2023 15:40:52 +0200
Message-Id: <20230830134055.106812-5-lersek@redhat.com>
In-Reply-To: <20230830134055.106812-1-lersek@redhat.com>
References: <20230830134055.106812-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lersek@redhat.com;
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

QXQgdGhpcyBwb2ludCwgb25seSAidmhvc3RfdXNlcl93cml0ZV9zeW5jIiBjYWxscyAiZW5mb3Jj
ZV9yZXBseSI7IGVtYmVkCnRoZSBsYXR0ZXIgaW50byB0aGUgZm9ybWVyLgoKVGhpcyBpcyBwdXJl
bHkgcmVmYWN0b3JpbmcgLS0gbm8gb2JzZXJ2YWJsZSBjaGFuZ2UuCgpDYzogIk1pY2hhZWwgUy4g
VHNpcmtpbiIgPG1zdEByZWRoYXQuY29tPiAoc3VwcG9ydGVyOnZob3N0KQpDYzogRXVnZW5pbyBQ
ZXJleiBNYXJ0aW4gPGVwZXJlem1hQHJlZGhhdC5jb20+CkNjOiBHZXJtYW4gTWFnbGlvbmUgPGdt
YWdsaW9uZUByZWRoYXQuY29tPgpDYzogTGl1IEppYW5nIDxnZXJyeUBsaW51eC5hbGliYWJhLmNv
bT4KQ2M6IFNlcmdpbyBMb3BleiBQYXNjdWFsIDxzbHBAcmVkaGF0LmNvbT4KQ2M6IFN0ZWZhbm8g
R2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4KU2lnbmVkLW9mZi1ieTogTGFzemxvIEVy
c2VrIDxsZXJzZWtAcmVkaGF0LmNvbT4KUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1
ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4KUmV2aWV3ZWQtYnk6IFN0ZWZhbm8gR2FyemFyZWxsYSA8
c2dhcnphcmVAcmVkaGF0LmNvbT4KLS0tCgpOb3RlczoKICAgIHYyOgogICAgCiAgICAtIHBpY2sg
dXAgUi1iJ3MgZnJvbSBQaGlsIGFuZCBTdGVmYW5vCiAgICAKICAgIC0gcmVuYW1lICJ2aG9zdF91
c2VyX3dyaXRlX21zZyIgdG8gInZob3N0X3VzZXJfd3JpdGVfc3luYyIgKGluIGNvZGUKICAgICAg
Y29udGV4dCBhbmQgY29tbWl0IG1lc3NhZ2UpIFtTdGVmYW5vXQoKIGh3L3ZpcnRpby92aG9zdC11
c2VyLmMgfCAzMiArKysrKysrKy0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEzIGluc2Vy
dGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92aG9zdC11
c2VyLmMgYi9ody92aXJ0aW8vdmhvc3QtdXNlci5jCmluZGV4IDE0NzZiMzZmMGE2ZS4uNDEyOWJh
NzJlNDA4IDEwMDY0NAotLS0gYS9ody92aXJ0aW8vdmhvc3QtdXNlci5jCisrKyBiL2h3L3ZpcnRp
by92aG9zdC11c2VyLmMKQEAgLTEzMDIsMjQgKzEzMDIsNiBAQCBzdGF0aWMgaW50IHZob3N0X3Vz
ZXJfZ2V0X2ZlYXR1cmVzKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwgdWludDY0X3QgKmZlYXR1cmVz
KQogICAgIHJldHVybiAwOwogfQogCi1zdGF0aWMgaW50IGVuZm9yY2VfcmVwbHkoc3RydWN0IHZo
b3N0X2RldiAqZGV2LAotICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IFZob3N0VXNlck1z
ZyAqbXNnKQotewotICAgIHVpbnQ2NF90IGR1bW15OwotCi0gICAgaWYgKG1zZy0+aGRyLmZsYWdz
ICYgVkhPU1RfVVNFUl9ORUVEX1JFUExZX01BU0spIHsKLSAgICAgICAgcmV0dXJuIHByb2Nlc3Nf
bWVzc2FnZV9yZXBseShkZXYsIG1zZyk7Ci0gICAgfQotCi0gICAvKgotICAgICogV2UgbmVlZCB0
byB3YWl0IGZvciBhIHJlcGx5IGJ1dCB0aGUgYmFja2VuZCBkb2VzIG5vdAotICAgICogc3VwcG9y
dCByZXBsaWVzIGZvciB0aGUgY29tbWFuZCB3ZSBqdXN0IHNlbnQuCi0gICAgKiBTZW5kIFZIT1NU
X1VTRVJfR0VUX0ZFQVRVUkVTIHdoaWNoIG1ha2VzIGFsbCBiYWNrZW5kcwotICAgICogc2VuZCBh
IHJlcGx5LgotICAgICovCi0gICAgcmV0dXJuIHZob3N0X3VzZXJfZ2V0X2ZlYXR1cmVzKGRldiwg
JmR1bW15KTsKLX0KLQogLyogTm90ZTogIm1zZy0+aGRyLmZsYWdzIiBtYXkgYmUgbW9kaWZpZWQu
ICovCiBzdGF0aWMgaW50IHZob3N0X3VzZXJfd3JpdGVfc3luYyhzdHJ1Y3Qgdmhvc3RfZGV2ICpk
ZXYsIFZob3N0VXNlck1zZyAqbXNnLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Ym9vbCB3YWl0X2Zvcl9yZXBseSkKQEAgLTEzNDAsNyArMTMyMiwxOSBAQCBzdGF0aWMgaW50IHZo
b3N0X3VzZXJfd3JpdGVfc3luYyhzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIFZob3N0VXNlck1zZyAq
bXNnLAogICAgIH0KIAogICAgIGlmICh3YWl0X2Zvcl9yZXBseSkgewotICAgICAgICByZXR1cm4g
ZW5mb3JjZV9yZXBseShkZXYsIG1zZyk7CisgICAgICAgIHVpbnQ2NF90IGR1bW15OworCisgICAg
ICAgIGlmIChtc2ctPmhkci5mbGFncyAmIFZIT1NUX1VTRVJfTkVFRF9SRVBMWV9NQVNLKSB7Cisg
ICAgICAgICAgICByZXR1cm4gcHJvY2Vzc19tZXNzYWdlX3JlcGx5KGRldiwgbXNnKTsKKyAgICAg
ICAgfQorCisgICAgICAgLyoKKyAgICAgICAgKiBXZSBuZWVkIHRvIHdhaXQgZm9yIGEgcmVwbHkg
YnV0IHRoZSBiYWNrZW5kIGRvZXMgbm90CisgICAgICAgICogc3VwcG9ydCByZXBsaWVzIGZvciB0
aGUgY29tbWFuZCB3ZSBqdXN0IHNlbnQuCisgICAgICAgICogU2VuZCBWSE9TVF9VU0VSX0dFVF9G
RUFUVVJFUyB3aGljaCBtYWtlcyBhbGwgYmFja2VuZHMKKyAgICAgICAgKiBzZW5kIGEgcmVwbHku
CisgICAgICAgICovCisgICAgICAgIHJldHVybiB2aG9zdF91c2VyX2dldF9mZWF0dXJlcyhkZXYs
ICZkdW1teSk7CiAgICAgfQogCiAgICAgcmV0dXJuIDA7Cgo=


