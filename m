Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9FD78D638
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 15:41:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbLRY-0008K8-2D; Wed, 30 Aug 2023 09:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qbLRW-0008Js-To
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 09:41:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qbLRU-0007pm-Px
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 09:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693402867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wJDfKVz3ZSjlOPy51MrtUNVWCe8oOZ/2jLJFlKPoeW8=;
 b=O2clGFAjlcTgqd1a7A4mXwCHDs4kAsJ7avYiIrk0OUvttxrsdV1VajUR2/YzkOm8hwdDMa
 CdtJJaan67ncsyGGDkabuVB+YFXtFobR4DyRzTh0S2V4IkKLDLPhhFnk6VgEuoHWfrWo4M
 gHYcmkj0jjU4g3tgoubSVbAzE7vS95c=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-x5zfKEFcOf26CNCKaMCGgw-1; Wed, 30 Aug 2023 09:41:04 -0400
X-MC-Unique: x5zfKEFcOf26CNCKaMCGgw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 12B1D3C0E236;
 Wed, 30 Aug 2023 13:41:04 +0000 (UTC)
Received: from lacos-laptop-9.usersys.redhat.com (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 99A77112131B;
 Wed, 30 Aug 2023 13:41:02 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu-devel@nongnu.org,
	lersek@redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 2/7] vhost-user: tighten "reply_supported" scope in
 "set_vring_addr"
Date: Wed, 30 Aug 2023 15:40:50 +0200
Message-Id: <20230830134055.106812-3-lersek@redhat.com>
In-Reply-To: <20230830134055.106812-1-lersek@redhat.com>
References: <20230830134055.106812-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

SW4gdGhlIHZob3N0X3VzZXJfc2V0X3ZyaW5nX2FkZHIoKSBmdW5jdGlvbiwgd2UgY2FsY3VsYXRl
CiJyZXBseV9zdXBwb3J0ZWQiIHVuY29uZGl0aW9uYWxseSwgZXZlbiB0aG91Z2ggd2UnbGwgb25s
eSBuZWVkIGl0IGlmCiJ3YWl0X2Zvcl9yZXBseSIgaXMgYWxzbyB0cnVlLgoKUmVzdHJpY3QgdGhl
IHNjb3BlIG9mICJyZXBseV9zdXBwb3J0ZWQiIHRvIHRoZSBtaW5pbXVtLgoKVGhpcyBpcyBwdXJl
bHkgcmVmYWN0b3JpbmcgLS0gbm8gb2JzZXJ2YWJsZSBjaGFuZ2UuCgpDYzogIk1pY2hhZWwgUy4g
VHNpcmtpbiIgPG1zdEByZWRoYXQuY29tPiAoc3VwcG9ydGVyOnZob3N0KQpDYzogRXVnZW5pbyBQ
ZXJleiBNYXJ0aW4gPGVwZXJlem1hQHJlZGhhdC5jb20+CkNjOiBHZXJtYW4gTWFnbGlvbmUgPGdt
YWdsaW9uZUByZWRoYXQuY29tPgpDYzogTGl1IEppYW5nIDxnZXJyeUBsaW51eC5hbGliYWJhLmNv
bT4KQ2M6IFNlcmdpbyBMb3BleiBQYXNjdWFsIDxzbHBAcmVkaGF0LmNvbT4KQ2M6IFN0ZWZhbm8g
R2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4KU2lnbmVkLW9mZi1ieTogTGFzemxvIEVy
c2VrIDxsZXJzZWtAcmVkaGF0LmNvbT4KUmV2aWV3ZWQtYnk6IFN0ZWZhbm8gR2FyemFyZWxsYSA8
c2dhcnphcmVAcmVkaGF0LmNvbT4KLS0tCgpOb3RlczoKICAgIHYyOgogICAgCiAgICAtIHBpY2sg
dXAgU3RlZmFubydzIFItYgoKIGh3L3ZpcnRpby92aG9zdC11c2VyLmMgfCAxMSArKysrKystLS0t
LQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9ody92aXJ0aW8vdmhvc3QtdXNlci5jIGIvaHcvdmlydGlvL3Zob3N0LXVzZXIuYwpp
bmRleCBiNGI2NzdjMWNlNjYuLjY0ZWFjMzE3YmZiMiAxMDA2NDQKLS0tIGEvaHcvdmlydGlvL3Zo
b3N0LXVzZXIuYworKysgYi9ody92aXJ0aW8vdmhvc3QtdXNlci5jCkBAIC0xMzMxLDE3ICsxMzMx
LDE4IEBAIHN0YXRpYyBpbnQgdmhvc3RfdXNlcl9zZXRfdnJpbmdfYWRkcihzdHJ1Y3Qgdmhvc3Rf
ZGV2ICpkZXYsCiAgICAgICAgIC5oZHIuc2l6ZSA9IHNpemVvZihtc2cucGF5bG9hZC5hZGRyKSwK
ICAgICB9OwogCi0gICAgYm9vbCByZXBseV9zdXBwb3J0ZWQgPSB2aXJ0aW9faGFzX2ZlYXR1cmUo
ZGV2LT5wcm90b2NvbF9mZWF0dXJlcywKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBWSE9TVF9VU0VSX1BST1RPQ09MX0ZfUkVQTFlfQUNLKTsKLQogICAgIC8q
CiAgICAgICogd2FpdCBmb3IgYSByZXBseSBpZiBsb2dnaW5nIGlzIGVuYWJsZWQgdG8gbWFrZSBz
dXJlCiAgICAgICogYmFja2VuZCBpcyBhY3R1YWxseSBsb2dnaW5nIGNoYW5nZXMKICAgICAgKi8K
ICAgICBib29sIHdhaXRfZm9yX3JlcGx5ID0gYWRkci0+ZmxhZ3MgJiAoMSA8PCBWSE9TVF9WUklO
R19GX0xPRyk7CiAKLSAgICBpZiAocmVwbHlfc3VwcG9ydGVkICYmIHdhaXRfZm9yX3JlcGx5KSB7
Ci0gICAgICAgIG1zZy5oZHIuZmxhZ3MgfD0gVkhPU1RfVVNFUl9ORUVEX1JFUExZX01BU0s7Cisg
ICAgaWYgKHdhaXRfZm9yX3JlcGx5KSB7CisgICAgICAgIGJvb2wgcmVwbHlfc3VwcG9ydGVkID0g
dmlydGlvX2hhc19mZWF0dXJlKGRldi0+cHJvdG9jb2xfZmVhdHVyZXMsCisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWSE9TVF9VU0VSX1BST1RPQ09MX0ZfUkVQTFlf
QUNLKTsKKyAgICAgICAgaWYgKHJlcGx5X3N1cHBvcnRlZCkgeworICAgICAgICAgICAgbXNnLmhk
ci5mbGFncyB8PSBWSE9TVF9VU0VSX05FRURfUkVQTFlfTUFTSzsKKyAgICAgICAgfQogICAgIH0K
IAogICAgIHJldCA9IHZob3N0X3VzZXJfd3JpdGUoZGV2LCAmbXNnLCBOVUxMLCAwKTsKCg==


