Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA52831BBD
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 15:49:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQThY-0006ER-D5; Thu, 18 Jan 2024 09:49:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rQThF-00061R-J2
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 09:48:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rQThA-0008Jg-9A
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 09:48:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705589319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vz7T1VScHuEZSTSlV/6Vizw7xW/XNipvoHmzz2FINLk=;
 b=V38MvImluybs1+KHockYDqO7buRVPPWgfBRVSm1YmcqocFd/0E38tEtG29d3KZIZt12RxU
 meCZfndTujbt/RlGmkI3EOhpYwiK3HX350u8Wi3py2NBLmfEVVg/Ch/A7nMn+/xvFBIxr+
 +tVpdBN9sdytlIF+R5JSmTCfeHGDh+c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-DoLGWQzXPGKWKhUs4Fe0dg-1; Thu, 18 Jan 2024 09:48:35 -0500
X-MC-Unique: DoLGWQzXPGKWKhUs4Fe0dg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD6B88F476F;
 Thu, 18 Jan 2024 14:48:34 +0000 (UTC)
Received: from localhost (unknown [10.39.192.126])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 35F051C05E0E;
 Thu, 18 Jan 2024 14:48:32 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-stable@nongnu.org>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 3/3] monitor: only run coroutine commands in
 qemu_aio_context
Date: Thu, 18 Jan 2024 09:48:23 -0500
Message-ID: <20240118144823.1497953-4-stefanha@redhat.com>
In-Reply-To: <20240118144823.1497953-1-stefanha@redhat.com>
References: <20240118144823.1497953-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Fixes: 7bed89958bfbf40df9ca681cefbdca63abdde39d ("device_core: use drain_call_rcu in in qmp_device_add")
Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2215192
Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2214985
Buglink: https://issues.redhat.com/browse/RHEL-17369
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 monitor/qmp.c                                 | 17 ----
 qapi/qmp-dispatch.c                           | 24 +++++-
 tests/qemu-iotests/060.out                    |  4 +-
 tests/qemu-iotests/071.out                    |  4 +-
 tests/qemu-iotests/081.out                    | 16 ++--
 tests/qemu-iotests/087.out                    | 12 +--
 tests/qemu-iotests/108.out                    |  2 +-
 tests/qemu-iotests/109                        |  4 +-
 tests/qemu-iotests/109.out                    | 78 ++++++++-----------
 tests/qemu-iotests/117.out                    |  2 +-
 tests/qemu-iotests/120.out                    |  2 +-
 tests/qemu-iotests/127.out                    |  2 +-
 tests/qemu-iotests/140.out                    |  2 +-
 tests/qemu-iotests/143.out                    |  2 +-
 tests/qemu-iotests/156.out                    |  2 +-
 tests/qemu-iotests/176.out                    | 16 ++--
 tests/qemu-iotests/182.out                    |  2 +-
 tests/qemu-iotests/183.out                    |  4 +-
 tests/qemu-iotests/184.out                    | 32 ++++----
 tests/qemu-iotests/185                        |  6 +-
 tests/qemu-iotests/185.out                    | 45 +++++++++--
 tests/qemu-iotests/191.out                    | 16 ++--
 tests/qemu-iotests/195.out                    | 16 ++--
 tests/qemu-iotests/223.out                    | 16 ++--
 tests/qemu-iotests/227.out                    | 32 ++++----
 tests/qemu-iotests/247.out                    |  2 +-
 tests/qemu-iotests/273.out                    |  8 +-
 tests/qemu-iotests/308                        |  4 +-
 tests/qemu-iotests/308.out                    |  4 +-
 tests/qemu-iotests/tests/file-io-error        |  5 +-
 tests/qemu-iotests/tests/iothreads-resize.out |  2 +-
 tests/qemu-iotests/tests/qsd-jobs.out         |  4 +-
 32 files changed, 207 insertions(+), 180 deletions(-)

diff --git a/monitor/qmp.c b/monitor/qmp.c
index 6eee450fe4..a239945e8d 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -321,14 +321,6 @@ void coroutine_fn monitor_qmp_dispatcher_co(void *data)
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
@@ -355,15 +347,6 @@ void coroutine_fn monitor_qmp_dispatcher_co(void *data)
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
     qatomic_set(&qmp_dispatcher_co, NULL);
 }
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 555528b6bb..176b549473 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -206,9 +206,31 @@ QDict *coroutine_mixed_fn qmp_dispatch(const QmpCommandList *cmds, QObject *requ
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
@@ -232,7 +254,7 @@ QDict *coroutine_mixed_fn qmp_dispatch(const QmpCommandList *cmds, QObject *requ
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
index 965c9a6a0a..3ae8552ff7 100644
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
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 1024, "offset": 1024, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror", "actively-synced": false}]}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "standby", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
@@ -50,6 +48,7 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "src", "len": 1024, "offset": 1024, "speed": 0, "type": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
+{"return": {}}
 Images are identical.
 
 === Writing a qcow2 header into raw ===
@@ -59,7 +58,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=SIZE
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 {'execute':'drive-mirror', 'arguments':{
-            'device': 'src', 'target': 'TEST_DIR/t.IMGFMT',
+            'device': 'src', 'target': 'TEST_DIR/t.IMGFMT', 
             'mode': 'existing', 'sync': 'full'}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
          Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
@@ -75,8 +74,8 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"execute":"query-block-jobs"}
 {"return": []}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 { 'execute': 'qmp_capabilities' }
@@ -87,12 +86,10 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 197120, "offset": 197120, "speed": 0, "type": "mirror"}}
 {"execute":"query-block-jobs"}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 197120, "offset": 197120, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror", "actively-synced": false}]}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "standby", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
@@ -102,6 +99,7 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "src", "len": 197120, "offset": 197120, "speed": 0, "type": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
+{"return": {}}
 Images are identical.
 
 === Writing a qed header into raw ===
@@ -111,7 +109,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=SIZE
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 {'execute':'drive-mirror', 'arguments':{
-            'device': 'src', 'target': 'TEST_DIR/t.IMGFMT',
+            'device': 'src', 'target': 'TEST_DIR/t.IMGFMT', 
             'mode': 'existing', 'sync': 'full'}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
          Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
@@ -127,8 +125,8 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"execute":"query-block-jobs"}
 {"return": []}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 { 'execute': 'qmp_capabilities' }
@@ -139,12 +137,10 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 327680, "offset": 327680, "speed": 0, "type": "mirror"}}
 {"execute":"query-block-jobs"}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 327680, "offset": 327680, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror", "actively-synced": false}]}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "standby", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
@@ -154,6 +150,7 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "src", "len": 327680, "offset": 327680, "speed": 0, "type": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
+{"return": {}}
 Images are identical.
 
 === Writing a vdi header into raw ===
@@ -163,7 +160,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=SIZE
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 {'execute':'drive-mirror', 'arguments':{
-            'device': 'src', 'target': 'TEST_DIR/t.IMGFMT',
+            'device': 'src', 'target': 'TEST_DIR/t.IMGFMT', 
             'mode': 'existing', 'sync': 'full'}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
          Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
@@ -179,8 +176,8 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"execute":"query-block-jobs"}
 {"return": []}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 { 'execute': 'qmp_capabilities' }
@@ -191,12 +188,10 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 1024, "offset": 1024, "speed": 0, "type": "mirror"}}
 {"execute":"query-block-jobs"}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 1024, "offset": 1024, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror", "actively-synced": false}]}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "standby", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
@@ -206,6 +201,7 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "src", "len": 1024, "offset": 1024, "speed": 0, "type": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
+{"return": {}}
 Images are identical.
 
 === Writing a vmdk header into raw ===
@@ -215,7 +211,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=SIZE
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 {'execute':'drive-mirror', 'arguments':{
-            'device': 'src', 'target': 'TEST_DIR/t.IMGFMT',
+            'device': 'src', 'target': 'TEST_DIR/t.IMGFMT', 
             'mode': 'existing', 'sync': 'full'}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
          Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
@@ -231,8 +227,8 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"execute":"query-block-jobs"}
 {"return": []}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 { 'execute': 'qmp_capabilities' }
@@ -243,12 +239,10 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 65536, "offset": 65536, "speed": 0, "type": "mirror"}}
 {"execute":"query-block-jobs"}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 65536, "offset": 65536, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror", "actively-synced": false}]}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "standby", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
@@ -258,6 +252,7 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "src", "len": 65536, "offset": 65536, "speed": 0, "type": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
+{"return": {}}
 Images are identical.
 
 === Writing a vpc header into raw ===
@@ -267,7 +262,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=SIZE
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 {'execute':'drive-mirror', 'arguments':{
-            'device': 'src', 'target': 'TEST_DIR/t.IMGFMT',
+            'device': 'src', 'target': 'TEST_DIR/t.IMGFMT', 
             'mode': 'existing', 'sync': 'full'}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
          Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
@@ -283,8 +278,8 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"execute":"query-block-jobs"}
 {"return": []}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 { 'execute': 'qmp_capabilities' }
@@ -295,12 +290,10 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 2560, "offset": 2560, "speed": 0, "type": "mirror"}}
 {"execute":"query-block-jobs"}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 2560, "offset": 2560, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror", "actively-synced": false}]}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "standby", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
@@ -310,6 +303,7 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "src", "len": 2560, "offset": 2560, "speed": 0, "type": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
+{"return": {}}
 Images are identical.
 
 === Copying sample image empty.bochs into raw ===
@@ -318,7 +312,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=SIZE
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 {'execute':'drive-mirror', 'arguments':{
-            'device': 'src', 'target': 'TEST_DIR/t.IMGFMT',
+            'device': 'src', 'target': 'TEST_DIR/t.IMGFMT', 
             'mode': 'existing', 'sync': 'full'}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
          Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
@@ -334,8 +328,8 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"execute":"query-block-jobs"}
 {"return": []}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 { 'execute': 'qmp_capabilities' }
@@ -346,12 +340,10 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 2560, "offset": 2560, "speed": 0, "type": "mirror"}}
 {"execute":"query-block-jobs"}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 2560, "offset": 2560, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror", "actively-synced": false}]}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "standby", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
@@ -361,6 +353,7 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "src", "len": 2560, "offset": 2560, "speed": 0, "type": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
+{"return": {}}
 Images are identical.
 
 === Copying sample image iotest-dirtylog-10G-4M.vhdx into raw ===
@@ -369,7 +362,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=SIZE
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 {'execute':'drive-mirror', 'arguments':{
-            'device': 'src', 'target': 'TEST_DIR/t.IMGFMT',
+            'device': 'src', 'target': 'TEST_DIR/t.IMGFMT', 
             'mode': 'existing', 'sync': 'full'}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
          Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
@@ -385,8 +378,8 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"execute":"query-block-jobs"}
 {"return": []}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 { 'execute': 'qmp_capabilities' }
@@ -397,12 +390,10 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 31457280, "offset": 31457280, "speed": 0, "type": "mirror"}}
 {"execute":"query-block-jobs"}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 31457280, "offset": 31457280, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror", "actively-synced": false}]}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "standby", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
@@ -412,6 +403,7 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "src", "len": 31457280, "offset": 31457280, "speed": 0, "type": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
+{"return": {}}
 Images are identical.
 
 === Copying sample image parallels-v1 into raw ===
@@ -420,7 +412,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=SIZE
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 {'execute':'drive-mirror', 'arguments':{
-            'device': 'src', 'target': 'TEST_DIR/t.IMGFMT',
+            'device': 'src', 'target': 'TEST_DIR/t.IMGFMT', 
             'mode': 'existing', 'sync': 'full'}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
          Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
@@ -436,8 +428,8 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"execute":"query-block-jobs"}
 {"return": []}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 { 'execute': 'qmp_capabilities' }
@@ -448,12 +440,10 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 327680, "offset": 327680, "speed": 0, "type": "mirror"}}
 {"execute":"query-block-jobs"}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 327680, "offset": 327680, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror", "actively-synced": false}]}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "standby", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
@@ -463,6 +453,7 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "src", "len": 327680, "offset": 327680, "speed": 0, "type": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
+{"return": {}}
 Images are identical.
 
 === Copying sample image simple-pattern.cloop into raw ===
@@ -471,7 +462,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=SIZE
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 {'execute':'drive-mirror', 'arguments':{
-            'device': 'src', 'target': 'TEST_DIR/t.IMGFMT',
+            'device': 'src', 'target': 'TEST_DIR/t.IMGFMT', 
             'mode': 'existing', 'sync': 'full'}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
          Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
@@ -487,8 +478,8 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"execute":"query-block-jobs"}
 {"return": []}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 { 'execute': 'qmp_capabilities' }
@@ -499,12 +490,10 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 2048, "offset": 2048, "speed": 0, "type": "mirror"}}
 {"execute":"query-block-jobs"}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 2048, "offset": 2048, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror", "actively-synced": false}]}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "standby", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
@@ -514,6 +503,7 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "src", "len": 2048, "offset": 2048, "speed": 0, "type": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
+{"return": {}}
 Images are identical.
 
 === Write legitimate MBR into raw ===
@@ -522,7 +512,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=SIZE
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
 {'execute':'drive-mirror', 'arguments':{
-            'device': 'src', 'target': 'TEST_DIR/t.IMGFMT',
+            'device': 'src', 'target': 'TEST_DIR/t.IMGFMT', 
             'mode': 'existing', 'sync': 'full'}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
          Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
@@ -530,12 +520,10 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 512, "offset": 512, "speed": 0, "type": "mirror"}}
 {"execute":"query-block-jobs"}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 512, "offset": 512, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror", "actively-synced": false}]}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "standby", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
@@ -545,6 +533,7 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "src", "len": 512, "offset": 512, "speed": 0, "type": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
+{"return": {}}
 Images are identical.
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
@@ -554,12 +543,10 @@ Images are identical.
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 512, "offset": 512, "speed": 0, "type": "mirror"}}
 {"execute":"query-block-jobs"}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 512, "offset": 512, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror", "actively-synced": false}]}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "standby", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
@@ -569,5 +556,6 @@ Images are identical.
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
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
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
index 2ae0a85bbf..17489fb91c 100755
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
     _wait_event $h 'JOB_STATUS_CHANGE' # standby
diff --git a/tests/qemu-iotests/185.out b/tests/qemu-iotests/185.out
index 7292c26bae..6af0953c4d 100644
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
index e5e7f42caa..5f5b42e2dc 100644
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
@@ -145,14 +145,14 @@ read 2097152/2097152 bytes at offset 2097152
 
 {"execute":"nbd-server-remove",
   "arguments":{"name":"n"}}
-{"return": {}}
-{"execute":"nbd-server-remove",
-  "arguments":{"name":"n2"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_EXPORT_DELETED", "data": {"id": "n"}}
 {"return": {}}
 {"execute":"nbd-server-remove",
   "arguments":{"name":"n2"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_EXPORT_DELETED", "data": {"id": "n2"}}
+{"return": {}}
+{"execute":"nbd-server-remove",
+  "arguments":{"name":"n2"}}
 {"error": {"class": "GenericError", "desc": "Export 'n2' is not found"}}
 {"execute":"nbd-server-stop"}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_EXPORT_DELETED", "data": {"id": "n3"}}
@@ -267,14 +267,14 @@ read 2097152/2097152 bytes at offset 2097152
 
 {"execute":"nbd-server-remove",
   "arguments":{"name":"n"}}
-{"return": {}}
-{"execute":"nbd-server-remove",
-  "arguments":{"name":"n2"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_EXPORT_DELETED", "data": {"id": "n"}}
 {"return": {}}
 {"execute":"nbd-server-remove",
   "arguments":{"name":"n2"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_EXPORT_DELETED", "data": {"id": "n2"}}
+{"return": {}}
+{"execute":"nbd-server-remove",
+  "arguments":{"name":"n2"}}
 {"error": {"class": "GenericError", "desc": "Export 'n2' is not found"}}
 {"execute":"nbd-server-stop"}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_EXPORT_DELETED", "data": {"id": "n3"}}
@@ -282,8 +282,8 @@ read 2097152/2097152 bytes at offset 2097152
 {"execute":"nbd-server-stop"}
 {"error": {"class": "GenericError", "desc": "NBD server not running"}}
 {"execute":"quit"}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 === Use qemu-nbd as server ===
 
diff --git a/tests/qemu-iotests/227.out b/tests/qemu-iotests/227.out
index a947b1a87d..d6a1d4ecb6 100644
--- a/tests/qemu-iotests/227.out
+++ b/tests/qemu-iotests/227.out
@@ -54,10 +54,6 @@ Testing: -drive driver=null-co,read-zeroes=on,if=virtio
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
@@ -69,6 +65,10 @@ Testing: -drive driver=null-co,read-zeroes=on,if=virtio
         "reason": "host-qmp-quit"
     }
 }
+{
+    "return": {
+    }
+}
 
 
 === blockstats with -drive if=none ===
@@ -124,10 +124,6 @@ Testing: -drive driver=null-co,if=none
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
@@ -139,6 +135,10 @@ Testing: -drive driver=null-co,if=none
         "reason": "host-qmp-quit"
     }
 }
+{
+    "return": {
+    }
+}
 
 
 === blockstats with -blockdev ===
@@ -155,10 +155,6 @@ Testing: -blockdev driver=null-co,node-name=null
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
@@ -170,6 +166,10 @@ Testing: -blockdev driver=null-co,node-name=null
         "reason": "host-qmp-quit"
     }
 }
+{
+    "return": {
+    }
+}
 
 
 === blockstats with -blockdev and -device ===
@@ -226,10 +226,6 @@ Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device virtio-b
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
@@ -241,5 +237,9 @@ Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device virtio-b
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
index de12b2b1b9..ea81dc496a 100755
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
index d5767133b1..e5e233691d 100644
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
@@ -201,9 +201,9 @@ wrote 67108864/67108864 bytes at offset 0
 read 67108864/67108864 bytes at offset 0
 64 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {'execute': 'quit'}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_EXPORT_DELETED", "data": {"id": "export"}}
+{"return": {}}
 read 67108864/67108864 bytes at offset 0
 64 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 *** done
diff --git a/tests/qemu-iotests/tests/file-io-error b/tests/qemu-iotests/tests/file-io-error
index 88ee5f670c..fb8db73b31 100755
--- a/tests/qemu-iotests/tests/file-io-error
+++ b/tests/qemu-iotests/tests/file-io-error
@@ -99,13 +99,12 @@ echo
 $QEMU_IO -f file -c 'write 0 64M' "$TEST_DIR/fuse-export" | _filter_qemu_io
 echo
 
-_send_qemu_cmd $QEMU_HANDLE \
+capture_events=BLOCK_EXPORT_DELETED _send_qemu_cmd $QEMU_HANDLE \
     "{'execute': 'block-export-del',
       'arguments': {'id': 'exp0'}}" \
     'return'
 
-_send_qemu_cmd $QEMU_HANDLE \
-    '' \
+_wait_event $QEMU_HANDLE \
     'BLOCK_EXPORT_DELETED'
 
 _send_qemu_cmd $QEMU_HANDLE \
diff --git a/tests/qemu-iotests/tests/iothreads-resize.out b/tests/qemu-iotests/tests/iothreads-resize.out
index 2ca5a9d964..2967ac8f0d 100644
--- a/tests/qemu-iotests/tests/iothreads-resize.out
+++ b/tests/qemu-iotests/tests/iothreads-resize.out
@@ -3,8 +3,8 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 QMP_VERSION
 {"return": {}}
 {"return": {}}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 128 MiB (134217728 bytes)
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
2.43.0


