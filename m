Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64562743CBE
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 15:27:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFE4t-0007mx-Nn; Fri, 30 Jun 2023 09:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4r-0007m7-Tf
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:21 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4p-0003TG-U6
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:21 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fbc54cab6fso10321735e9.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 06:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688131338; x=1690723338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=++INz+dFUs55GL3VAaeUx3Gl63IpijUdLO6j4ZH4eos=;
 b=Grea6odi9qnObGoYGEW/BYKs0ekEzV0ADjYu1zYuRYZTGN0+vgqRU7zjoBIAyuqHTe
 xd86JC6yLI9LZMmI8ixmAO6e7Atmdh/96Wvj0vqnHAulABdx5jIx9xiMaAkmImhsHGYL
 lCYywVnTLvqmDLp8jiyfZnB4cQVV6FCy8mW7oxGQwa43qNHQZwLX9l8e5wDpMH4/q057
 WNun7nXKgOpd9YK62WHZDYkmGM4/gGh0QcFNrmqHBSQTrtQ9qWzhZ9tsfqyT5BlbHLzF
 H6mKCiJzn5pdjdyf3wv5hnrP4pIngzTAcCBgzvglyrnt5JYzEQMYyf6busOS9KhtIIDZ
 KY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688131338; x=1690723338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=++INz+dFUs55GL3VAaeUx3Gl63IpijUdLO6j4ZH4eos=;
 b=aVR/21xpD4K72o+vq0wr1rt9Oy5iVPDpwgNQpFSKhTWF1SExDzU//QRBUiZoxoTIsR
 g5ektQo5nP+zf4k5kQpbXfr/1wLkFj2sPL/0jKMv/PEVpmlALuqnhFR7aC5IQgjOuHse
 oRPQGW8fWt6FsYxf7gIatUfGb5fUPM3Woy8DVwPSDuw+D1iK2N2X+TpSIwTJYRYpz/jr
 nhhlywLRnsKve4UtqbfpGftq3AYosQWWuXrfsM0Dt+pi0tNqSMjZ3OF2XiqD4Pdr0liJ
 /aVmV+YOGaWjIKtB7Vt7jBYCkCaZ9NgVhn9qXuUYIeKzVo6ga/Yx0QHrvh8VDqgkF/Ux
 5kqw==
X-Gm-Message-State: ABy/qLYAz6fx1HYEBOg8OlTbItBi20yn0FXuOYMCdf8p1DvkvX431RjV
 HQ2OYaRjA11AxvglrbKEvGpJup4GKMNOIumROT1Vmg==
X-Google-Smtp-Source: APBJJlEkQaQwiqLC53R6jncYkpFCz0qpuZpmrkjLt3V24abF/fuX2Sew39ivtdvBhubcqG/IYvYkBA==
X-Received: by 2002:adf:ea91:0:b0:313:f457:6c59 with SMTP id
 s17-20020adfea91000000b00313f4576c59mr2645853wrm.44.1688131338370; 
 Fri, 30 Jun 2023 06:22:18 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 a16-20020adfdd10000000b00313ef2150dcsm14571092wrm.45.2023.06.30.06.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 06:22:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru,
	laurent@vivier.eu
Subject: [PATCH 22/24] accel/tcg: Return bool from page_check_range
Date: Fri, 30 Jun 2023 15:21:57 +0200
Message-Id: <20230630132159.376995-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630132159.376995-1-richard.henderson@linaro.org>
References: <20230630132159.376995-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
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

Replace the 0/-1 result with true/false.
Invert the sense of the test of all callers.
Document the function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/qemu.h                |  2 +-
 include/exec/cpu-all.h         | 13 ++++++++++++-
 linux-user/qemu.h              |  2 +-
 accel/tcg/user-exec.c          | 22 +++++++++++-----------
 linux-user/syscall.c           |  2 +-
 target/hppa/op_helper.c        |  2 +-
 target/riscv/vector_helper.c   |  2 +-
 target/sparc/ldst_helper.c     |  2 +-
 accel/tcg/ldst_atomicity.c.inc |  4 ++--
 9 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 41d84e0b81..edf9602f9b 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -267,7 +267,7 @@ abi_long do_freebsd_sysarch(void *cpu_env, abi_long arg1, abi_long arg2);
 
 static inline bool access_ok(int type, abi_ulong addr, abi_ulong size)
 {
-    return page_check_range((target_ulong)addr, size, type) == 0;
+    return page_check_range((target_ulong)addr, size, type);
 }
 
 /*
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index e2195c7e3d..30ce44fd90 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -222,7 +222,18 @@ int walk_memory_regions(void *, walk_memory_regions_fn);
 int page_get_flags(target_ulong address);
 void page_set_flags(target_ulong start, target_ulong last, int flags);
 void page_reset_target_data(target_ulong start, target_ulong last);
-int page_check_range(target_ulong start, target_ulong len, int flags);
+
+/**
+ * page_check_range
+ * @start: first byte of range
+ * @len: length of range
+ * @flags: flags required for each page
+ *
+ * Return true if every page in [@start, @start+@len) has @flags set.
+ * Return false if any page is unmapped.  Thus testing flags == 0 is
+ * equivalent to testing for flags == PAGE_VALID.
+ */
+bool page_check_range(target_ulong start, target_ulong last, int flags);
 
 /**
  * page_check_range_empty:
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 92f9f5af41..a6e8f0f9f6 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -179,7 +179,7 @@ static inline bool access_ok_untagged(int type, abi_ulong addr, abi_ulong size)
         : !guest_range_valid_untagged(addr, size)) {
         return false;
     }
-    return page_check_range((target_ulong)addr, size, type) == 0;
+    return page_check_range((target_ulong)addr, size, type);
 }
 
 static inline bool access_ok(CPUState *cpu, int type,
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 7a36f95bbc..107a8cda61 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -520,19 +520,19 @@ void page_set_flags(target_ulong start, target_ulong last, int flags)
     }
 }
 
-int page_check_range(target_ulong start, target_ulong len, int flags)
+bool page_check_range(target_ulong start, target_ulong len, int flags)
 {
     target_ulong last;
     int locked;  /* tri-state: =0: unlocked, +1: global, -1: local */
-    int ret;
+    bool ret;
 
     if (len == 0) {
-        return 0;  /* trivial length */
+        return true;  /* trivial length */
     }
 
     last = start + len - 1;
     if (last < start) {
-        return -1; /* wrap around */
+        return false; /* wrap around */
     }
 
     locked = have_mmap_lock();
@@ -551,33 +551,33 @@ int page_check_range(target_ulong start, target_ulong len, int flags)
                 p = pageflags_find(start, last);
             }
             if (!p) {
-                ret = -1; /* entire region invalid */
+                ret = false; /* entire region invalid */
                 break;
             }
         }
         if (start < p->itree.start) {
-            ret = -1; /* initial bytes invalid */
+            ret = false; /* initial bytes invalid */
             break;
         }
 
         missing = flags & ~p->flags;
         if (missing & ~PAGE_WRITE) {
-            ret = -1; /* page doesn't match */
+            ret = false; /* page doesn't match */
             break;
         }
         if (missing & PAGE_WRITE) {
             if (!(p->flags & PAGE_WRITE_ORG)) {
-                ret = -1; /* page not writable */
+                ret = false; /* page not writable */
                 break;
             }
             /* Asking about writable, but has been protected: undo. */
             if (!page_unprotect(start, 0)) {
-                ret = -1;
+                ret = false;
                 break;
             }
             /* TODO: page_unprotect should take a range, not a single page. */
             if (last - start < TARGET_PAGE_SIZE) {
-                ret = 0; /* ok */
+                ret = true; /* ok */
                 break;
             }
             start += TARGET_PAGE_SIZE;
@@ -585,7 +585,7 @@ int page_check_range(target_ulong start, target_ulong len, int flags)
         }
 
         if (last <= p->itree.last) {
-            ret = 0; /* ok */
+            ret = true; /* ok */
             break;
         }
         start = p->itree.last + 1;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 94cb4ad8fb..384dc5a5fe 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8076,7 +8076,7 @@ static int open_self_maps(CPUArchState *cpu_env, int fd)
             max = h2g_valid(max - 1) ?
                 max : (uintptr_t) g2h_untagged(GUEST_ADDR_MAX) + 1;
 
-            if (page_check_range(h2g(min), max - min, flags) == -1) {
+            if (!page_check_range(h2g(min), max - min, flags)) {
                 continue;
             }
 
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 32c27c66b2..f25a5a72aa 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -168,7 +168,7 @@ target_ureg HELPER(probe)(CPUHPPAState *env, target_ulong addr,
                           uint32_t level, uint32_t want)
 {
 #ifdef CONFIG_USER_ONLY
-    return (page_check_range(addr, 1, want) == 0) ? 1 : 0;
+    return page_check_range(addr, 1, want);
 #else
     int prot, excp;
     hwaddr phys;
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 1e06e7447c..1f9549f168 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -583,7 +583,7 @@ vext_ldff(void *vd, void *v0, target_ulong base,
                                          cpu_mmu_index(env, false));
                 if (host) {
 #ifdef CONFIG_USER_ONLY
-                    if (page_check_range(addr, offset, PAGE_READ) < 0) {
+                    if (page_check_range(addr, offset, PAGE_READ)) {
                         vl = i;
                         goto ProbeSuccess;
                     }
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 981a47d8bb..78b03308ae 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -1191,7 +1191,7 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
     case ASI_PNFL: /* Primary no-fault LE */
     case ASI_SNF:  /* Secondary no-fault */
     case ASI_SNFL: /* Secondary no-fault LE */
-        if (page_check_range(addr, size, PAGE_READ) == -1) {
+        if (!page_check_range(addr, size, PAGE_READ)) {
             ret = 0;
             break;
         }
diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.inc
index de70531a7a..4de0a80492 100644
--- a/accel/tcg/ldst_atomicity.c.inc
+++ b/accel/tcg/ldst_atomicity.c.inc
@@ -159,7 +159,7 @@ static uint64_t load_atomic8_or_exit(CPUArchState *env, uintptr_t ra, void *pv)
      * another process, because the fallback start_exclusive solution
      * provides no protection across processes.
      */
-    if (!page_check_range(h2g(pv), 8, PAGE_WRITE_ORG)) {
+    if (page_check_range(h2g(pv), 8, PAGE_WRITE_ORG)) {
         uint64_t *p = __builtin_assume_aligned(pv, 8);
         return *p;
     }
@@ -194,7 +194,7 @@ static Int128 load_atomic16_or_exit(CPUArchState *env, uintptr_t ra, void *pv)
      * another process, because the fallback start_exclusive solution
      * provides no protection across processes.
      */
-    if (!page_check_range(h2g(p), 16, PAGE_WRITE_ORG)) {
+    if (page_check_range(h2g(p), 16, PAGE_WRITE_ORG)) {
         return *p;
     }
 #endif
-- 
2.34.1


