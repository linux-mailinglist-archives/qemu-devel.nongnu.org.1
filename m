Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6619A7B5C1F
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 22:34:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnPb7-0003ZY-D5; Mon, 02 Oct 2023 16:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qnPb4-0003Xc-PU
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 16:32:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qnPb3-0001Vy-8n
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 16:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696278771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gqkn9cVUW8+iFFFAJvE87tVhYI+EY4ld357DksWpoqw=;
 b=L2xw8zVQ1GDJkud8njaN340tkfTy6EX3+A+zgUkuGEN+e1h6aWP+akw061guwv9LtIl+7u
 owL5CwezuxUusoD2DZMqIG0xAS2wU9bfrhdQZnFW9pFHVxehhiUQ7FreLArZ6pratzoCCO
 X3YpSRXcJu1JPTYn9KDm6gG1rJqVmYM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-358-Coh6_GC7N9WR6_BP-K-cwQ-1; Mon, 02 Oct 2023 16:32:40 -0400
X-MC-Unique: Coh6_GC7N9WR6_BP-K-cwQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C0EF811E7B;
 Mon,  2 Oct 2023 20:32:40 +0000 (UTC)
Received: from lacos-laptop-9.usersys.redhat.com (unknown [10.39.192.119])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0AAF840C6EBF;
 Mon,  2 Oct 2023 20:32:37 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu-devel@nongnu.org,
	lersek@redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v3 4/7] vhost-user: flatten "enforce_reply" into
 "vhost_user_write_sync"
Date: Mon,  2 Oct 2023 22:32:18 +0200
Message-Id: <20231002203221.17241-5-lersek@redhat.com>
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
c2dhcnphcmVAcmVkaGF0LmNvbT4KVGVzdGVkLWJ5OiBBbGJlcnQgRXN0ZXZlIDxhZXN0ZXZlQHJl
ZGhhdC5jb20+ClJldmlld2VkLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNv
bT4KLS0tCgpOb3RlczoKICAgIHYzOgogICAgCiAgICAtIHBpY2sgdXAgUi1iIGZyb20gRXVnZW5p
bywgVC1iIGZyb20gQWxiZXJ0CiAgICAKICAgIHYyOgogICAgCiAgICAtIHBpY2sgdXAgUi1iJ3Mg
ZnJvbSBQaGlsIGFuZCBTdGVmYW5vCiAgICAKICAgIC0gcmVuYW1lICJ2aG9zdF91c2VyX3dyaXRl
X21zZyIgdG8gInZob3N0X3VzZXJfd3JpdGVfc3luYyIgKGluIGNvZGUKICAgICAgY29udGV4dCBh
bmQgY29tbWl0IG1lc3NhZ2UpIFtTdGVmYW5vXQoKIGh3L3ZpcnRpby92aG9zdC11c2VyLmMgfCAz
MiArKysrKysrKy0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyks
IDE5IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92aG9zdC11c2VyLmMgYi9o
dy92aXJ0aW8vdmhvc3QtdXNlci5jCmluZGV4IDE0NzZiMzZmMGE2ZS4uNDEyOWJhNzJlNDA4IDEw
MDY0NAotLS0gYS9ody92aXJ0aW8vdmhvc3QtdXNlci5jCisrKyBiL2h3L3ZpcnRpby92aG9zdC11
c2VyLmMKQEAgLTEzMDIsMjQgKzEzMDIsNiBAQCBzdGF0aWMgaW50IHZob3N0X3VzZXJfZ2V0X2Zl
YXR1cmVzKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwgdWludDY0X3QgKmZlYXR1cmVzKQogICAgIHJl
dHVybiAwOwogfQogCi1zdGF0aWMgaW50IGVuZm9yY2VfcmVwbHkoc3RydWN0IHZob3N0X2RldiAq
ZGV2LAotICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IFZob3N0VXNlck1zZyAqbXNnKQot
ewotICAgIHVpbnQ2NF90IGR1bW15OwotCi0gICAgaWYgKG1zZy0+aGRyLmZsYWdzICYgVkhPU1Rf
VVNFUl9ORUVEX1JFUExZX01BU0spIHsKLSAgICAgICAgcmV0dXJuIHByb2Nlc3NfbWVzc2FnZV9y
ZXBseShkZXYsIG1zZyk7Ci0gICAgfQotCi0gICAvKgotICAgICogV2UgbmVlZCB0byB3YWl0IGZv
ciBhIHJlcGx5IGJ1dCB0aGUgYmFja2VuZCBkb2VzIG5vdAotICAgICogc3VwcG9ydCByZXBsaWVz
IGZvciB0aGUgY29tbWFuZCB3ZSBqdXN0IHNlbnQuCi0gICAgKiBTZW5kIFZIT1NUX1VTRVJfR0VU
X0ZFQVRVUkVTIHdoaWNoIG1ha2VzIGFsbCBiYWNrZW5kcwotICAgICogc2VuZCBhIHJlcGx5Lgot
ICAgICovCi0gICAgcmV0dXJuIHZob3N0X3VzZXJfZ2V0X2ZlYXR1cmVzKGRldiwgJmR1bW15KTsK
LX0KLQogLyogTm90ZTogIm1zZy0+aGRyLmZsYWdzIiBtYXkgYmUgbW9kaWZpZWQuICovCiBzdGF0
aWMgaW50IHZob3N0X3VzZXJfd3JpdGVfc3luYyhzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIFZob3N0
VXNlck1zZyAqbXNnLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCB3YWl0
X2Zvcl9yZXBseSkKQEAgLTEzNDAsNyArMTMyMiwxOSBAQCBzdGF0aWMgaW50IHZob3N0X3VzZXJf
d3JpdGVfc3luYyhzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIFZob3N0VXNlck1zZyAqbXNnLAogICAg
IH0KIAogICAgIGlmICh3YWl0X2Zvcl9yZXBseSkgewotICAgICAgICByZXR1cm4gZW5mb3JjZV9y
ZXBseShkZXYsIG1zZyk7CisgICAgICAgIHVpbnQ2NF90IGR1bW15OworCisgICAgICAgIGlmICht
c2ctPmhkci5mbGFncyAmIFZIT1NUX1VTRVJfTkVFRF9SRVBMWV9NQVNLKSB7CisgICAgICAgICAg
ICByZXR1cm4gcHJvY2Vzc19tZXNzYWdlX3JlcGx5KGRldiwgbXNnKTsKKyAgICAgICAgfQorCisg
ICAgICAgLyoKKyAgICAgICAgKiBXZSBuZWVkIHRvIHdhaXQgZm9yIGEgcmVwbHkgYnV0IHRoZSBi
YWNrZW5kIGRvZXMgbm90CisgICAgICAgICogc3VwcG9ydCByZXBsaWVzIGZvciB0aGUgY29tbWFu
ZCB3ZSBqdXN0IHNlbnQuCisgICAgICAgICogU2VuZCBWSE9TVF9VU0VSX0dFVF9GRUFUVVJFUyB3
aGljaCBtYWtlcyBhbGwgYmFja2VuZHMKKyAgICAgICAgKiBzZW5kIGEgcmVwbHkuCisgICAgICAg
ICovCisgICAgICAgIHJldHVybiB2aG9zdF91c2VyX2dldF9mZWF0dXJlcyhkZXYsICZkdW1teSk7
CiAgICAgfQogCiAgICAgcmV0dXJuIDA7Cgo=


