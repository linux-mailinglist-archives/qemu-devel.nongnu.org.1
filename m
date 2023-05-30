Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC3B715953
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 11:03:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3vG8-0002T0-FC; Tue, 30 May 2023 05:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1q3vG5-0002Oo-4A
 for qemu-devel@nongnu.org; Tue, 30 May 2023 05:03:13 -0400
Received: from mga03.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1q3vG3-0006FE-8x
 for qemu-devel@nongnu.org; Tue, 30 May 2023 05:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685437391; x=1716973391;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fJlGAPVr94+R54bhtucSXb6TcTWdOccQlUQmJThAuqw=;
 b=C8m0fOEMCxOR8WQKENASY0O4f6IzWnZ1ifXOrCA45rDipb/1y/2/XdtN
 JM2EqrTguXRDwzrbRGtqVf+3voAa++3GTduFpI+uE2oGESzupotXTLD6l
 DRH0JdzlE7hKuROQLV+ziXNdwz9W8ixEyddZKJyy0zYpZFXBhaPXyu8ZL
 EZeEUtwTQWzW3xK6w9Yv4V8VxLPM9nM2+s1L4dO8EA4j3iJKvhR71Wbc+
 1xI0Aq5HDuC4i1CCAB8Tx3JBiXBu4RevX18Adq27N4dNm/YYIm7SEQ+lA
 3/Nwt+vGaAwLR1u0ZFGj7IstX2rO/6BA2rbiSybgnwlUxta0WeLIlbYgG A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="358110384"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; d="scan'208";a="358110384"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2023 02:03:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="739435466"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; d="scan'208";a="739435466"
Received: from tdx-lm.sh.intel.com ([10.239.53.27])
 by orsmga001.jf.intel.com with ESMTP; 30 May 2023 02:03:05 -0700
From: Wei Wang <wei.w.wang@intel.com>
To: quintela@redhat.com,
	peterx@redhat.com,
	lei4.wang@intel.com
Cc: qemu-devel@nongnu.org,
	Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v2 1/2] migration: enfocre multifd and postcopy preempt to be
 set before incoming
Date: Tue, 30 May 2023 17:02:58 +0800
Message-Id: <20230530090259.189462-2-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230530090259.189462-1-wei.w.wang@intel.com>
References: <20230530090259.189462-1-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.65; envelope-from=wei.w.wang@intel.com;
 helo=mga03.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

qemu_start_incoming_migration needs to check the number of multifd
channels or postcopy ram channels to configure the backlog parameter (i.e.
the maximum length to which the queue of pending connections for sockfd
may grow) of listen(). So enforce the usage of postcopy-preempt and
multifd as below:
- need to use "-incoming defer" on the destination; and
- set_capability and set_parameter need to be done before migrate_incoming

Otherwise, disable the use of the features and report error messages to
remind users to adjust the commands.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 migration/options.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index a560483871..954a39aa6d 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -415,6 +415,11 @@ INITIALIZE_MIGRATE_CAPS_SET(check_caps_background_snapshot,
     MIGRATION_CAPABILITY_VALIDATE_UUID,
     MIGRATION_CAPABILITY_ZERO_COPY_SEND);
 
+static bool migrate_incoming_started(void)
+{
+    return !!migration_incoming_get_current()->transport_data;
+}
+
 /**
  * @migration_caps_check - check capability compatibility
  *
@@ -538,6 +543,12 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
             error_setg(errp, "Postcopy preempt not compatible with compress");
             return false;
         }
+
+        if (migrate_incoming_started()) {
+            error_setg(errp,
+                       "Postcopy preempt must be set before incoming starts");
+            return false;
+        }
     }
 
     if (new_caps[MIGRATION_CAPABILITY_MULTIFD]) {
@@ -545,6 +556,10 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
             error_setg(errp, "Multifd is not compatible with compress");
             return false;
         }
+        if (migrate_incoming_started()) {
+            error_setg(errp, "Multifd must be set before incoming starts");
+            return false;
+        }
     }
 
     return true;
@@ -998,11 +1013,22 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
 
     /* x_checkpoint_delay is now always positive */
 
-    if (params->has_multifd_channels && (params->multifd_channels < 1)) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "multifd_channels",
-                   "a value between 1 and 255");
-        return false;
+    if (params->has_multifd_channels) {
+        if (params->multifd_channels < 1) {
+            error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                       "multifd_channels",
+                       "a value between 1 and 255");
+            return false;
+        }
+        if (migrate_incoming_started()) {
+            MigrationState *ms = migrate_get_current();
+
+            ms->capabilities[MIGRATION_CAPABILITY_MULTIFD] = false;
+            error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                       "multifd_channels",
+                       "must be set before incoming starts");
+            return false;
+        }
     }
 
     if (params->has_multifd_zlib_level &&
-- 
2.27.0


