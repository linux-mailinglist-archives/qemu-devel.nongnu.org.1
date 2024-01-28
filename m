Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E710983F8BE
	for <lists+qemu-devel@lfdr.de>; Sun, 28 Jan 2024 18:49:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rU9Gl-00063d-HV; Sun, 28 Jan 2024 12:48:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rU9GU-0005ym-Ta; Sun, 28 Jan 2024 12:48:19 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rU9GP-0000Hs-Vr; Sun, 28 Jan 2024 12:48:18 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0B7BC480E2;
 Sun, 28 Jan 2024 20:48:47 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 36A506D50B;
 Sun, 28 Jan 2024 20:47:55 +0300 (MSK)
Received: (nullmailer pid 811323 invoked by uid 1000);
 Sun, 28 Jan 2024 17:47:47 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.9 28/30] monitor: only run coroutine commands in
 qemu_aio_context
Date: Sun, 28 Jan 2024 20:47:41 +0300
Message-Id: <20240128174747.811264-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.9-20240128204652@cover.tls.msk.ru>
References: <qemu-stable-7.2.9-20240128204652@cover.tls.msk.ru>
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

From: Stefan Hajnoczi <stefanha@redhat.com>

monitor_qmp_dispatcher_co() runs in the iohandler AioContext that is not
polled during nested event loops. The coroutine currently reschedules
itself in the main loop's qemu_aio_context AioContext, which is polled
during nested event loops. One known problem is that QMP device-add
calls drain_call_rcu(), which temporarily drops the BQL, leading to all
sorts of havoc like other vCPU threads re-entering device emulation code
while another vCPU thread is waiting in device emulation code with
aio_poll().

Paolo Bonzini suggested running non-coroutine QMP handlers in the
iohandler AioContext. This avoids trouble with nested event loops. His
original idea was to move coroutine rescheduling to
monitor_qmp_dispatch(), but I resorted to moving it to qmp_dispatch()
because we don't know if the QMP handler needs to run in coroutine
context in monitor_qmp_dispatch(). monitor_qmp_dispatch() would have
been nicer since it's associated with the monitor implementation and not
as general as qmp_dispatch(), which is also used by qemu-ga.

A number of qemu-iotests need updated .out files because the order of
QMP events vs QMP responses has changed.

Solves Issue #1933.

Cc: qemu-stable@nongnu.org
Fixes: 7bed89958bfbf40df9ca681cefbdca63abdde39d ("device_core: use drain_call_rcu in in qmp_device_add")
Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2215192
Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2214985
Buglink: https://issues.redhat.com/browse/RHEL-17369
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20240118144823.1497953-4-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit effd60c878176bcaf97fa7ce2b12d04bb8ead6f7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: omit changes to tests missing in 7.2)

diff --git a/monitor/qmp.c b/monitor/qmp.c
index 092c527b6f..acd0a350c2 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -296,14 +296,6 @@ void coroutine_fn monitor_qmp_dispatcher_co(void *data)
             qemu_coroutine_yield();
         }
 
-        /*
-         * Move the coroutine from iohandler_ctx to qemu_aio_context for
-         * executing the command handler so that it can make progress if it
-         * involves an AIO_WAIT_WHILE().
-         */
-        aio_co_schedule(qemu_get_aio_context(), qmp_dispatcher_co);
-        qemu_coroutine_yield();
-
         /* Process request */
         if (req_obj->req) {
             if (trace_event_get_state(TRACE_MONITOR_QMP_CMD_IN_BAND)) {
@@ -330,15 +322,6 @@ void coroutine_fn monitor_qmp_dispatcher_co(void *data)
         }
 
         qmp_request_free(req_obj);
-
-        /*
-         * Yield and reschedule so the main loop stays responsive.
-         *
-         * Move back to iohandler_ctx so that nested event loops for
-         * qemu_aio_context don't start new monitor commands.
-         */
-        aio_co_schedule(iohandler_get_aio_context(), qmp_dispatcher_co);
-        qemu_coroutine_yield();
     }
 }
 
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 0990873ec8..5d000fae87 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -206,9 +206,31 @@ QDict *qmp_dispatch(const QmpCommandList *cmds, QObject *request,
     assert(!(oob && qemu_in_coroutine()));
     assert(monitor_cur() == NULL);
     if (!!(cmd->options & QCO_COROUTINE) == qemu_in_coroutine()) {
+        if (qemu_in_coroutine()) {
+            /*
+             * Move the coroutine from iohandler_ctx to qemu_aio_context for
+             * executing the command handler so that it can make progress if it
+             * involves an AIO_WAIT_WHILE().
+             */
+            aio_co_schedule(qemu_get_aio_context(), qemu_coroutine_self());
+            qemu_coroutine_yield();
+        }
+
         monitor_set_cur(qemu_coroutine_self(), cur_mon);
         cmd->fn(args, &ret, &err);
         monitor_set_cur(qemu_coroutine_self(), NULL);
+
+        if (qemu_in_coroutine()) {
+            /*
+             * Yield and reschedule so the main loop stays responsive.
+             *
+             * Move back to iohandler_ctx so that nested event loops for
+             * qemu_aio_context don't start new monitor commands.
+             */
+            aio_co_schedule(iohandler_get_aio_context(),
+                            qemu_coroutine_self());
+            qemu_coroutine_yield();
+        }
     } else {
        /*
         * Actual context doesn't match the one the command needs.
@@ -232,7 +254,7 @@ QDict *qmp_dispatch(const QmpCommandList *cmds, QObject *request,
             .errp       = &err,
             .co         = qemu_coroutine_self(),
         };
-        aio_bh_schedule_oneshot(qemu_get_aio_context(), do_qmp_dispatch_bh,
+        aio_bh_schedule_oneshot(iohandler_get_aio_context(), do_qmp_dispatch_bh,
                                 &data);
         qemu_coroutine_yield();
     }
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index 329977d9b9..a37bf446e9 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -421,8 +421,8 @@ QMP_VERSION
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_IMAGE_CORRUPTED", "data": {"device": "none0", "msg": "Preventing invalid write on metadata (overlaps with refcount table)", "offset": 65536, "node-name": "drive", "fatal": true, "size": 65536}}
 write failed: Input/output error
 {"return": ""}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 === Testing incoming inactive corrupted image ===
 
@@ -432,8 +432,8 @@ QMP_VERSION
 qcow2: Image is corrupt: L2 table offset 0x2a2a2a00 unaligned (L1 index: 0); further non-fatal corruption events will be suppressed
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_IMAGE_CORRUPTED", "data": {"device": "", "msg": "L2 table offset 0x2a2a2a00 unaligned (L1 index: 0)", "node-name": "drive", "fatal": false}}
 {"return": ""}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
     corrupt: false
 *** done
diff --git a/tests/qemu-iotests/071.out b/tests/qemu-iotests/071.out
index bca0c02f5c..a2923b05c2 100644
--- a/tests/qemu-iotests/071.out
+++ b/tests/qemu-iotests/071.out
@@ -45,8 +45,8 @@ QMP_VERSION
 {"return": {}}
 read failed: Input/output error
 {"return": ""}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 
 === Testing blkverify on existing block device ===
@@ -84,9 +84,9 @@ wrote 512/512 bytes at offset 0
 {"return": ""}
 read failed: Input/output error
 {"return": ""}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 QEMU_PROG: Failed to flush the L2 table cache: Input/output error
 QEMU_PROG: Failed to flush the refcount block cache: Input/output error
+{"return": {}}
 
 *** done
diff --git a/tests/qemu-iotests/081.out b/tests/qemu-iotests/081.out
index 615c083549..aba85ea564 100644
--- a/tests/qemu-iotests/081.out
+++ b/tests/qemu-iotests/081.out
@@ -35,8 +35,8 @@ QMP_VERSION
 read 10485760/10485760 bytes at offset 0
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 
 == using quorum rewrite corrupted mode ==
@@ -67,8 +67,8 @@ QMP_VERSION
 read 10485760/10485760 bytes at offset 0
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 -- checking that the image has been corrected --
 read 10485760/10485760 bytes at offset 0
@@ -106,8 +106,8 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing:
 QMP_VERSION
@@ -115,8 +115,8 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "Cannot add a child to a quorum in blkverify mode"}}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 
 == dynamically removing a child from a quorum ==
@@ -125,31 +125,31 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing:
 QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "The number of children cannot be lower than the vote threshold 2"}}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing:
 QMP_VERSION
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "blkverify=on can only be set if there are exactly two files and vote-threshold is 2"}}
 {"error": {"class": "GenericError", "desc": "Cannot find device='drive0-quorum' nor node-name='drive0-quorum'"}}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 Testing:
 QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "The number of children cannot be lower than the vote threshold 2"}}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 *** done
diff --git a/tests/qemu-iotests/087.out b/tests/qemu-iotests/087.out
index e1c23a6983..97b6d8036d 100644
--- a/tests/qemu-iotests/087.out
+++ b/tests/qemu-iotests/087.out
@@ -7,8 +7,8 @@ Testing:
 QMP_VERSION
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "'node-name' must be specified for the root node"}}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 
 === Duplicate ID ===
@@ -18,8 +18,8 @@ QMP_VERSION
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "node-name=disk is conflicting with a device id"}}
 {"error": {"class": "GenericError", "desc": "Duplicate nodes with node-name='test-node'"}}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 
 === aio=native without O_DIRECT ===
@@ -28,8 +28,8 @@ Testing:
 QMP_VERSION
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "aio=native was specified, but it requires cache.direct=on, which was not specified."}}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 
 === Encrypted image QCow ===
@@ -40,8 +40,8 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "Use of AES-CBC encrypted IMGFMT images is no longer supported in system emulators"}}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 
 === Encrypted image LUKS ===
@@ -52,8 +52,8 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 
 === Missing driver ===
@@ -63,7 +63,7 @@ Testing: -S
 QMP_VERSION
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "Parameter 'driver' is missing"}}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 *** done
diff --git a/tests/qemu-iotests/108.out b/tests/qemu-iotests/108.out
index b5401d788d..b9c876b394 100644
--- a/tests/qemu-iotests/108.out
+++ b/tests/qemu-iotests/108.out
@@ -173,8 +173,8 @@ OK: Reftable is where we expect it
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "create"}}
 {"return": {}}
 { "execute": "quit" }
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/109 b/tests/qemu-iotests/109
index e207a555f3..0fb580f9a5 100755
--- a/tests/qemu-iotests/109
+++ b/tests/qemu-iotests/109
@@ -57,13 +57,13 @@ run_qemu()
     _launch_qemu -drive file="${source_img}",format=raw,cache=${CACHEMODE},aio=${AIOMODE},id=src
     _send_qemu_cmd $QEMU_HANDLE "{ 'execute': 'qmp_capabilities' }" "return"
 
-    _send_qemu_cmd $QEMU_HANDLE \
+    capture_events="$qmp_event" _send_qemu_cmd $QEMU_HANDLE \
         "{'execute':'drive-mirror', 'arguments':{
             'device': 'src', 'target': '$raw_img', $qmp_format
             'mode': 'existing', 'sync': 'full'}}" \
         "return"
 
-    _send_qemu_cmd $QEMU_HANDLE '' "$qmp_event"
+    capture_events="$qmp_event JOB_STATUS_CHANGE" _wait_event $QEMU_HANDLE "$qmp_event"
     if test "$qmp_event" = BLOCK_JOB_ERROR; then
         _send_qemu_cmd $QEMU_HANDLE '' '"status": "null"'
     fi
diff --git a/tests/qemu-iotests/109.out b/tests/qemu-iotests/109.out
index e29280015e..255b81fcdc 100644
--- a/tests/qemu-iotests/109.out
+++ b/tests/qemu-iotests/109.out
@@ -7,7 +7,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=SIZE
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 {'execute':'drive-mirror', 'arguments':{
-            'device': 'src', 'target': 'TEST_DIR/t.IMGFMT',
+            'device': 'src', 'target': 'TEST_DIR/t.IMGFMT', 
             'mode': 'existing', 'sync': 'full'}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
          Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
@@ -23,8 +23,8 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"execute":"query-block-jobs"}
 {"return": []}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 { 'execute': 'qmp_capabilities' }
@@ -35,12 +35,10 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 1024, "offset": 1024, "speed": 0, "type": "mirror"}}
 {"execute":"query-block-jobs"}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 1024, "offset": 1024, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "standby", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
@@ -48,6 +46,7 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "src", "len": 1024, "offset": 1024, "speed": 0, "type": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
+{"return": {}}
 Images are identical.
 
 === Writing a qcow2 header into raw ===
@@ -57,7 +56,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=SIZE
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 {'execute':'drive-mirror', 'arguments':{
-            'device': 'src', 'target': 'TEST_DIR/t.IMGFMT',
+            'device': 'src', 'target': 'TEST_DIR/t.IMGFMT', 
             'mode': 'existing', 'sync': 'full'}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
          Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
@@ -73,8 +72,8 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"execute":"query-block-jobs"}
 {"return": []}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 { 'execute': 'qmp_capabilities' }
@@ -85,12 +84,10 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 197120, "offset": 197120, "speed": 0, "type": "mirror"}}
 {"execute":"query-block-jobs"}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 197120, "offset": 197120, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "standby", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
@@ -98,6 +95,7 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "src", "len": 197120, "offset": 197120, "speed": 0, "type": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
+{"return": {}}
 Images are identical.
 
 === Writing a qed header into raw ===
@@ -107,7 +105,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=SIZE
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 {'execute':'drive-mirror', 'arguments':{
-            'device': 'src', 'target': 'TEST_DIR/t.IMGFMT',
+            'device': 'src', 'target': 'TEST_DIR/t.IMGFMT', 
             'mode': 'existing', 'sync': 'full'}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
          Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
@@ -123,8 +121,8 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"execute":"query-block-jobs"}
 {"return": []}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 { 'execute': 'qmp_capabilities' }
@@ -135,12 +133,10 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 327680, "offset": 327680, "speed": 0, "type": "mirror"}}
 {"execute":"query-block-jobs"}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 327680, "offset": 327680, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "standby", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
@@ -148,6 +144,7 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "src", "len": 327680, "offset": 327680, "speed": 0, "type": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
+{"return": {}}
 Images are identical.
 
 === Writing a vdi header into raw ===
@@ -157,7 +154,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=SIZE
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 {'execute':'drive-mirror', 'arguments':{
-            'device': 'src', 'target': 'TEST_DIR/t.IMGFMT',
+            'device': 'src', 'target': 'TEST_DIR/t.IMGFMT', 
             'mode': 'existing', 'sync': 'full'}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
          Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
@@ -173,8 +170,8 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"execute":"query-block-jobs"}
 {"return": []}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 { 'execute': 'qmp_capabilities' }
@@ -185,12 +182,10 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 1024, "offset": 1024, "speed": 0, "type": "mirror"}}
 {"execute":"query-block-jobs"}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 1024, "offset": 1024, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "standby", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
@@ -198,6 +193,7 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "src", "len": 1024, "offset": 1024, "speed": 0, "type": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
+{"return": {}}
 Images are identical.
 
 === Writing a vmdk header into raw ===
@@ -207,7 +203,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=SIZE
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 {'execute':'drive-mirror', 'arguments':{
-            'device': 'src', 'target': 'TEST_DIR/t.IMGFMT',
+            'device': 'src', 'target': 'TEST_DIR/t.IMGFMT', 
             'mode': 'existing', 'sync': 'full'}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
          Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
@@ -223,8 +219,8 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"execute":"query-block-jobs"}
 {"return": []}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 { 'execute': 'qmp_capabilities' }
@@ -235,12 +231,10 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 65536, "offset": 65536, "speed": 0, "type": "mirror"}}
 {"execute":"query-block-jobs"}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 65536, "offset": 65536, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "standby", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
@@ -248,6 +242,7 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "src", "len": 65536, "offset": 65536, "speed": 0, "type": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
+{"return": {}}
 Images are identical.
 
 === Writing a vpc header into raw ===
@@ -257,7 +252,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=SIZE
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 {'execute':'drive-mirror', 'arguments':{
-            'device': 'src', 'target': 'TEST_DIR/t.IMGFMT',
+            'device': 'src', 'target': 'TEST_DIR/t.IMGFMT', 
             'mode': 'existing', 'sync': 'full'}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
          Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
@@ -273,8 +268,8 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"execute":"query-block-jobs"}
 {"return": []}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 { 'execute': 'qmp_capabilities' }
@@ -285,12 +280,10 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 2560, "offset": 2560, "speed": 0, "type": "mirror"}}
 {"execute":"query-block-jobs"}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 2560, "offset": 2560, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "standby", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
@@ -298,6 +291,7 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "src", "len": 2560, "offset": 2560, "speed": 0, "type": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
+{"return": {}}
 Images are identical.
 
 === Copying sample image empty.bochs into raw ===
@@ -306,7 +300,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=SIZE
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 {'execute':'drive-mirror', 'arguments':{
-            'device': 'src', 'target': 'TEST_DIR/t.IMGFMT',
+            'device': 'src', 'target': 'TEST_DIR/t.IMGFMT', 
             'mode': 'existing', 'sync': 'full'}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
          Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
@@ -322,8 +316,8 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"execute":"query-block-jobs"}
 {"return": []}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 { 'execute': 'qmp_capabilities' }
@@ -334,12 +328,10 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 2560, "offset": 2560, "speed": 0, "type": "mirror"}}
 {"execute":"query-block-jobs"}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 2560, "offset": 2560, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "standby", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
@@ -347,6 +339,7 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "src", "len": 2560, "offset": 2560, "speed": 0, "type": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
+{"return": {}}
 Images are identical.
 
 === Copying sample image iotest-dirtylog-10G-4M.vhdx into raw ===
@@ -355,7 +348,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=SIZE
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 {'execute':'drive-mirror', 'arguments':{
-            'device': 'src', 'target': 'TEST_DIR/t.IMGFMT',
+            'device': 'src', 'target': 'TEST_DIR/t.IMGFMT', 
             'mode': 'existing', 'sync': 'full'}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
          Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
@@ -371,8 +364,8 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"execute":"query-block-jobs"}
 {"return": []}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 { 'execute': 'qmp_capabilities' }
@@ -383,12 +376,10 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 31457280, "offset": 31457280, "speed": 0, "type": "mirror"}}
 {"execute":"query-block-jobs"}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 31457280, "offset": 31457280, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "standby", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
@@ -396,6 +387,7 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "src", "len": 31457280, "offset": 31457280, "speed": 0, "type": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
+{"return": {}}
 Images are identical.
 
 === Copying sample image parallels-v1 into raw ===
@@ -404,7 +396,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=SIZE
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 {'execute':'drive-mirror', 'arguments':{
-            'device': 'src', 'target': 'TEST_DIR/t.IMGFMT',
+            'device': 'src', 'target': 'TEST_DIR/t.IMGFMT', 
             'mode': 'existing', 'sync': 'full'}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
          Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
@@ -420,8 +412,8 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"execute":"query-block-jobs"}
 {"return": []}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 { 'execute': 'qmp_capabilities' }
@@ -432,12 +424,10 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 327680, "offset": 327680, "speed": 0, "type": "mirror"}}
 {"execute":"query-block-jobs"}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 327680, "offset": 327680, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "standby", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
@@ -445,6 +435,7 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "src", "len": 327680, "offset": 327680, "speed": 0, "type": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
+{"return": {}}
 Images are identical.
 
 === Copying sample image simple-pattern.cloop into raw ===
@@ -453,7 +444,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=SIZE
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 {'execute':'drive-mirror', 'arguments':{
-            'device': 'src', 'target': 'TEST_DIR/t.IMGFMT',
+            'device': 'src', 'target': 'TEST_DIR/t.IMGFMT', 
             'mode': 'existing', 'sync': 'full'}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
          Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
@@ -469,8 +460,8 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"execute":"query-block-jobs"}
 {"return": []}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 { 'execute': 'qmp_capabilities' }
@@ -481,12 +472,10 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 2048, "offset": 2048, "speed": 0, "type": "mirror"}}
 {"execute":"query-block-jobs"}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 2048, "offset": 2048, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "standby", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
@@ -494,6 +483,7 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "src", "len": 2048, "offset": 2048, "speed": 0, "type": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
+{"return": {}}
 Images are identical.
 
 === Write legitimate MBR into raw ===
@@ -502,7 +492,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=SIZE
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 {'execute':'drive-mirror', 'arguments':{
-            'device': 'src', 'target': 'TEST_DIR/t.IMGFMT',
+            'device': 'src', 'target': 'TEST_DIR/t.IMGFMT', 
             'mode': 'existing', 'sync': 'full'}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
          Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
@@ -510,12 +500,10 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 512, "offset": 512, "speed": 0, "type": "mirror"}}
 {"execute":"query-block-jobs"}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 512, "offset": 512, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "standby", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
@@ -523,6 +511,7 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "src", "len": 512, "offset": 512, "speed": 0, "type": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
+{"return": {}}
 Images are identical.
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
@@ -532,12 +521,10 @@ Images are identical.
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 512, "offset": 512, "speed": 0, "type": "mirror"}}
 {"execute":"query-block-jobs"}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 512, "offset": 512, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "standby", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
@@ -545,5 +532,6 @@ Images are identical.
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "src", "len": 512, "offset": 512, "speed": 0, "type": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
+{"return": {}}
 Images are identical.
 *** done
diff --git a/tests/qemu-iotests/117.out b/tests/qemu-iotests/117.out
index 735ffd25c6..1cea9e0217 100644
--- a/tests/qemu-iotests/117.out
+++ b/tests/qemu-iotests/117.out
@@ -18,8 +18,8 @@ wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}
 { 'execute': 'quit' }
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 No errors were found on the image.
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/120.out b/tests/qemu-iotests/120.out
index 0744c1f136..35d84a5bc5 100644
--- a/tests/qemu-iotests/120.out
+++ b/tests/qemu-iotests/120.out
@@ -5,8 +5,8 @@ QMP_VERSION
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 65536/65536 bytes at offset 0
diff --git a/tests/qemu-iotests/127.out b/tests/qemu-iotests/127.out
index 1685c4850a..dd8c4a8aa9 100644
--- a/tests/qemu-iotests/127.out
+++ b/tests/qemu-iotests/127.out
@@ -28,6 +28,6 @@ wrote 42/42 bytes at offset 0
 { 'execute': 'quit' }
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "mirror"}}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 *** done
diff --git a/tests/qemu-iotests/140.out b/tests/qemu-iotests/140.out
index 312f76d5da..32866440ae 100644
--- a/tests/qemu-iotests/140.out
+++ b/tests/qemu-iotests/140.out
@@ -19,6 +19,6 @@ read 65536/65536 bytes at offset 0
 qemu-io: can't open device nbd+unix:///drv?socket=SOCK_DIR/nbd: Requested export not available
 server reported: export 'drv' not present
 { 'execute': 'quit' }
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 *** done
diff --git a/tests/qemu-iotests/143.out b/tests/qemu-iotests/143.out
index 9ec5888e0e..d6afa32abc 100644
--- a/tests/qemu-iotests/143.out
+++ b/tests/qemu-iotests/143.out
@@ -10,6 +10,6 @@ server reported: export 'no_such_export' not present
 qemu-io: can't open device nbd+unix:///aa--aa1?socket=SOCK_DIR/nbd: Requested export not available
 server reported: export 'aa--aa...' not present
 { 'execute': 'quit' }
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 *** done
diff --git a/tests/qemu-iotests/156.out b/tests/qemu-iotests/156.out
index 4a22f0c41a..07e5e83f5d 100644
--- a/tests/qemu-iotests/156.out
+++ b/tests/qemu-iotests/156.out
@@ -72,8 +72,8 @@ read 65536/65536 bytes at offset 196608
 {"return": ""}
 
 { 'execute': 'quit' }
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/176.out b/tests/qemu-iotests/176.out
index 9d09b60452..45e9153ef3 100644
--- a/tests/qemu-iotests/176.out
+++ b/tests/qemu-iotests/176.out
@@ -169,8 +169,8 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 2147352576
@@ -206,8 +206,8 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {"sha256": HASH}}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 === Test pass bitmap.1 ===
 
@@ -218,8 +218,8 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 2147352576
@@ -256,8 +256,8 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {"sha256": HASH}}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 === Test pass bitmap.2 ===
 
@@ -268,8 +268,8 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 2147352576
@@ -306,8 +306,8 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {"sha256": HASH}}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 === Test pass bitmap.3 ===
 
@@ -318,8 +318,8 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 2147352576
@@ -353,6 +353,6 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {"sha256": HASH}}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 *** done
diff --git a/tests/qemu-iotests/182.out b/tests/qemu-iotests/182.out
index 57f7265458..83fc1a4797 100644
--- a/tests/qemu-iotests/182.out
+++ b/tests/qemu-iotests/182.out
@@ -53,6 +53,6 @@ Formatting 'TEST_DIR/t.qcow2.overlay', fmt=qcow2 cluster_size=65536 extended_l2=
 {'execute': 'qmp_capabilities'}
 {"return": {}}
 {'execute': 'quit'}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 *** done
diff --git a/tests/qemu-iotests/183.out b/tests/qemu-iotests/183.out
index fd9c2e52a5..51aa41c888 100644
--- a/tests/qemu-iotests/183.out
+++ b/tests/qemu-iotests/183.out
@@ -53,11 +53,11 @@ wrote 65536/65536 bytes at offset 1048576
 === Shut down and check image ===
 
 {"execute":"quit"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"return": {}}
 {"execute":"quit"}
-{"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 No errors were found on the image.
 No errors were found on the image.
 wrote 65536/65536 bytes at offset 1048576
diff --git a/tests/qemu-iotests/184.out b/tests/qemu-iotests/184.out
index 77e5489d65..e8f631f853 100644
--- a/tests/qemu-iotests/184.out
+++ b/tests/qemu-iotests/184.out
@@ -89,10 +89,6 @@ Testing:
     "return": [
     ]
 }
-{
-    "return": {
-    }
-}
 {
     "timestamp": {
         "seconds":  TIMESTAMP,
@@ -104,6 +100,10 @@ Testing:
         "reason": "host-qmp-quit"
     }
 }
+{
+    "return": {
+    }
+}
 
 
 == property changes in ThrottleGroup ==
@@ -169,10 +169,6 @@ Testing:
         "iops-total-max": 0
     }
 }
-{
-    "return": {
-    }
-}
 {
     "timestamp": {
         "seconds":  TIMESTAMP,
@@ -184,6 +180,10 @@ Testing:
         "reason": "host-qmp-quit"
     }
 }
+{
+    "return": {
+    }
+}
 
 
 == object creation/set errors  ==
@@ -211,10 +211,6 @@ Testing:
         "desc": "bps/iops/max total values and read/write values cannot be used at the same time"
     }
 }
-{
-    "return": {
-    }
-}
 {
     "timestamp": {
         "seconds":  TIMESTAMP,
@@ -226,6 +222,10 @@ Testing:
         "reason": "host-qmp-quit"
     }
 }
+{
+    "return": {
+    }
+}
 
 
 == don't specify group ==
@@ -247,10 +247,6 @@ Testing:
         "desc": "Parameter 'throttle-group' is missing"
     }
 }
-{
-    "return": {
-    }
-}
 {
     "timestamp": {
         "seconds":  TIMESTAMP,
@@ -262,6 +258,10 @@ Testing:
         "reason": "host-qmp-quit"
     }
 }
+{
+    "return": {
+    }
+}
 
 
 *** done
diff --git a/tests/qemu-iotests/185 b/tests/qemu-iotests/185
index 8b1143dc16..61f13d0460 100755
--- a/tests/qemu-iotests/185
+++ b/tests/qemu-iotests/185
@@ -344,14 +344,14 @@ wait_for_job_and_quit() {
 
     sleep 1
 
+    # List of expected events
+    capture_events='BLOCK_JOB_CANCELLED JOB_STATUS_CHANGE SHUTDOWN'
+
     _send_qemu_cmd $h \
         '{"execute": "quit"}' \
         'return'
 
-    # List of expected events
-    capture_events='BLOCK_JOB_CANCELLED JOB_STATUS_CHANGE SHUTDOWN'
     _wait_event $h 'SHUTDOWN'
-    QEMU_EVENTS= # Ignore all JOB_STATUS_CHANGE events that came before SHUTDOWN
     _wait_event $h 'JOB_STATUS_CHANGE' # standby
     _wait_event $h 'JOB_STATUS_CHANGE' # ready
     _wait_event $h 'JOB_STATUS_CHANGE' # aborting
diff --git a/tests/qemu-iotests/185.out b/tests/qemu-iotests/185.out
index 70e8dd6c87..1cccccb1b6 100644
--- a/tests/qemu-iotests/185.out
+++ b/tests/qemu-iotests/185.out
@@ -40,9 +40,16 @@ Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off comp
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
 {"return": {}}
 { 'execute': 'quit' }
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "paused", "id": "disk"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "paused", "id": "disk"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "disk"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 67108864, "offset": 524288, "speed": 65536, "type": "commit"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "disk"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "disk"}}
+{"return": {}}
 
 === Start active commit job and exit qemu ===
 
@@ -56,9 +63,16 @@ Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off comp
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
 {"return": {}}
 { 'execute': 'quit' }
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "paused", "id": "disk"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "paused", "id": "disk"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "disk"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 4194304, "offset": 4194304, "speed": 65536, "type": "commit"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "disk"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "disk"}}
+{"return": {}}
 
 === Start mirror job and exit qemu ===
 
@@ -75,9 +89,16 @@ Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 cluster_size=65536 extended_l2=off
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
 {"return": {}}
 { 'execute': 'quit' }
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "paused", "id": "disk"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "paused", "id": "disk"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "disk"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 4194304, "offset": 4194304, "speed": 65536, "type": "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "disk"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "disk"}}
+{"return": {}}
 
 === Start backup job and exit qemu ===
 
@@ -97,9 +118,16 @@ Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 cluster_size=65536 extended_l2=off
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
 {"return": {}}
 { 'execute': 'quit' }
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "paused", "id": "disk"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "paused", "id": "disk"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "disk"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 67108864, "offset": 65536, "speed": 65536, "type": "backup"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "disk"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "disk"}}
+{"return": {}}
 
 === Start streaming job and exit qemu ===
 
@@ -112,9 +140,16 @@ Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 cluster_size=65536 extended_l2=off
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
 {"return": {}}
 { 'execute': 'quit' }
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "paused", "id": "disk"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "paused", "id": "disk"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "disk"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 67108864, "offset": 524288, "speed": 65536, "type": "stream"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "disk"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "disk"}}
+{"return": {}}
 No errors were found on the image.
 
 === Start mirror to throttled QSD and exit qemu ===
diff --git a/tests/qemu-iotests/191.out b/tests/qemu-iotests/191.out
index ea88777374..c3309e4bc6 100644
--- a/tests/qemu-iotests/191.out
+++ b/tests/qemu-iotests/191.out
@@ -378,10 +378,6 @@ wrote 65536/65536 bytes at offset 1048576
     ]
 }
 { 'execute': 'quit' }
-{
-    "return": {
-    }
-}
 {
     "timestamp": {
         "seconds":  TIMESTAMP,
@@ -393,6 +389,10 @@ wrote 65536/65536 bytes at offset 1048576
         "reason": "host-qmp-quit"
     }
 }
+{
+    "return": {
+    }
+}
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 64 MiB (67108864 bytes)
@@ -796,10 +796,6 @@ wrote 65536/65536 bytes at offset 1048576
     ]
 }
 { 'execute': 'quit' }
-{
-    "return": {
-    }
-}
 {
     "timestamp": {
         "seconds":  TIMESTAMP,
@@ -811,6 +807,10 @@ wrote 65536/65536 bytes at offset 1048576
         "reason": "host-qmp-quit"
     }
 }
+{
+    "return": {
+    }
+}
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 64 MiB (67108864 bytes)
diff --git a/tests/qemu-iotests/195.out b/tests/qemu-iotests/195.out
index ec84df5012..91717d302e 100644
--- a/tests/qemu-iotests/195.out
+++ b/tests/qemu-iotests/195.out
@@ -17,10 +17,6 @@ Testing: -drive if=none,file=TEST_DIR/t.IMGFMT,backing.node-name=mid
     "return": {
     }
 }
-{
-    "return": {
-    }
-}
 {
     "timestamp": {
         "seconds":  TIMESTAMP,
@@ -32,6 +28,10 @@ Testing: -drive if=none,file=TEST_DIR/t.IMGFMT,backing.node-name=mid
         "reason": "host-qmp-quit"
     }
 }
+{
+    "return": {
+    }
+}
 
 image: TEST_DIR/t.IMGFMT.mid
 file format: IMGFMT
@@ -55,10 +55,6 @@ Testing: -drive if=none,file=TEST_DIR/t.IMGFMT,node-name=top
     "return": {
     }
 }
-{
-    "return": {
-    }
-}
 {
     "timestamp": {
         "seconds":  TIMESTAMP,
@@ -70,6 +66,10 @@ Testing: -drive if=none,file=TEST_DIR/t.IMGFMT,node-name=top
         "reason": "host-qmp-quit"
     }
 }
+{
+    "return": {
+    }
+}
 
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
diff --git a/tests/qemu-iotests/223.out b/tests/qemu-iotests/223.out
index 26fb347c5d..65625c491e 100644
--- a/tests/qemu-iotests/223.out
+++ b/tests/qemu-iotests/223.out
@@ -11,8 +11,8 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 
 === Write part of the file under active bitmap ===
@@ -142,14 +142,14 @@ read 2097152/2097152 bytes at offset 2097152
 
 {"execute":"nbd-server-remove",
   "arguments":{"name":"n"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_EXPORT_DELETED", "data": {"id": "n"}}
 {"return": {}}
 {"execute":"nbd-server-remove",
   "arguments":{"name":"n2"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_EXPORT_DELETED", "data": {"id": "n"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_EXPORT_DELETED", "data": {"id": "n2"}}
 {"return": {}}
 {"execute":"nbd-server-remove",
   "arguments":{"name":"n2"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_EXPORT_DELETED", "data": {"id": "n2"}}
 {"error": {"class": "GenericError", "desc": "Export 'n2' is not found"}}
 {"execute":"nbd-server-stop"}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_EXPORT_DELETED", "data": {"id": "n3"}}
@@ -261,14 +261,14 @@ read 2097152/2097152 bytes at offset 2097152
 
 {"execute":"nbd-server-remove",
   "arguments":{"name":"n"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_EXPORT_DELETED", "data": {"id": "n"}}
 {"return": {}}
 {"execute":"nbd-server-remove",
   "arguments":{"name":"n2"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_EXPORT_DELETED", "data": {"id": "n"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_EXPORT_DELETED", "data": {"id": "n2"}}
 {"return": {}}
 {"execute":"nbd-server-remove",
   "arguments":{"name":"n2"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_EXPORT_DELETED", "data": {"id": "n2"}}
 {"error": {"class": "GenericError", "desc": "Export 'n2' is not found"}}
 {"execute":"nbd-server-stop"}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_EXPORT_DELETED", "data": {"id": "n3"}}
@@ -276,8 +276,8 @@ read 2097152/2097152 bytes at offset 2097152
 {"execute":"nbd-server-stop"}
 {"error": {"class": "GenericError", "desc": "NBD server not running"}}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 === Use qemu-nbd as server ===
 
diff --git a/tests/qemu-iotests/227.out b/tests/qemu-iotests/227.out
index 378c1b8fb1..b6a56118b7 100644
--- a/tests/qemu-iotests/227.out
+++ b/tests/qemu-iotests/227.out
@@ -48,10 +48,6 @@ Testing: -drive driver=null-co,read-zeroes=on,if=virtio
         }
     ]
 }
-{
-    "return": {
-    }
-}
 {
     "timestamp": {
         "seconds":  TIMESTAMP,
@@ -63,6 +59,10 @@ Testing: -drive driver=null-co,read-zeroes=on,if=virtio
         "reason": "host-qmp-quit"
     }
 }
+{
+    "return": {
+    }
+}
 
 
 === blockstats with -drive if=none ===
@@ -112,10 +112,6 @@ Testing: -drive driver=null-co,if=none
         }
     ]
 }
-{
-    "return": {
-    }
-}
 {
     "timestamp": {
         "seconds":  TIMESTAMP,
@@ -127,6 +123,10 @@ Testing: -drive driver=null-co,if=none
         "reason": "host-qmp-quit"
     }
 }
+{
+    "return": {
+    }
+}
 
 
 === blockstats with -blockdev ===
@@ -143,10 +143,6 @@ Testing: -blockdev driver=null-co,node-name=null
     "return": [
     ]
 }
-{
-    "return": {
-    }
-}
 {
     "timestamp": {
         "seconds":  TIMESTAMP,
@@ -158,6 +154,10 @@ Testing: -blockdev driver=null-co,node-name=null
         "reason": "host-qmp-quit"
     }
 }
+{
+    "return": {
+    }
+}
 
 
 === blockstats with -blockdev and -device ===
@@ -208,10 +208,6 @@ Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device virtio-b
         }
     ]
 }
-{
-    "return": {
-    }
-}
 {
     "timestamp": {
         "seconds":  TIMESTAMP,
@@ -223,5 +219,9 @@ Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device virtio-b
         "reason": "host-qmp-quit"
     }
 }
+{
+    "return": {
+    }
+}
 
 *** done
diff --git a/tests/qemu-iotests/247.out b/tests/qemu-iotests/247.out
index e909e83994..7d252e7fe4 100644
--- a/tests/qemu-iotests/247.out
+++ b/tests/qemu-iotests/247.out
@@ -17,6 +17,6 @@ QMP_VERSION
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "job0", "len": 134217728, "offset": 134217728, "speed": 0, "type": "commit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job0"}}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 *** done
diff --git a/tests/qemu-iotests/273.out b/tests/qemu-iotests/273.out
index 6a74a8138b..71843f02de 100644
--- a/tests/qemu-iotests/273.out
+++ b/tests/qemu-iotests/273.out
@@ -282,10 +282,6 @@ Testing: -blockdev file,node-name=base,filename=TEST_DIR/t.IMGFMT.base -blockdev
         ]
     }
 }
-{
-    "return": {
-    }
-}
 {
     "timestamp": {
         "seconds":  TIMESTAMP,
@@ -297,5 +293,9 @@ Testing: -blockdev file,node-name=base,filename=TEST_DIR/t.IMGFMT.base -blockdev
         "reason": "host-qmp-quit"
     }
 }
+{
+    "return": {
+    }
+}
 
 *** done
diff --git a/tests/qemu-iotests/308 b/tests/qemu-iotests/308
index bde4aac2fa..d1bb49f1de 100755
--- a/tests/qemu-iotests/308
+++ b/tests/qemu-iotests/308
@@ -77,6 +77,7 @@ fuse_export_add()
 # $1: Export ID
 fuse_export_del()
 {
+    capture_events="BLOCK_EXPORT_DELETED" \
     _send_qemu_cmd $QEMU_HANDLE \
         "{'execute': 'block-export-del',
           'arguments': {
@@ -84,8 +85,7 @@ fuse_export_del()
           } }" \
         'return'
 
-    _send_qemu_cmd $QEMU_HANDLE \
-        '' \
+    _wait_event $QEMU_HANDLE \
         'BLOCK_EXPORT_DELETED'
 }
 
diff --git a/tests/qemu-iotests/308.out b/tests/qemu-iotests/308.out
index e4467a10cf..9fcf8844d4 100644
--- a/tests/qemu-iotests/308.out
+++ b/tests/qemu-iotests/308.out
@@ -165,9 +165,9 @@ OK: Post-truncate image size is as expected
 
 === Tear down ===
 {'execute': 'quit'}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_EXPORT_DELETED", "data": {"id": "export-mp"}}
+{"return": {}}
 
 === Compare copy with original ===
 Images are identical.
diff --git a/tests/qemu-iotests/tests/qsd-jobs.out b/tests/qemu-iotests/tests/qsd-jobs.out
index c1bc9b8356..aa6b6d1aef 100644
--- a/tests/qemu-iotests/tests/qsd-jobs.out
+++ b/tests/qemu-iotests/tests/qsd-jobs.out
@@ -7,8 +7,8 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/
 QMP_VERSION
 {"return": {}}
 {"return": {}}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "job0", "len": 0, "offset": 0, "speed": 0, "type": "commit"}}
+{"return": {}}
 
 === Streaming can't get permission on base node ===
 
@@ -17,6 +17,6 @@ QMP_VERSION
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job0"}}
 {"error": {"class": "GenericError", "desc": "Permission conflict on node 'fmt_base': permissions 'write' are both required by an unnamed block device (uses node 'fmt_base' as 'root' child) and unshared by stream job 'job0' (uses node 'fmt_base' as 'intermediate node' child)."}}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_EXPORT_DELETED", "data": {"id": "export1"}}
+{"return": {}}
 *** done
-- 
2.39.2


