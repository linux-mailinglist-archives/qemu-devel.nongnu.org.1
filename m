Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A0678A0FC
	for <lists+qemu-devel@lfdr.de>; Sun, 27 Aug 2023 20:30:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaKWE-000704-80; Sun, 27 Aug 2023 14:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qaKWC-0006zI-9v
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 14:29:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qaKW9-0004Xg-Tn
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 14:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693160983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IDNTMLQYy80LbQiw/K80XEYeTnP9RO7F3JM5of2sNrI=;
 b=I2S0mkp7QeAJCC94sx07QbqsvJi/kdQHZ06kJWGpBg9pksOdIo7iJNMA7KSQnWRdtt9P79
 xoQOrzq7tvGLwtMfAyPlsMTWU6/sgRuRS4+7Gx7S70dDdLB2HPSDVqY/ALCRXtFrcwKQLB
 746jmmr/5s8jAJCK93Q9r8uOQCUhxvM=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-326-Fa0S1A7vOQqDSJdWYL4GXA-1; Sun, 27 Aug 2023 14:29:41 -0400
X-MC-Unique: Fa0S1A7vOQqDSJdWYL4GXA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 136D91C0515B;
 Sun, 27 Aug 2023 18:29:41 +0000 (UTC)
Received: from lacos-laptop-9.usersys.redhat.com (unknown [10.39.192.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F9BE140E950;
 Sun, 27 Aug 2023 18:29:39 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu-devel@nongnu.org,
	lersek@redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 0/7] vhost-user: call VHOST_USER_SET_VRING_ENABLE synchronously
Date: Sun, 27 Aug 2023 20:29:30 +0200
Message-Id: <20230827182937.146450-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

VGhlIGxhc3QgcGF0Y2ggaW4gdGhlIHNlcmllcyBzdGF0ZXMgYW5kIGZpeGVzIHRoZSBwcm9ibGVt
OyBwcmlvciBwYXRjaGVzCm9ubHkgcmVmYWN0b3IgdGhlIGNvZGUuCgpDYzogIk1pY2hhZWwgUy4g
VHNpcmtpbiIgPG1zdEByZWRoYXQuY29tPiAoc3VwcG9ydGVyOnZob3N0KQpDYzogRXVnZW5pbyBQ
ZXJleiBNYXJ0aW4gPGVwZXJlem1hQHJlZGhhdC5jb20+CkNjOiBHZXJtYW4gTWFnbGlvbmUgPGdt
YWdsaW9uZUByZWRoYXQuY29tPgpDYzogTGl1IEppYW5nIDxnZXJyeUBsaW51eC5hbGliYWJhLmNv
bT4KQ2M6IFNlcmdpbyBMb3BleiBQYXNjdWFsIDxzbHBAcmVkaGF0LmNvbT4KQ2M6IFN0ZWZhbm8g
R2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4KClRoYW5rcywKTGFzemxvCgpMYXN6bG8g
RXJzZWsgKDcpOgogIHZob3N0LXVzZXI6IHN0cmlwIHN1cGVyZmx1b3VzIHdoaXRlc3BhY2UKICB2
aG9zdC11c2VyOiB0aWdodGVuICJyZXBseV9zdXBwb3J0ZWQiIHNjb3BlIGluICJzZXRfdnJpbmdf
YWRkciIKICB2aG9zdC11c2VyOiBmYWN0b3Igb3V0ICJ2aG9zdF91c2VyX3dyaXRlX21zZyIKICB2
aG9zdC11c2VyOiBmbGF0dGVuICJlbmZvcmNlX3JlcGx5IiBpbnRvICJ2aG9zdF91c2VyX3dyaXRl
X21zZyIKICB2aG9zdC11c2VyOiBob2lzdCAid3JpdGVfbXNnIiwgImdldF9mZWF0dXJlcyIsICJn
ZXRfdTY0IgogIHZob3N0LXVzZXI6IGFsbG93ICJ2aG9zdF9zZXRfdnJpbmciIHRvIHdhaXQgZm9y
IGEgcmVwbHkKICB2aG9zdC11c2VyOiBjYWxsIFZIT1NUX1VTRVJfU0VUX1ZSSU5HX0VOQUJMRSBz
eW5jaHJvbm91c2x5CgogaHcvdmlydGlvL3Zob3N0LXVzZXIuYyB8IDIwMiArKysrKysrKystLS0t
LS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDk0IGluc2VydGlvbnMoKyksIDEwOCBkZWxldGlvbnMo
LSkKCgpiYXNlLWNvbW1pdDogNTBlN2E0MGFmMzcyZWU1OTMxYzk5ZWY3MzkwZjVkM2Q2ZmJmNmVj
NAo=


