Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4CB832EBC
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 19:16:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQtNM-0001ih-8S; Fri, 19 Jan 2024 13:13:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQtNE-0001eH-Hf
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 13:13:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQtN9-0007dZ-9R
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 13:13:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705688022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xX/LqETDPHHCAR/ixbnRDJdbnZadDBuYH5MHn0GrT44=;
 b=N1w1sfeM0U9BsbH+d35nbC/zWJsvUnuDlpwCKGXvdge0zrdM9alVF/icESzPV/o27d8o/e
 Dhzu2fguRBjG/2j4RLw1vgiVfOXszr/BJf3Nke7zIqG+nD42+2owNm/K/edx9mhllOW6Ll
 Ndu/30HwNfHxOlmxEwO3ZICclZenLAc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-JIGSowUWNAq30O0xFNTt-A-1; Fri, 19 Jan 2024 13:13:38 -0500
X-MC-Unique: JIGSowUWNAq30O0xFNTt-A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D989A86794D;
 Fri, 19 Jan 2024 18:13:37 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 31002494;
 Fri, 19 Jan 2024 18:13:37 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 06/14] iotests: port 141 to Python for reliable QMP testing
Date: Fri, 19 Jan 2024 19:13:19 +0100
Message-ID: <20240119181327.236745-7-kwolf@redhat.com>
In-Reply-To: <20240119181327.236745-1-kwolf@redhat.com>
References: <20240119181327.236745-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

The common.qemu bash functions allow tests to interact with the QMP
monitor of a QEMU process. I spent two days trying to update 141 when
the order of the test output changed, but found it would still fail
occassionally because printf() and QMP events race with synchronous QMP
communication.

I gave up and ported 141 to the existing Python API for QMP tests. The
Python API is less affected by the order in which QEMU prints output
because it does not print all QMP traffic by default.

The next commit changes the order in which QMP messages are received.
Make 141 reliable first.

Cc: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20240118144823.1497953-3-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/141     | 307 ++++++++++++++++---------------------
 tests/qemu-iotests/141.out | 200 ++++++------------------
 2 files changed, 176 insertions(+), 331 deletions(-)

diff --git a/tests/qemu-iotests/141 b/tests/qemu-iotests/141
index a37030ee17..a7d3985a02 100755
--- a/tests/qemu-iotests/141
+++ b/tests/qemu-iotests/141
@@ -1,9 +1,12 @@
-#!/usr/bin/env bash
+#!/usr/bin/env python3
 # group: rw auto quick
 #
 # Test case for ejecting BDSs with block jobs still running on them
 #
-# Copyright (C) 2016 Red Hat, Inc.
+# Originally written in bash by Hanna Czenczek, ported to Python by Stefan
+# Hajnoczi.
+#
+# Copyright Red Hat
 #
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
@@ -19,177 +22,129 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=hreitz@redhat.com
-
-seq="$(basename $0)"
-echo "QA output created by $seq"
-
-status=1	# failure is the default!
-
-_cleanup()
-{
-    _cleanup_qemu
-    _cleanup_test_img
-    for img in "$TEST_DIR"/{b,m,o}.$IMGFMT; do
-        _rm_test_img "$img"
-    done
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.filter
-. ./common.qemu
-
-# Needs backing file and backing format support
-_supported_fmt qcow2 qed
-_supported_proto file
-_supported_os Linux
-
-
-test_blockjob()
-{
-    _send_qemu_cmd $QEMU_HANDLE \
-        "{'execute': 'blockdev-add',
-          'arguments': {
-              'node-name': 'drv0',
-              'driver': '$IMGFMT',
-              'file': {
-                  'driver': 'file',
-                  'filename': '$TEST_IMG'
-              }}}" \
-        'return'
-
-    # If "$2" is an event, we may or may not see it before the
-    # {"return": {}}.  Therefore, filter the {"return": {}} out both
-    # here and in the next command.  (Naturally, if we do not see it
-    # here, we will see it before the next command can be executed,
-    # so it will appear in the next _send_qemu_cmd's output.)
-    _send_qemu_cmd $QEMU_HANDLE \
-        "$1" \
-        "$2" \
-        | _filter_img_create | _filter_qmp_empty_return
-
-    # We want this to return an error because the block job is still running
-    _send_qemu_cmd $QEMU_HANDLE \
-        "{'execute': 'blockdev-del',
-          'arguments': {'node-name': 'drv0'}}" \
-        'error' | _filter_generated_node_ids | _filter_qmp_empty_return
-
-    _send_qemu_cmd $QEMU_HANDLE \
-        "{'execute': 'block-job-cancel',
-          'arguments': {'device': 'job0'}}" \
-        "$3"
-
-    _send_qemu_cmd $QEMU_HANDLE \
-        "{'execute': 'blockdev-del',
-          'arguments': {'node-name': 'drv0'}}" \
-        'return'
-}
-
-
-TEST_IMG="$TEST_DIR/b.$IMGFMT" _make_test_img 1M
-TEST_IMG="$TEST_DIR/m.$IMGFMT" _make_test_img -b "$TEST_DIR/b.$IMGFMT" -F $IMGFMT 1M
-_make_test_img -b "$TEST_DIR/m.$IMGFMT" 1M -F $IMGFMT
-
-_launch_qemu -nodefaults
-
-_send_qemu_cmd $QEMU_HANDLE \
-    "{'execute': 'qmp_capabilities'}" \
-    'return'
-
-echo
-echo '=== Testing drive-backup ==='
-echo
-
-# drive-backup will not send BLOCK_JOB_READY by itself, and cancelling the job
-# will consequently result in BLOCK_JOB_CANCELLED being emitted.
-
-test_blockjob \
-    "{'execute': 'drive-backup',
-      'arguments': {'job-id': 'job0',
-                    'device': 'drv0',
-                    'target': '$TEST_DIR/o.$IMGFMT',
-                    'format': '$IMGFMT',
-                    'sync': 'none'}}" \
-    'return' \
-    '"status": "null"'
-
-echo
-echo '=== Testing drive-mirror ==='
-echo
-
-# drive-mirror will send BLOCK_JOB_READY basically immediately, and cancelling
-# the job will consequently result in BLOCK_JOB_COMPLETED being emitted.
-
-test_blockjob \
-    "{'execute': 'drive-mirror',
-      'arguments': {'job-id': 'job0',
-                    'device': 'drv0',
-                    'target': '$TEST_DIR/o.$IMGFMT',
-                    'format': '$IMGFMT',
-                    'sync': 'none'}}" \
-    'BLOCK_JOB_READY' \
-    '"status": "null"'
-
-echo
-echo '=== Testing active block-commit ==='
-echo
-
-# An active block-commit will send BLOCK_JOB_READY basically immediately, and
-# cancelling the job will consequently result in BLOCK_JOB_COMPLETED being
-# emitted.
-
-test_blockjob \
-    "{'execute': 'block-commit',
-      'arguments': {'job-id': 'job0', 'device': 'drv0'}}" \
-    'BLOCK_JOB_READY' \
-    '"status": "null"'
-
-echo
-echo '=== Testing non-active block-commit ==='
-echo
-
-# Give block-commit something to work on, otherwise it would be done
-# immediately, send a BLOCK_JOB_COMPLETED and ejecting the BDS would work just
-# fine without the block job still running.
-
-$QEMU_IO -c 'write 0 1M' "$TEST_DIR/m.$IMGFMT" | _filter_qemu_io
-
-test_blockjob \
-    "{'execute': 'block-commit',
-      'arguments': {'job-id': 'job0',
-                    'device': 'drv0',
-                    'top':    '$TEST_DIR/m.$IMGFMT',
-                    'speed':  1}}" \
-    'return' \
-    '"status": "null"'
-
-echo
-echo '=== Testing block-stream ==='
-echo
-
-# Give block-stream something to work on, otherwise it would be done
-# immediately, send a BLOCK_JOB_COMPLETED and ejecting the BDS would work just
-# fine without the block job still running.
-
-$QEMU_IO -c 'write 0 1M' "$TEST_DIR/b.$IMGFMT" | _filter_qemu_io
-
-# With some data to stream (and @speed set to 1), block-stream will not complete
-# until we send the block-job-cancel command.
-
-test_blockjob \
-    "{'execute': 'block-stream',
-      'arguments': {'job-id': 'job0',
-                    'device': 'drv0',
-                    'speed': 1}}" \
-    'return' \
-    '"status": "null"'
-
-_cleanup_qemu
-
-# success, all done
-echo "*** done"
-rm -f $seq.full
-status=0
+import iotests
+
+# Common filters to mask values that vary in the test output
+QMP_FILTERS = [iotests.filter_qmp_testfiles, \
+               iotests.filter_qmp_imgfmt]
+
+
+class TestCase:
+    def __init__(self, name, vm, image_path, cancel_event):
+        self.name = name
+        self.vm = vm
+        self.image_path = image_path
+        self.cancel_event = cancel_event
+
+    def __enter__(self):
+        iotests.log(f'=== Testing {self.name} ===')
+        self.vm.qmp_log('blockdev-add', \
+                        node_name='drv0', \
+                        driver=iotests.imgfmt, \
+                        file={'driver': 'file', 'filename': self.image_path}, \
+                        filters=QMP_FILTERS)
+
+    def __exit__(self, *exc_details):
+        # This is expected to fail because the job still exists
+        self.vm.qmp_log('blockdev-del', node_name='drv0', \
+                        filters=[iotests.filter_qmp_generated_node_ids])
+
+        self.vm.qmp_log('block-job-cancel', device='job0')
+        event = self.vm.event_wait(self.cancel_event)
+        iotests.log(event, filters=[iotests.filter_qmp_event])
+
+        # This time it succeeds
+        self.vm.qmp_log('blockdev-del', node_name='drv0')
+
+        # Separate test cases in output
+        iotests.log('')
+
+
+def main() -> None:
+    with iotests.FilePath('bottom', 'middle', 'top', 'target') as \
+            (bottom_path, middle_path, top_path, target_path), \
+         iotests.VM() as vm:
+
+        iotests.log('Creating bottom <- middle <- top backing file chain...')
+        IMAGE_SIZE='1M'
+        iotests.qemu_img_create('-f', iotests.imgfmt, bottom_path, IMAGE_SIZE)
+        iotests.qemu_img_create('-f', iotests.imgfmt, \
+                                '-F', iotests.imgfmt, \
+                                '-b', bottom_path, \
+                                middle_path, \
+                                IMAGE_SIZE)
+        iotests.qemu_img_create('-f', iotests.imgfmt, \
+                                '-F', iotests.imgfmt, \
+                                '-b', middle_path, \
+                                top_path, \
+                                IMAGE_SIZE)
+
+        iotests.log('Starting VM...')
+        vm.add_args('-nodefaults')
+        vm.launch()
+
+        # drive-backup will not send BLOCK_JOB_READY by itself, and cancelling
+        # the job will consequently result in BLOCK_JOB_CANCELLED being
+        # emitted.
+        with TestCase('drive-backup', vm, top_path, 'BLOCK_JOB_CANCELLED'):
+            vm.qmp_log('drive-backup', \
+                       job_id='job0', \
+                       device='drv0', \
+                       target=target_path, \
+                       format=iotests.imgfmt, \
+                       sync='none', \
+                       filters=QMP_FILTERS)
+
+        # drive-mirror will send BLOCK_JOB_READY basically immediately, and
+        # cancelling the job will consequently result in BLOCK_JOB_COMPLETED
+        # being emitted.
+        with TestCase('drive-mirror', vm, top_path, 'BLOCK_JOB_COMPLETED'):
+            vm.qmp_log('drive-mirror', \
+                       job_id='job0', \
+                       device='drv0', \
+                       target=target_path, \
+                       format=iotests.imgfmt, \
+                       sync='none', \
+                       filters=QMP_FILTERS)
+            event = vm.event_wait('BLOCK_JOB_READY')
+            assert event is not None # silence mypy
+            iotests.log(event, filters=[iotests.filter_qmp_event])
+
+        # An active block-commit will send BLOCK_JOB_READY basically
+        # immediately, and cancelling the job will consequently result in
+        # BLOCK_JOB_COMPLETED being emitted.
+        with TestCase('active block-commit', vm, top_path, \
+                      'BLOCK_JOB_COMPLETED'):
+            vm.qmp_log('block-commit', \
+                       job_id='job0', \
+                       device='drv0')
+            event = vm.event_wait('BLOCK_JOB_READY')
+            assert event is not None # silence mypy
+            iotests.log(event, filters=[iotests.filter_qmp_event])
+
+        # Give block-commit something to work on, otherwise it would be done
+        # immediately, send a BLOCK_JOB_COMPLETED and ejecting the BDS would
+        # work just fine without the block job still running.
+        iotests.qemu_io(middle_path, '-c', f'write 0 {IMAGE_SIZE}')
+        with TestCase('non-active block-commit', vm, top_path, \
+                      'BLOCK_JOB_CANCELLED'):
+            vm.qmp_log('block-commit', \
+                       job_id='job0', \
+                       device='drv0', \
+                       top=middle_path, \
+                       speed=1, \
+                       filters=[iotests.filter_qmp_testfiles])
+
+        # Give block-stream something to work on, otherwise it would be done
+        # immediately, send a BLOCK_JOB_COMPLETED and ejecting the BDS would
+        # work just fine without the block job still running.
+        iotests.qemu_io(bottom_path, '-c', f'write 0 {IMAGE_SIZE}')
+        with TestCase('block-stream', vm, top_path, 'BLOCK_JOB_CANCELLED'):
+            vm.qmp_log('block-stream', \
+                       job_id='job0', \
+                       device='drv0', \
+                       speed=1)
+
+if __name__ == '__main__':
+    iotests.script_main(main, supported_fmts=['qcow2', 'qed'],
+                        supported_protocols=['file'])
diff --git a/tests/qemu-iotests/141.out b/tests/qemu-iotests/141.out
index 63203d9944..91b7ba50af 100644
--- a/tests/qemu-iotests/141.out
+++ b/tests/qemu-iotests/141.out
@@ -1,179 +1,69 @@
-QA output created by 141
-Formatting 'TEST_DIR/b.IMGFMT', fmt=IMGFMT size=1048576
-Formatting 'TEST_DIR/m.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/b.IMGFMT backing_fmt=IMGFMT
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/m.IMGFMT backing_fmt=IMGFMT
-{'execute': 'qmp_capabilities'}
-{"return": {}}
-
+Creating bottom <- middle <- top backing file chain...
+Starting VM...
 === Testing drive-backup ===
-
-{'execute': 'blockdev-add',
-          'arguments': {
-              'node-name': 'drv0',
-              'driver': 'IMGFMT',
-              'file': {
-                  'driver': 'file',
-                  'filename': 'TEST_DIR/t.IMGFMT'
-              }}}
-{"return": {}}
-{'execute': 'drive-backup',
-'arguments': {'job-id': 'job0',
-'device': 'drv0',
-'target': 'TEST_DIR/o.IMGFMT',
-'format': 'IMGFMT',
-'sync': 'none'}}
-Formatting 'TEST_DIR/o.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT backing_fmt=IMGFMT
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "paused", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
-{'execute': 'blockdev-del',
-          'arguments': {'node-name': 'drv0'}}
+{"execute": "blockdev-add", "arguments": {"driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/PID-top"}, "node-name": "drv0"}}
+{"return": {}}
+{"execute": "drive-backup", "arguments": {"device": "drv0", "format": "IMGFMT", "job-id": "job0", "sync": "none", "target": "TEST_DIR/PID-target"}}
+{"return": {}}
+{"execute": "blockdev-del", "arguments": {"node-name": "drv0"}}
 {"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: node is used as backing hd of 'NODE_NAME'"}}
-{'execute': 'block-job-cancel',
-          'arguments': {'device': 'job0'}}
+{"execute": "block-job-cancel", "arguments": {"device": "job0"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "job0", "len": 1048576, "offset": 0, "speed": 0, "type": "backup"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job0"}}
-{'execute': 'blockdev-del',
-          'arguments': {'node-name': 'drv0'}}
+{"data": {"device": "job0", "len": 1048576, "offset": 0, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "blockdev-del", "arguments": {"node-name": "drv0"}}
 {"return": {}}
 
 === Testing drive-mirror ===
-
-{'execute': 'blockdev-add',
-          'arguments': {
-              'node-name': 'drv0',
-              'driver': 'IMGFMT',
-              'file': {
-                  'driver': 'file',
-                  'filename': 'TEST_DIR/t.IMGFMT'
-              }}}
-{"return": {}}
-{'execute': 'drive-mirror',
-'arguments': {'job-id': 'job0',
-'device': 'drv0',
-'target': 'TEST_DIR/o.IMGFMT',
-'format': 'IMGFMT',
-'sync': 'none'}}
-Formatting 'TEST_DIR/o.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT backing_fmt=IMGFMT
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "job0", "len": 0, "offset": 0, "speed": 0, "type": "mirror"}}
-{'execute': 'blockdev-del',
-          'arguments': {'node-name': 'drv0'}}
+{"execute": "blockdev-add", "arguments": {"driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/PID-top"}, "node-name": "drv0"}}
+{"return": {}}
+{"execute": "drive-mirror", "arguments": {"device": "drv0", "format": "IMGFMT", "job-id": "job0", "sync": "none", "target": "TEST_DIR/PID-target"}}
+{"return": {}}
+{"data": {"device": "job0", "len": 0, "offset": 0, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "blockdev-del", "arguments": {"node-name": "drv0"}}
 {"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: block device is in use by block job: mirror"}}
-{'execute': 'block-job-cancel',
-          'arguments': {'device': 'job0'}}
+{"execute": "block-job-cancel", "arguments": {"device": "job0"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "job0", "len": 0, "offset": 0, "speed": 0, "type": "mirror"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job0"}}
-{'execute': 'blockdev-del',
-          'arguments': {'node-name': 'drv0'}}
+{"data": {"device": "job0", "len": 0, "offset": 0, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "blockdev-del", "arguments": {"node-name": "drv0"}}
 {"return": {}}
 
 === Testing active block-commit ===
-
-{'execute': 'blockdev-add',
-          'arguments': {
-              'node-name': 'drv0',
-              'driver': 'IMGFMT',
-              'file': {
-                  'driver': 'file',
-                  'filename': 'TEST_DIR/t.IMGFMT'
-              }}}
-{"return": {}}
-{'execute': 'block-commit',
-'arguments': {'job-id': 'job0', 'device': 'drv0'}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "job0", "len": 0, "offset": 0, "speed": 0, "type": "commit"}}
-{'execute': 'blockdev-del',
-          'arguments': {'node-name': 'drv0'}}
+{"execute": "blockdev-add", "arguments": {"driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/PID-top"}, "node-name": "drv0"}}
+{"return": {}}
+{"execute": "block-commit", "arguments": {"device": "drv0", "job-id": "job0"}}
+{"return": {}}
+{"data": {"device": "job0", "len": 0, "offset": 0, "speed": 0, "type": "commit"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "blockdev-del", "arguments": {"node-name": "drv0"}}
 {"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: block device is in use by block job: commit"}}
-{'execute': 'block-job-cancel',
-          'arguments': {'device': 'job0'}}
+{"execute": "block-job-cancel", "arguments": {"device": "job0"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "job0", "len": 0, "offset": 0, "speed": 0, "type": "commit"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job0"}}
-{'execute': 'blockdev-del',
-          'arguments': {'node-name': 'drv0'}}
+{"data": {"device": "job0", "len": 0, "offset": 0, "speed": 0, "type": "commit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "blockdev-del", "arguments": {"node-name": "drv0"}}
 {"return": {}}
 
 === Testing non-active block-commit ===
-
-wrote 1048576/1048576 bytes at offset 0
-1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-{'execute': 'blockdev-add',
-          'arguments': {
-              'node-name': 'drv0',
-              'driver': 'IMGFMT',
-              'file': {
-                  'driver': 'file',
-                  'filename': 'TEST_DIR/t.IMGFMT'
-              }}}
-{"return": {}}
-{'execute': 'block-commit',
-'arguments': {'job-id': 'job0',
-'device': 'drv0',
-'top':    'TEST_DIR/m.IMGFMT',
-'speed':  1}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
-{'execute': 'blockdev-del',
-          'arguments': {'node-name': 'drv0'}}
+{"execute": "blockdev-add", "arguments": {"driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/PID-top"}, "node-name": "drv0"}}
+{"return": {}}
+{"execute": "block-commit", "arguments": {"device": "drv0", "job-id": "job0", "speed": 1, "top": "TEST_DIR/PID-middle"}}
+{"return": {}}
+{"execute": "blockdev-del", "arguments": {"node-name": "drv0"}}
 {"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: block device is in use by block job: commit"}}
-{'execute': 'block-job-cancel',
-          'arguments': {'device': 'job0'}}
+{"execute": "block-job-cancel", "arguments": {"device": "job0"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "job0", "len": 1048576, "offset": 524288, "speed": 1, "type": "commit"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job0"}}
-{'execute': 'blockdev-del',
-          'arguments': {'node-name': 'drv0'}}
+{"data": {"device": "job0", "len": 1048576, "offset": 524288, "speed": 1, "type": "commit"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "blockdev-del", "arguments": {"node-name": "drv0"}}
 {"return": {}}
 
 === Testing block-stream ===
-
-wrote 1048576/1048576 bytes at offset 0
-1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-{'execute': 'blockdev-add',
-          'arguments': {
-              'node-name': 'drv0',
-              'driver': 'IMGFMT',
-              'file': {
-                  'driver': 'file',
-                  'filename': 'TEST_DIR/t.IMGFMT'
-              }}}
-{"return": {}}
-{'execute': 'block-stream',
-'arguments': {'job-id': 'job0',
-'device': 'drv0',
-'speed': 1}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
-{'execute': 'blockdev-del',
-          'arguments': {'node-name': 'drv0'}}
+{"execute": "blockdev-add", "arguments": {"driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/PID-top"}, "node-name": "drv0"}}
+{"return": {}}
+{"execute": "block-stream", "arguments": {"device": "drv0", "job-id": "job0", "speed": 1}}
+{"return": {}}
+{"execute": "blockdev-del", "arguments": {"node-name": "drv0"}}
 {"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: block device is in use by block job: stream"}}
-{'execute': 'block-job-cancel',
-          'arguments': {'device': 'job0'}}
+{"execute": "block-job-cancel", "arguments": {"device": "job0"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "job0", "len": 1048576, "offset": 524288, "speed": 1, "type": "stream"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job0"}}
-{'execute': 'blockdev-del',
-          'arguments': {'node-name': 'drv0'}}
+{"data": {"device": "job0", "len": 1048576, "offset": 524288, "speed": 1, "type": "stream"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "blockdev-del", "arguments": {"node-name": "drv0"}}
 {"return": {}}
-*** done
+
-- 
2.43.0


