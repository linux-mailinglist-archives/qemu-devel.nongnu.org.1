Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E875BCF66D
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Oct 2025 16:08:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7aE6-0005AC-AZ; Sat, 11 Oct 2025 10:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7aDw-0004rD-Hw
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 10:05:29 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7aDh-0005cF-Il
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 10:05:28 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id E1F10C01A4;
 Sat, 11 Oct 2025 17:04:56 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id h4NOTl1FrqM0-EWc3DB48; Sat, 11 Oct 2025 17:04:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760191496;
 bh=cqJGFcUL6Rzua6pAruHETR88Uz0MgIGITTJfyEQeeIA=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=T5our68t41i/JtZFHw+40x1tyw4YDPggf8mQCcim8vlUw6dVOdZ+Y36Qwc9bP3d21
 84D+a3P/I8YUxQR8EQGJRAC6pFjKDM/XCbEiZYWZhCVWJVv/eldxyBnT2Xdwoe3vGh
 w8UzRIxefm7kPaghZvN1WDHqDptvflmKeiCw0WIk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, eblake@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 23/33] qapi/run-state.json: docs: width=70 and two spaces
 between sentences
Date: Sat, 11 Oct 2025 17:04:29 +0300
Message-ID: <20251011140441.297246-24-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251011140441.297246-1-vsementsov@yandex-team.ru>
References: <20251011140441.297246-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 qapi/run-state.json | 60 ++++++++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/qapi/run-state.json b/qapi/run-state.json
index 4757947ca6..b72fbf2579 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -156,7 +156,8 @@
 #
 #     <- { "event": "SHUTDOWN",
 #          "data": { "guest": true, "reason": "guest-shutdown" },
-#          "timestamp": { "seconds": 1267040730, "microseconds": 682951 } }
+#          "timestamp": { "seconds": 1267040730,
+#                         "microseconds": 682951 } }
 ##
 { 'event': 'SHUTDOWN', 'data': { 'guest': 'bool', 'reason': 'ShutdownCause' } }
 
@@ -171,7 +172,8 @@
 # .. qmp-example::
 #
 #     <- { "event": "POWERDOWN",
-#          "timestamp": { "seconds": 1267040730, "microseconds": 682951 } }
+#          "timestamp": { "seconds": 1267040730,
+#                         "microseconds": 682951 } }
 ##
 { 'event': 'POWERDOWN' }
 
@@ -193,7 +195,8 @@
 #
 #     <- { "event": "RESET",
 #          "data": { "guest": false, "reason": "guest-reset" },
-#          "timestamp": { "seconds": 1267041653, "microseconds": 9518 } }
+#          "timestamp": { "seconds": 1267041653,
+#                         "microseconds": 9518 } }
 ##
 { 'event': 'RESET', 'data': { 'guest': 'bool', 'reason': 'ShutdownCause' } }
 
@@ -207,7 +210,8 @@
 # .. qmp-example::
 #
 #     <- { "event": "STOP",
-#          "timestamp": { "seconds": 1267041730, "microseconds": 281295 } }
+#          "timestamp": { "seconds": 1267041730,
+#                         "microseconds": 281295 } }
 ##
 { 'event': 'STOP' }
 
@@ -221,7 +225,8 @@
 # .. qmp-example::
 #
 #     <- { "event": "RESUME",
-#          "timestamp": { "seconds": 1271770767, "microseconds": 582542 } }
+#          "timestamp": { "seconds": 1271770767,
+#                         "microseconds": 582542 } }
 ##
 { 'event': 'RESUME' }
 
@@ -236,7 +241,8 @@
 # .. qmp-example::
 #
 #     <- { "event": "SUSPEND",
-#          "timestamp": { "seconds": 1344456160, "microseconds": 309119 } }
+#          "timestamp": { "seconds": 1344456160,
+#                         "microseconds": 309119 } }
 ##
 { 'event': 'SUSPEND' }
 
@@ -247,15 +253,16 @@
 # saved on disk, for example, S4 state, which is sometimes called
 # hibernate state
 #
-# .. note:: QEMU shuts down (similar to event `SHUTDOWN`) when entering
-#    this state.
+# .. note:: QEMU shuts down (similar to event `SHUTDOWN`) when
+#    entering this state.
 #
 # Since: 1.2
 #
 # .. qmp-example::
 #
 #     <- { "event": "SUSPEND_DISK",
-#          "timestamp": { "seconds": 1344456160, "microseconds": 309119 } }
+#          "timestamp": { "seconds": 1344456160,
+#                         "microseconds": 309119 } }
 ##
 { 'event': 'SUSPEND_DISK' }
 
@@ -270,7 +277,8 @@
 # .. qmp-example::
 #
 #     <- { "event": "WAKEUP",
-#          "timestamp": { "seconds": 1344522075, "microseconds": 745528 } }
+#          "timestamp": { "seconds": 1344522075,
+#                         "microseconds": 745528 } }
 ##
 { 'event': 'WAKEUP' }
 
@@ -281,9 +289,9 @@
 #
 # @action: action that has been taken
 #
-# .. note:: If action is "reset", "shutdown", or "pause" the `WATCHDOG`
-#    event is followed respectively by the `RESET`, `SHUTDOWN`, or `STOP`
-#    events.
+# .. note:: If action is "reset", "shutdown", or "pause" the
+#   `WATCHDOG` event is followed respectively by the `RESET`,
+#   `SHUTDOWN`, or `STOP` events.
 #
 # .. note:: This event is rate-limited.
 #
@@ -293,7 +301,8 @@
 #
 #     <- { "event": "WATCHDOG",
 #          "data": { "action": "reset" },
-#          "timestamp": { "seconds": 1267061043, "microseconds": 959568 } }
+#          "timestamp": { "seconds": 1267061043,
+#                         "microseconds": 959568 } }
 ##
 { 'event': 'WATCHDOG',
   'data': { 'action': 'WatchdogAction' } }
@@ -402,7 +411,8 @@
 #
 # @panic: `PanicAction` action taken on guest panic.
 #
-# @watchdog: `WatchdogAction` action taken when watchdog timer expires.
+# @watchdog: `WatchdogAction` action taken when watchdog timer
+#     expires.
 #
 # Since: 6.0
 #
@@ -437,7 +447,8 @@
 #
 #     <- { "event": "GUEST_PANICKED",
 #          "data": { "action": "pause" },
-#          "timestamp": { "seconds": 1648245231, "microseconds": 900001 } }
+#          "timestamp": { "seconds": 1648245231,
+#                         "microseconds": 900001 } }
 ##
 { 'event': 'GUEST_PANICKED',
   'data': { 'action': 'GuestPanicAction', '*info': 'GuestPanicInformation' } }
@@ -457,7 +468,8 @@
 #
 #     <- { "event": "GUEST_CRASHLOADED",
 #          "data": { "action": "run" },
-#          "timestamp": { "seconds": 1648245259, "microseconds": 893771 } }
+#          "timestamp": { "seconds": 1648245259,
+#                         "microseconds": 893771 } }
 ##
 { 'event': 'GUEST_CRASHLOADED',
   'data': { 'action': 'GuestPanicAction', '*info': 'GuestPanicInformation' } }
@@ -472,7 +484,8 @@
 # .. qmp-example::
 #
 #     <- { "event": "GUEST_PVSHUTDOWN",
-#          "timestamp": { "seconds": 1648245259, "microseconds": 893771 } }
+#          "timestamp": { "seconds": 1648245259,
+#                         "microseconds": 893771 } }
 ##
 { 'event': 'GUEST_PVSHUTDOWN' }
 
@@ -542,8 +555,8 @@
 # @arg4: for Windows, third argument of the `STOP`.  For Linux, the
 #     RAX register (x86) or the stack pointer (aarch64) of the guest.
 #
-# @arg5: for Windows, fourth argument of the `STOP`.  For x86 Linux, the
-#     stack pointer of the guest.
+# @arg5: for Windows, fourth argument of the `STOP`.  For x86 Linux,
+#     the stack pointer of the guest.
 #
 # Since: 2.9
 ##
@@ -610,7 +623,7 @@
 #
 # @error-code: TD-specific error code
 #
-# @message: Human-readable error message provided by the guest. Not
+# @message: Human-readable error message provided by the guest.  Not
 #     to be trusted.
 #
 # @gpa: guest-physical address of a page that contains more verbose
@@ -644,8 +657,9 @@
 #          "data": { "recipient": "hypervisor",
 #                    "action": "fatal",
 #                    "flags": { "action-required": false,
-#                               "recursive": false } },
-#          "timestamp": { "seconds": 1267061043, "microseconds": 959568 } }
+#                               "recursive": false } }
+#          "timestamp": { "seconds": 1267061043,
+#                         "microseconds": 959568 } }
 ##
 { 'event': 'MEMORY_FAILURE',
   'data': { 'recipient': 'MemoryFailureRecipient',
-- 
2.48.1


