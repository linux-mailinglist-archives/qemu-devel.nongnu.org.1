Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1179BAC8348
	for <lists+qemu-devel@lfdr.de>; Thu, 29 May 2025 22:33:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKjvC-0001bI-LI; Thu, 29 May 2025 16:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uKjuu-0001UR-QQ
 for qemu-devel@nongnu.org; Thu, 29 May 2025 16:31:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uKjus-0007Js-Ho
 for qemu-devel@nongnu.org; Thu, 29 May 2025 16:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748550711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=MxOJ4h3pUMmqgV7CKY77KaqirCaFqgVGuPZZhzJfid8=;
 b=W7ejHInr4jhOrjauew4x3YAA0AX64KJhTdV1Qhrq9V7vYwdWaZicOuInPgMDZghrBZqGkU
 wiot1S9g/uViQWRHUfNf+ch2qlr2J6tMfbBfHCsrDjDDrhc7c46L37K222ZkVTNns4mdwc
 br02mAfLSW9uQLE7RQnwkL/O9dLeWtk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-gQ1SAAonNraiA5H47pSnBQ-1; Thu,
 29 May 2025 16:31:50 -0400
X-MC-Unique: gQ1SAAonNraiA5H47pSnBQ-1
X-Mimecast-MFC-AGG-ID: gQ1SAAonNraiA5H47pSnBQ_1748550709
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6EC7B1800256; Thu, 29 May 2025 20:31:49 +0000 (UTC)
Received: from localhost (unknown [10.2.16.100])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B85A719560B7; Thu, 29 May 2025 20:31:48 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH] iotests: fix 240
Date: Thu, 29 May 2025 16:31:47 -0400
Message-ID: <20250529203147.180338-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Commit 2e8e18c2e463 ("virtio-scsi: add iothread-vq-mapping parameter")
removed the limitation that virtio-scsi devices must successfully set
the AioContext on their BlockBackends. This was made possible thanks to
the QEMU multi-queue block layer.

This change broke qemu-iotests 240, which checks that adding a
virtio-scsi device with a drive that is already in another AioContext
will fail.

Update the test to take the relaxed behavior into account. I considered
removing this test case entirely, but the code coverage still seems
valuable.

Fixes: 2e8e18c2e463 ("virtio-scsi: add iothread-vq-mapping parameter")
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qemu-iotests/240     | 2 --
 tests/qemu-iotests/240.out | 4 +---
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/240 b/tests/qemu-iotests/240
index 9b281e1dc0..f8af9ff648 100755
--- a/tests/qemu-iotests/240
+++ b/tests/qemu-iotests/240
@@ -81,8 +81,6 @@ class TestCase(iotests.QMPTestCase):
 
         self.vm.qmp_log('device_del', id='scsi-hd0')
         self.vm.event_wait('DEVICE_DELETED')
-        self.vm.qmp_log('device_add', id='scsi-hd1', driver='scsi-hd', drive='hd0', bus="scsi1.0")
-
         self.vm.qmp_log('device_del', id='scsi-hd1')
         self.vm.event_wait('DEVICE_DELETED')
         self.vm.qmp_log('blockdev-del', node_name='hd0')
diff --git a/tests/qemu-iotests/240.out b/tests/qemu-iotests/240.out
index 89ed25e506..10dcc42e06 100644
--- a/tests/qemu-iotests/240.out
+++ b/tests/qemu-iotests/240.out
@@ -46,10 +46,8 @@
 {"execute": "device_add", "arguments": {"bus": "scsi0.0", "drive": "hd0", "driver": "scsi-hd", "id": "scsi-hd0"}}
 {"return": {}}
 {"execute": "device_add", "arguments": {"bus": "scsi1.0", "drive": "hd0", "driver": "scsi-hd", "id": "scsi-hd1"}}
-{"error": {"class": "GenericError", "desc": "Cannot change iothread of active block backend"}}
-{"execute": "device_del", "arguments": {"id": "scsi-hd0"}}
 {"return": {}}
-{"execute": "device_add", "arguments": {"bus": "scsi1.0", "drive": "hd0", "driver": "scsi-hd", "id": "scsi-hd1"}}
+{"execute": "device_del", "arguments": {"id": "scsi-hd0"}}
 {"return": {}}
 {"execute": "device_del", "arguments": {"id": "scsi-hd1"}}
 {"return": {}}
-- 
2.49.0


