Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B3F714F53
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 20:21:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3hU2-0007ec-Jw; Mon, 29 May 2023 14:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1q3hTw-0007dz-OT
 for qemu-devel@nongnu.org; Mon, 29 May 2023 14:20:38 -0400
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1q3hTt-00019q-8c
 for qemu-devel@nongnu.org; Mon, 29 May 2023 14:20:36 -0400
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-75b191fa0afso200010685a.0
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 11:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1685384432; x=1687976432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cw5z9EKJ5wTgcvigkqtkmb/9lbpBGpT9tuRtIHF2xgM=;
 b=O/vTZqeq/H+kl5jpUgV69Y7Dc/haWtOpN5q1FCpX6XQH0EAiBjTF3wHWUIuKa04V44
 PDOYk3o1TnNsXcghb1eNgmbvsqUfKe8GcpJppgUxxqeUZ9x6vo0FNwwadMI/JsFxoRbV
 uvF8sFMw67XrJ0VU+IsykmZSaFIw80fna2PLXxQYix0OqF8aXqZhLuAETn5WyVptX9Te
 yOAglaqr20Cf/F2TE+AfsQ1SNGI1KEPJuwHWTMWatMvBKhjNuThL9Dj6GLk5ykkgndxe
 LXMC1Z0pwHtqSau0FaOA+m7IUweU4SajtIcXkrgClGVai+iN2SFI1QzE0WklMKz6luWL
 ErXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685384432; x=1687976432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cw5z9EKJ5wTgcvigkqtkmb/9lbpBGpT9tuRtIHF2xgM=;
 b=g9KQ0q3n2SXspHvlLQd61a5geXQFZmcY/P8b73+1NXW/lKNq3A5C0AeECQDJ32X0tP
 yYkO9A3mhA7v47DiTVz/Uw6B8AvkxW7TKnr8ArYsckdrwRz4Sxm8T/qs1KYv5ZPmHIAK
 sIhn5nLLtz0MGg5ucj/lb3Lubo5X297BatXqQFHx16HtsHN35Lh4SxBLahpGzMirTDZx
 6cqwAAfafUN4k354xNqtkoOmjRhjLedIcFyMJO6UGTnl+mf4EWmum5nKF2wg+8/4SXKy
 kzXS4OXg/VSdJbDl9rJl44T04wdWaSsvd/hfIdZ7nU21349Nmw20wPLi2dy3Kfg10gME
 /AZg==
X-Gm-Message-State: AC+VfDwiyTRt1yAKYwoPvFi9FZL6vbZcWX7wjwpa5ZpUxq4nnp4/Qw6M
 EQ4I5ymr95Q8qsXFnspzoeKyfw==
X-Google-Smtp-Source: ACHHUZ4ID/4ZatFhLYODlAWSgR53jgWt0PPjebGJOSGFX98JlfLE229WabB5Z1nlERGw3N3u2YxKkQ==
X-Received: by 2002:a37:4656:0:b0:75b:23a1:d84e with SMTP id
 t83-20020a374656000000b0075b23a1d84emr6781908qka.16.1685384432187; 
 Mon, 29 May 2023 11:20:32 -0700 (PDT)
Received: from n231-230-216.byted.org ([147.160.184.95])
 by smtp.gmail.com with ESMTPSA id
 b15-20020a05620a126f00b0074e3cf3b44dsm2873314qkl.125.2023.05.29.11.20.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 May 2023 11:20:31 -0700 (PDT)
From: Hao Xiang <hao.xiang@bytedance.com>
To: pbonzini@redhat.com,
	quintela@redhat.com,
	qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH 3/4] Implement zero page checking using DSA.
Date: Mon, 29 May 2023 18:20:00 +0000
Message-Id: <20230529182001.2232069-4-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230529182001.2232069-1-hao.xiang@bytedance.com>
References: <20230529182001.2232069-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qk1-x72b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

1. Adds a memory comparison function by submitting
the work to the idxd driver.
2. Add interface to set bufferiszero accel function
to DSA offloading.
3. Fallback to use CPU accel function if DSA offloading
fails due to page fault.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 include/qemu/cutils.h |   6 +
 migration/ram.c       |   4 +
 util/bufferiszero.c   |  14 ++
 util/dsa.c            | 295 ++++++++++++++++++++++++++++++++++++++++++
 util/meson.build      |   1 +
 5 files changed, 320 insertions(+)
 create mode 100644 util/dsa.c

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index 92c436d8c7..9d0286ac99 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -188,9 +188,15 @@ char *freq_to_str(uint64_t freq_hz);
 /* used to print char* safely */
 #define STR_OR_NULL(str) ((str) ? (str) : "null")
 
+typedef bool (*buffer_accel_fn)(const void *, size_t);
+void set_accel(buffer_accel_fn, size_t len);
+void get_fallback_accel(buffer_accel_fn *);
 bool buffer_is_zero(const void *buf, size_t len);
 bool test_buffer_is_zero_next_accel(void);
 
+int configure_dsa(const char *dsa_path);
+void dsa_cleanup(void);
+
 /*
  * Implementation of ULEB128 (http://en.wikipedia.org/wiki/LEB128)
  * Input is limited to 14-bit numbers
diff --git a/migration/ram.c b/migration/ram.c
index 88a6c82e63..b586ac4a99 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2280,6 +2280,10 @@ static int ram_save_host_page(RAMState *rs, PageSearchStatus *pss)
             if (preempt_active) {
                 qemu_mutex_unlock(&rs->bitmap_mutex);
             }
+            /*
+             * TODO: Make ram_save_target_page asyn to take advantage
+             * of DSA offloading.
+             */
             tmppages = migration_ops->ram_save_target_page(rs, pss);
             if (tmppages >= 0) {
                 pages += tmppages;
diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index 3e6a5dfd63..3d089ef1fe 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -206,6 +206,7 @@ buffer_zero_avx512(const void *buf, size_t len)
 static unsigned used_accel = INIT_USED;
 static unsigned length_to_accel = INIT_LENGTH;
 static bool (*buffer_accel)(const void *, size_t) = INIT_ACCEL;
+static bool (*buffer_accel_fallback)(const void *, size_t) = INIT_ACCEL;
 
 static unsigned __attribute__((noinline))
 select_accel_cpuinfo(unsigned info)
@@ -231,6 +232,7 @@ select_accel_cpuinfo(unsigned info)
         if (info & all[i].bit) {
             length_to_accel = all[i].len;
             buffer_accel = all[i].fn;
+            buffer_accel_fallback = all[i].fn;
             return all[i].bit;
         }
     }
@@ -272,6 +274,17 @@ bool test_buffer_is_zero_next_accel(void)
 }
 #endif
 
+void set_accel(buffer_accel_fn fn, size_t len)
+{
+    buffer_accel = fn;
+    length_to_accel = len;
+}
+
+void get_fallback_accel(buffer_accel_fn *fn)
+{
+    *fn = buffer_accel_fallback;
+}
+
 /*
  * Checks if a buffer is all zeroes
  */
@@ -288,3 +301,4 @@ bool buffer_is_zero(const void *buf, size_t len)
        includes a check for an unrolled loop over 64-bit integers.  */
     return select_accel_fn(buf, len);
 }
+
diff --git a/util/dsa.c b/util/dsa.c
new file mode 100644
index 0000000000..2fdcdb4f49
--- /dev/null
+++ b/util/dsa.c
@@ -0,0 +1,295 @@
+/*
+ * Use Intel Data Streaming Accelerator to offload certain background
+ * operations.
+ *
+ * Copyright (c) 2023 Hao Xiang <hao.xiang@bytedance.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+#include "qemu/osdep.h"
+#include "qemu/cutils.h"
+#include "qemu/bswap.h"
+#include "qemu/error-report.h"
+
+#ifdef CONFIG_DSA_OPT
+
+#pragma GCC push_options
+#pragma GCC target("enqcmd")
+#pragma GCC target("movdir64b")
+
+#include <linux/idxd.h>
+#include "x86intrin.h"
+
+#define DSA_WQ_SIZE 4096
+
+static bool use_simulation;
+static uint64_t total_bytes_checked;
+static uint64_t total_function_calls;
+static uint64_t total_success_count;
+static int max_retry_count;
+static int top_retry_count;
+
+static void *dsa_wq = MAP_FAILED;
+static uint8_t zero_page_buffer[4096];
+static bool dedicated_mode;
+static int length_to_accel = 64;
+
+static buffer_accel_fn buffer_zero_fallback;
+
+/**
+ * @brief This function opens a DSA device's work queue and
+ *        maps the DSA device memory into the current process.
+ *
+ * @param dsa_wq_path A pointer to the DSA device work queue's file path.
+ * @return A pointer to the mapped memory.
+ */
+static void *map_dsa_device(const char *dsa_wq_path)
+{
+    void *dsa_device;
+    int fd;
+
+    fd = open(dsa_wq_path, O_RDWR);
+    if (fd < 0) {
+        fprintf(stderr, "open %s failed with errno = %d.\n",
+                dsa_wq_path, errno);
+        return MAP_FAILED;
+    }
+    dsa_device = mmap(NULL, DSA_WQ_SIZE, PROT_WRITE,
+                      MAP_SHARED | MAP_POPULATE, fd, 0);
+    close(fd);
+    if (dsa_device == MAP_FAILED) {
+        fprintf(stderr, "mmap failed with errno = %d.\n", errno);
+        return MAP_FAILED;
+    }
+    return dsa_device;
+}
+
+/**
+ * @brief Submits a DSA work item to the device work queue.
+ *
+ * @param wq A pointer to the DSA work queue's device memory.
+ * @param descriptor A pointer to the DSA work item descriptor.
+ * @return Zero if successful, non-zero otherwise.
+ */
+static int submit_wi(void *wq, void *descriptor)
+{
+    int retry = 0;
+
+    _mm_sfence();
+
+    if (dedicated_mode) {
+        _movdir64b(dsa_wq, descriptor);
+    } else {
+        while (true) {
+            if (_enqcmd(dsa_wq, descriptor) == 0) {
+                break;
+            }
+            retry++;
+            if (retry > max_retry_count) {
+                fprintf(stderr, "Submit work retry %d times.\n", retry);
+                exit(1);
+            }
+        }
+    }
+
+    return 0;
+}
+
+/**
+ * @brief Poll for the DSA work item completion.
+ *
+ * @param completion A pointer to the DSA work item completion record.
+ * @param opcode The DSA opcode.
+ * @return Zero if successful, non-zero otherwise.
+ */
+static int poll_completion(struct dsa_completion_record *completion,
+                           enum dsa_opcode opcode)
+{
+    int retry = 0;
+
+    while (true) {
+        if (completion->status != DSA_COMP_NONE) {
+            /* TODO: Error handling here. */
+            if (completion->status != DSA_COMP_SUCCESS &&
+                completion->status != DSA_COMP_PAGE_FAULT_NOBOF) {
+                fprintf(stderr, "DSA opcode %d failed with status = %d.\n",
+                    opcode, completion->status);
+                exit(1);
+            } else {
+                total_success_count++;
+            }
+            break;
+        }
+        retry++;
+        if (retry > max_retry_count) {
+            fprintf(stderr, "Wait for completion retry %d times.\n", retry);
+            exit(1);
+        }
+        _mm_pause();
+    }
+
+    if (retry > top_retry_count) {
+        top_retry_count = retry;
+    }
+
+    return 0;
+}
+
+static bool buffer_zero_dsa_simulation(const void *buf, size_t len)
+{
+    /* TODO: Handle page size greater than 4k. */
+    if (len > sizeof(zero_page_buffer)) {
+        fprintf(stderr, "Page size greater than %lu is not supported by DSA "
+                        "buffer zero checking.\n", sizeof(zero_page_buffer));
+        exit(1);
+    }
+
+    total_bytes_checked += len;
+    total_function_calls++;
+
+    return memcmp(buf, zero_page_buffer, len) == 0;
+}
+
+/**
+ * @brief Sends a memory comparison work item to a DSA device and wait
+ *        for completion.
+ *
+ * @param buf A pointer to the memory buffer for comparison.
+ * @param len Length of the memory buffer for comparison.
+ * @return true if the memory buffer is all zero, false otherwise.
+ */
+static bool buffer_zero_dsa(const void *buf, size_t len)
+{
+    struct dsa_completion_record completion __attribute__((aligned(32)));
+    struct dsa_hw_desc descriptor;
+    uint8_t test_byte;
+
+    /* TODO: Handle page size greater than 4k. */
+    if (len > sizeof(zero_page_buffer)) {
+        fprintf(stderr, "Page size greater than %lu is not supported by DSA "
+                        "buffer zero checking.\n", sizeof(zero_page_buffer));
+        exit(1);
+    }
+
+    total_bytes_checked += len;
+    total_function_calls++;
+
+    memset(&completion, 0, sizeof(completion));
+    memset(&descriptor, 0, sizeof(descriptor));
+
+    descriptor.opcode = DSA_OPCODE_COMPARE;
+    descriptor.flags = IDXD_OP_FLAG_RCR | IDXD_OP_FLAG_CRAV;
+    descriptor.xfer_size = len;
+    descriptor.src_addr = (uintptr_t)buf;
+    descriptor.dst_addr = (uintptr_t)zero_page_buffer;
+    completion.status = 0;
+    descriptor.completion_addr = (uint64_t)&completion;
+
+    /*
+     * TODO: Find a better solution. DSA device can encounter page
+     * fault during the memory comparison operatio. Block on page
+     * fault is turned off for better performance. This temporary
+     * solution reads the first byte of the memory buffer in order
+     * to cause a CPU page fault so that DSA device won't hit that
+     * later.
+     */
+    test_byte = ((uint8_t *)buf)[0];
+    ((uint8_t *)buf)[0] = test_byte;
+
+    submit_wi(dsa_wq, &descriptor);
+    poll_completion(&completion, DSA_OPCODE_COMPARE);
+
+    if (completion.status == DSA_COMP_SUCCESS) {
+        return completion.result == 0;
+    }
+
+    /*
+     * DSA was able to partially complete the operation. Check the
+     * result. If we already know this is not a zero page, we can
+     * return now.
+     */
+    if (completion.bytes_completed != 0 && completion.result != 0) {
+        return false;
+    }
+
+    /* Let's fallback to use CPU to complete it. */
+    return buffer_zero_fallback((uint8_t *)buf + completion.bytes_completed,
+                                len - completion.bytes_completed);
+}
+
+/**
+ * @brief Check if DSA devices are enabled in the current system
+ *        and set DSA offloading for zero page checking operation.
+ *        This function is called during QEMU initialization.
+ *
+ * @param dsa_path A pointer to the DSA device's work queue file path.
+ * @return int Zero if successful, non-zero otherwise.
+ */
+int configure_dsa(const char *dsa_path)
+{
+    dedicated_mode = false;
+    use_simulation = false;
+    max_retry_count = 3000;
+    total_bytes_checked = 0;
+    total_function_calls = 0;
+    total_success_count = 0;
+
+    memset(zero_page_buffer, 0, sizeof(zero_page_buffer));
+
+    dsa_wq = map_dsa_device(dsa_path);
+    if (dsa_wq == MAP_FAILED) {
+        fprintf(stderr, "map_dsa_device failed MAP_FAILED, "
+                "using simulation.\n");
+        return -1;
+    }
+
+    if (use_simulation)
+        set_accel(buffer_zero_dsa_simulation, length_to_accel);
+    else {
+        set_accel(buffer_zero_dsa, length_to_accel);
+        get_fallback_accel(&buffer_zero_fallback);
+    }
+
+    return 0;
+}
+
+/**
+ * @brief Clean up system resources created for DSA offloading.
+ *        This function is called during QEMU process teardown.
+ *
+ */
+void dsa_cleanup(void)
+{
+    if (dsa_wq != MAP_FAILED) {
+        munmap(dsa_wq, DSA_WQ_SIZE);
+    }
+}
+
+#else
+
+int configure_dsa(const char *dsa_path)
+{
+    fprintf(stderr, "Intel Data Streaming Accelerator is not supported "
+                    "on this platform.\n");
+    return -1;
+}
+
+void dsa_cleanup(void) {}
+
+#endif
diff --git a/util/meson.build b/util/meson.build
index 3a93071d27..f493071c91 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -84,6 +84,7 @@ if have_block or have_ga
 endif
 if have_block
   util_ss.add(files('aio-wait.c'))
+  util_ss.add(files('dsa.c'))
   util_ss.add(files('buffer.c'))
   util_ss.add(files('bufferiszero.c'))
   util_ss.add(files('hbitmap.c'))
-- 
2.30.2


