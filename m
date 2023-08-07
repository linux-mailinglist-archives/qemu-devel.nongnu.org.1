Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C64E6772B21
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 18:37:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT3EL-00072f-24; Mon, 07 Aug 2023 12:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT3EF-000700-CR
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:37:11 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT3ED-0002fp-2f
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:37:11 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bc6bfc4b58so7164165ad.1
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 09:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691426227; x=1692031027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m/S7kO9TVAY5h9AXp3Rhk6dYJIKvvZfYNmVBr4WCkpo=;
 b=aVq26DmAbXKGwBYvPnyi0T7cZiAIjbQVjYeTTHXWnvAnmgh6sAF/FvsCWTagbt9+2+
 D2zJbke/wnihNY9N5H9vKAwGzw9P9knNuPyH5MUIVhx1SFmAlGQxrPvrmLHmsgxUpyik
 bS+q0D5n15av9ZARyD9kZy/86LaPXI+iAgSVOXsOgfR5CTv93GBIh/BS/ZYNgiMhl5Lf
 FiFwo0dlpHQloOaUIWLAFZ6yfC0ZLIx+ZB14744Ickpt/S8ngBYVU4qImawTdACEzzYK
 yUBAUW/21m9dtaiVxpS/ohHJpY6C0fAkR9Iu0sPGndclg5DwSpdHLDflEDxTbwW4sahD
 qd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691426227; x=1692031027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m/S7kO9TVAY5h9AXp3Rhk6dYJIKvvZfYNmVBr4WCkpo=;
 b=L1yMCHKEvyitoByv/6NdDZDnfvDPTOe9XW1qw8m/qqEECgciUxYw16OvMRrqsQm/gv
 vG2w01iGu9gsYpIqGvZNz8odwUkHMCwi0km/TZOsNSGU7TZQf4cStPkv1bl+agzHhiPS
 PtyKGiiijOvOGMA+BMLqEJr4lvphyDiXuQDQ23JKo3JvOkRiTY6g7lKvp+xZuH4HUo2c
 HFxsmysRC5+iajxfcc8MPBsCPQIX8OSeYKoUAUMuN+510nH9bUPAeGVqDBCU3V0W59ef
 SAxlqpBilQfxekm7ZfzeGqtWSz245l21WU2oFWwVpnN6kb/nrsSs50U5zbgGOtiX8iUZ
 54dQ==
X-Gm-Message-State: AOJu0YyWIjeFyHTwAm18RwjGZocWYvbL80kwvSJBapQpcLXuwo0vvCI9
 DCd8XUCh9pmsjhdzV/F8gqsAYi8IEDxKP/0Fz28=
X-Google-Smtp-Source: AGHT+IGdBwlNBvCFW3oGmGTnB/LjwHKiAwyey0UWDqpV502gU5mZoMAHZMzMA8n+KcOlcNYFNG//HQ==
X-Received: by 2002:a17:903:2351:b0:1bb:d280:5e0b with SMTP id
 c17-20020a170903235100b001bbd2805e0bmr9039209plh.18.1691426227604; 
 Mon, 07 Aug 2023 09:37:07 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a170902d34600b001b9df8f14d7sm7119837plk.267.2023.08.07.09.37.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 09:37:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org, laurent@vivier.eu, deller@gmx.de,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH for-8.1 v10 01/14] linux-user: Adjust task_unmapped_base for
 reserved_va
Date: Mon,  7 Aug 2023 09:36:52 -0700
Message-Id: <20230807163705.9848-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807163705.9848-1-richard.henderson@linaro.org>
References: <20230807163705.9848-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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
 linux-user/user-mmap.h | 18 +++++++++++++++++-
 linux-user/main.c      | 28 ++++++++++++++++++++++++++++
 linux-user/mmap.c      | 18 +++---------------
 3 files changed, 48 insertions(+), 16 deletions(-)

diff --git a/linux-user/user-mmap.h b/linux-user/user-mmap.h
index 7265c2c116..fd456e024e 100644
--- a/linux-user/user-mmap.h
+++ b/linux-user/user-mmap.h
@@ -18,6 +18,23 @@
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
+extern abi_ulong task_unmapped_base;
+extern abi_ulong mmap_next_start;
+
 int target_mprotect(abi_ulong start, abi_ulong len, int prot);
 abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
                      int flags, int fd, off_t offset);
@@ -26,7 +43,6 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
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


