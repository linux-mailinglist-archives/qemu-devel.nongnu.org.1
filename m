Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8FE774C71
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 23:09:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTTwu-0007ez-A6; Tue, 08 Aug 2023 17:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTTws-0007eP-44
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:09:02 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTTwq-0005vF-BH
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:09:01 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1bc3d94d40fso53342925ad.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 14:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691528939; x=1692133739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p1NLSIvorkQrsaaDKLyaBigg9Lde4sad1iqhAbZMlyw=;
 b=MDpP9kd7pBJnh2iFK0ctNMk5dSBef9/29x7WlX4pZnMuIP7GlBFsLMgqrvTrXk/koM
 JZ8k94EdoUwS+lkhgVwEZq5tYlbz8g03IhQcsiWa3BLywJAiU4TIDSO++1jUPnxMaqMi
 nHKv/1pLs3yyoaMxJw7Lgj1JATSHmKEYeubktBkZTru1i8v05dDiUANLbVyh4sU9PaJp
 whR5ud+QMwXONiItj3XyvnK0Vxi8Nye3WeWapifVDGuvOJsXBPnuDwk1JccqKap/W3QI
 IdhrbOPpcEF2cB5NSKdI1FwdUkwHuVHH6TSInc3VvzEiwEdUfIDHFai2TnWvMJ0gASRV
 TedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691528939; x=1692133739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p1NLSIvorkQrsaaDKLyaBigg9Lde4sad1iqhAbZMlyw=;
 b=MgymohYg/HfyyweHXShfUhkM7Zj5SOtnrwucTjzusr9QMNcQAPM8nsce3Lzbcge7sE
 zztObyRR+eETT4slrlZ/88Vv5cXTnOfLNRZVKnE+HY0fosDTgr3h4TQnM5I63zDcSKuX
 4Z7V2IcQOstHEad22E6gu/iPeNQPQjvb/OH1jAw2o5Ewbn4zp2r9yN1fOdE3aRngS1Wc
 2JolgOVO8LBwgwAomCRG9psIZU1SNGWfwA0NO5m9mxQojpA4hy8U0xDwwT+hGfny8vL+
 mwsbtCX178rJnUG004GXb0Xpmd41tJ/rZ6Wzykxek9VTQvgfx972D9MOITsJX3P5Yg3D
 +h2g==
X-Gm-Message-State: AOJu0Yx7WcInMwNxA+KnqDij5py8s+yHyIzPCHsXWiRvE+ZA3cf1/BXT
 b0iBrnqErPyxpqnaa0MaQUiIFYhhu6kEgPyPb4U=
X-Google-Smtp-Source: AGHT+IGNuLJmZnfoSgxuYGPRbG3zol2Cd/2m1nPGwQCtx75LIQxwl7a15Q/lphPO1aDeE2tDkM/4Iw==
X-Received: by 2002:a17:902:dacf:b0:1bb:97d0:c628 with SMTP id
 q15-20020a170902dacf00b001bb97d0c628mr1038330plx.31.1691528938986; 
 Tue, 08 Aug 2023 14:08:58 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 k11-20020a170902694b00b001b3fb2f0296sm9437533plt.120.2023.08.08.14.08.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 14:08:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 01/14] linux-user: Adjust task_unmapped_base for reserved_va
Date: Tue,  8 Aug 2023 14:08:43 -0700
Message-Id: <20230808210856.95568-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808210856.95568-1-richard.henderson@linaro.org>
References: <20230808210856.95568-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Ensure that the chosen values for mmap_next_start and
task_unmapped_base are within the guest address space.

Tested-by: Helge Deller <deller@gmx.de>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/user-mmap.h | 34 +++++++++++++++++++++++++++++++++-
 linux-user/main.c      | 28 ++++++++++++++++++++++++++++
 linux-user/mmap.c      | 18 +++---------------
 3 files changed, 64 insertions(+), 16 deletions(-)

diff --git a/linux-user/user-mmap.h b/linux-user/user-mmap.h
index 7265c2c116..2c9d99ed6c 100644
--- a/linux-user/user-mmap.h
+++ b/linux-user/user-mmap.h
@@ -18,6 +18,39 @@
 #ifndef LINUX_USER_USER_MMAP_H
 #define LINUX_USER_USER_MMAP_H
 
+#if HOST_LONG_BITS == 64 && TARGET_ABI_BITS == 64
+#ifdef TARGET_AARCH64
+# define TASK_UNMAPPED_BASE  0x5500000000
+#else
+# define TASK_UNMAPPED_BASE  (1ul << 38)
+#endif
+#else
+#ifdef TARGET_HPPA
+# define TASK_UNMAPPED_BASE  0xfa000000
+#else
+# define TASK_UNMAPPED_BASE  0x40000000
+#endif
+#endif
+
+/*
+ * Guest parameters for the ADDR_COMPAT_LAYOUT personality
+ * (at present this is the only layout supported by QEMU).
+ *
+ * TASK_UNMAPPED_BASE: For mmap without hint (addr != 0), the search
+ * for unused virtual memory begins at TASK_UNMAPPED_BASE.
+ *
+ * task_unmapped_base: When the guest address space is limited via -R,
+ * the value of TASK_UNMAPPED_BASE is adjusted to fit.
+ */
+extern abi_ulong task_unmapped_base;
+
+/*
+ * mmap_next_start: The base address for the next mmap without hint,
+ * increased after each successful map, starting at task_unmapped_base.
+ * This is an optimization within QEMU and not part of ADDR_COMPAT_LAYOUT.
+ */
+extern abi_ulong mmap_next_start;
+
 int target_mprotect(abi_ulong start, abi_ulong len, int prot);
 abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
                      int flags, int fd, off_t offset);
@@ -26,7 +59,6 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
                        abi_ulong new_size, unsigned long flags,
                        abi_ulong new_addr);
 abi_long target_madvise(abi_ulong start, abi_ulong len_in, int advice);
-extern abi_ulong mmap_next_start;
 abi_ulong mmap_find_vma(abi_ulong, abi_ulong, abi_ulong);
 void mmap_fork_start(void);
 void mmap_fork_end(int child);
diff --git a/linux-user/main.c b/linux-user/main.c
index 556956c363..be621dc792 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -821,6 +821,34 @@ int main(int argc, char **argv, char **envp)
         reserved_va = max_reserved_va;
     }
 
+    /*
+     * Temporarily disable
+     *   "comparison is always false due to limited range of data type"
+     * due to comparison between (possible) uint64_t and uintptr_t.
+     */
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wtype-limits"
+
+    /*
+     * Select an initial value for task_unmapped_base that is in range.
+     */
+    if (reserved_va) {
+        if (TASK_UNMAPPED_BASE < reserved_va) {
+            task_unmapped_base = TASK_UNMAPPED_BASE;
+        } else {
+            /* The most common default formula is TASK_SIZE / 3. */
+            task_unmapped_base = TARGET_PAGE_ALIGN(reserved_va / 3);
+        }
+    } else if (TASK_UNMAPPED_BASE < UINTPTR_MAX) {
+        task_unmapped_base = TASK_UNMAPPED_BASE;
+    } else {
+        /* 32-bit host: pick something medium size. */
+        task_unmapped_base = 0x10000000;
+    }
+    mmap_next_start = task_unmapped_base;
+
+#pragma GCC diagnostic pop
+
     {
         Error *err = NULL;
         if (seed_optarg != NULL) {
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index eb04fab8ab..84436d45c8 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -299,20 +299,8 @@ static bool mmap_frag(abi_ulong real_start, abi_ulong start, abi_ulong last,
     return true;
 }
 
-#if HOST_LONG_BITS == 64 && TARGET_ABI_BITS == 64
-#ifdef TARGET_AARCH64
-# define TASK_UNMAPPED_BASE  0x5500000000
-#else
-# define TASK_UNMAPPED_BASE  (1ul << 38)
-#endif
-#else
-#ifdef TARGET_HPPA
-# define TASK_UNMAPPED_BASE  0xfa000000
-#else
-# define TASK_UNMAPPED_BASE  0x40000000
-#endif
-#endif
-abi_ulong mmap_next_start = TASK_UNMAPPED_BASE;
+abi_ulong task_unmapped_base;
+abi_ulong mmap_next_start;
 
 /*
  * Subroutine of mmap_find_vma, used when we have pre-allocated
@@ -391,7 +379,7 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
 
             if ((addr & (align - 1)) == 0) {
                 /* Success.  */
-                if (start == mmap_next_start && addr >= TASK_UNMAPPED_BASE) {
+                if (start == mmap_next_start && addr >= task_unmapped_base) {
                     mmap_next_start = addr + size;
                 }
                 return addr;
-- 
2.34.1


