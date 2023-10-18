Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 579A57CFB52
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:39:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtTEw-0000jB-UE; Thu, 19 Oct 2023 09:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1qtNyo-0003BS-Qr
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 04:02:08 -0400
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1qtNym-0006MN-Ip
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 04:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697702524; x=1729238524;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wZYxJmWSfUug2p3jTY5+EH28LA+GLCN7OAdwgFeYHKU=;
 b=Cu4D4HLpI/WkweN+SJCBOctGynhfnz9ndiKlCJjGCiGawAWA/5EKE7ug
 bqQ7bXQSeVMvP8Bhhqrul8ifiYjmg9Pte09L3gJcvF7TPa6fLFVocUM2u
 49f5YxvWaIXhK1L5il6YUfT7pud3IffOKSNlruceYC3W1JQE4U+U092U7
 5OpOIt3MxIJZERofoahF5g1xA0aY7myqsrfnQ5TWglOEb8cd/ZEHAVkkn
 h/DauI8nHSQvKX5W6KmIErIhZvbgI9LEznEaGVc5loqe/tOqWC+Jdk+QW
 /DTZWZdHDO94HG1RNYg9DI40voZLnzm9ljMmQQwTGz3IEq+50JPixwI9n g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="383418488"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; d="scan'208";a="383418488"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2023 01:02:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="1004134861"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; d="scan'208";a="1004134861"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by fmsmga006.fm.intel.com with ESMTP; 19 Oct 2023 01:02:00 -0700
From: Yuan Liu <yuan1.liu@intel.com>
To: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Cc: qemu-devel@nongnu.org,
	yuan1.liu@intel.com,
	nanhai.zou@intel.com
Subject: [PATCH 4/5] migration iaa-compress: Add IAA initialization and
 deinitialization
Date: Thu, 19 Oct 2023 06:12:23 +0800
Message-Id: <20231018221224.599065-5-yuan1.liu@intel.com>
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
X-Mailman-Approved-At: Thu, 19 Oct 2023 09:38:37 -0400
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

This patch defines the structure for IAA jobs related to data
compression and decompression, as well as the initialization and
deinitialization processes for IAA.

Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
---
 migration/iaa-ram-compress.c | 152 +++++++++++++++++++++++++++++++++++
 migration/iaa-ram-compress.h |  20 +++++
 migration/meson.build        |   1 +
 migration/ram-compress.c     |  21 +++--
 4 files changed, 189 insertions(+), 5 deletions(-)
 create mode 100644 migration/iaa-ram-compress.c
 create mode 100644 migration/iaa-ram-compress.h

diff --git a/migration/iaa-ram-compress.c b/migration/iaa-ram-compress.c
new file mode 100644
index 0000000000..da45952594
--- /dev/null
+++ b/migration/iaa-ram-compress.c
@@ -0,0 +1,152 @@
+/*
+ * QEMU IAA compression support
+ *
+ * Copyright (c) 2023 Intel Corporation
+ *  Written by:
+ *  Yuan Liu<yuan1.liu@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/cutils.h"
+#include "qemu/error-report.h"
+#include "migration.h"
+#include "options.h"
+#include "io/channel-null.h"
+#include "exec/target_page.h"
+#include "exec/ramblock.h"
+#include "iaa-ram-compress.h"
+#include "qpl/qpl.h"
+
+/* The IAA work queue maximum depth */
+#define IAA_JOB_NUM (512)
+
+typedef struct {
+    CompressResult result;
+    ram_addr_t offset; /* The offset of the compressed page in the block */
+    RAMBlock *block; /* The block of the compressed page */
+} iaa_comp_param;
+
+typedef struct {
+    uint8_t *host; /* Target address for decompression page */
+} iaa_decomp_param;
+
+typedef struct IaaJob {
+    QSIMPLEQ_ENTRY(IaaJob) entry;
+    bool is_compression;
+    uint32_t in_len;
+    uint32_t out_len;
+    uint8_t *in_buf;
+    uint8_t *out_buf;
+    qpl_job *qpl; /* It is used to submit (de)compression work to IAA */
+    union {
+        iaa_comp_param comp;
+        iaa_decomp_param decomp;
+    } param;
+} IaaJob;
+
+typedef struct IaaJobPool {
+    uint32_t pos;
+    uint32_t cnt;
+    IaaJob *jobs[IAA_JOB_NUM];
+    uint8_t *job_in_buf; /* The IAA device input buffers for all IAA jobs */
+    uint8_t *job_out_buf; /* The IAA device output buffers for all IAA jobs */
+    size_t buf_size;
+} IaaJobPool;
+
+static IaaJobPool iaa_job_pool;
+/* This is used to record jobs that have been submitted but not yet completed */
+static QSIMPLEQ_HEAD(, IaaJob) polling_queue =
+                                   QSIMPLEQ_HEAD_INITIALIZER(polling_queue);
+
+void iaa_compress_deinit(void)
+{
+    for (int i = 0; i < IAA_JOB_NUM; i++) {
+        if (iaa_job_pool.jobs[i]) {
+            if (iaa_job_pool.jobs[i]->qpl) {
+                qpl_fini_job(iaa_job_pool.jobs[i]->qpl);
+                g_free(iaa_job_pool.jobs[i]->qpl);
+            }
+            g_free(iaa_job_pool.jobs[i]);
+        }
+    }
+    if (iaa_job_pool.job_in_buf) {
+        munmap(iaa_job_pool.job_in_buf, iaa_job_pool.buf_size);
+        iaa_job_pool.job_in_buf = NULL;
+    }
+    if (iaa_job_pool.job_out_buf) {
+        munmap(iaa_job_pool.job_out_buf, iaa_job_pool.buf_size);
+        iaa_job_pool.job_out_buf = NULL;
+    }
+}
+
+int iaa_compress_init(bool is_decompression)
+{
+    qpl_status status;
+    IaaJob *job = NULL;
+    uint32_t qpl_hw_size = 0;
+    int flags = MAP_PRIVATE | MAP_POPULATE | MAP_ANONYMOUS;
+    size_t buf_size = IAA_JOB_NUM * qemu_target_page_size();
+
+    QSIMPLEQ_INIT(&polling_queue);
+    memset(&iaa_job_pool, 0, sizeof(IaaJobPool));
+    iaa_job_pool.buf_size = buf_size;
+    iaa_job_pool.job_out_buf = mmap(NULL, buf_size, PROT_READ | PROT_WRITE,
+                                    flags, -1, 0);
+    if (iaa_job_pool.job_out_buf == MAP_FAILED) {
+        error_report("Failed to allocate iaa output buffer, error %s",
+                     strerror(errno));
+        return -1;
+    }
+    /*
+     * There is no need to allocate an input buffer for the compression
+     * function, the IAA hardware can directly access the virtual machine
+     * memory through the host address through Share Virtual Memory(SVM)
+     */
+    if (is_decompression) {
+        iaa_job_pool.job_in_buf = mmap(NULL, buf_size, PROT_READ | PROT_WRITE,
+                                       flags, -1, 0);
+        if (iaa_job_pool.job_in_buf == MAP_FAILED) {
+            error_report("Failed to allocate iaa input buffer, error %s",
+                         strerror(errno));
+            goto init_err;
+        }
+    }
+    status = qpl_get_job_size(qpl_path_hardware, &qpl_hw_size);
+    if (status != QPL_STS_OK) {
+        error_report("Failed to initialize iaa hardware, error %d", status);
+        goto init_err;
+    }
+    for (int i = 0; i < IAA_JOB_NUM; i++) {
+        size_t buf_offset = qemu_target_page_size() * i;
+        job = g_try_malloc0(sizeof(IaaJob));
+        if (!job) {
+            error_report("Failed to allocate iaa job memory, error %s",
+                         strerror(errno));
+            goto init_err;
+        }
+        iaa_job_pool.jobs[i] = job;
+        job->qpl = g_try_malloc0(qpl_hw_size);
+        if (!job->qpl) {
+            error_report("Failed to allocate iaa qpl memory, error %s",
+                         strerror(errno));
+            goto init_err;
+        }
+        if (is_decompression) {
+            job->in_buf = iaa_job_pool.job_in_buf + buf_offset;
+        }
+        job->out_buf = iaa_job_pool.job_out_buf + buf_offset;
+        status = qpl_init_job(qpl_path_hardware, job->qpl);
+        if (status != QPL_STS_OK) {
+            error_report("Failed to initialize iaa qpl, error %d", status);
+            goto init_err;
+        }
+    }
+    return 0;
+init_err:
+    iaa_compress_deinit();
+    return -1;
+}
diff --git a/migration/iaa-ram-compress.h b/migration/iaa-ram-compress.h
new file mode 100644
index 0000000000..27998b255b
--- /dev/null
+++ b/migration/iaa-ram-compress.h
@@ -0,0 +1,20 @@
+/*
+ * QEMU IAA compression support
+ *
+ * Copyright (c) 2023 Intel Corporation
+ *  Written by:
+ *  Yuan Liu<yuan1.liu@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef QEMU_MIGRATION_IAA_COMPRESS_H
+#define QEMU_MIGRATION_IAA_COMPRESS_H
+#include "qemu-file.h"
+#include "ram-compress.h"
+
+int iaa_compress_init(bool is_decompression);
+void iaa_compress_deinit(void);
+#endif
diff --git a/migration/meson.build b/migration/meson.build
index 92b1cc4297..9131815420 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -40,6 +40,7 @@ if get_option('live_block_migration').allowed()
   system_ss.add(files('block.c'))
 endif
 system_ss.add(when: zstd, if_true: files('multifd-zstd.c'))
+system_ss.add(when: qpl, if_true: files('iaa-ram-compress.c'))
 
 specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
                 if_true: files('ram.c',
diff --git a/migration/ram-compress.c b/migration/ram-compress.c
index 47357352f7..acc511ce57 100644
--- a/migration/ram-compress.c
+++ b/migration/ram-compress.c
@@ -30,6 +30,9 @@
 #include "qemu/cutils.h"
 
 #include "ram-compress.h"
+#ifdef CONFIG_QPL
+#include "iaa-ram-compress.h"
+#endif
 
 #include "qemu/error-report.h"
 #include "migration.h"
@@ -484,10 +487,11 @@ int ram_compress_save_setup(void)
     if (!migrate_compress()) {
         return 0;
     }
+#ifdef CONFIG_QPL
     if (migrate_compress_with_iaa()) {
-        /* Implement in next patch */
-        return 0;
+        return iaa_compress_init(false);
     }
+#endif
     return compress_threads_save_setup();
 }
 
@@ -496,10 +500,12 @@ void ram_compress_save_cleanup(void)
     if (!migrate_compress()) {
         return;
     }
+#ifdef CONFIG_QPL
     if (migrate_compress_with_iaa()) {
-        /* Implement in next patch */
+        iaa_compress_deinit();
         return;
     }
+#endif
     compress_threads_save_cleanup();
 }
 
@@ -516,9 +522,11 @@ int ram_compress_load_setup(QEMUFile *f)
     if (!migrate_compress()) {
         return 0;
     }
+#ifdef CONFIG_QPL
     if (migrate_compress_with_iaa()) {
-        /* Implement in next patch */
+        return iaa_compress_init(true);
     }
+#endif
     return compress_threads_load_setup(f);
 }
 
@@ -527,8 +535,11 @@ void ram_compress_load_cleanup(void)
     if (!migrate_compress()) {
         return;
     }
+#ifdef CONFIG_QPL
     if (migrate_compress_with_iaa()) {
-        /* Implement in next patch */
+        iaa_compress_deinit();
+        return;
     }
+#endif
     compress_threads_load_cleanup();
 }
-- 
2.39.3


