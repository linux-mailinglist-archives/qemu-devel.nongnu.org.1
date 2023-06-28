Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3A4741393
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 16:18:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEVxd-0008Df-DQ; Wed, 28 Jun 2023 10:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qEVxU-0008DG-J5
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 10:15:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qEVxS-00058n-8F
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 10:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687961744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=algdDuAwUlI+YTY9cX6huJ2i/sKUXW88SDJZHMJOPOo=;
 b=WdT1BWkj2Revz67kM+hNoK35N9FPXR9jrjp6Xno07ZbTNVVYmIiBU9Oq3roGBmgLZSbbsL
 vjp6XIHfju33U4YH98BE+ZM+hHaYq8+q5mPMX228OrbZf4uhpv4kRBOOSisudgS2SwfT/c
 DMr3Lsgzq1/ssLybGlG8WLGIbReeI1Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-219-I2IwNWt8P6GlFoNu_PLwtQ-1; Wed, 28 Jun 2023 10:15:41 -0400
X-MC-Unique: I2IwNWt8P6GlFoNu_PLwtQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1767A1064A78;
 Wed, 28 Jun 2023 14:15:41 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.195.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 614FB40C2063;
 Wed, 28 Jun 2023 14:15:40 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 01/23] iotests: Test active commit with iothread and background
 I/O
Date: Wed, 28 Jun 2023 16:15:04 +0200
Message-ID: <20230628141526.293104-2-kwolf@redhat.com>
In-Reply-To: <20230628141526.293104-1-kwolf@redhat.com>
References: <20230628141526.293104-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This is a better regression test for the bugs hidden by commit 80fc5d26
('graph-lock: Disable locking for now'). With that commit reverted, it
hangs instantaneously and reliably for me.

It is important to have a reliable test like this, because the following
commits will set out to fix the actual root cause of the deadlocks and
then finally revert commit 80fc5d26, which was only a stopgap solution.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20230605085711.21261-2-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 .../tests/iothreads-commit-active             | 85 +++++++++++++++++++
 .../tests/iothreads-commit-active.out         | 23 +++++
 2 files changed, 108 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/iothreads-commit-active
 create mode 100644 tests/qemu-iotests/tests/iothreads-commit-active.out

diff --git a/tests/qemu-iotests/tests/iothreads-commit-active b/tests/qemu-iotests/tests/iothreads-commit-active
new file mode 100755
index 0000000000..4010a4871f
--- /dev/null
+++ b/tests/qemu-iotests/tests/iothreads-commit-active
@@ -0,0 +1,85 @@
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
+import asyncio
+import iotests
+
+iotests.script_initialize(supported_fmts=['qcow2'],
+                          supported_platforms=['linux'])
+iotests.verify_virtio_scsi_pci_or_ccw()
+
+with iotests.FilePath('disk0.img') as img_path, \
+     iotests.FilePath('disk0-snap.img') as snap_path, \
+     iotests.FilePath('mirror-src.img') as src_path, \
+     iotests.FilePath('mirror-dst.img') as dst_path, \
+     iotests.VM() as vm:
+
+    img_size = '10M'
+    iotests.qemu_img_create('-f', iotests.imgfmt, img_path, img_size)
+    iotests.qemu_img_create('-f', iotests.imgfmt, '-b', img_path,
+                            '-F', iotests.imgfmt, snap_path)
+    iotests.qemu_img_create('-f', iotests.imgfmt, src_path, img_size)
+    iotests.qemu_img_create('-f', iotests.imgfmt, dst_path, img_size)
+
+    iotests.qemu_io_log('-c', 'write 0 64k', img_path)
+    iotests.qemu_io_log('-c', 'write 1M 64k', snap_path)
+    iotests.qemu_io_log('-c', 'write 3M 64k', snap_path)
+
+    iotests.qemu_io_log('-c', f'write 0 {img_size}', src_path)
+
+    iotests.log('Launching VM...')
+    vm.add_object('iothread,id=iothread0')
+    vm.add_object('throttle-group,x-bps-write=1048576,id=tg0')
+    vm.add_blockdev(f'file,node-name=disk0-file,filename={img_path}')
+    vm.add_blockdev('qcow2,node-name=disk0-fmt,file=disk0-file')
+    vm.add_drive(snap_path, 'backing=disk0-fmt,node-name=disk0',
+                 interface='none')
+    vm.add_device('virtio-scsi,iothread=iothread0')
+    vm.add_device('scsi-hd,drive=drive0')
+
+    vm.add_blockdev(f'file,filename={src_path},node-name=mirror-src-file')
+    vm.add_blockdev('qcow2,file=mirror-src-file,node-name=mirror-src')
+    vm.add_blockdev(f'file,filename={dst_path},node-name=mirror-dst-file')
+    vm.add_blockdev('qcow2,file=mirror-dst-file,node-name=mirror-dst-fmt')
+    vm.add_blockdev('throttle,throttle-group=tg0,file=mirror-dst-fmt,'
+                    'node-name=mirror-dst')
+    vm.add_device('scsi-hd,drive=mirror-src')
+
+    vm.launch()
+
+    # The background I/O is created on unrelated nodes (so that they won't be
+    # drained together with the other ones), but on the same iothread
+    iotests.log('Creating some background I/O...')
+    iotests.log(vm.qmp('blockdev-mirror', job_id='job0', sync='full',
+                       device='mirror-src', target='mirror-dst',
+                       auto_dismiss=False))
+
+    iotests.log('Starting active commit...')
+    iotests.log(vm.qmp('block-commit', device='disk0', job_id='job1',
+                       auto_dismiss=False))
+
+    # Should succeed and not time out
+    try:
+        vm.run_job('job1', wait=5.0)
+        vm.shutdown()
+    except asyncio.TimeoutError:
+        # VM may be stuck, kill it
+        vm.kill()
+        raise
diff --git a/tests/qemu-iotests/tests/iothreads-commit-active.out b/tests/qemu-iotests/tests/iothreads-commit-active.out
new file mode 100644
index 0000000000..4afd50b8d3
--- /dev/null
+++ b/tests/qemu-iotests/tests/iothreads-commit-active.out
@@ -0,0 +1,23 @@
+wrote 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+wrote 65536/65536 bytes at offset 1048576
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+wrote 65536/65536 bytes at offset 3145728
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+wrote 10485760/10485760 bytes at offset 0
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+Launching VM...
+Creating some background I/O...
+{"return": {}}
+Starting active commit...
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "job1"}}
+{"return": {}}
+{"data": {"device": "job1", "len": 131072, "offset": 131072, "speed": 0, "type": "commit"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "job1", "len": 131072, "offset": 131072, "speed": 0, "type": "commit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "job1"}}
+{"return": {}}
-- 
2.41.0


