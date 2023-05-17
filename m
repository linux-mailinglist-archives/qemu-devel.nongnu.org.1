Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B48C5706CD9
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 17:29:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzJ5D-0002QA-TT; Wed, 17 May 2023 11:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1pzJ5C-0002O6-4U
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:28:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1pzJ5A-0000ug-Kq
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684337331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lFLcuMrJ88uqg8RrGhan+Qhyt2kDwpqYecyh3DxualQ=;
 b=XGZZyklmTbseTMlS1WpKICpWtmG8sFIvhCU3GW6JZI+U49Ej1BAt9duXEQIVRWB0V8iJ6S
 Ny0xm7yqcXmQ7j0g++SoOUBpp0+3gyDteYrYzI5XqV/S7GKKWJsgTg9GLC3ZX82ijjNYL4
 vwhXR0rAdwfnkOpwC2ALZNCmBJ/3Kyw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-39-RvarhIJpN2qEgRF8CoXPAw-1; Wed, 17 May 2023 11:28:50 -0400
X-MC-Unique: RvarhIJpN2qEgRF8CoXPAw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C35AA87DC1E;
 Wed, 17 May 2023 15:28:42 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7BBF81121314;
 Wed, 17 May 2023 15:28:41 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, mjt@tls.msk.ru,
 eblake@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Subject: [PATCH 3/3] iotests: Test commit with iothreads and ongoing I/O
Date: Wed, 17 May 2023 17:28:34 +0200
Message-Id: <20230517152834.277483-4-kwolf@redhat.com>
In-Reply-To: <20230517152834.277483-1-kwolf@redhat.com>
References: <20230517152834.277483-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This tests exercises graph locking, draining, and graph modifications
with AioContext switches a lot. Amongst others, it serves as a
regression test for bdrv_graph_wrlock() deadlocking because it is called
with a locked AioContext and for AioContext handling in the NBD server.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/iotests.py                 |  4 ++
 .../qemu-iotests/tests/graph-changes-while-io | 56 +++++++++++++++++--
 .../tests/graph-changes-while-io.out          |  4 +-
 3 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 3e82c634cf..7073579a7d 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -462,6 +462,10 @@ def qmp(self, cmd: str, args: Optional[Dict[str, object]] = None) \
         assert self._qmp is not None
         return self._qmp.cmd(cmd, args)
 
+    def get_qmp(self) -> QEMUMonitorProtocol:
+        assert self._qmp is not None
+        return self._qmp
+
     def stop(self, kill_signal=15):
         self._p.send_signal(kill_signal)
         self._p.wait()
diff --git a/tests/qemu-iotests/tests/graph-changes-while-io b/tests/qemu-iotests/tests/graph-changes-while-io
index 7664f33689..750e7d4d38 100755
--- a/tests/qemu-iotests/tests/graph-changes-while-io
+++ b/tests/qemu-iotests/tests/graph-changes-while-io
@@ -22,19 +22,19 @@
 import os
 from threading import Thread
 import iotests
-from iotests import imgfmt, qemu_img, qemu_img_create, QMPTestCase, \
-        QemuStorageDaemon
+from iotests import imgfmt, qemu_img, qemu_img_create, qemu_io, \
+        QMPTestCase, QemuStorageDaemon
 
 
 top = os.path.join(iotests.test_dir, 'top.img')
 nbd_sock = os.path.join(iotests.sock_dir, 'nbd.sock')
 
 
-def do_qemu_img_bench() -> None:
+def do_qemu_img_bench(count: int = 2000000) -> None:
     """
     Do some I/O requests on `nbd_sock`.
     """
-    qemu_img('bench', '-f', 'raw', '-c', '2000000',
+    qemu_img('bench', '-f', 'raw', '-c', str(count),
              f'nbd+unix:///node0?socket={nbd_sock}')
 
 
@@ -84,6 +84,54 @@ class TestGraphChangesWhileIO(QMPTestCase):
 
         bench_thr.join()
 
+    def test_commit_while_io(self) -> None:
+        # Run qemu-img bench in the background
+        bench_thr = Thread(target=do_qemu_img_bench, args=(200000, ))
+        bench_thr.start()
+
+        qemu_io('-c', 'write 0 64k', top)
+        qemu_io('-c', 'write 128k 64k', top)
+
+        result = self.qsd.qmp('blockdev-add', {
+            'driver': imgfmt,
+            'node-name': 'overlay',
+            'backing': None,
+            'file': {
+                'driver': 'file',
+                'filename': top
+            }
+        })
+        self.assert_qmp(result, 'return', {})
+
+        result = self.qsd.qmp('blockdev-snapshot', {
+            'node': 'node0',
+            'overlay': 'overlay',
+        })
+        self.assert_qmp(result, 'return', {})
+
+        # While qemu-img bench is running, repeatedly commit overlay to node0
+        while bench_thr.is_alive():
+            result = self.qsd.qmp('block-commit', {
+                'job-id': 'job0',
+                'device': 'overlay',
+            })
+            self.assert_qmp(result, 'return', {})
+
+            result = self.qsd.qmp('block-job-cancel', {
+                'device': 'job0',
+            })
+            self.assert_qmp(result, 'return', {})
+
+            cancelled = False
+            while not cancelled:
+                for event in self.qsd.get_qmp().get_events(wait=10.0):
+                    if event['event'] != 'JOB_STATUS_CHANGE':
+                        continue
+                    if event['data']['status'] == 'null':
+                        cancelled = True
+
+        bench_thr.join()
+
 if __name__ == '__main__':
     # Format must support raw backing files
     iotests.main(supported_fmts=['qcow', 'qcow2', 'qed'],
diff --git a/tests/qemu-iotests/tests/graph-changes-while-io.out b/tests/qemu-iotests/tests/graph-changes-while-io.out
index ae1213e6f8..fbc63e62f8 100644
--- a/tests/qemu-iotests/tests/graph-changes-while-io.out
+++ b/tests/qemu-iotests/tests/graph-changes-while-io.out
@@ -1,5 +1,5 @@
-.
+..
 ----------------------------------------------------------------------
-Ran 1 tests
+Ran 2 tests
 
 OK
-- 
2.40.1


