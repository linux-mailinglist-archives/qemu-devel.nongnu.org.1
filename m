Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91356BCF701
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Oct 2025 16:22:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7aEY-0005hQ-Hf; Sat, 11 Oct 2025 10:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7aEM-0005dq-2P
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 10:05:54 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7aE9-0005Se-4v
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 10:05:53 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id E24E1C0198;
 Sat, 11 Oct 2025 17:04:52 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id h4NOTl1FrqM0-wuUSrn9v; Sat, 11 Oct 2025 17:04:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760191492;
 bh=Rud6N/8EOaRmexXfDpe6yvJ3eRpDftouptgpBJ3O2Yg=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=BeGwKY14w5fWEbPNtPR32N6hEAw5vPfbXkG1mRUL5I67Of+HK7qR6RCinRynJ+w2S
 qxS+57oAHrEcPs4R5mnqvWeeiMHqxEQldsAgdhBewlbshLWvPhaH50KjwHZ5EG5DIg
 XFSPRBvFbRNJVt/AxjAcj/K/AizI3oeCr1nFXEJU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, eblake@redhat.com,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 14/33] qapi/migration.json: docs: width=70 and two spaces
 between sentences
Date: Sat, 11 Oct 2025 17:04:20 +0300
Message-ID: <20251011140441.297246-15-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251011140441.297246-1-vsementsov@yandex-team.ru>
References: <20251011140441.297246-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 qapi/migration.json | 209 ++++++++++++++++++++++++++------------------
 1 file changed, 124 insertions(+), 85 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index be0f3fcc12..74b9db1a51 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -160,11 +160,11 @@
 #
 # @pre-switchover: Paused before device serialisation.  (since 2.11)
 #
-# @device: During device serialisation (also known as switchover phase).
-#     Before 9.2, this is only used when (1) in precopy, and (2) when
-#     pre-switchover capability is enabled.  After 10.0, this state will
-#     always be present for every migration procedure as the switchover
-#     phase.  (since 2.11)
+# @device: During device serialisation (also known as switchover
+#     phase).  Before 9.2, this is only used when (1) in precopy, and
+#     (2) when pre-switchover capability is enabled.  After 10.0, this
+#     state will always be present for every migration procedure as
+#     the switchover phase.  (since 2.11)
 #
 # @wait-unplug: wait for device unplug request by guest OS to be
 #     completed.  (since 4.2)
@@ -238,30 +238,33 @@
 #     This is only present when the postcopy-blocktime migration
 #     capability is enabled.  (Since 3.0)
 #
-# @postcopy-latency: average remote page fault latency (in ns).  Note that
-#     this doesn't include all faults, but only the ones that require a
-#     remote page request.  So it should be always bigger than the real
-#     average page fault latency. This is only present when the
-#     postcopy-blocktime migration capability is enabled.  (Since 10.1)
-#
-# @postcopy-latency-dist: remote page fault latency distributions.  Each
-#     element of the array is the number of faults that fall into the
-#     bucket period.  For the N-th bucket (N>=0), the latency window is
-#     [2^Nus, 2^(N+1)us).  For example, the 8th element stores how many
-#     remote faults got resolved within [256us, 512us) window. This is only
-#     present when the postcopy-blocktime migration capability is enabled.
+# @postcopy-latency: average remote page fault latency (in ns).
+#     Note that this doesn't include all faults, but only the ones
+#     that require a remote page request.  So it should be always
+#     bigger than the real average page fault latency.  This is only
+#     present when the postcopy-blocktime migration capability is
+#     enabled.  (Since 10.1)
+#
+# @postcopy-latency-dist: remote page fault latency distributions.
+#     Each element of the array is the number of faults that fall into
+#     the bucket period.  For the N-th bucket (N>=0), the latency
+#     window is [2^Nus, 2^(N+1)us).  For example, the 8th element
+#     stores how many remote faults got resolved within [256us, 512us)
+#     window.  This is only present when the postcopy-blocktime
+#     migration capability is enabled. (Since 10.1)
+#
+# @postcopy-vcpu-latency: average remote page fault latency per vCPU
+#     (in ns).  It has the same definition of @postcopy-latency, but
+#     instead this is the per-vCPU statistics.  This is only present
+#     when the postcopy-blocktime migration capability is enabled.
 #     (Since 10.1)
 #
-# @postcopy-vcpu-latency: average remote page fault latency per vCPU (in
-#     ns).  It has the same definition of @postcopy-latency, but instead
-#     this is the per-vCPU statistics.  This is only present when the
-#     postcopy-blocktime migration capability is enabled.  (Since 10.1)
-#
-# @postcopy-non-vcpu-latency: average remote page fault latency for all
-#     faults happend in non-vCPU threads (in ns).  It has the same
-#     definition of @postcopy-latency but this only provides statistics to
-#     non-vCPU faults.  This is only present when the postcopy-blocktime
-#     migration capability is enabled.  (Since 10.1)
+# @postcopy-non-vcpu-latency: average remote page fault latency for
+#     all faults happend in non-vCPU threads (in ns).  It has the same
+#     definition of @postcopy-latency but this only provides
+#     statistics to non-vCPU faults.  This is only present when the
+#     postcopy-blocktime migration capability is enabled.
+#     (Since 10.1)
 #
 # @socket-address: Only used for tcp, to know what the real port is
 #     (Since 4.0)
@@ -290,7 +293,8 @@
 # Features:
 #
 # @unstable: Members @postcopy-latency, @postcopy-vcpu-latency,
-#     @postcopy-latency-dist, @postcopy-non-vcpu-latency are experimental.
+#     @postcopy-latency-dist, @postcopy-non-vcpu-latency are
+#     experimental.
 #
 # Since: 0.14
 ##
@@ -564,7 +568,8 @@
 # .. qmp-example::
 #
 #     -> { "execute": "migrate-set-capabilities" , "arguments":
-#          { "capabilities": [ { "capability": "xbzrle", "state": true } ] } }
+#          { "capabilities": [ { "capability": "xbzrle",
+#                                "state": true } ] } }
 #     <- { "return": {} }
 ##
 { 'command': 'migrate-set-capabilities',
@@ -627,8 +632,8 @@
 #
 # @normal: the original form of migration.  (since 8.2)
 #
-# @cpr-reboot: The `migrate` command stops the VM and saves state to the
-#     URI.  After quitting QEMU, the user resumes by running QEMU
+# @cpr-reboot: The `migrate` command stops the VM and saves state to
+#     the URI.  After quitting QEMU, the user resumes by running QEMU
 #     -incoming.
 #
 #     This mode allows the user to quit QEMU, optionally update and
@@ -903,9 +908,10 @@
 #     more CPU.  Defaults to 1.  (Since 5.0)
 #
 # @multifd-qatzip-level: Set the compression level to be used in live
-#     migration.  The level is an integer between 1 and 9, where 1 means
-#     the best compression speed, and 9 means the best compression
-#     ratio which will consume more CPU.  Defaults to 1.  (Since 9.2)
+#     migration.  The level is an integer between 1 and 9, where 1
+#     means the best compression speed, and 9 means the best
+#     compression ratio which will consume more CPU.  Defaults to 1.
+#     (Since 9.2)
 #
 # @multifd-zstd-level: Set the compression level to be used in live
 #     migration, the compression level is an integer between 0 and 20,
@@ -1089,9 +1095,10 @@
 #     more CPU.  Defaults to 1.  (Since 5.0)
 #
 # @multifd-qatzip-level: Set the compression level to be used in live
-#     migration.  The level is an integer between 1 and 9, where 1 means
-#     the best compression speed, and 9 means the best compression
-#     ratio which will consume more CPU.  Defaults to 1.  (Since 9.2)
+#     migration.  The level is an integer between 1 and 9, where 1
+#     means the best compression speed, and 9 means the best
+#     compression ratio which will consume more CPU.  Defaults to 1.
+#     (Since 9.2)
 #
 # @multifd-zstd-level: Set the compression level to be used in live
 #     migration, the compression level is an integer between 0 and 20,
@@ -1304,9 +1311,10 @@
 #     more CPU.  Defaults to 1.  (Since 5.0)
 #
 # @multifd-qatzip-level: Set the compression level to be used in live
-#     migration.  The level is an integer between 1 and 9, where 1 means
-#     the best compression speed, and 9 means the best compression
-#     ratio which will consume more CPU.  Defaults to 1.  (Since 9.2)
+#     migration.  The level is an integer between 1 and 9, where 1
+#     means the best compression speed, and 9 means the best
+#     compression ratio which will consume more CPU.  Defaults to 1.
+#     (Since 9.2)
 #
 # @multifd-zstd-level: Set the compression level to be used in live
 #     migration, the compression level is an integer between 0 and 20,
@@ -1442,7 +1450,8 @@
 #
 # .. qmp-example::
 #
-#     <- {"timestamp": {"seconds": 1432121972, "microseconds": 744001},
+#     <- {"timestamp": {"seconds": 1432121972,
+#                       "microseconds": 744001},
 #         "event": "MIGRATION",
 #         "data": {"status": "completed"} }
 ##
@@ -1461,7 +1470,8 @@
 #
 # .. qmp-example::
 #
-#     <- { "timestamp": {"seconds": 1449669631, "microseconds": 239225},
+#     <- { "timestamp": {"seconds": 1449669631,
+#                        "microseconds": 239225},
 #           "event": "MIGRATION_PASS", "data": {"pass": 2} }
 ##
 { 'event': 'MIGRATION_PASS',
@@ -1545,8 +1555,10 @@
 #
 # .. qmp-example::
 #
-#     <- { "timestamp": {"seconds": 2032141960, "microseconds": 417172},
-#          "event": "COLO_EXIT", "data": {"mode": "primary", "reason": "request" } }
+#     <- { "timestamp": {"seconds": 2032141960,
+#                        "microseconds": 417172},
+#          "event": "COLO_EXIT",
+#          "data": { "mode": "primary", "reason": "request" } }
 ##
 { 'event': 'COLO_EXIT',
   'data': {'mode': 'COLOMode', 'reason': 'COLOExitReason' } }
@@ -1758,7 +1770,8 @@
 #
 # .. qmp-example::
 #
-#     -> { "execute": "migrate", "arguments": { "uri": "tcp:0:4446" } }
+#     -> { "execute": "migrate",
+#          "arguments": { "uri": "tcp:0:4446" } }
 #     <- { "return": {} }
 #
 #     -> { "execute": "migrate",
@@ -1774,8 +1787,9 @@
 #          "arguments": {
 #              "channels": [ { "channel-type": "main",
 #                              "addr": { "transport": "exec",
-#                                        "args": [ "/bin/nc", "-p", "6000",
-#                                                  "/some/sock" ] } } ] } }
+#                                        "args": [
+#                                          "/bin/nc", "-p", "6000",
+#                                          "/some/sock" ] } } ] } }
 #     <- { "return": {} }
 #
 #     -> { "execute": "migrate",
@@ -1813,9 +1827,9 @@
 #     list connected to a destination interface endpoint.
 #
 # @exit-on-error: Exit on incoming migration failure.  Default true.
-#     When set to false, the failure triggers a :qapi:event:`MIGRATION`
-#     event, and error details could be retrieved with `query-migrate`.
-#     (since 9.1)
+#     When set to false, the failure triggers a
+#     :qapi:event:`MIGRATION` event, and error details could be
+#     retrieved with `query-migrate`. (since 9.1)
 #
 # Since: 2.3
 #
@@ -1855,8 +1869,9 @@
 #          "arguments": {
 #              "channels": [ { "channel-type": "main",
 #                              "addr": { "transport": "exec",
-#                                        "args": [ "/bin/nc", "-p", "6000",
-#                                                  "/some/sock" ] } } ] } }
+#                                        "args": [
+#                                          "/bin/nc", "-p", "6000",
+#                                          "/some/sock" ] } } ] } }
 #     <- { "return": {} }
 #
 #     -> { "execute": "migrate-incoming",
@@ -2037,7 +2052,8 @@
 # .. qmp-example::
 #
 #     -> { "execute": "query-colo-status" }
-#     <- { "return": { "mode": "primary", "last-mode": "none", "reason": "request" } }
+#     <- { "return": { "mode": "primary", "last-mode": "none",
+#                      "reason": "request" } }
 #
 # Since: 3.1
 ##
@@ -2094,7 +2110,8 @@
 #
 #     <- { "event": "UNPLUG_PRIMARY",
 #          "data": { "device-id": "hostdev0" },
-#          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#          "timestamp": { "seconds": 1265044230,
+#                         "microseconds": 450486 } }
 ##
 { 'event': 'UNPLUG_PRIMARY',
   'data': { 'device-id': 'str' } }
@@ -2252,8 +2269,8 @@
 #
 # .. qmp-example::
 #
-#     -> {"execute": "calc-dirty-rate", "arguments": {"calc-time": 1,
-#                                                     "sample-pages": 512} }
+#     -> { "execute": "calc-dirty-rate",
+#          "arguments": {"calc-time": 1, "sample-pages": 512} }
 #     <- { "return": {} }
 #
 # .. qmp-example::
@@ -2261,8 +2278,10 @@
 #
 #    Measure dirty rate using dirty bitmap for 500 milliseconds::
 #
-#     -> {"execute": "calc-dirty-rate", "arguments": {"calc-time": 500,
-#         "calc-time-unit": "millisecond", "mode": "dirty-bitmap"} }
+#     -> { "execute": "calc-dirty-rate",
+#          "arguments": { "calc-time": 500,
+#                         "calc-time-unit": "millisecond",
+#                         "mode": "dirty-bitmap"} }
 #
 #     <- { "return": {} }
 ##
@@ -2284,16 +2303,17 @@
 # .. qmp-example::
 #    :title: Measurement is in progress
 #
-#     <- {"status": "measuring", "sample-pages": 512,
-#         "mode": "page-sampling", "start-time": 1693900454, "calc-time": 10,
-#         "calc-time-unit": "second"}
+#     <- { "status": "measuring", "sample-pages": 512,
+#          "mode": "page-sampling", "start-time": 1693900454,
+#          "calc-time": 10, "calc-time-unit": "second" }
 #
 # .. qmp-example::
 #    :title: Measurement has been completed
 #
-#     <- {"status": "measured", "sample-pages": 512, "dirty-rate": 108,
-#         "mode": "page-sampling", "start-time": 1693900454, "calc-time": 10,
-#         "calc-time-unit": "second"}
+#     <- { "status": "measured", "sample-pages": 512,
+#          "dirty-rate": 108, "mode": "page-sampling",
+#          "start-time": 1693900454,
+#          "calc-time": 10, "calc-time-unit": "second" }
 ##
 { 'command': 'query-dirty-rate', 'data': {'*calc-time-unit': 'TimeUnit' },
                                  'returns': 'DirtyRateInfo' }
@@ -2452,23 +2472,30 @@
 #        }
 #     <- { "return": { } }
 #     <- {"event": "JOB_STATUS_CHANGE",
-#         "timestamp": {"seconds": 1432121972, "microseconds": 744001},
+#         "timestamp": {"seconds": 1432121972,
+#                       "microseconds": 744001},
 #         "data": {"status": "created", "id": "snapsave0"}}
 #     <- {"event": "JOB_STATUS_CHANGE",
-#         "timestamp": {"seconds": 1432122172, "microseconds": 744001},
+#         "timestamp": {"seconds": 1432122172,
+#                       "microseconds": 744001},
 #         "data": {"status": "running", "id": "snapsave0"}}
 #     <- {"event": "STOP",
-#         "timestamp": {"seconds": 1432122372, "microseconds": 744001} }
+#         "timestamp": {"seconds": 1432122372,
+#                       "microseconds": 744001} }
 #     <- {"event": "RESUME",
-#         "timestamp": {"seconds": 1432122572, "microseconds": 744001} }
+#         "timestamp": {"seconds": 1432122572,
+#                       "microseconds": 744001} }
 #     <- {"event": "JOB_STATUS_CHANGE",
-#         "timestamp": {"seconds": 1432122772, "microseconds": 744001},
+#         "timestamp": {"seconds": 1432122772,
+#                       "microseconds": 744001},
 #         "data": {"status": "waiting", "id": "snapsave0"}}
 #     <- {"event": "JOB_STATUS_CHANGE",
-#         "timestamp": {"seconds": 1432122972, "microseconds": 744001},
+#         "timestamp": {"seconds": 1432122972,
+#                       "microseconds": 744001},
 #         "data": {"status": "pending", "id": "snapsave0"}}
 #     <- {"event": "JOB_STATUS_CHANGE",
-#         "timestamp": {"seconds": 1432123172, "microseconds": 744001},
+#         "timestamp": {"seconds": 1432123172,
+#                       "microseconds": 744001},
 #         "data": {"status": "concluded", "id": "snapsave0"}}
 #     -> {"execute": "query-jobs"}
 #     <- {"return": [{"current-progress": 1,
@@ -2507,8 +2534,8 @@
 # time it takes to load the snapshot.
 #
 # It is strongly recommended that @devices contain all writable block
-# device nodes that can have changed since the original `snapshot-save`
-# command execution.
+# device nodes that can have changed since the original
+# `snapshot-save` command execution.
 #
 # .. qmp-example::
 #
@@ -2522,23 +2549,30 @@
 #        }
 #     <- { "return": { } }
 #     <- {"event": "JOB_STATUS_CHANGE",
-#         "timestamp": {"seconds": 1472124172, "microseconds": 744001},
+#         "timestamp": {"seconds": 1472124172,
+#                       "microseconds": 744001},
 #         "data": {"status": "created", "id": "snapload0"}}
 #     <- {"event": "JOB_STATUS_CHANGE",
-#         "timestamp": {"seconds": 1472125172, "microseconds": 744001},
+#         "timestamp": {"seconds": 1472125172,
+#                       "microseconds": 744001},
 #         "data": {"status": "running", "id": "snapload0"}}
 #     <- {"event": "STOP",
-#         "timestamp": {"seconds": 1472125472, "microseconds": 744001} }
+#         "timestamp": {"seconds": 1472125472,
+#                       "microseconds": 744001} }
 #     <- {"event": "RESUME",
-#         "timestamp": {"seconds": 1472125872, "microseconds": 744001} }
+#         "timestamp": {"seconds": 1472125872,
+#                       "microseconds": 744001} }
 #     <- {"event": "JOB_STATUS_CHANGE",
-#         "timestamp": {"seconds": 1472126172, "microseconds": 744001},
+#         "timestamp": {"seconds": 1472126172,
+#                       "microseconds": 744001},
 #         "data": {"status": "waiting", "id": "snapload0"}}
 #     <- {"event": "JOB_STATUS_CHANGE",
-#         "timestamp": {"seconds": 1472127172, "microseconds": 744001},
+#         "timestamp": {"seconds": 1472127172,
+#                       "microseconds": 744001},
 #         "data": {"status": "pending", "id": "snapload0"}}
 #     <- {"event": "JOB_STATUS_CHANGE",
-#         "timestamp": {"seconds": 1472128172, "microseconds": 744001},
+#         "timestamp": {"seconds": 1472128172,
+#                       "microseconds": 744001},
 #         "data": {"status": "concluded", "id": "snapload0"}}
 #     -> {"execute": "query-jobs"}
 #     <- {"return": [{"current-progress": 1,
@@ -2582,19 +2616,24 @@
 #        }
 #     <- { "return": { } }
 #     <- {"event": "JOB_STATUS_CHANGE",
-#         "timestamp": {"seconds": 1442124172, "microseconds": 744001},
+#         "timestamp": {"seconds": 1442124172,
+#                       "microseconds": 744001},
 #         "data": {"status": "created", "id": "snapdelete0"}}
 #     <- {"event": "JOB_STATUS_CHANGE",
-#         "timestamp": {"seconds": 1442125172, "microseconds": 744001},
+#         "timestamp": {"seconds": 1442125172,
+#                       "microseconds": 744001},
 #         "data": {"status": "running", "id": "snapdelete0"}}
 #     <- {"event": "JOB_STATUS_CHANGE",
-#         "timestamp": {"seconds": 1442126172, "microseconds": 744001},
+#         "timestamp": {"seconds": 1442126172,
+#                       "microseconds": 744001},
 #         "data": {"status": "waiting", "id": "snapdelete0"}}
 #     <- {"event": "JOB_STATUS_CHANGE",
-#         "timestamp": {"seconds": 1442127172, "microseconds": 744001},
+#         "timestamp": {"seconds": 1442127172,
+#                       "microseconds": 744001},
 #         "data": {"status": "pending", "id": "snapdelete0"}}
 #     <- {"event": "JOB_STATUS_CHANGE",
-#         "timestamp": {"seconds": 1442128172, "microseconds": 744001},
+#         "timestamp": {"seconds": 1442128172,
+#                       "microseconds": 744001},
 #         "data": {"status": "concluded", "id": "snapdelete0"}}
 #     -> {"execute": "query-jobs"}
 #     <- {"return": [{"current-progress": 1,
-- 
2.48.1


