Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 192BA78A0FD
	for <lists+qemu-devel@lfdr.de>; Sun, 27 Aug 2023 20:30:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaKWH-00071b-1e; Sun, 27 Aug 2023 14:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qaKWF-00070m-KU
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 14:29:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qaKWD-0004YG-GA
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 14:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693160988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sbuVoIa7+Tjynw4006iAf8XJ5ZVSiXLnZDjhuJBbdgo=;
 b=CvdjID1s47mI1FEoXCOQhwxEsWI/29H08IBg1jICaI9SBAJoSJz5cg0BYijzYWJS0JL9IT
 cFTSP4msZDWVXxQrsTYbrWYju7aDcaL1RNNdQf2hqHIT2T9YVkcLNbrnIFPHoH1v3akERK
 U94QyytvGYquSpKyh/I0sLtcH97Olk8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-473-YkxInQ-tOc2cO-C-jmzYkg-1; Sun, 27 Aug 2023 14:29:44 -0400
X-MC-Unique: YkxInQ-tOc2cO-C-jmzYkg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 82D2B101A528;
 Sun, 27 Aug 2023 18:29:44 +0000 (UTC)
Received: from lacos-laptop-9.usersys.redhat.com (unknown [10.39.192.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 127A4140E950;
 Sun, 27 Aug 2023 18:29:42 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu-devel@nongnu.org,
	lersek@redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 2/7] vhost-user: tighten "reply_supported" scope in
 "set_vring_addr"
Date: Sun, 27 Aug 2023 20:29:32 +0200
Message-Id: <20230827182937.146450-3-lersek@redhat.com>
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
c2VrIDxsZXJzZWtAcmVkaGF0LmNvbT4KLS0tCiBody92aXJ0aW8vdmhvc3QtdXNlci5jIHwgMTEg
KysrKysrLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3Zob3N0LXVzZXIuYyBiL2h3L3ZpcnRpby92aG9z
dC11c2VyLmMKaW5kZXggYjRiNjc3YzFjZTY2Li42NGVhYzMxN2JmYjIgMTAwNjQ0Ci0tLSBhL2h3
L3ZpcnRpby92aG9zdC11c2VyLmMKKysrIGIvaHcvdmlydGlvL3Zob3N0LXVzZXIuYwpAQCAtMTMz
MSwxNyArMTMzMSwxOCBAQCBzdGF0aWMgaW50IHZob3N0X3VzZXJfc2V0X3ZyaW5nX2FkZHIoc3Ry
dWN0IHZob3N0X2RldiAqZGV2LAogICAgICAgICAuaGRyLnNpemUgPSBzaXplb2YobXNnLnBheWxv
YWQuYWRkciksCiAgICAgfTsKIAotICAgIGJvb2wgcmVwbHlfc3VwcG9ydGVkID0gdmlydGlvX2hh
c19mZWF0dXJlKGRldi0+cHJvdG9jb2xfZmVhdHVyZXMsCi0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgVkhPU1RfVVNFUl9QUk9UT0NPTF9GX1JFUExZX0FDSyk7
Ci0KICAgICAvKgogICAgICAqIHdhaXQgZm9yIGEgcmVwbHkgaWYgbG9nZ2luZyBpcyBlbmFibGVk
IHRvIG1ha2Ugc3VyZQogICAgICAqIGJhY2tlbmQgaXMgYWN0dWFsbHkgbG9nZ2luZyBjaGFuZ2Vz
CiAgICAgICovCiAgICAgYm9vbCB3YWl0X2Zvcl9yZXBseSA9IGFkZHItPmZsYWdzICYgKDEgPDwg
VkhPU1RfVlJJTkdfRl9MT0cpOwogCi0gICAgaWYgKHJlcGx5X3N1cHBvcnRlZCAmJiB3YWl0X2Zv
cl9yZXBseSkgewotICAgICAgICBtc2cuaGRyLmZsYWdzIHw9IFZIT1NUX1VTRVJfTkVFRF9SRVBM
WV9NQVNLOworICAgIGlmICh3YWl0X2Zvcl9yZXBseSkgeworICAgICAgICBib29sIHJlcGx5X3N1
cHBvcnRlZCA9IHZpcnRpb19oYXNfZmVhdHVyZShkZXYtPnByb3RvY29sX2ZlYXR1cmVzLAorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVkhPU1RfVVNFUl9QUk9UT0NP
TF9GX1JFUExZX0FDSyk7CisgICAgICAgIGlmIChyZXBseV9zdXBwb3J0ZWQpIHsKKyAgICAgICAg
ICAgIG1zZy5oZHIuZmxhZ3MgfD0gVkhPU1RfVVNFUl9ORUVEX1JFUExZX01BU0s7CisgICAgICAg
IH0KICAgICB9CiAKICAgICByZXQgPSB2aG9zdF91c2VyX3dyaXRlKGRldiwgJm1zZywgTlVMTCwg
MCk7Cgo=


