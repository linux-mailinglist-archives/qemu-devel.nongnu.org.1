Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4A0723F35
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 12:19:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Tme-0000Br-M4; Tue, 06 Jun 2023 06:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1q6Tmc-00006C-7a
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 06:19:22 -0400
Received: from mga05.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1q6TmZ-0007Nm-Jb
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 06:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686046759; x=1717582759;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gfQ2g23Frf4Yd2X75DnzGcuHLOvhA17x9xeJUzT/+Xo=;
 b=NUEax+O+zOYozR33kKRjlnTaNw+YxAFekF05yb2n3eegonsSCS3LPPMw
 /IBcdYQZiVOi3Tb2U4T4UeTAH4UyRdryaRGbfrof0DksanmErH2mAlTKY
 DStOv9rXBarP73moYKvAULYfANP8ZvYx7PZKAvgk4xo/dxeyYXgrjPmO5
 LtknnHwHSF45oBN9qtFHMYfKXkXYS8ovSBZKjrcX2v6senekYpTcltt50
 xErDyjOYu5nUbBNDcdGlCTdlX74fk3+FGlGKEN+rSZ3suBXNNE168J0SX
 RP2FmdketVXxrmonyT1UdfuBMxlWZk8b7hVHqcbfYooXL5aP0WN16sA6j g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="443004175"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; d="scan'208";a="443004175"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2023 03:19:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="709032924"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; d="scan'208";a="709032924"
Received: from tdx-lm.sh.intel.com ([10.239.53.27])
 by orsmga002.jf.intel.com with ESMTP; 06 Jun 2023 03:19:14 -0700
From: Wei Wang <wei.w.wang@intel.com>
To: quintela@redhat.com,
	peterx@redhat.com,
	lei4.wang@intel.com
Cc: qemu-devel@nongnu.org,
	Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v2 1/2] migration: enfocre multifd and postcopy preempt to be
 set before incoming
Date: Tue,  6 Jun 2023 18:19:09 +0800
Message-Id: <20230606101910.20456-2-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230606101910.20456-1-wei.w.wang@intel.com>
References: <20230606101910.20456-1-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.43; envelope-from=wei.w.wang@intel.com;
 helo=mga05.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/options.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index b62ab30cd5..01403e5eaa 100644
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


