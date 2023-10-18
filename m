Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C99277CFB71
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:42:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtTF4-0001Cd-57; Thu, 19 Oct 2023 09:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1qtNyn-0003BP-2u
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 04:02:06 -0400
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1qtNyk-0006MG-OX
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 04:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697702522; x=1729238522;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DROmFsTvSKbYJNdAP2qUwrPECgNR/OTTq/y6dYy22uI=;
 b=LtdJ7MIAulyyKE5NlsAqtg1EGTyZ42SirzjQdZDlR41AZQ7VAodHCsvR
 vBfZ8Ht3wYag4MnJi59wilfsiOZf6QYRKwqFfWZHqNqPNRRfVyl2smZI5
 fKEeglQ+yI1zjjOJV9balKSpV+R0iISMdiV954m52Z5T/I1q2I/ANiMb0
 QCZJPpXwyEvbN1A63UpzncM31o8LdT5WoYGkdCYwyWD9f6QduLv5bmoB+
 3rW0lLadGBClrCy7zuLmx4JrkR6Ca+tlfEkv4+e7maZD+cRqFowX6CjL2
 zJssGnrB+rVX7+v6uvlY0ocrtDJHmSIJF63eTGA8C4cFD8G8OaSz59WZs A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="383418479"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; d="scan'208";a="383418479"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2023 01:01:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="1004134854"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; d="scan'208";a="1004134854"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by fmsmga006.fm.intel.com with ESMTP; 19 Oct 2023 01:01:56 -0700
From: Yuan Liu <yuan1.liu@intel.com>
To: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Cc: qemu-devel@nongnu.org,
	yuan1.liu@intel.com,
	nanhai.zou@intel.com
Subject: [PATCH 3/5] ram compress: Refactor ram compression functions
Date: Thu, 19 Oct 2023 06:12:22 +0800
Message-Id: <20231018221224.599065-4-yuan1.liu@intel.com>
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
X-Mailman-Approved-At: Thu, 19 Oct 2023 09:38:26 -0400
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

Refactor legacy RAM compression functions to support both IAA
compression and CPU compression.

Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
---
 migration/migration.c    |  6 +--
 migration/ram-compress.c | 81 ++++++++++++++++++++++++++++++++--------
 migration/ram-compress.h | 10 ++---
 migration/ram.c          | 18 ++++++---
 4 files changed, 86 insertions(+), 29 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 585d3c8f55..08a9c313d0 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -237,7 +237,7 @@ void migration_incoming_state_destroy(void)
     struct MigrationIncomingState *mis = migration_incoming_get_current();
 
     multifd_load_cleanup();
-    compress_threads_load_cleanup();
+    ram_compress_load_cleanup();
 
     if (mis->to_src_file) {
         /* Tell source that we are done */
@@ -524,7 +524,7 @@ process_incoming_migration_co(void *opaque)
 
     assert(mis->from_src_file);
 
-    if (compress_threads_load_setup(mis->from_src_file)) {
+    if (ram_compress_load_setup(mis->from_src_file)) {
         error_report("Failed to setup decompress threads");
         goto fail;
     }
@@ -577,7 +577,7 @@ fail:
     qemu_fclose(mis->from_src_file);
 
     multifd_load_cleanup();
-    compress_threads_load_cleanup();
+    ram_compress_load_cleanup();
 
     exit(EXIT_FAILURE);
 }
diff --git a/migration/ram-compress.c b/migration/ram-compress.c
index 06254d8c69..47357352f7 100644
--- a/migration/ram-compress.c
+++ b/migration/ram-compress.c
@@ -105,11 +105,11 @@ static void *do_data_compress(void *opaque)
     return NULL;
 }
 
-void compress_threads_save_cleanup(void)
+static void compress_threads_save_cleanup(void)
 {
     int i, thread_count;
 
-    if (!migrate_compress() || !comp_param) {
+    if (!comp_param) {
         return;
     }
 
@@ -144,13 +144,10 @@ void compress_threads_save_cleanup(void)
     comp_param = NULL;
 }
 
-int compress_threads_save_setup(void)
+static int compress_threads_save_setup(void)
 {
     int i, thread_count;
 
-    if (!migrate_compress()) {
-        return 0;
-    }
     thread_count = migrate_compress_threads();
     compress_threads = g_new0(QemuThread, thread_count);
     comp_param = g_new0(CompressParam, thread_count);
@@ -370,6 +367,11 @@ int wait_for_decompress_done(void)
         return 0;
     }
 
+    if (migrate_compress_with_iaa()) {
+        /* Implement in next patch */
+        return 0;
+    }
+
     thread_count = migrate_decompress_threads();
     qemu_mutex_lock(&decomp_done_lock);
     for (idx = 0; idx < thread_count; idx++) {
@@ -381,13 +383,10 @@ int wait_for_decompress_done(void)
     return qemu_file_get_error(decomp_file);
 }
 
-void compress_threads_load_cleanup(void)
+static void compress_threads_load_cleanup(void)
 {
     int i, thread_count;
 
-    if (!migrate_compress()) {
-        return;
-    }
     thread_count = migrate_decompress_threads();
     for (i = 0; i < thread_count; i++) {
         /*
@@ -422,14 +421,10 @@ void compress_threads_load_cleanup(void)
     decomp_file = NULL;
 }
 
-int compress_threads_load_setup(QEMUFile *f)
+static int compress_threads_load_setup(QEMUFile *f)
 {
     int i, thread_count;
 
-    if (!migrate_compress()) {
-        return 0;
-    }
-
     thread_count = migrate_decompress_threads();
     decompress_threads = g_new0(QemuThread, thread_count);
     decomp_param = g_new0(DecompressParam, thread_count);
@@ -457,7 +452,7 @@ exit:
     return -1;
 }
 
-void decompress_data_with_multi_threads(QEMUFile *f, void *host, int len)
+static void decompress_data_with_multi_threads(QEMUFile *f, void *host, int len)
 {
     int idx, thread_count;
 
@@ -483,3 +478,57 @@ void decompress_data_with_multi_threads(QEMUFile *f, void *host, int len)
         }
     }
 }
+
+int ram_compress_save_setup(void)
+{
+    if (!migrate_compress()) {
+        return 0;
+    }
+    if (migrate_compress_with_iaa()) {
+        /* Implement in next patch */
+        return 0;
+    }
+    return compress_threads_save_setup();
+}
+
+void ram_compress_save_cleanup(void)
+{
+    if (!migrate_compress()) {
+        return;
+    }
+    if (migrate_compress_with_iaa()) {
+        /* Implement in next patch */
+        return;
+    }
+    compress_threads_save_cleanup();
+}
+
+void ram_decompress_data(QEMUFile *f, void *host, int len)
+{
+    if (migrate_compress_with_iaa()) {
+        /* Implement in next patch */
+    }
+    decompress_data_with_multi_threads(f, host, len);
+}
+
+int ram_compress_load_setup(QEMUFile *f)
+{
+    if (!migrate_compress()) {
+        return 0;
+    }
+    if (migrate_compress_with_iaa()) {
+        /* Implement in next patch */
+    }
+    return compress_threads_load_setup(f);
+}
+
+void ram_compress_load_cleanup(void)
+{
+    if (!migrate_compress()) {
+        return;
+    }
+    if (migrate_compress_with_iaa()) {
+        /* Implement in next patch */
+    }
+    compress_threads_load_cleanup();
+}
diff --git a/migration/ram-compress.h b/migration/ram-compress.h
index 6f7fe2f472..382083acf6 100644
--- a/migration/ram-compress.h
+++ b/migration/ram-compress.h
@@ -55,16 +55,16 @@ struct CompressParam {
 };
 typedef struct CompressParam CompressParam;
 
-void compress_threads_save_cleanup(void);
-int compress_threads_save_setup(void);
+void ram_compress_save_cleanup(void);
+int ram_compress_save_setup(void);
 
 void flush_compressed_data(int (send_queued_data(CompressParam *)));
 int compress_page_with_multi_thread(RAMBlock *block, ram_addr_t offset,
                                 int (send_queued_data(CompressParam *)));
 
 int wait_for_decompress_done(void);
-void compress_threads_load_cleanup(void);
-int compress_threads_load_setup(QEMUFile *f);
-void decompress_data_with_multi_threads(QEMUFile *f, void *host, int len);
+void ram_compress_load_cleanup(void);
+int ram_compress_load_setup(QEMUFile *f);
+void ram_decompress_data(QEMUFile *f, void *host, int len);
 
 #endif
diff --git a/migration/ram.c b/migration/ram.c
index e4bfd39f08..34ee1de332 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1347,6 +1347,10 @@ static void ram_flush_compressed_data(RAMState *rs)
     if (!save_page_use_compression(rs)) {
         return;
     }
+    if (migrate_compress_with_iaa()) {
+        /* Implement in next patch */
+        return;
+    }
 
     flush_compressed_data(send_queued_data);
 }
@@ -2099,6 +2103,10 @@ static bool save_compress_page(RAMState *rs, PageSearchStatus *pss,
         return false;
     }
 
+    if (migrate_compress_with_iaa()) {
+        /* Implement in next patch */
+        return true;
+    }
     if (compress_page_with_multi_thread(block, offset, send_queued_data) > 0) {
         return true;
     }
@@ -2498,7 +2506,7 @@ static void ram_save_cleanup(void *opaque)
     }
 
     xbzrle_cleanup();
-    compress_threads_save_cleanup();
+    ram_compress_save_cleanup();
     ram_state_cleanup(rsp);
     g_free(migration_ops);
     migration_ops = NULL;
@@ -3023,14 +3031,14 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     RAMBlock *block;
     int ret;
 
-    if (compress_threads_save_setup()) {
+    if (ram_compress_save_setup()) {
         return -1;
     }
 
     /* migration has already setup the bitmap, reuse it. */
     if (!migration_in_colo_state()) {
         if (ram_init_all(rsp) != 0) {
-            compress_threads_save_cleanup();
+            ram_compress_save_cleanup();
             return -1;
         }
     }
@@ -3753,7 +3761,7 @@ int ram_load_postcopy(QEMUFile *f, int channel)
                 ret = -EINVAL;
                 break;
             }
-            decompress_data_with_multi_threads(f, page_buffer, len);
+            ram_decompress_data(f, page_buffer, len);
             break;
         case RAM_SAVE_FLAG_MULTIFD_FLUSH:
             multifd_recv_sync_main();
@@ -4022,7 +4030,7 @@ static int ram_load_precopy(QEMUFile *f)
                 ret = -EINVAL;
                 break;
             }
-            decompress_data_with_multi_threads(f, host, len);
+            ram_decompress_data(f, host, len);
             break;
 
         case RAM_SAVE_FLAG_XBZRLE:
-- 
2.39.3


