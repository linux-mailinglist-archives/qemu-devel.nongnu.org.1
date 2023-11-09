Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7EF7E79C3
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 08:34:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1M14-0005cV-N6; Fri, 10 Nov 2023 02:33:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1r1M11-0005RE-K2
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 02:33:19 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1r1M0z-0007DT-SK
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 02:33:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699601598; x=1731137598;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=28hGxziHoPgYcEF1SjO4kQyakVIaD+oRtveWRlxr5tU=;
 b=HbUQW9TIubU9QhzAwm2BmARPn443/mxjguS6nETAsVRs5ua+7SVcmEnh
 3pXxHCJIrFOiIWhAiG6uFM6MxRNZPNHzIwcQdSZ14dslXonATlOZE1eWF
 LzNEU79GTendvmpD0KriVDRHiV8SgZGpxj4Xk6NO1TAU0pYajmtpJ5aMA
 h+5MTcOXPV5/xK9kfWwwDG3d5N47alsR7zOnPpXeF9xc9D2xZvwddC2pd
 pBlZLle6DWVnOaByKDTIMkVgkBdJ0XrlWG6XxDHsK27w1Op0KnRVcqpkj
 m+kD8ekQU4ZWGxjbwzwCXgTdhhjEQ0VF/1Ph3650UV9eSZXpLNbIRX1s6 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="11694840"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; d="scan'208";a="11694840"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2023 23:33:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="1010886563"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; d="scan'208";a="1010886563"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by fmsmga006.fm.intel.com with ESMTP; 09 Nov 2023 23:33:12 -0800
From: Yuan Liu <yuan1.liu@intel.com>
To: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Cc: qemu-devel@nongnu.org,
	yuan1.liu@intel.com,
	nanhai.zou@intel.com
Subject: [PATCH v2 2/4] multifd: Implement multifd compression accelerator
Date: Thu,  9 Nov 2023 23:46:36 +0800
Message-Id: <20231109154638.488213-3-yuan1.liu@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231109154638.488213-1-yuan1.liu@intel.com>
References: <20231109154638.488213-1-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

when starting multifd live migration, if the compression method is
enabled, compression method can be accelerated using accelerators.

Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
---
 migration/multifd.c | 38 ++++++++++++++++++++++++++++++++++++--
 migration/multifd.h |  8 ++++++++
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 1fe53d3b98..7149e67867 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -165,6 +165,34 @@ static MultiFDMethods multifd_nocomp_ops = {
 static MultiFDMethods *multifd_ops[MULTIFD_COMPRESSION__MAX] = {
     [MULTIFD_COMPRESSION_NONE] = &multifd_nocomp_ops,
 };
+static MultiFDAccelMethods *accel_multifd_ops[MULTIFD_COMPRESSION_ACCEL__MAX];
+
+static MultiFDMethods *get_multifd_ops(void)
+{
+    MultiFDCompression comp = migrate_multifd_compression();
+    MultiFDCompressionAccel accel = migrate_multifd_compression_accel();
+
+    if (comp == MULTIFD_COMPRESSION_NONE ||
+        accel == MULTIFD_COMPRESSION_ACCEL_NONE) {
+        return multifd_ops[comp];
+    }
+    if (accel == MULTIFD_COMPRESSION_ACCEL_AUTO) {
+        for (int i = 0; i < MULTIFD_COMPRESSION_ACCEL__MAX; i++) {
+            if (accel_multifd_ops[i] &&
+                accel_multifd_ops[i]->is_supported(comp)) {
+                return accel_multifd_ops[i]->get_multifd_methods();
+            }
+        }
+        return multifd_ops[comp];
+    }
+
+    /* Check if a specified accelerator is available */
+    if (accel_multifd_ops[accel] &&
+        accel_multifd_ops[accel]->is_supported(comp)) {
+        return accel_multifd_ops[accel]->get_multifd_methods();
+    }
+    return multifd_ops[comp];
+}

 void multifd_register_ops(int method, MultiFDMethods *ops)
 {
@@ -172,6 +200,12 @@ void multifd_register_ops(int method, MultiFDMethods *ops)
     multifd_ops[method] = ops;
 }

+void multifd_register_accel_ops(int accel, MultiFDAccelMethods *ops)
+{
+    assert(0 < accel && accel < MULTIFD_COMPRESSION_ACCEL__MAX);
+    accel_multifd_ops[accel] = ops;
+}
+
 static int multifd_send_initial_packet(MultiFDSendParams *p, Error **errp)
 {
     MultiFDInit_t msg = {};
@@ -922,7 +956,7 @@ int multifd_save_setup(Error **errp)
     multifd_send_state->pages = multifd_pages_init(page_count);
     qemu_sem_init(&multifd_send_state->channels_ready, 0);
     qatomic_set(&multifd_send_state->exiting, 0);
-    multifd_send_state->ops = multifd_ops[migrate_multifd_compression()];
+    multifd_send_state->ops = get_multifd_ops();

     for (i = 0; i < thread_count; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
@@ -1180,7 +1214,7 @@ int multifd_load_setup(Error **errp)
     multifd_recv_state->params = g_new0(MultiFDRecvParams, thread_count);
     qatomic_set(&multifd_recv_state->count, 0);
     qemu_sem_init(&multifd_recv_state->sem_sync, 0);
-    multifd_recv_state->ops = multifd_ops[migrate_multifd_compression()];
+    multifd_recv_state->ops = get_multifd_ops();

     for (i = 0; i < thread_count; i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
diff --git a/migration/multifd.h b/migration/multifd.h
index a835643b48..c40ff79443 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -206,7 +206,15 @@ typedef struct {
     int (*recv_pages)(MultiFDRecvParams *p, Error **errp);
 } MultiFDMethods;

+typedef struct {
+    /* Check if the compression method supports acceleration */
+    bool (*is_supported) (MultiFDCompression compression);
+    /* Get multifd methods of the accelerator */
+    MultiFDMethods* (*get_multifd_methods)(void);
+} MultiFDAccelMethods;
+
 void multifd_register_ops(int method, MultiFDMethods *ops);
+void multifd_register_accel_ops(int accel, MultiFDAccelMethods *ops);

 #endif

--
2.39.3


