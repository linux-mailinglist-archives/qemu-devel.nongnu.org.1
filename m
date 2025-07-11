Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5996B015E5
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Jul 2025 10:26:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua94v-0007Ir-FA; Fri, 11 Jul 2025 04:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua8yd-0006TF-OX; Fri, 11 Jul 2025 04:19:28 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua8yb-0004IY-AL; Fri, 11 Jul 2025 04:19:26 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 899F51356DF;
 Fri, 11 Jul 2025 11:17:19 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7DFBB23FA54;
 Fri, 11 Jul 2025 11:17:46 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.3 20/39] iotests: fix 240
Date: Fri, 11 Jul 2025 11:16:16 +0300
Message-ID: <20250711081745.1785806-20-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.3-20250711105634@cover.tls.msk.ru>
References: <qemu-stable-10.0.3-20250711105634@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

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
Reviewed-by: Eric Blake <eblake@redhat.com>
Tested-by: Eric Blake <eblake@redhat.com>
Message-ID: <20250529203147.180338-1-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 2e887187454e57d04522099d4f04d17137d6e05c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

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
2.47.2


