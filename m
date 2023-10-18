Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C64D97CFB6D
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:41:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtTF6-0001uB-Il; Thu, 19 Oct 2023 09:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1qtNyx-0003FI-3G
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 04:02:15 -0400
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1qtNyu-0006N8-SX
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 04:02:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697702532; x=1729238532;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TFLaIokBr3NS3B84d8PU4bnFn7b2kvq59OhP5EiNt2U=;
 b=Q3Ymo2NegoI/DwMszjrzxoitkRJdQoeFyQ5rBwd4AhnABzy528MTo5OK
 b5VQTuwsCEUFuiuHMkI2UmWv7SgKz1iuM4w1S9okchhseqqmh50r60zhS
 ai2BHur+DRNBVJTA4qwDoGn0Z+CVUIaY6HHswDNcqSvqlLTpMpdcjukAx
 v9zmxjzjHpN/kw0fDBMmGYedEjmrAR7MNMzIQ0iVAW5U9DDTbWLEUfMOH
 FOQwR2B8Wk5wBlRZCaLVr9ZkrmPPB+a1s4L57jqjYXK77ARvtUfN9fh4U
 RmkE0OzfpyKUpvuZXfI7s1MkH25dt0yssq8vr1stqQYoAbTDXSoyKeQUu Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="383418517"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; d="scan'208";a="383418517"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2023 01:02:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="1004134875"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; d="scan'208";a="1004134875"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by fmsmga006.fm.intel.com with ESMTP; 19 Oct 2023 01:02:08 -0700
From: Yuan Liu <yuan1.liu@intel.com>
To: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Cc: qemu-devel@nongnu.org,
	yuan1.liu@intel.com,
	nanhai.zou@intel.com
Subject: [PATCH 5/5] migration iaa-compress: Implement IAA compression
Date: Thu, 19 Oct 2023 06:12:24 +0800
Message-Id: <20231018221224.599065-6-yuan1.liu@intel.com>
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

Implement the functions of IAA for data compression and decompression.
The implementation uses non-blocking job submission and polling to check
the job completion status to reduce IAA's overhead in the live migration
process.

Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
---
 migration/iaa-ram-compress.c | 167 +++++++++++++++++++++++++++++++++++
 migration/iaa-ram-compress.h |   7 ++
 migration/ram-compress.c     |  10 ++-
 migration/ram.c              |  56 ++++++++++--
 4 files changed, 232 insertions(+), 8 deletions(-)

diff --git a/migration/iaa-ram-compress.c b/migration/iaa-ram-compress.c
index da45952594..243aeb6d55 100644
--- a/migration/iaa-ram-compress.c
+++ b/migration/iaa-ram-compress.c
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
+
 #include "qemu/error-report.h"
 #include "migration.h"
 #include "options.h"
@@ -62,6 +63,31 @@ static IaaJobPool iaa_job_pool;
 static QSIMPLEQ_HEAD(, IaaJob) polling_queue =
                                    QSIMPLEQ_HEAD_INITIALIZER(polling_queue);
 
+static IaaJob *get_job(send_iaa_data send_page)
+{
+    IaaJob *job;
+
+retry:
+    /* Wait for a job to complete when there is no available job */
+    if (iaa_job_pool.cnt == IAA_JOB_NUM) {
+        flush_iaa_jobs(false, send_page);
+        goto retry;
+    }
+    job = iaa_job_pool.jobs[iaa_job_pool.pos];
+    iaa_job_pool.pos++;
+    iaa_job_pool.cnt++;
+    if (iaa_job_pool.pos == IAA_JOB_NUM) {
+        iaa_job_pool.pos = 0;
+    }
+    return job;
+}
+
+static void put_job(IaaJob *job)
+{
+    assert(iaa_job_pool.cnt > 0);
+    iaa_job_pool.cnt--;
+}
+
 void iaa_compress_deinit(void)
 {
     for (int i = 0; i < IAA_JOB_NUM; i++) {
@@ -150,3 +176,144 @@ init_err:
     iaa_compress_deinit();
     return -1;
 }
+
+static void process_completed_job(IaaJob *job, send_iaa_data send_page)
+{
+    if (job->is_compression) {
+        send_page(job->param.comp.block, job->param.comp.offset,
+                  job->out_buf, job->out_len, job->param.comp.result);
+    } else {
+        assert(job->out_len == qemu_target_page_size());
+        memcpy(job->param.decomp.host, job->out_buf, job->out_len);
+    }
+    put_job(job);
+}
+
+static qpl_status check_job_status(IaaJob *job, bool block)
+{
+    qpl_status status;
+    qpl_job *qpl = job->qpl;
+
+    status = block ? qpl_wait_job(qpl) : qpl_check_job(qpl);
+    if (status == QPL_STS_OK) {
+        job->out_len = qpl->total_out;
+        if (job->is_compression) {
+            job->param.comp.result = RES_COMPRESS;
+            /* if no compression benefit, send a normal page for migration */
+            if (job->out_len == qemu_target_page_size()) {
+                iaa_comp_param *param = &(job->param.comp);
+                memcpy(job->out_buf, (param->block->host + param->offset),
+                       job->out_len);
+                job->param.comp.result = RES_NONE;
+            }
+        }
+    } else if (status == QPL_STS_MORE_OUTPUT_NEEDED) {
+        if (job->is_compression) {
+            /*
+             * if the compressed data is larger than the original data, send a
+             * normal page for migration, in this case, IAA has copied the
+             * original data to job->out_buf automatically.
+             */
+            job->out_len = qemu_target_page_size();
+            job->param.comp.result = RES_NONE;
+            status = QPL_STS_OK;
+        }
+    }
+    return status;
+}
+
+static void check_polling_jobs(send_iaa_data send_page)
+{
+    IaaJob *job, *job_next;
+    qpl_status status;
+
+    QSIMPLEQ_FOREACH_SAFE(job, &polling_queue, entry, job_next) {
+        status = check_job_status(job, false);
+        if (status == QPL_STS_OK) { /* job has done */
+            process_completed_job(job, send_page);
+            QSIMPLEQ_REMOVE_HEAD(&polling_queue, entry);
+        } else if (status == QPL_STS_BEING_PROCESSED) { /* job is running */
+            break;
+        } else {
+            abort();
+        }
+    }
+}
+
+static int submit_new_job(IaaJob *job)
+{
+    qpl_status status;
+    qpl_job *qpl = job->qpl;
+
+    qpl->op = job->is_compression ? qpl_op_compress : qpl_op_decompress;
+    qpl->next_in_ptr = job->in_buf;
+    qpl->next_out_ptr = job->out_buf;
+    qpl->available_in = job->in_len;
+    qpl->available_out = qemu_target_page_size(); /* outbuf maximum size */
+    qpl->flags = QPL_FLAG_FIRST | QPL_FLAG_LAST | QPL_FLAG_OMIT_VERIFY;
+    qpl->level = 1; /* only level 1 compression is supported */
+
+    do {
+        status = qpl_submit_job(qpl);
+    } while (status == QPL_STS_QUEUES_ARE_BUSY_ERR);
+
+    if (status != QPL_STS_OK) {
+        error_report("Failed to submit iaa job, error %d", status);
+        return -1;
+    }
+    QSIMPLEQ_INSERT_TAIL(&polling_queue, job, entry);
+    return 0;
+}
+
+int flush_iaa_jobs(bool flush_all_jobs, send_iaa_data send_page)
+{
+    IaaJob *job, *job_next;
+
+    QSIMPLEQ_FOREACH_SAFE(job, &polling_queue, entry, job_next) {
+        if (check_job_status(job, true) != QPL_STS_OK) {
+            return -1;
+        }
+        process_completed_job(job, send_page);
+        QSIMPLEQ_REMOVE_HEAD(&polling_queue, entry);
+        if (!flush_all_jobs) {
+            break;
+        }
+    }
+    return 0;
+}
+
+int compress_page_with_iaa(RAMBlock *block, ram_addr_t offset,
+                           send_iaa_data send_page)
+{
+    IaaJob *job;
+
+    if (iaa_job_pool.cnt != 0) {
+        check_polling_jobs(send_page);
+    }
+    if (buffer_is_zero(block->host + offset, qemu_target_page_size())) {
+        send_page(block, offset, NULL, 0, RES_ZEROPAGE);
+        return 1;
+    }
+    job = get_job(send_page);
+    job->is_compression = true;
+    job->in_buf = block->host + offset;
+    job->in_len = qemu_target_page_size();
+    job->param.comp.offset = offset;
+    job->param.comp.block = block;
+    return (submit_new_job(job) == 0 ? 1 : 0);
+}
+
+int decompress_data_with_iaa(QEMUFile *f, void *host, int len)
+{
+    IaaJob *job;
+
+    if (iaa_job_pool.cnt != 0) {
+        check_polling_jobs(NULL);
+    }
+    job = get_job(NULL);
+    job->is_compression = false;
+    qemu_get_buffer(f, job->in_buf, len);
+    job->in_len = len;
+    job->param.decomp.host = host;
+    return submit_new_job(job);
+}
diff --git a/migration/iaa-ram-compress.h b/migration/iaa-ram-compress.h
index 27998b255b..5a555b3b8d 100644
--- a/migration/iaa-ram-compress.h
+++ b/migration/iaa-ram-compress.h
@@ -15,6 +15,13 @@
 #include "qemu-file.h"
 #include "ram-compress.h"
 
+typedef int (*send_iaa_data) (RAMBlock *block, ram_addr_t offset, uint8_t *data,
+                              uint32_t data_len, CompressResult result);
+
 int iaa_compress_init(bool is_decompression);
 void iaa_compress_deinit(void);
+int compress_page_with_iaa(RAMBlock *block, ram_addr_t offset,
+                           send_iaa_data send_page);
+int decompress_data_with_iaa(QEMUFile *f, void *host, int len);
+int flush_iaa_jobs(bool flush_all_jobs, send_iaa_data send_page);
 #endif
diff --git a/migration/ram-compress.c b/migration/ram-compress.c
index acc511ce57..0bddf8b9ea 100644
--- a/migration/ram-compress.c
+++ b/migration/ram-compress.c
@@ -370,10 +370,11 @@ int wait_for_decompress_done(void)
         return 0;
     }
 
+#ifdef CONFIG_QPL
     if (migrate_compress_with_iaa()) {
-        /* Implement in next patch */
-        return 0;
+        return flush_iaa_jobs(true, NULL);
     }
+#endif
 
     thread_count = migrate_decompress_threads();
     qemu_mutex_lock(&decomp_done_lock);
@@ -511,9 +512,12 @@ void ram_compress_save_cleanup(void)
 
 void ram_decompress_data(QEMUFile *f, void *host, int len)
 {
+#ifdef CONFIG_QPL
     if (migrate_compress_with_iaa()) {
-        /* Implement in next patch */
+        decompress_data_with_iaa(f, host, len);
+        return;
     }
+#endif
     decompress_data_with_multi_threads(f, host, len);
 }
 
diff --git a/migration/ram.c b/migration/ram.c
index 34ee1de332..5ef818112c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -69,6 +69,9 @@
 #include "qemu/userfaultfd.h"
 #endif /* defined(__linux__) */
 
+#ifdef CONFIG_QPL
+#include "iaa-ram-compress.h"
+#endif
 /***********************************************************/
 /* ram save/restore */
 
@@ -1342,16 +1345,59 @@ static int send_queued_data(CompressParam *param)
     return len;
 }
 
+#ifdef CONFIG_QPL
+static int send_iaa_compressed_page(RAMBlock *block, ram_addr_t offset,
+                                    uint8_t *data, uint32_t data_len,
+                                    CompressResult result)
+{
+    PageSearchStatus *pss = &ram_state->pss[RAM_CHANNEL_PRECOPY];
+    MigrationState *ms = migrate_get_current();
+    QEMUFile *file = ms->to_dst_file;
+    int len = 0;
+
+    assert(block == pss->last_sent_block);
+    if (result == RES_ZEROPAGE) {
+        len += save_page_header(pss, file, block, offset | RAM_SAVE_FLAG_ZERO);
+        qemu_put_byte(file, 0);
+        len += 1;
+        ram_release_page(block->idstr, offset);
+        stat64_add(&mig_stats.zero_pages, 1);
+    } else if (result == RES_COMPRESS) {
+        assert(data != NULL);
+        assert((data_len > 0) && (data_len < qemu_target_page_size()));
+        len += save_page_header(pss, file, block,
+                                offset | RAM_SAVE_FLAG_COMPRESS_PAGE);
+        qemu_put_be32(file, data_len);
+        qemu_put_buffer(file, data, data_len);
+        len += data_len;
+        /* 8 means a header with RAM_SAVE_FLAG_CONTINUE. */
+        compression_counters.compressed_size += len - 8;
+        compression_counters.pages++;
+    } else if (result == RES_NONE) {
+        assert((data != NULL) && (data_len == TARGET_PAGE_SIZE));
+        len += save_page_header(pss, file, block, offset | RAM_SAVE_FLAG_PAGE);
+        qemu_put_buffer(file, data, data_len);
+        len += data_len;
+        stat64_add(&mig_stats.normal_pages, 1);
+    } else {
+        abort();
+    }
+    ram_transferred_add(len);
+    return len;
+}
+#endif
+
 static void ram_flush_compressed_data(RAMState *rs)
 {
     if (!save_page_use_compression(rs)) {
         return;
     }
+#ifdef CONFIG_QPL
     if (migrate_compress_with_iaa()) {
-        /* Implement in next patch */
+        flush_iaa_jobs(true, send_iaa_compressed_page);
         return;
     }
-
+#endif
     flush_compressed_data(send_queued_data);
 }
 
@@ -2102,11 +2148,11 @@ static bool save_compress_page(RAMState *rs, PageSearchStatus *pss,
         ram_flush_compressed_data(rs);
         return false;
     }
-
+#ifdef CONFIG_QPL
     if (migrate_compress_with_iaa()) {
-        /* Implement in next patch */
-        return true;
+        return compress_page_with_iaa(block, offset, send_iaa_compressed_page);
     }
+#endif
     if (compress_page_with_multi_thread(block, offset, send_queued_data) > 0) {
         return true;
     }
-- 
2.39.3


