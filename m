Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8904A2F2BA
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Feb 2025 17:13:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWO9-0006pE-3q; Mon, 10 Feb 2025 11:12:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thWNs-0006h8-TI
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:11:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thWNp-00017z-TS
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:11:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739203901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yzw6kPQK4fjsn/KDPQEjLySTEtEaxHvhHdbz5V3w+cw=;
 b=J7qYivGwVgw1ObYdvxOnf3If0/TG/Wc63jJH98TS6DClu6W/ASPb4DTQVlbSzNwFhsoGX0
 zxNvr/qnmQQ4/eRmRJI8T1pVwcLr3tPnPwFFmf/63gvtUzM/s47QK/kvhIkpP1hLtospoF
 XDTBtQXbw5rfc0DrIp4V/UbYJVn+498=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-vfnsuIUrMNW6wM7MpzG0jA-1; Mon,
 10 Feb 2025 11:11:39 -0500
X-MC-Unique: vfnsuIUrMNW6wM7MpzG0jA-1
X-Mimecast-MFC-AGG-ID: vfnsuIUrMNW6wM7MpzG0jA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D43319560AA; Mon, 10 Feb 2025 16:11:33 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.225.156])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D817C195608D; Mon, 10 Feb 2025 16:11:31 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 23/25] iotests: Add qsd-migrate case
Date: Mon, 10 Feb 2025 17:10:32 +0100
Message-ID: <20250210161034.76494-24-kwolf@redhat.com>
In-Reply-To: <20250210161034.76494-1-kwolf@redhat.com>
References: <20250210161034.76494-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Test that it's possible to migrate a VM that uses an image on shared
storage through qemu-storage-daemon.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Acked-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-ID: <20250204211407.381505-16-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/tests/qsd-migrate     | 140 +++++++++++++++++++++++
 tests/qemu-iotests/tests/qsd-migrate.out |  59 ++++++++++
 2 files changed, 199 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/qsd-migrate
 create mode 100644 tests/qemu-iotests/tests/qsd-migrate.out

diff --git a/tests/qemu-iotests/tests/qsd-migrate b/tests/qemu-iotests/tests/qsd-migrate
new file mode 100755
index 0000000000..de17562cb0
--- /dev/null
+++ b/tests/qemu-iotests/tests/qsd-migrate
@@ -0,0 +1,140 @@
+#!/usr/bin/env python3
+# group: rw quick
+#
+# Copyright (C) Red Hat, Inc.
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
+from iotests import filter_qemu_io, filter_qtest
+
+iotests.script_initialize(supported_fmts=['generic'],
+                          supported_protocols=['file'],
+                          supported_platforms=['linux'])
+
+with iotests.FilePath('disk.img') as path, \
+     iotests.FilePath('nbd-src.sock', base_dir=iotests.sock_dir) as nbd_src, \
+     iotests.FilePath('nbd-dst.sock', base_dir=iotests.sock_dir) as nbd_dst, \
+     iotests.FilePath('migrate.sock', base_dir=iotests.sock_dir) as mig_sock, \
+     iotests.VM(path_suffix="-src") as vm_src, \
+     iotests.VM(path_suffix="-dst") as vm_dst:
+
+    img_size = '10M'
+
+    iotests.log('Preparing disk...')
+    iotests.qemu_img_create('-f', iotests.imgfmt, path, img_size)
+
+    iotests.log('Launching source QSD...')
+    qsd_src = iotests.QemuStorageDaemon(
+        '--blockdev', f'file,node-name=disk-file,filename={path}',
+        '--blockdev', f'{iotests.imgfmt},file=disk-file,node-name=disk-fmt',
+        '--nbd-server', f'addr.type=unix,addr.path={nbd_src}',
+        '--export', 'nbd,id=exp0,node-name=disk-fmt,writable=true,'
+                    'allow-inactive=true',
+        qmp=True,
+    )
+
+    iotests.log('Launching source VM...')
+    vm_src.add_args('-blockdev', f'nbd,node-name=disk,server.type=unix,'
+                                 f'server.path={nbd_src},export=disk-fmt')
+    vm_src.add_args('-device', 'virtio-blk,drive=disk,id=virtio0')
+    vm_src.launch()
+
+    iotests.log('Launching destination QSD...')
+    qsd_dst = iotests.QemuStorageDaemon(
+        '--blockdev', f'file,node-name=disk-file,filename={path},active=off',
+        '--blockdev', f'{iotests.imgfmt},file=disk-file,node-name=disk-fmt,'
+                      f'active=off',
+        '--nbd-server', f'addr.type=unix,addr.path={nbd_dst}',
+        '--export', 'nbd,id=exp0,node-name=disk-fmt,writable=true,'
+                    'allow-inactive=true',
+        qmp=True,
+        instance_id='b',
+    )
+
+    iotests.log('Launching destination VM...')
+    vm_dst.add_args('-blockdev', f'nbd,node-name=disk,server.type=unix,'
+                                 f'server.path={nbd_dst},export=disk-fmt')
+    vm_dst.add_args('-device', 'virtio-blk,drive=disk,id=virtio0')
+    vm_dst.add_args('-incoming', f'unix:{mig_sock}')
+    vm_dst.launch()
+
+    iotests.log('\nTest I/O on the source')
+    vm_src.hmp_qemu_io('virtio0/virtio-backend', 'write -P 0x11 0 4k',
+                       use_log=True, qdev=True)
+    vm_src.hmp_qemu_io('virtio0/virtio-backend', 'read -P 0x11 0 4k',
+                       use_log=True, qdev=True)
+
+    iotests.log('\nStarting migration...')
+
+    mig_caps = [
+        {'capability': 'events', 'state': True},
+        {'capability': 'pause-before-switchover', 'state': True},
+    ]
+    vm_src.qmp_log('migrate-set-capabilities', capabilities=mig_caps)
+    vm_dst.qmp_log('migrate-set-capabilities', capabilities=mig_caps)
+    vm_src.qmp_log('migrate', uri=f'unix:{mig_sock}',
+                   filters=[iotests.filter_qmp_testfiles])
+
+    vm_src.event_wait('MIGRATION',
+                      match={'data': {'status': 'pre-switchover'}})
+
+    iotests.log('\nPre-switchover: Reconfigure QSD instances')
+
+    iotests.log(qsd_src.qmp('blockdev-set-active', {'active': False}))
+
+    # Reading is okay from both sides while the image is inactive. Note that
+    # the destination may have stale data until it activates the image, though.
+    vm_src.hmp_qemu_io('virtio0/virtio-backend', 'read -P 0x11 0 4k',
+                       use_log=True, qdev=True)
+    vm_dst.hmp_qemu_io('virtio0/virtio-backend', 'read 0 4k',
+                       use_log=True, qdev=True)
+
+    iotests.log(qsd_dst.qmp('blockdev-set-active', {'active': True}))
+
+    iotests.log('\nCompleting migration...')
+
+    vm_src.qmp_log('migrate-continue', state='pre-switchover')
+    vm_dst.event_wait('MIGRATION', match={'data': {'status': 'completed'}})
+
+    iotests.log('\nTest I/O on the destination')
+
+    # Now the destination must see what the source wrote
+    vm_dst.hmp_qemu_io('virtio0/virtio-backend', 'read -P 0x11 0 4k',
+                       use_log=True, qdev=True)
+
+    # And be able to overwrite it
+    vm_dst.hmp_qemu_io('virtio0/virtio-backend', 'write -P 0x22 0 4k',
+                       use_log=True, qdev=True)
+    vm_dst.hmp_qemu_io('virtio0/virtio-backend', 'read -P 0x22 0 4k',
+                       use_log=True, qdev=True)
+
+    iotests.log('\nDone')
+
+    vm_src.shutdown()
+    iotests.log('\n--- vm_src log ---')
+    log = vm_src.get_log()
+    if log:
+        iotests.log(log, [filter_qtest, filter_qemu_io])
+    qsd_src.stop()
+
+    vm_dst.shutdown()
+    iotests.log('\n--- vm_dst log ---')
+    log = vm_dst.get_log()
+    if log:
+        iotests.log(log, [filter_qtest, filter_qemu_io])
+    qsd_dst.stop()
diff --git a/tests/qemu-iotests/tests/qsd-migrate.out b/tests/qemu-iotests/tests/qsd-migrate.out
new file mode 100644
index 0000000000..4a5241e5d4
--- /dev/null
+++ b/tests/qemu-iotests/tests/qsd-migrate.out
@@ -0,0 +1,59 @@
+Preparing disk...
+Launching source QSD...
+Launching source VM...
+Launching destination QSD...
+Launching destination VM...
+
+Test I/O on the source
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io -d virtio0/virtio-backend \"write -P 0x11 0 4k\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io -d virtio0/virtio-backend \"read -P 0x11 0 4k\""}}
+{"return": ""}
+
+Starting migration...
+{"execute": "migrate-set-capabilities", "arguments": {"capabilities": [{"capability": "events", "state": true}, {"capability": "pause-before-switchover", "state": true}]}}
+{"return": {}}
+{"execute": "migrate-set-capabilities", "arguments": {"capabilities": [{"capability": "events", "state": true}, {"capability": "pause-before-switchover", "state": true}]}}
+{"return": {}}
+{"execute": "migrate", "arguments": {"uri": "unix:SOCK_DIR/PID-migrate.sock"}}
+{"return": {}}
+
+Pre-switchover: Reconfigure QSD instances
+{"return": {}}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io -d virtio0/virtio-backend \"read -P 0x11 0 4k\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io -d virtio0/virtio-backend \"read 0 4k\""}}
+{"return": ""}
+{"return": {}}
+
+Completing migration...
+{"execute": "migrate-continue", "arguments": {"state": "pre-switchover"}}
+{"return": {}}
+
+Test I/O on the destination
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io -d virtio0/virtio-backend \"read -P 0x11 0 4k\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io -d virtio0/virtio-backend \"write -P 0x22 0 4k\""}}
+{"return": ""}
+{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io -d virtio0/virtio-backend \"read -P 0x22 0 4k\""}}
+{"return": ""}
+
+Done
+
+--- vm_src log ---
+wrote 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- vm_dst log ---
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-- 
2.48.1


