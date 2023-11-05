Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F157E1331
	for <lists+qemu-devel@lfdr.de>; Sun,  5 Nov 2023 12:49:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzbcm-00034X-TC; Sun, 05 Nov 2023 06:49:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1qzbch-000344-WF
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 06:49:00 -0500
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1qzbcg-0002JT-DH
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 06:48:59 -0500
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1qzbce-0003YW-Ig; Sun, 05 Nov 2023 12:48:56 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>
Subject: [PULL 7/9] qapi: Add HV_BALLOON_STATUS_REPORT event and its QMP query
 command
Date: Sun,  5 Nov 2023 12:47:55 +0100
Message-ID: <73c1706e3d4be8f4a39ead876297839d389b0699.1699184105.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1699184105.git.maciej.szmigiero@oracle.com>
References: <cover.1699184105.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

Used by the hv-balloon driver for (optional) guest memory status reports.

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/hyperv/hv-balloon.c | 30 +++++++++++++++++++-
 monitor/monitor.c      |  1 +
 qapi/machine.json      | 62 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/hw/hyperv/hv-balloon.c b/hw/hyperv/hv-balloon.c
index c384f23a3b5e..2d1464cd7dca 100644
--- a/hw/hyperv/hv-balloon.c
+++ b/hw/hyperv/hv-balloon.c
@@ -1099,7 +1099,35 @@ static void hv_balloon_handle_status_report(HvBalloon *balloon,
     balloon->status_report.available *= HV_BALLOON_PAGE_SIZE;
     balloon->status_report.received = true;
 
-    /* report event */
+    qapi_event_send_hv_balloon_status_report(balloon->status_report.committed,
+                                             balloon->status_report.available);
+}
+
+HvBalloonInfo *qmp_query_hv_balloon_status_report(Error **errp)
+{
+    HvBalloon *balloon;
+    HvBalloonInfo *info;
+
+    balloon = HV_BALLOON(object_resolve_path_type("", TYPE_HV_BALLOON, NULL));
+    if (!balloon) {
+        error_setg(errp, "no %s device present", TYPE_HV_BALLOON);
+        return NULL;
+    }
+
+    if (!balloon->status_report.enabled) {
+        error_setg(errp, "guest memory status reporting not enabled");
+        return NULL;
+    }
+
+    if (!balloon->status_report.received) {
+        error_setg(errp, "no guest memory status report received yet");
+        return NULL;
+    }
+
+    info = g_malloc0(sizeof(*info));
+    info->committed = balloon->status_report.committed;
+    info->available = balloon->status_report.available;
+    return info;
 }
 
 static void hv_balloon_handle_unballoon_response(HvBalloon *balloon,
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 941f87815aa4..01ede1babd3d 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -315,6 +315,7 @@ static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
     [QAPI_EVENT_QUORUM_FAILURE]    = { 1000 * SCALE_MS },
     [QAPI_EVENT_VSERPORT_CHANGE]   = { 1000 * SCALE_MS },
     [QAPI_EVENT_MEMORY_DEVICE_SIZE_CHANGE] = { 1000 * SCALE_MS },
+    [QAPI_EVENT_HV_BALLOON_STATUS_REPORT] = { 1000 * SCALE_MS },
 };
 
 /*
diff --git a/qapi/machine.json b/qapi/machine.json
index 2985d043c00d..b6d634b30d55 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1137,6 +1137,68 @@
 { 'event': 'BALLOON_CHANGE',
   'data': { 'actual': 'int' } }
 
+##
+# @HvBalloonInfo:
+#
+# hv-balloon guest-provided memory status information.
+#
+# @committed: the amount of memory in use inside the guest plus the
+#     amount of the memory unusable inside the guest (ballooned out,
+#     offline, etc.)
+#
+# @available: the amount of the memory inside the guest available for
+#     new allocations ("free")
+#
+# Since: 8.2
+##
+{ 'struct': 'HvBalloonInfo',
+  'data': { 'committed': 'size', 'available': 'size' } }
+
+##
+# @query-hv-balloon-status-report:
+#
+# Returns the hv-balloon driver data contained in the last received "STATUS"
+# message from the guest.
+#
+# Returns:
+# - @HvBalloonInfo on success
+# - If no hv-balloon device is present, guest memory status reporting
+#   is not enabled or no guest memory status report received yet,
+#   GenericError
+#
+# Since: 8.2
+#
+# Example:
+#
+# -> { "execute": "query-hv-balloon-status-report" }
+# <- { "return": {
+#          "committed": 816640000,
+#          "available": 3333054464
+#       }
+#    }
+##
+{ 'command': 'query-hv-balloon-status-report', 'returns': 'HvBalloonInfo' }
+
+##
+# @HV_BALLOON_STATUS_REPORT:
+#
+# Emitted when the hv-balloon driver receives a "STATUS" message from
+# the guest.
+#
+# Note: this event is rate-limited.
+#
+# Since: 8.2
+#
+# Example:
+#
+# <- { "event": "HV_BALLOON_STATUS_REPORT",
+#      "data": { "committed": 816640000, "available": 3333054464 },
+#      "timestamp": { "seconds": 1600295492, "microseconds": 661044 } }
+#
+##
+{ 'event': 'HV_BALLOON_STATUS_REPORT',
+  'data': 'HvBalloonInfo' }
+
 ##
 # @MemoryInfo:
 #

