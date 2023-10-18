Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BD67CFB65
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:41:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtTEt-0000Hz-9n; Thu, 19 Oct 2023 09:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1qtNyj-0003Ae-9f
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 04:02:02 -0400
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1qtNyg-0006LE-Qi
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 04:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697702518; x=1729238518;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZhQKN7EFGxpu5IEr8DgBFIeEvHbuo5TQ3WYoPPCFuqM=;
 b=hKtEcQbKZkI+uam+MRG+ua0cePW3Kk5yFsHC8+SDKgK+S4k2xUM6R2KJ
 lMVDHhgo1iFYYBby/195jCCAlhulkV4frsoexSq25szr70M6JxcYVlef7
 PVeCIO9m+Hi9YjPZphp6u33Hxw7qDtdJFAj1CMDyMMCrde23iCt+0Bz4I
 RgJIBtFvCNqucp8xtzMp+/JHkIN2XB6//oYtOqkdJ7UVnajbxkbs4Wz9u
 KKtFcInFhOCemupbFcglmsORqtX8U2eUMoiEg9MkSzdGCrxzOVA6YBS/z
 VYgDpnz5gbupz1yYvRyimH5DKD9GiQDFCPsKaeFTEK1oclMMwYpNGG/fU Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="383418471"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; d="scan'208";a="383418471"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2023 01:01:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="1004134848"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; d="scan'208";a="1004134848"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by fmsmga006.fm.intel.com with ESMTP; 19 Oct 2023 01:01:53 -0700
From: Yuan Liu <yuan1.liu@intel.com>
To: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Cc: qemu-devel@nongnu.org,
	yuan1.liu@intel.com,
	nanhai.zou@intel.com
Subject: [PATCH 2/5] qapi/migration: Introduce compress-with-iaa migration
 parameter
Date: Thu, 19 Oct 2023 06:12:21 +0800
Message-Id: <20231018221224.599065-3-yuan1.liu@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231018221224.599065-1-yuan1.liu@intel.com>
References: <20231018221224.599065-1-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.93; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 19 Oct 2023 09:38:36 -0400
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

Introduce the compress-with-iaa=on/off option to enable or disable live
migration data (de)compression with the In-Memory Analytics Accelerator
(IAA).

The data (de)compression with IAA feature is based on the migration
compression capability, which is enabled by setting
migrate_set_capability compress on. If the migration compression
capability is enabled and the IAA compression parameter is set, IAA will
be used instead of CPU for data (de)compression.

Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
---
 migration/migration-hmp-cmds.c |  8 ++++++++
 migration/options.c            | 20 ++++++++++++++++++++
 migration/options.h            |  1 +
 qapi/migration.json            |  4 +++-
 4 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index c115ef2d23..38e441bb37 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -281,6 +281,10 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_COMPRESS_THREADS),
             params->compress_threads);
+        assert(params->has_compress_with_iaa);
+        monitor_printf(mon, "%s: %s\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_COMPRESS_WITH_IAA),
+            params->compress_with_iaa ? "on" : "off");
         assert(params->has_compress_wait_thread);
         monitor_printf(mon, "%s: %s\n",
             MigrationParameter_str(MIGRATION_PARAMETER_COMPRESS_WAIT_THREAD),
@@ -517,6 +521,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_compress_threads = true;
         visit_type_uint8(v, param, &p->compress_threads, &err);
         break;
+    case MIGRATION_PARAMETER_COMPRESS_WITH_IAA:
+        p->has_compress_with_iaa = true;
+        visit_type_bool(v, param, &p->compress_with_iaa, &err);
+        break;
     case MIGRATION_PARAMETER_COMPRESS_WAIT_THREAD:
         p->has_compress_wait_thread = true;
         visit_type_bool(v, param, &p->compress_wait_thread, &err);
diff --git a/migration/options.c b/migration/options.c
index 1d1e1321b0..06d4b36b77 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -107,6 +107,8 @@ Property migration_properties[] = {
     DEFINE_PROP_UINT8("x-compress-threads", MigrationState,
                       parameters.compress_threads,
                       DEFAULT_MIGRATE_COMPRESS_THREAD_COUNT),
+    DEFINE_PROP_BOOL("x-compress-with-iaa", MigrationState,
+                      parameters.compress_with_iaa, false),
     DEFINE_PROP_BOOL("x-compress-wait-thread", MigrationState,
                       parameters.compress_wait_thread, true),
     DEFINE_PROP_UINT8("x-decompress-threads", MigrationState,
@@ -724,6 +726,13 @@ int migrate_compress_threads(void)
     return s->parameters.compress_threads;
 }
 
+bool migrate_compress_with_iaa(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->parameters.compress_with_iaa;
+}
+
 int migrate_compress_wait_thread(void)
 {
     MigrationState *s = migrate_get_current();
@@ -899,6 +908,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->compress_level = s->parameters.compress_level;
     params->has_compress_threads = true;
     params->compress_threads = s->parameters.compress_threads;
+    params->has_compress_with_iaa = true;
+    params->compress_with_iaa = s->parameters.compress_with_iaa;
     params->has_compress_wait_thread = true;
     params->compress_wait_thread = s->parameters.compress_wait_thread;
     params->has_decompress_threads = true;
@@ -969,6 +980,7 @@ void migrate_params_init(MigrationParameters *params)
     /* Set has_* up only for parameter checks */
     params->has_compress_level = true;
     params->has_compress_threads = true;
+    params->has_compress_with_iaa = true;
     params->has_compress_wait_thread = true;
     params->has_decompress_threads = true;
     params->has_throttle_trigger_threshold = true;
@@ -1195,6 +1207,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
         dest->decompress_threads = params->decompress_threads;
     }
 
+    if (params->has_compress_with_iaa) {
+        dest->compress_with_iaa = params->compress_with_iaa;
+    }
+
     if (params->has_throttle_trigger_threshold) {
         dest->throttle_trigger_threshold = params->throttle_trigger_threshold;
     }
@@ -1300,6 +1316,10 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
         s->parameters.decompress_threads = params->decompress_threads;
     }
 
+    if (params->has_compress_with_iaa) {
+        s->parameters.compress_with_iaa = params->compress_with_iaa;
+    }
+
     if (params->has_throttle_trigger_threshold) {
         s->parameters.throttle_trigger_threshold = params->throttle_trigger_threshold;
     }
diff --git a/migration/options.h b/migration/options.h
index 045e2a41a2..926d723d0e 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -77,6 +77,7 @@ uint8_t migrate_cpu_throttle_increment(void);
 uint8_t migrate_cpu_throttle_initial(void);
 bool migrate_cpu_throttle_tailslow(void);
 int migrate_decompress_threads(void);
+bool migrate_compress_with_iaa(void);
 uint64_t migrate_downtime_limit(void);
 uint8_t migrate_max_cpu_throttle(void);
 uint64_t migrate_max_bandwidth(void);
diff --git a/qapi/migration.json b/qapi/migration.json
index 8843e74b59..8edc622dd9 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -835,7 +835,7 @@
 { 'enum': 'MigrationParameter',
   'data': ['announce-initial', 'announce-max',
            'announce-rounds', 'announce-step',
-           'compress-level', 'compress-threads', 'decompress-threads',
+           'compress-level', 'compress-threads', 'compress-with-iaa', 'decompress-threads',
            'compress-wait-thread', 'throttle-trigger-threshold',
            'cpu-throttle-initial', 'cpu-throttle-increment',
            'cpu-throttle-tailslow',
@@ -1008,6 +1008,7 @@
             '*announce-step': 'size',
             '*compress-level': 'uint8',
             '*compress-threads': 'uint8',
+            '*compress-with-iaa': 'bool',
             '*compress-wait-thread': 'bool',
             '*decompress-threads': 'uint8',
             '*throttle-trigger-threshold': 'uint8',
@@ -1208,6 +1209,7 @@
             '*announce-step': 'size',
             '*compress-level': 'uint8',
             '*compress-threads': 'uint8',
+            '*compress-with-iaa': 'bool',
             '*compress-wait-thread': 'bool',
             '*decompress-threads': 'uint8',
             '*throttle-trigger-threshold': 'uint8',
-- 
2.39.3


