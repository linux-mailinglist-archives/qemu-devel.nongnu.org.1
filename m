Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AD2823B0B
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 04:17:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLEDT-0005Wd-EO; Wed, 03 Jan 2024 22:16:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rLEDF-0005VR-2N
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 22:16:05 -0500
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rLEDC-00038q-O4
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 22:16:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704338162; x=1735874162;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NQg7u/XzEAvtrRRQA3KYd7lWsTaf05gMYyw4pAhb0as=;
 b=hH9K3rs0ZdsThPIGLZiuqR0+YoEA+wY34JGWEId98RjK7/1dqObzmMoS
 hS9w+MQQGbwmwB2flMQLc8l1tjZ3SZf6+yQcOQe26SeJiHJRWFIOT70FE
 JoF5GPiTwQ+M2bzVep6fvw+BWLKCBZjPMm3csVrQAv+65KGePOvAStDTW
 N/QLypAArDpukdn1mg1Jwd/NP6YHpCam43T0U4vRnsUwdyJ3m8Hehz0dL
 bqjASJvKYo/H2mw1LAUOF6u/dBZKTOtcRud6U9DiYnNc2iXNrj6S7spX2
 XJqqnea+3j9reb1ChgSfwscR6hcNAKaYp7dcZatT1WHfd100es1qBbt2s g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="376610423"
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; d="scan'208";a="376610423"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jan 2024 19:15:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; d="scan'208";a="28613650"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by orviesa001.jf.intel.com with ESMTP; 03 Jan 2024 19:15:49 -0800
From: Yuan Liu <yuan1.liu@intel.com>
To: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Cc: qemu-devel@nongnu.org,
	yuan1.liu@intel.com,
	nanhai.zou@intel.com
Subject: [PATCH v3 2/4] multifd: Implement multifd compression accelerator
Date: Wed,  3 Jan 2024 19:28:49 +0800
Message-Id: <20240103112851.908082-3-yuan1.liu@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240103112851.908082-1-yuan1.liu@intel.com>
References: <20240103112851.908082-1-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.136; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-2.601, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

when starting multifd live migration, if the compression method is
enabled, compression method can be accelerated using accelerators.

Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 40 ++++++++++++++++++++++++++++++++++++++--
 migration/multifd.h |  8 ++++++++
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 1fe53d3b98..8ee083b691 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -165,6 +165,36 @@ static MultiFDMethods multifd_nocomp_ops = {
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
+    assert(comp < MULTIFD_COMPRESSION__MAX);
+    assert(accel < MULTIFD_COMPRESSION_ACCEL__MAX);
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
@@ -172,6 +202,12 @@ void multifd_register_ops(int method, MultiFDMethods *ops)
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
@@ -922,7 +958,7 @@ int multifd_save_setup(Error **errp)
     multifd_send_state->pages = multifd_pages_init(page_count);
     qemu_sem_init(&multifd_send_state->channels_ready, 0);
     qatomic_set(&multifd_send_state->exiting, 0);
-    multifd_send_state->ops = multifd_ops[migrate_multifd_compression()];
+    multifd_send_state->ops = get_multifd_ops();
 
     for (i = 0; i < thread_count; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
@@ -1180,7 +1216,7 @@ int multifd_load_setup(Error **errp)
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


