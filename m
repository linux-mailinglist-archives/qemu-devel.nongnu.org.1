Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 229B270F01A
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 10:03:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1jSD-0004Px-PZ; Wed, 24 May 2023 04:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1q1jS5-0004N9-6j
 for qemu-devel@nongnu.org; Wed, 24 May 2023 04:02:35 -0400
Received: from mga09.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1q1jS1-0008LI-EU
 for qemu-devel@nongnu.org; Wed, 24 May 2023 04:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684915349; x=1716451349;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4rVGc5Y7cM33mtO9y++6ZhZUj1e2rgnR+apua1L3e9k=;
 b=eHNXeHoNSdteZEMO1LPXYiClu92cOgTgnC0zvqSnaD2tGYhYdqK9rRqG
 bXfntFnmoXvAInXMozmipGr1nonAYh3pW+i0C3QcTg3kuTCRMnOn28KyK
 BRmsih7xFv6eOOXVmtlXS4alvAoaIr8iLzYWVy/MVr4xvqRw8Jw10FtjQ
 OG1l564FIVdAwVAKsDW+qLG7dPD8egRrFli1J8+SC2zLFGnwYYj8mo2eK
 dVddtdPhMK6kOOa5GbUdYYzNEz9HKlXHSIC1iBUZESU+QU0vPRFSR/GZ6
 1gEzm/GYC7d15PVnVm5pgVoKQxrPlJI7icGPy2GvgxBfzyL0rYSViGYVz w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="355849634"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; d="scan'208";a="355849634"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2023 01:02:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="707411084"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; d="scan'208";a="707411084"
Received: from tdx-lm.sh.intel.com ([10.239.53.27])
 by fmsmga007.fm.intel.com with ESMTP; 24 May 2023 01:01:59 -0700
From: Wei Wang <wei.w.wang@intel.com>
To: quintela@redhat.com,
	peterx@redhat.com,
	qemu-devel@nongnu.org
Cc: Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v1] migration: fix migrate_params_test_apply to set the dest
 param correctly
Date: Wed, 24 May 2023 16:01:57 +0800
Message-Id: <20230524080157.530968-1-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.24; envelope-from=wei.w.wang@intel.com;
 helo=mga09.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

qmp_migrate_set_parameters expects to use tmp for parameters check,
so migrate_params_test_apply is expected to copy the related fields from
params to tmp. So fix migrate_params_test_apply to use the function
parameter, *dest, rather than the global one. The dest->has_xxx (xxx is
the feature name) related fields need to be set, as they will be checked
by migrate_params_check.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 migration/options.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index b62ab30cd5..a560483871 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1089,39 +1089,45 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
 static void migrate_params_test_apply(MigrateSetParameters *params,
                                       MigrationParameters *dest)
 {
-    *dest = migrate_get_current()->parameters;
-
     /* TODO use QAPI_CLONE() instead of duplicating it inline */
 
     if (params->has_compress_level) {
+        dest->has_compress_level = true;
         dest->compress_level = params->compress_level;
     }
 
     if (params->has_compress_threads) {
+        dest->has_compress_threads = true;
         dest->compress_threads = params->compress_threads;
     }
 
     if (params->has_compress_wait_thread) {
+        dest->has_compress_wait_thread = true;
         dest->compress_wait_thread = params->compress_wait_thread;
     }
 
     if (params->has_decompress_threads) {
+        dest->has_decompress_threads = true;
         dest->decompress_threads = params->decompress_threads;
     }
 
     if (params->has_throttle_trigger_threshold) {
+        dest->has_throttle_trigger_threshold = true;
         dest->throttle_trigger_threshold = params->throttle_trigger_threshold;
     }
 
     if (params->has_cpu_throttle_initial) {
+        dest->has_cpu_throttle_initial = true;
         dest->cpu_throttle_initial = params->cpu_throttle_initial;
     }
 
     if (params->has_cpu_throttle_increment) {
+        dest->has_cpu_throttle_increment = true;
         dest->cpu_throttle_increment = params->cpu_throttle_increment;
     }
 
     if (params->has_cpu_throttle_tailslow) {
+        dest->has_cpu_throttle_tailslow = true;
         dest->cpu_throttle_tailslow = params->cpu_throttle_tailslow;
     }
 
@@ -1136,45 +1142,58 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     }
 
     if (params->has_max_bandwidth) {
+        dest->has_max_bandwidth = true;
         dest->max_bandwidth = params->max_bandwidth;
     }
 
     if (params->has_downtime_limit) {
+        dest->has_downtime_limit = true;
         dest->downtime_limit = params->downtime_limit;
     }
 
     if (params->has_x_checkpoint_delay) {
+        dest->has_x_checkpoint_delay = true;
         dest->x_checkpoint_delay = params->x_checkpoint_delay;
     }
 
     if (params->has_block_incremental) {
+        dest->has_block_incremental = true;
         dest->block_incremental = params->block_incremental;
     }
     if (params->has_multifd_channels) {
+        dest->has_multifd_channels = true;
         dest->multifd_channels = params->multifd_channels;
     }
     if (params->has_multifd_compression) {
+        dest->has_multifd_compression = true;
         dest->multifd_compression = params->multifd_compression;
     }
     if (params->has_xbzrle_cache_size) {
+        dest->has_xbzrle_cache_size = true;
         dest->xbzrle_cache_size = params->xbzrle_cache_size;
     }
     if (params->has_max_postcopy_bandwidth) {
+        dest->has_max_postcopy_bandwidth = true;
         dest->max_postcopy_bandwidth = params->max_postcopy_bandwidth;
     }
     if (params->has_max_cpu_throttle) {
+        dest->has_max_cpu_throttle = true;
         dest->max_cpu_throttle = params->max_cpu_throttle;
     }
     if (params->has_announce_initial) {
+        dest->has_announce_initial = true;
         dest->announce_initial = params->announce_initial;
     }
     if (params->has_announce_max) {
+        dest->has_announce_max = true;
         dest->announce_max = params->announce_max;
     }
     if (params->has_announce_rounds) {
+        dest->has_announce_rounds = true;
         dest->announce_rounds = params->announce_rounds;
     }
     if (params->has_announce_step) {
+        dest->has_announce_step = true;
         dest->announce_step = params->announce_step;
     }
 
@@ -1321,6 +1340,7 @@ void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
         params->tls_hostname->u.s = strdup("");
     }
 
+    memset(&tmp, 0, sizeof(MigrationParameters));
     migrate_params_test_apply(params, &tmp);
 
     if (!migrate_params_check(&tmp, errp)) {
-- 
2.27.0


