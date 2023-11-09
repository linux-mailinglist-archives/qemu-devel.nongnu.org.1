Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D377E79C2
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 08:34:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1M1E-000672-VH; Fri, 10 Nov 2023 02:33:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1r1M1C-0005z8-3n
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 02:33:30 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1r1M16-0007HI-Kr
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 02:33:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699601604; x=1731137604;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uOL+LNCHU+xCugILn6evh00iYwzMVNa02vULBrgV7+g=;
 b=mTUZkV74axE0O0cyPRisysZOwJXYOW4snhQs96HJSTeUZ6L3CYMQwYXo
 QwWI1cbAGlE2V8FFkiLxu95wL6xcw0KfNzEnnSGdjHBKdgIxu+qvVMu69
 0e4b4wsHPIIkrEvv5VsX35n3eSvT//CLSm/S1zpYXvHMoefnhSP80puf+
 Ylwpzm2Ak5Y2cXN7VXphr97Cnay9+cDAz8VpGd33DTu93CdlGyzuT9MVu
 Y5WpxRyjOxXnfi94dQJoea0JtMBQsmZDCj4mK+VgKbBPCvXPTOlzVmByW
 9/1ySTrUGwSnv12sbzeF2PIUB7zZEFcArF1nZoKRIyV0wMEl76klBDQ1p g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="3183711"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="3183711"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2023 23:33:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="829571068"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; d="scan'208";a="829571068"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by fmsmga008.fm.intel.com with ESMTP; 09 Nov 2023 23:33:18 -0800
From: Yuan Liu <yuan1.liu@intel.com>
To: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Cc: qemu-devel@nongnu.org,
	yuan1.liu@intel.com,
	nanhai.zou@intel.com
Subject: [PATCH v2 4/4] multifd: Introduce QPL compression accelerator
Date: Thu,  9 Nov 2023 23:46:38 +0800
Message-Id: <20231109154638.488213-5-yuan1.liu@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231109154638.488213-1-yuan1.liu@intel.com>
References: <20231109154638.488213-1-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=yuan1.liu@intel.com;
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

Intel Query Processing Library (QPL) is an open-source library
for data compression, it supports the deflate compression algorithm,
compatible with Zlib and GZIP.

QPL supports both software compression and hardware compression.
Software compression is based on instruction optimization to accelerate
data compression, and it can be widely used on Intel CPUs. Hardware
compression utilizes the Intel In-Memory Analytics Accelerator (IAA)
hardware which is available on Intel Xeon Sapphire Rapids processors.

During multifd live migration, the QPL accelerator can be specified to
accelerate the Zlib compression algorithm. QPL can automatically choose
software or hardware acceleration based on the platform.

Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
---
 migration/meson.build   |   1 +
 migration/multifd-qpl.c | 326 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 327 insertions(+)
 create mode 100644 migration/multifd-qpl.c

diff --git a/migration/meson.build b/migration/meson.build
index 92b1cc4297..c155c2d781 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -40,6 +40,7 @@ if get_option('live_block_migration').allowed()
   system_ss.add(files('block.c'))
 endif
 system_ss.add(when: zstd, if_true: files('multifd-zstd.c'))
+system_ss.add(when: qpl, if_true: files('multifd-qpl.c'))

 specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
                 if_true: files('ram.c',
diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
new file mode 100644
index 0000000000..9d2ca9e44e
--- /dev/null
+++ b/migration/multifd-qpl.c
@@ -0,0 +1,326 @@
+/*
+ * Multifd qpl compression accelerator implementation
+ *
+ * Copyright (c) 2023 Intel Corporation
+ *
+ * Authors:
+ *  Yuan Liu<yuan1.liu@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/rcu.h"
+#include "exec/ramblock.h"
+#include "exec/target_page.h"
+#include "qapi/error.h"
+#include "migration.h"
+#include "trace.h"
+#include "options.h"
+#include "multifd.h"
+#include "qpl/qpl.h"
+
+#define MAX_BUF_SIZE (MULTIFD_PACKET_SIZE * 2)
+
+static bool support_compression_methods[MULTIFD_COMPRESSION__MAX];
+
+struct qpl_data {
+    qpl_job *job;
+    /* compressed data buffer */
+    uint8_t *buf;
+    /* decompressed data buffer */
+    uint8_t *zbuf;
+};
+
+static int init_qpl(struct qpl_data *qpl, uint8_t channel_id,  Error **errp)
+{
+    qpl_status status;
+    qpl_path_t path = qpl_path_auto;
+    uint32_t job_size = 0;
+
+    status = qpl_get_job_size(path, &job_size);
+    if (status != QPL_STS_OK) {
+        error_setg(errp, "multfd: %u: failed to get QPL size, error %d",
+                   channel_id, status);
+        return -1;
+    }
+
+    qpl->job = g_try_malloc0(job_size);
+    if (!qpl->job) {
+        error_setg(errp, "multfd: %u: failed to allocate QPL job", channel_id);
+        return -1;
+    }
+
+    status = qpl_init_job(path, qpl->job);
+    if (status != QPL_STS_OK) {
+        error_setg(errp, "multfd: %u: failed to init QPL hardware, error %d",
+                   channel_id, status);
+        g_free(qpl->job);
+        return -1;
+    }
+    return 0;
+}
+
+static void deinit_qpl(struct qpl_data *qpl)
+{
+    if (qpl->job) {
+        qpl_fini_job(qpl->job);
+        g_free(qpl->job);
+    }
+}
+
+/**
+ * qpl_send_setup: setup send side
+ *
+ * Setup each channel with QPL compression.
+ *
+ * Returns 0 for success or -1 for error
+ *
+ * @p: Params for the channel that we are using
+ * @errp: pointer to an error
+ */
+static int qpl_send_setup(MultiFDSendParams *p, Error **errp)
+{
+    struct qpl_data *qpl = g_new0(struct qpl_data, 1);
+    /* prefault the memory to avoid the IO page faults */
+    int flags = MAP_PRIVATE | MAP_POPULATE | MAP_ANONYMOUS;
+    const char *err_msg;
+
+    if (init_qpl(qpl, p->id, errp) != 0) {
+        err_msg = "failed to initialize QPL\n";
+        goto err_qpl_init;
+    }
+    qpl->zbuf = mmap(NULL, MAX_BUF_SIZE, PROT_READ | PROT_WRITE, flags, -1, 0);
+    if (qpl->zbuf == MAP_FAILED) {
+        err_msg = "failed to allocate QPL zbuf\n";
+        goto err_zbuf_mmap;
+    }
+    p->data = qpl;
+    return 0;
+
+err_zbuf_mmap:
+    deinit_qpl(qpl);
+err_qpl_init:
+    g_free(qpl);
+    error_setg(errp, "multifd %u: %s", p->id, err_msg);
+    return -1;
+}
+
+/**
+ * qpl_send_cleanup: cleanup send side
+ *
+ * Close the channel and return memory.
+ *
+ * @p: Params for the channel that we are using
+ * @errp: pointer to an error
+ */
+static void qpl_send_cleanup(MultiFDSendParams *p, Error **errp)
+{
+    struct qpl_data *qpl = p->data;
+
+    deinit_qpl(qpl);
+    if (qpl->zbuf) {
+        munmap(qpl->zbuf, MAX_BUF_SIZE);
+        qpl->zbuf = NULL;
+    }
+    g_free(p->data);
+    p->data = NULL;
+}
+
+/**
+ * qpl_send_prepare: prepare data to be able to send
+ *
+ * Create a compressed buffer with all the pages that we are going to
+ * send.
+ *
+ * Returns 0 for success or -1 for error
+ *
+ * @p: Params for the channel that we are using
+ * @errp: pointer to an error
+ */
+static int qpl_send_prepare(MultiFDSendParams *p, Error **errp)
+{
+    struct qpl_data *qpl = p->data;
+    qpl_job *job = qpl->job;
+    qpl_status status;
+
+    job->op = qpl_op_compress;
+    job->next_out_ptr = qpl->zbuf;
+    job->available_out = MAX_BUF_SIZE;
+    job->flags = QPL_FLAG_FIRST | QPL_FLAG_OMIT_VERIFY | QPL_FLAG_ZLIB_MODE;
+    /* QPL supports compression level 1 */
+    job->level = 1;
+    for (int i = 0; i < p->normal_num; i++) {
+        if (i == p->normal_num - 1) {
+            job->flags |= (QPL_FLAG_LAST | QPL_FLAG_OMIT_VERIFY);
+        }
+        job->next_in_ptr = p->pages->block->host + p->normal[i];
+        job->available_in = p->page_size;
+        status = qpl_execute_job(job);
+        if (status != QPL_STS_OK) {
+            error_setg(errp, "multifd %u: execute job error %d ",
+                       p->id, status);
+            return -1;
+        }
+        job->flags &= ~QPL_FLAG_FIRST;
+    }
+    p->iov[p->iovs_num].iov_base = qpl->zbuf;
+    p->iov[p->iovs_num].iov_len = job->total_out;
+    p->iovs_num++;
+    p->next_packet_size += job->total_out;
+    p->flags |= MULTIFD_FLAG_ZLIB;
+    return 0;
+}
+
+/**
+ * qpl_recv_setup: setup receive side
+ *
+ * Create the compressed channel and buffer.
+ *
+ * Returns 0 for success or -1 for error
+ *
+ * @p: Params for the channel that we are using
+ * @errp: pointer to an error
+ */
+static int qpl_recv_setup(MultiFDRecvParams *p, Error **errp)
+{
+    struct qpl_data *qpl = g_new0(struct qpl_data, 1);
+    int flags = MAP_PRIVATE | MAP_POPULATE | MAP_ANONYMOUS;
+    const char *err_msg;
+
+    if (init_qpl(qpl, p->id, errp) != 0) {
+        err_msg = "failed to initialize QPL\n";
+        goto err_qpl_init;
+    }
+    qpl->zbuf = mmap(NULL, MAX_BUF_SIZE, PROT_READ | PROT_WRITE, flags, -1, 0);
+    if (qpl->zbuf == MAP_FAILED) {
+        err_msg = "failed to allocate QPL zbuf\n";
+        goto err_zbuf_mmap;
+    }
+    qpl->buf = mmap(NULL, MAX_BUF_SIZE, PROT_READ | PROT_WRITE, flags, -1, 0);
+    if (qpl->buf == MAP_FAILED) {
+        err_msg = "failed to allocate QPL buf\n";
+        goto err_buf_mmap;
+    }
+    p->data = qpl;
+    return 0;
+
+err_buf_mmap:
+    munmap(qpl->zbuf, MAX_BUF_SIZE);
+    qpl->zbuf = NULL;
+err_zbuf_mmap:
+    deinit_qpl(qpl);
+err_qpl_init:
+    g_free(qpl);
+    error_setg(errp, "multifd %u: %s", p->id, err_msg);
+    return -1;
+}
+
+/**
+ * qpl_recv_cleanup: setup receive side
+ *
+ * For no compression this function does nothing.
+ *
+ * @p: Params for the channel that we are using
+ */
+static void qpl_recv_cleanup(MultiFDRecvParams *p)
+{
+    struct qpl_data *qpl = p->data;
+
+    deinit_qpl(qpl);
+    if (qpl->zbuf) {
+        munmap(qpl->zbuf, MAX_BUF_SIZE);
+        qpl->zbuf = NULL;
+    }
+    if (qpl->buf) {
+        munmap(qpl->buf, MAX_BUF_SIZE);
+        qpl->buf = NULL;
+    }
+    g_free(p->data);
+    p->data = NULL;
+}
+
+/**
+ * qpl_recv_pages: read the data from the channel into actual pages
+ *
+ * Read the compressed buffer, and uncompress it into the actual
+ * pages.
+ *
+ * Returns 0 for success or -1 for error
+ *
+ * @p: Params for the channel that we are using
+ * @errp: pointer to an error
+ */
+static int qpl_recv_pages(MultiFDRecvParams *p, Error **errp)
+{
+    struct qpl_data *qpl = p->data;
+    uint32_t in_size = p->next_packet_size;
+    uint32_t expected_size = p->normal_num * p->page_size;
+    uint32_t flags = p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
+    qpl_job *job = qpl->job;
+    qpl_status status;
+    int ret;
+
+    if (flags != MULTIFD_FLAG_ZLIB) {
+        error_setg(errp, "multifd %u: flags received %x flags expected %x",
+                   p->id, flags, MULTIFD_FLAG_ZLIB);
+        return -1;
+    }
+    ret = qio_channel_read_all(p->c, (void *)qpl->zbuf, in_size, errp);
+    if (ret != 0) {
+        return ret;
+    }
+
+    job->op = qpl_op_decompress;
+    job->next_in_ptr = qpl->zbuf;
+    job->available_in = in_size;
+    job->next_out_ptr = qpl->buf;
+    job->available_out = expected_size;
+    job->flags = QPL_FLAG_FIRST | QPL_FLAG_LAST | QPL_FLAG_OMIT_VERIFY |
+                 QPL_FLAG_ZLIB_MODE;
+    status = qpl_execute_job(job);
+    if ((status != QPL_STS_OK) || (job->total_out != expected_size)) {
+        error_setg(errp, "multifd %u: execute job error %d, expect %u, out %u",
+                   p->id, status, job->total_out, expected_size);
+        return -1;
+    }
+    for (int i = 0; i < p->normal_num; i++) {
+        memcpy(p->host + p->normal[i], qpl->buf + (i * p->page_size),
+               p->page_size);
+    }
+    return 0;
+}
+
+static MultiFDMethods multifd_qpl_ops = {
+    .send_setup = qpl_send_setup,
+    .send_cleanup = qpl_send_cleanup,
+    .send_prepare = qpl_send_prepare,
+    .recv_setup = qpl_recv_setup,
+    .recv_cleanup = qpl_recv_cleanup,
+    .recv_pages = qpl_recv_pages
+};
+
+static bool is_supported(MultiFDCompression compression)
+{
+    return support_compression_methods[compression];
+}
+
+static MultiFDMethods *get_qpl_multifd_methods(void)
+{
+    return &multifd_qpl_ops;
+}
+
+static MultiFDAccelMethods multifd_qpl_accel_ops = {
+    .is_supported = is_supported,
+    .get_multifd_methods = get_qpl_multifd_methods,
+};
+
+static void multifd_qpl_register(void)
+{
+    multifd_register_accel_ops(MULTIFD_COMPRESSION_ACCEL_QPL,
+                               &multifd_qpl_accel_ops);
+    support_compression_methods[MULTIFD_COMPRESSION_ZLIB] = true;
+}
+
+migration_init(multifd_qpl_register);
--
2.39.3


