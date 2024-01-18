Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4A5831361
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 08:55:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQNE9-0000Ng-EW; Thu, 18 Jan 2024 02:54:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQNE7-0000Mt-0H; Thu, 18 Jan 2024 02:54:15 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQNE4-0007Jk-Fz; Thu, 18 Jan 2024 02:54:14 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F14724502D;
 Thu, 18 Jan 2024 10:54:34 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 278EF66196;
 Thu, 18 Jan 2024 10:54:05 +0300 (MSK)
Received: (nullmailer pid 2381637 invoked by uid 1000);
 Thu, 18 Jan 2024 07:54:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.1 03/38] iotests: Basic tests for internal snapshots
Date: Thu, 18 Jan 2024 10:52:30 +0300
Message-Id: <20240118075404.2381519-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.1-20240118102508@cover.tls.msk.ru>
References: <qemu-stable-8.2.1-20240118102508@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Kevin Wolf <kwolf@redhat.com>

We have a few test cases that include tests for corner case aspects of
internal snapshots, but nothing that tests that they actually function
as snapshots or that involves deleting a snapshot. Add a test for this
kind of basic internal snapshot functionality.

The error cases include a regression test for the crash we just fixed
with snapshot operations on inactive images.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20231201142520.32255-4-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit bb6e2511eb48539b7dcbcb5f47772e156b9c45d1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qemu-iotests/tests/qcow2-internal-snapshots b/tests/qemu-iotests/tests/qcow2-internal-snapshots
new file mode 100755
index 0000000000..36523aba06
--- /dev/null
+++ b/tests/qemu-iotests/tests/qcow2-internal-snapshots
@@ -0,0 +1,170 @@
+#!/usr/bin/env bash
+# group: rw quick
+#
+# Test case for internal snapshots in qcow2
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
+
+# creator
+owner=kwolf@redhat.com
+
+seq="$(basename $0)"
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+
+_cleanup()
+{
+	_cleanup_test_img
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ../common.rc
+. ../common.filter
+
+# This tests qcow2-specific low-level functionality
+_supported_fmt qcow2
+_supported_proto generic
+# Internal snapshots are (currently) impossible with refcount_bits=1,
+# and generally impossible with external data files
+_unsupported_imgopts 'compat=0.10' 'refcount_bits=1[^0-9]' data_file
+
+IMG_SIZE=64M
+
+_qemu()
+{
+    $QEMU -no-shutdown -nographic -monitor stdio -serial none \
+          -blockdev file,filename="$TEST_IMG",node-name=disk0-file \
+          -blockdev "$IMGFMT",file=disk0-file,node-name=disk0 \
+          -object iothread,id=iothread0 \
+          -device virtio-scsi,iothread=iothread0 \
+          -device scsi-hd,drive=disk0,share-rw=on \
+          "$@" 2>&1 |\
+    _filter_qemu | _filter_hmp | _filter_qemu_io
+}
+
+_make_test_img $IMG_SIZE
+
+echo
+echo "=== Write some data, take a snapshot and overwrite part of it ==="
+echo
+
+{
+    echo 'qemu-io disk0 "write -P0x11 0 1M"'
+    # Give qemu some time to boot before saving the VM state
+    sleep 0.5
+    echo "savevm snap0"
+    echo 'qemu-io disk0 "write -P0x22 0 512k"'
+    echo "quit"
+} | _qemu
+
+echo
+$QEMU_IMG snapshot -l "$TEST_IMG" | _filter_date | _filter_vmstate_size
+_check_test_img
+
+echo
+echo "=== Verify that loading the snapshot reverts to the old content ==="
+echo
+
+{
+    # -loadvm reverted the write from the previous QEMU instance
+    echo 'qemu-io disk0 "read -P0x11 0 1M"'
+
+    # Verify that it works without restarting QEMU, too
+    echo 'qemu-io disk0 "write -P0x33 512k 512k"'
+    echo "loadvm snap0"
+    echo 'qemu-io disk0 "read -P0x11 0 1M"'
+
+    # Verify COW by writing a partial cluster
+    echo 'qemu-io disk0 "write -P0x33 63k 2k"'
+    echo 'qemu-io disk0 "read -P0x11 0 63k"'
+    echo 'qemu-io disk0 "read -P0x33 63k 2k"'
+    echo 'qemu-io disk0 "read -P0x11 65k 63k"'
+
+    # Take a second snapshot
+    echo "savevm snap1"
+
+    echo "quit"
+} | _qemu -loadvm snap0
+
+echo
+$QEMU_IMG snapshot -l "$TEST_IMG" | _filter_date | _filter_vmstate_size
+_check_test_img
+
+echo
+echo "=== qemu-img snapshot can revert to snapshots ==="
+echo
+
+$QEMU_IMG snapshot -a snap0 "$TEST_IMG"
+$QEMU_IO -c "read -P0x11 0 1M" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IMG snapshot -a snap1 "$TEST_IMG"
+$QEMU_IO \
+    -c "read -P0x11 0 63k" \
+    -c "read -P0x33 63k 2k" \
+    -c "read -P0x11 65k 63k" \
+    "$TEST_IMG" | _filter_qemu_io
+
+echo
+echo "=== Deleting snapshots ==="
+echo
+{
+    # The active layer stays unaffected by deleting the snapshot
+    echo "delvm snap1"
+    echo 'qemu-io disk0 "read -P0x11 0 63k"'
+    echo 'qemu-io disk0 "read -P0x33 63k 2k"'
+    echo 'qemu-io disk0 "read -P0x11 65k 63k"'
+
+    echo "quit"
+} | _qemu
+
+
+echo
+$QEMU_IMG snapshot -l "$TEST_IMG" | _filter_date | _filter_vmstate_size
+_check_test_img
+
+echo
+echo "=== Error cases ==="
+echo
+
+# snap1 should not exist any more
+_qemu -loadvm snap1
+
+echo
+{
+    echo "loadvm snap1"
+    echo "quit"
+} | _qemu
+
+# Snapshot operations and inactive images are incompatible
+echo
+_qemu -loadvm snap0 -incoming defer
+{
+    echo "loadvm snap0"
+    echo "delvm snap0"
+    echo "savevm snap1"
+    echo "quit"
+} | _qemu -incoming defer
+
+# -loadvm and -preconfig are incompatible
+echo
+_qemu -loadvm snap0 -preconfig
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/tests/qcow2-internal-snapshots.out b/tests/qemu-iotests/tests/qcow2-internal-snapshots.out
new file mode 100644
index 0000000000..438f535e6a
--- /dev/null
+++ b/tests/qemu-iotests/tests/qcow2-internal-snapshots.out
@@ -0,0 +1,107 @@
+QA output created by qcow2-internal-snapshots
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+
+=== Write some data, take a snapshot and overwrite part of it ===
+
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) qemu-io disk0 "write -P0x11 0 1M"
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+(qemu) savevm snap0
+(qemu) qemu-io disk0 "write -P0x22 0 512k"
+wrote 524288/524288 bytes at offset 0
+512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+(qemu) quit
+
+Snapshot list:
+ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
+1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
+No errors were found on the image.
+
+=== Verify that loading the snapshot reverts to the old content ===
+
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) qemu-io disk0 "read -P0x11 0 1M"
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+(qemu) qemu-io disk0 "write -P0x33 512k 512k"
+wrote 524288/524288 bytes at offset 524288
+512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+(qemu) loadvm snap0
+(qemu) qemu-io disk0 "read -P0x11 0 1M"
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+(qemu) qemu-io disk0 "write -P0x33 63k 2k"
+wrote 2048/2048 bytes at offset 64512
+2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+(qemu) qemu-io disk0 "read -P0x11 0 63k"
+read 64512/64512 bytes at offset 0
+63 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+(qemu) qemu-io disk0 "read -P0x33 63k 2k"
+read 2048/2048 bytes at offset 64512
+2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+(qemu) qemu-io disk0 "read -P0x11 65k 63k"
+read 64512/64512 bytes at offset 66560
+63 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+(qemu) savevm snap1
+(qemu) quit
+
+Snapshot list:
+ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
+1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
+2         snap1                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
+No errors were found on the image.
+
+=== qemu-img snapshot can revert to snapshots ===
+
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 64512/64512 bytes at offset 0
+63 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 2048/2048 bytes at offset 64512
+2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 64512/64512 bytes at offset 66560
+63 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== Deleting snapshots ===
+
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) delvm snap1
+(qemu) qemu-io disk0 "read -P0x11 0 63k"
+read 64512/64512 bytes at offset 0
+63 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+(qemu) qemu-io disk0 "read -P0x33 63k 2k"
+read 2048/2048 bytes at offset 64512
+2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+(qemu) qemu-io disk0 "read -P0x11 65k 63k"
+read 64512/64512 bytes at offset 66560
+63 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+(qemu) quit
+
+Snapshot list:
+ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
+1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
+No errors were found on the image.
+
+=== Error cases ===
+
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) QEMU_PROG: Snapshot 'snap1' does not exist in one or more devices
+
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) loadvm snap1
+Error: Snapshot 'snap1' does not exist in one or more devices
+(qemu) quit
+
+QEMU_PROG: 'incoming' and 'loadvm' options are mutually exclusive
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) loadvm snap0
+Error: Device 'disk0' is writable but does not support snapshots
+(qemu) delvm snap0
+Error: Device 'disk0' is writable but does not support snapshots
+(qemu) savevm snap1
+Error: Device 'disk0' is writable but does not support snapshots
+(qemu) quit
+
+QEMU_PROG: 'preconfig' and 'loadvm' options are mutually exclusive
+*** done
-- 
2.39.2


