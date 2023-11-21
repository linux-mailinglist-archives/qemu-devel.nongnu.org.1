Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 645207F2C1C
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 12:54:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5PJp-0003TB-69; Tue, 21 Nov 2023 06:53:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r5PJe-0003Q5-HY
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 06:53:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r5PJb-0004I7-Ms
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 06:53:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700567595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fxqQaIbtWzaDK7C1q7TBvQJn2zQauO6g1ptKjSvqdSc=;
 b=YQpBgJbH9XA6lX3ngGaM5GGoj4dKci2acEKXmHycb0AMTdKYOE8r+RfpLb0Q0Yxbp1I3DZ
 wcO8gcdwkzN6yQogGWUC+og8M5e9dfQ2a8Ohevu3nv2bdzOapk+c9w1+DJDtbV8tYiCe1E
 rDJZKThb6jvuBvmNaqiJHykUYlHF4Ss=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-dldBfph6P4eni04goEz39w-1; Tue, 21 Nov 2023 06:53:11 -0500
X-MC-Unique: dldBfph6P4eni04goEz39w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 961DD185A7A5;
 Tue, 21 Nov 2023 11:53:11 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 05D03492BFC;
 Tue, 21 Nov 2023 11:53:10 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 5/9] iotests: Test two stream jobs in a single iothread
Date: Tue, 21 Nov 2023 12:52:58 +0100
Message-ID: <20231121115302.52214-6-kwolf@redhat.com>
In-Reply-To: <20231121115302.52214-1-kwolf@redhat.com>
References: <20231121115302.52214-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This tests two parallel stream jobs that will complete around the same
time and run on two different disks in the same iothreads. It is loosely
based on the bug report at https://issues.redhat.com/browse/RHEL-1761.

For me, this test hangs reliably with the originally reported bug in
blk_remove_bs(). After fixing it, it intermittently hangs for the bugs
fixed after it, missing AioContext unlocking in bdrv_graph_wrunlock()
and in stream_prepare(). The deadlocks seem to happen more frequently
when the test directory is on tmpfs.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20231115172012.112727-5-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/tests/iothreads-stream     | 74 +++++++++++++++++++
 tests/qemu-iotests/tests/iothreads-stream.out | 11 +++
 2 files changed, 85 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/iothreads-stream
 create mode 100644 tests/qemu-iotests/tests/iothreads-stream.out

diff --git a/tests/qemu-iotests/tests/iothreads-stream b/tests/qemu-iotests/tests/iothreads-stream
new file mode 100755
index 0000000000..503f221f16
--- /dev/null
+++ b/tests/qemu-iotests/tests/iothreads-stream
@@ -0,0 +1,74 @@
+#!/usr/bin/env python3
+# group: rw quick auto
+#
+# Copyright (C) 2023 Red Hat, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+# Creator/Owner: Kevin Wolf <kwolf@redhat.com>
+
+import iotests
+
+iotests.script_initialize(supported_fmts=['qcow2'],
+                          supported_platforms=['linux'])
+iotests.verify_virtio_scsi_pci_or_ccw()
+
+with iotests.FilePath('disk1.img') as base1_path, \
+     iotests.FilePath('disk1-snap.img') as snap1_path, \
+     iotests.FilePath('disk2.img') as base2_path, \
+     iotests.FilePath('disk2-snap.img') as snap2_path, \
+     iotests.VM() as vm:
+
+    img_size = '10M'
+
+    # Only one iothread for both disks
+    vm.add_object('iothread,id=iothread0')
+    vm.add_device('virtio-scsi,iothread=iothread0')
+
+    iotests.log('Preparing disks...')
+    for i, base_path, snap_path in ((0, base1_path, snap1_path),
+                                    (1, base2_path, snap2_path)):
+        iotests.qemu_img_create('-f', iotests.imgfmt, base_path, img_size)
+        iotests.qemu_img_create('-f', iotests.imgfmt, '-b', base_path,
+                                '-F', iotests.imgfmt, snap_path)
+
+        iotests.qemu_io_log('-c', f'write 0 {img_size}', base_path)
+
+        vm.add_blockdev(f'file,node-name=disk{i}-base-file,'
+                        f'filename={base_path}')
+        vm.add_blockdev(f'qcow2,node-name=disk{i}-base,file=disk{i}-base-file')
+        vm.add_blockdev(f'file,node-name=disk{i}-file,filename={snap_path}')
+        vm.add_blockdev(f'qcow2,node-name=disk{i},file=disk{i}-file,'
+                        f'backing=disk{i}-base')
+        vm.add_device(f'scsi-hd,drive=disk{i}')
+
+    iotests.log('Launching VM...')
+    vm.launch()
+
+    iotests.log('Starting stream jobs...')
+    iotests.log(vm.qmp('block-stream', device='disk0', job_id='job0'))
+    iotests.log(vm.qmp('block-stream', device='disk1', job_id='job1'))
+
+    finished = 0
+    while True:
+        try:
+            ev = vm.event_wait('JOB_STATUS_CHANGE', timeout=0.1)
+            if ev is not None and ev['data']['status'] == 'null':
+                finished += 1
+                # The test is done once both jobs are gone
+                if finished == 2:
+                    break
+        except TimeoutError:
+            pass
+        vm.cmd('query-jobs')
diff --git a/tests/qemu-iotests/tests/iothreads-stream.out b/tests/qemu-iotests/tests/iothreads-stream.out
new file mode 100644
index 0000000000..ef134165e5
--- /dev/null
+++ b/tests/qemu-iotests/tests/iothreads-stream.out
@@ -0,0 +1,11 @@
+Preparing disks...
+wrote 10485760/10485760 bytes at offset 0
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+wrote 10485760/10485760 bytes at offset 0
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+Launching VM...
+Starting stream jobs...
+{"return": {}}
+{"return": {}}
-- 
2.42.0


