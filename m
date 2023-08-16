Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A4F77E879
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 20:16:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWL2f-0002Le-Fx; Wed, 16 Aug 2023 14:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWL2d-0002L1-3E
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:14:47 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWL2a-0003gM-5i
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:14:46 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1bdb7b0c8afso32663755ad.3
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 11:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692209681; x=1692814481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dW/vtLNEGLKE5B9LCkZvKX3qKtEgOxcnhubyDt3ZcGY=;
 b=yg9mzqq10jDjdr0LrevN5wTFkBJnNPVY14w+AYINCf8VbCVCvDJWpkHUI9eJUFfppF
 QflU7YymYDLowKHedvvueKDKs9KQkL6cwsVvDQKTBBGOHYGm8zoKnu63B77qeAe+vvbT
 5jiz2qhHk97WN4LZZAf8myvxs6V4c1nANvpvuncCeATHT/82juLWWXlmqmZQRSBLpkzN
 Rd4I01fHXtempTiKYeWsDwFobIaJzkY2X3E7CjBKm1uml2BG1QLLeohLUc4zucYSXb17
 fKQEMSOivsLXMPp4ioGx3SX5c+7h5uUWgebyUGhdrT1h5y4jvDvnt8cnVp1slrLil9BC
 +Ckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692209681; x=1692814481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dW/vtLNEGLKE5B9LCkZvKX3qKtEgOxcnhubyDt3ZcGY=;
 b=DJivG256heah+nfW1fYuBRc7hjWsyepwHd8iJBJBpnWtNWFgeMUlutLAer/CB2V8GN
 z4j2QOmWlT8fve6E1ZNdHHkMy1t+ifACNli3Tfs2nr4WG865GDhCFl6OxCtyO6Ddr/lg
 R3EpOXdIZ/iRXap5cv6o+ik23UJdQN9eQm/nPU5pPNe9IKS2sHi8wJQkNXWcJl4/9hjH
 2N5GZjlpgcDBazRMee6ReDzjVo//gvBwcRC3P/jydMUQumRpizDoO5mfZ/Piar3f1Ejv
 Ybuqzn2D7KPKIEK6491VJQZDfI+eN9+7bUUvaYkSN8jfLgFgKW6CGEueEJVFnDY4C+07
 WJCQ==
X-Gm-Message-State: AOJu0YxrRft8lePNkXjy1sRfAxtTUAWKPM1FM6AQR3xEG0RSbUg65dnu
 AWM+tYHjS3JYwPmATzhfjWnNx/WKrQQkbh0Oke8=
X-Google-Smtp-Source: AGHT+IHhz0Td/QpuqEZidGcpre3lFA16MEzINBbqGW5mvVudg5UMiGBIsN51vTTTDxkOkGyLLxebgA==
X-Received: by 2002:a17:902:be08:b0:1bc:6dd9:82c3 with SMTP id
 r8-20020a170902be0800b001bc6dd982c3mr2378382pls.37.1692209681487; 
 Wed, 16 Aug 2023 11:14:41 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:a064:e3f9:a812:973b])
 by smtp.gmail.com with ESMTPSA id
 g14-20020a170902868e00b001b9dab0397bsm13423563plo.29.2023.08.16.11.14.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 11:14:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: iii@linux.ibm.com,
	deller@gmx.de
Subject: [PATCH 2/6] linux-user: Use walk_memory_regions for open_self_maps
Date: Wed, 16 Aug 2023 11:14:33 -0700
Message-Id: <20230816181437.572997-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816181437.572997-1-richard.henderson@linaro.org>
References: <20230816181437.572997-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Replace the by-hand method of region identification with
the official user-exec interface.  Cross-check the region
provided to the callback with the interval tree from
read_self_maps().

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 192 ++++++++++++++++++++++++++-----------------
 1 file changed, 115 insertions(+), 77 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 074262b3ac..658c276e39 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8095,12 +8095,66 @@ static int open_self_cmdline(CPUArchState *cpu_env, int fd)
     return 0;
 }
 
-static void show_smaps(int fd, unsigned long size)
-{
-    unsigned long page_size_kb = TARGET_PAGE_SIZE >> 10;
-    unsigned long size_kb = size >> 10;
+struct open_self_maps_data {
+    TaskState *ts;
+    IntervalTreeRoot *host_maps;
+    int fd;
+    bool smaps;
+};
 
-    dprintf(fd, "Size:                  %lu kB\n"
+/*
+ * Subroutine to output one line of /proc/self/maps,
+ * or one region of /proc/self/smaps.
+ */
+
+#ifdef TARGET_HPPA
+# define test_stack(S, E, L)  (E == L)
+#else
+# define test_stack(S, E, L)  (S == L)
+#endif
+
+static void open_self_maps_4(const struct open_self_maps_data *d,
+                             const MapInfo *mi, abi_ptr start,
+                             abi_ptr end, unsigned flags)
+{
+    const struct image_info *info = d->ts->info;
+    const char *path = mi->path;
+    uint64_t offset;
+    int fd = d->fd;
+    int count;
+
+    if (test_stack(start, end, info->stack_limit)) {
+        path = "[stack]";
+    }
+
+    /* Except null device (MAP_ANON), adjust offset for this fragment. */
+    offset = mi->offset;
+    if (mi->dev) {
+        uintptr_t hstart = (uintptr_t)g2h_untagged(start);
+        offset += hstart - mi->itree.start;
+    }
+
+    count = dprintf(fd, TARGET_ABI_FMT_ptr "-" TARGET_ABI_FMT_ptr
+                    " %c%c%c%c %08" PRIx64 " %02x:%02x %"PRId64,
+                    start, end,
+                    (flags & PAGE_READ) ? 'r' : '-',
+                    (flags & PAGE_WRITE_ORG) ? 'w' : '-',
+                    (flags & PAGE_EXEC) ? 'x' : '-',
+                    mi->is_priv ? 'p' : 's',
+                    offset, major(mi->dev), minor(mi->dev),
+                    (uint64_t)mi->inode);
+    if (path) {
+        dprintf(fd, "%*s%s\n", 73 - count, "", path);
+    } else {
+        dprintf(fd, "\n");
+    }
+
+    if (d->smaps) {
+        unsigned long size = end - start;
+        unsigned long page_size_kb = TARGET_PAGE_SIZE >> 10;
+        unsigned long size_kb = size >> 10;
+
+        dprintf(fd, "Size:                  %lu kB\n"
                 "KernelPageSize:        %lu kB\n"
                 "MMUPageSize:           %lu kB\n"
                 "Rss:                   0 kB\n"
@@ -8121,91 +8175,75 @@ static void show_smaps(int fd, unsigned long size)
                 "Swap:                  0 kB\n"
                 "SwapPss:               0 kB\n"
                 "Locked:                0 kB\n"
-                "THPeligible:    0\n", size_kb, page_size_kb, page_size_kb);
+                "THPeligible:    0\n"
+                "VmFlags:%s%s%s%s%s%s%s%s\n",
+                size_kb, page_size_kb, page_size_kb,
+                (flags & PAGE_READ) ? " rd" : "",
+                (flags & PAGE_WRITE_ORG) ? " wr" : "",
+                (flags & PAGE_EXEC) ? " ex" : "",
+                mi->is_priv ? "" : " sh",
+                (flags & PAGE_READ) ? " mr" : "",
+                (flags & PAGE_WRITE_ORG) ? " mw" : "",
+                (flags & PAGE_EXEC) ? " me" : "",
+                mi->is_priv ? "" : " ms");
+    }
 }
 
-static int open_self_maps_1(CPUArchState *cpu_env, int fd, bool smaps)
+/*
+ * Callback for walk_memory_regions, when read_self_maps() fails.
+ * Proceed without the benefit of host /proc/self/maps cross-check.
+ */
+static int open_self_maps_3(void *opaque, target_ulong guest_start,
+                            target_ulong guest_end, unsigned long flags)
 {
-    CPUState *cpu = env_cpu(cpu_env);
-    TaskState *ts = cpu->opaque;
-    IntervalTreeRoot *map_info = read_self_maps();
-    IntervalTreeNode *s;
-    int count;
+    static const MapInfo mi = { .is_priv = true };
 
-    for (s = interval_tree_iter_first(map_info, 0, -1); s;
-         s = interval_tree_iter_next(s, 0, -1)) {
-        MapInfo *e = container_of(s, MapInfo, itree);
+    open_self_maps_4(opaque, &mi, guest_start, guest_end, flags);
+    return 0;
+}
 
-        if (h2g_valid(e->itree.start)) {
-            unsigned long min = e->itree.start;
-            unsigned long max = e->itree.last + 1;
-            int flags = page_get_flags(h2g(min));
-            const char *path;
+/*
+ * Callback for walk_memory_regions, when read_self_maps() succeeds.
+ */
+static int open_self_maps_2(void *opaque, target_ulong guest_start,
+                            target_ulong guest_end, unsigned long flags)
+{
+    const struct open_self_maps_data *d = opaque;
+    uintptr_t host_start = (uintptr_t)g2h_untagged(guest_start);
+    uintptr_t host_last = (uintptr_t)g2h_untagged(guest_end - 1);
 
-            max = h2g_valid(max - 1) ?
-                max : (uintptr_t) g2h_untagged(GUEST_ADDR_MAX) + 1;
+    while (1) {
+        IntervalTreeNode *n =
+            interval_tree_iter_first(d->host_maps, host_start, host_start);
+        MapInfo *mi = container_of(n, MapInfo, itree);
+        uintptr_t this_hlast = MIN(host_last, n->last);
+        target_ulong this_gend = h2g(this_hlast) + 1;
 
-            if (!page_check_range(h2g(min), max - min, flags)) {
-                continue;
-            }
+        open_self_maps_4(d, mi, guest_start, this_gend, flags);
 
-#ifdef TARGET_HPPA
-            if (h2g(max) == ts->info->stack_limit) {
-#else
-            if (h2g(min) == ts->info->stack_limit) {
-#endif
-                path = "[stack]";
-            } else {
-                path = e->path;
-            }
-
-            count = dprintf(fd, TARGET_ABI_FMT_ptr "-" TARGET_ABI_FMT_ptr
-                            " %c%c%c%c %08" PRIx64 " %02x:%02x %"PRId64,
-                            h2g(min), h2g(max - 1) + 1,
-                            (flags & PAGE_READ) ? 'r' : '-',
-                            (flags & PAGE_WRITE_ORG) ? 'w' : '-',
-                            (flags & PAGE_EXEC) ? 'x' : '-',
-                            e->is_priv ? 'p' : 's',
-                            (uint64_t)e->offset,
-                            major(e->dev), minor(e->dev),
-                            (uint64_t)e->inode);
-            if (path) {
-                dprintf(fd, "%*s%s\n", 73 - count, "", path);
-            } else {
-                dprintf(fd, "\n");
-            }
-            if (smaps) {
-                show_smaps(fd, max - min);
-                dprintf(fd, "VmFlags:%s%s%s%s%s%s%s%s\n",
-                        (flags & PAGE_READ) ? " rd" : "",
-                        (flags & PAGE_WRITE_ORG) ? " wr" : "",
-                        (flags & PAGE_EXEC) ? " ex" : "",
-                        e->is_priv ? "" : " sh",
-                        (flags & PAGE_READ) ? " mr" : "",
-                        (flags & PAGE_WRITE_ORG) ? " mw" : "",
-                        (flags & PAGE_EXEC) ? " me" : "",
-                        e->is_priv ? "" : " ms");
-            }
+        if (this_hlast == host_last) {
+            return 0;
         }
+        host_start = this_hlast + 1;
+        guest_start = h2g(host_start);
     }
+}
 
-    free_self_maps(map_info);
+static int open_self_maps_1(CPUArchState *env, int fd, bool smaps)
+{
+    struct open_self_maps_data d = {
+        .ts = env_cpu(env)->opaque,
+        .host_maps = read_self_maps(),
+        .fd = fd,
+        .smaps = smaps
+    };
 
-#ifdef TARGET_VSYSCALL_PAGE
-    /*
-     * We only support execution from the vsyscall page.
-     * This is as if CONFIG_LEGACY_VSYSCALL_XONLY=y from v5.3.
-     */
-    count = dprintf(fd, TARGET_FMT_lx "-" TARGET_FMT_lx
-                    " --xp 00000000 00:00 0",
-                    TARGET_VSYSCALL_PAGE, TARGET_VSYSCALL_PAGE + TARGET_PAGE_SIZE);
-    dprintf(fd, "%*s%s\n", 73 - count, "",  "[vsyscall]");
-    if (smaps) {
-        show_smaps(fd, TARGET_PAGE_SIZE);
-        dprintf(fd, "VmFlags: ex\n");
+    if (d.host_maps) {
+        walk_memory_regions(&d, open_self_maps_2);
+        free_self_maps(d.host_maps);
+    } else {
+        walk_memory_regions(&d, open_self_maps_3);
     }
-#endif
-
     return 0;
 }
 
-- 
2.34.1


