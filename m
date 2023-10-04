Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5717B7987
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:05:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnwsN-0001Sh-V8; Wed, 04 Oct 2023 04:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwrB-0006l6-Bx; Wed, 04 Oct 2023 04:03:47 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwr7-0008IK-SG; Wed, 04 Oct 2023 04:03:43 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E92582759B;
 Wed,  4 Oct 2023 11:02:25 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4A4612CBD7;
 Wed,  4 Oct 2023 11:02:25 +0300 (MSK)
Received: (nullmailer pid 2702801 invoked by uid 1000);
 Wed, 04 Oct 2023 08:02:21 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.2 17/45] tests/file-io-error: New test
Date: Wed,  4 Oct 2023 11:01:38 +0300
Message-Id: <20231004080221.2702636-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.2-20231003193203@cover.tls.msk.ru>
References: <qemu-stable-8.1.2-20231003193203@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Hanna Czenczek <hreitz@redhat.com>

This is a regression test for
https://bugzilla.redhat.com/show_bug.cgi?id=2234374.

All this test needs to do is trigger an I/O error inside of file-posix
(specifically raw_co_prw()).  One reliable way to do this without
requiring special privileges is to use a FUSE export, which allows us to
inject any error that we want, e.g. via blkdebug.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-Id: <20230824155345.109765-6-hreitz@redhat.com>
[hreitz: Fixed test to be skipped when there is no FUSE support, to
         suppress fusermount's allow_other warning, and to be skipped
         with $IMGOPTSSYNTAX enabled]
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
(cherry picked from commit 380448464dd89291cf7fd7434be6c225482a334d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qemu-iotests/tests/file-io-error b/tests/qemu-iotests/tests/file-io-error
new file mode 100755
index 0000000000..88ee5f670c
--- /dev/null
+++ b/tests/qemu-iotests/tests/file-io-error
@@ -0,0 +1,119 @@
+#!/usr/bin/env bash
+# group: rw
+#
+# Produce an I/O error in file-posix, and hope that it is not catastrophic.
+# Regression test for: https://bugzilla.redhat.com/show_bug.cgi?id=2234374
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
+seq=$(basename "$0")
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+
+_cleanup()
+{
+    _cleanup_qemu
+    rm -f "$TEST_DIR/fuse-export"
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ../common.rc
+. ../common.filter
+. ../common.qemu
+
+# Format-agnostic (we do not use any), but we do test the file protocol
+_supported_proto file
+_require_drivers blkdebug null-co
+
+if [ "$IMGOPTSSYNTAX" = "true" ]; then
+    # We need `$QEMU_IO -f file` to work; IMGOPTSSYNTAX uses --image-opts,
+    # breaking -f.
+    _unsupported_fmt $IMGFMT
+fi
+
+# This is a regression test of a bug in which flie-posix would access zone
+# information in case of an I/O error even when there is no zone information,
+# resulting in a division by zero.
+# To reproduce the problem, we need to trigger an I/O error inside of
+# file-posix, which can be done (rootless) by providing a FUSE export that
+# presents only errors when accessed.
+
+_launch_qemu
+_send_qemu_cmd $QEMU_HANDLE \
+    "{'execute': 'qmp_capabilities'}" \
+    'return'
+
+_send_qemu_cmd $QEMU_HANDLE \
+    "{'execute': 'blockdev-add',
+      'arguments': {
+          'driver': 'blkdebug',
+          'node-name': 'node0',
+          'inject-error': [{'event': 'none'}],
+          'image': {
+              'driver': 'null-co'
+          }
+      }}" \
+    'return'
+
+# FUSE mountpoint must exist and be a regular file
+touch "$TEST_DIR/fuse-export"
+
+# The grep -v to filter fusermount's (benign) error when /etc/fuse.conf does
+# not contain user_allow_other and the subsequent check for missing FUSE support
+# have both been taken from iotest 308.
+output=$(_send_qemu_cmd $QEMU_HANDLE \
+    "{'execute': 'block-export-add',
+      'arguments': {
+          'id': 'exp0',
+          'type': 'fuse',
+          'node-name': 'node0',
+          'mountpoint': '$TEST_DIR/fuse-export',
+          'writable': true
+      }}" \
+    'return' \
+    | grep -v 'option allow_other only allowed if')
+
+if echo "$output" | grep -q "Parameter 'type' does not accept value 'fuse'"; then
+    _notrun 'No FUSE support'
+fi
+echo "$output"
+
+echo
+# This should fail, but gracefully, i.e. just print an I/O error, not crash.
+$QEMU_IO -f file -c 'write 0 64M' "$TEST_DIR/fuse-export" | _filter_qemu_io
+echo
+
+_send_qemu_cmd $QEMU_HANDLE \
+    "{'execute': 'block-export-del',
+      'arguments': {'id': 'exp0'}}" \
+    'return'
+
+_send_qemu_cmd $QEMU_HANDLE \
+    '' \
+    'BLOCK_EXPORT_DELETED'
+
+_send_qemu_cmd $QEMU_HANDLE \
+    "{'execute': 'blockdev-del',
+      'arguments': {'node-name': 'node0'}}" \
+    'return'
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/tests/file-io-error.out b/tests/qemu-iotests/tests/file-io-error.out
new file mode 100644
index 0000000000..0f46455a94
--- /dev/null
+++ b/tests/qemu-iotests/tests/file-io-error.out
@@ -0,0 +1,33 @@
+QA output created by file-io-error
+{'execute': 'qmp_capabilities'}
+{"return": {}}
+{'execute': 'blockdev-add',
+      'arguments': {
+          'driver': 'blkdebug',
+          'node-name': 'node0',
+          'inject-error': [{'event': 'none'}],
+          'image': {
+              'driver': 'null-co'
+          }
+      }}
+{"return": {}}
+{'execute': 'block-export-add',
+      'arguments': {
+          'id': 'exp0',
+          'type': 'fuse',
+          'node-name': 'node0',
+          'mountpoint': 'TEST_DIR/fuse-export',
+          'writable': true
+      }}
+{"return": {}}
+
+write failed: Input/output error
+
+{'execute': 'block-export-del',
+      'arguments': {'id': 'exp0'}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_EXPORT_DELETED", "data": {"id": "exp0"}}
+{'execute': 'blockdev-del',
+      'arguments': {'node-name': 'node0'}}
+{"return": {}}
+*** done
-- 
2.39.2


