Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 269C97874A1
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 17:54:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZCeq-0000lb-0l; Thu, 24 Aug 2023 11:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qZCen-0000ij-Fz
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:54:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qZCek-0007lT-VF
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:54:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692892438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UyzJiT6RO5iFaFGbDwX36ckIuPAI5eTspml7T3pjtjw=;
 b=cx8YU5jjaXCI8Nu9EWvmpg4CGBJANhYr516DcZz5kO4OchI5V76GcpmCtfu017AO5iCV2C
 RNglp807sFHjZa07vp1VKLq8MQ0UBq3v0lMQ4H1Pv+F02sOB8WG2W+XeJuTizsdHEF8Vvd
 I4Mbf3vkpfuFol5zBsW8WK0AbJEwfnw=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-PP7tA6_gOwaGbtGpaG3WHA-1; Thu, 24 Aug 2023 11:53:54 -0400
X-MC-Unique: PP7tA6_gOwaGbtGpaG3WHA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 87B2E3810D46;
 Thu, 24 Aug 2023 15:53:54 +0000 (UTC)
Received: from localhost (unknown [10.39.193.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 427EB1121314;
 Thu, 24 Aug 2023 15:53:54 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Sam Li <faithilikerun@gmail.com>
Subject: [PATCH 5/5] tests/file-io-error: New test
Date: Thu, 24 Aug 2023 17:53:44 +0200
Message-ID: <20230824155345.109765-6-hreitz@redhat.com>
In-Reply-To: <20230824155345.109765-1-hreitz@redhat.com>
References: <20230824155345.109765-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is a regression test for
https://bugzilla.redhat.com/show_bug.cgi?id=2234374.

All this test needs to do is trigger an I/O error inside of file-posix
(specifically raw_co_prw()).  One reliable way to do this without
requiring special privileges is to use a FUSE export, which allows us to
inject any error that we want, e.g. via blkdebug.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 tests/qemu-iotests/tests/file-io-error     | 99 ++++++++++++++++++++++
 tests/qemu-iotests/tests/file-io-error.out | 31 +++++++
 2 files changed, 130 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/file-io-error
 create mode 100644 tests/qemu-iotests/tests/file-io-error.out

diff --git a/tests/qemu-iotests/tests/file-io-error b/tests/qemu-iotests/tests/file-io-error
new file mode 100755
index 0000000000..a47ad0a678
--- /dev/null
+++ b/tests/qemu-iotests/tests/file-io-error
@@ -0,0 +1,99 @@
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
+_send_qemu_cmd $QEMU_HANDLE \
+    "{'execute': 'block-export-add',
+      'arguments': {
+          'id': 'exp0',
+          'type': 'fuse',
+          'node-name': 'node0',
+          'mountpoint': '$TEST_DIR/fuse-export',
+          'writable': true
+      }}" \
+    'return'
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
index 0000000000..4e6758c62c
--- /dev/null
+++ b/tests/qemu-iotests/tests/file-io-error.out
@@ -0,0 +1,31 @@
+QA output created by file-io-error
+{'execute': 'qmp_capabilities'}
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
+{'execute': 'blockdev-del',
+      'arguments': {'node-name': 'node0'}}
+{"return": {}}
+*** done
-- 
2.41.0


