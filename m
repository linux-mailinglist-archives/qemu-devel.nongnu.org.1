Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9336F786467
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 03:04:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYykQ-0000TY-Bf; Wed, 23 Aug 2023 21:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYykN-0000ET-QD
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 21:02:51 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYykK-0000S1-M5
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 21:02:51 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-68becf931bfso332598b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 18:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692838967; x=1693443767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mus/3sAGYIp/tZt8gw3OhfynvDJwuLWU//9f2MDJGRM=;
 b=SrOC2Nx/cxZaGF/dcSkCbfCmRcnrl3/S1gkX5sM0rmiZYJrzoA7nsLOoTraI+VrN69
 Mt6Gfyb/n+LLzOpDnN+TZd+h8e+KtPvYeg6pGDoihk9KoEsFbcL/ffzCbJUPP2LkZYl1
 E9cbFfdJDD8W1Mr5WGLouu/6W2RSQ70X4yyvvynDKZgjIYtbIo8FHsJGVdQn9hBTokYv
 laNifJ/VgkY+1JGOiaVGmuR0MxHiWASdNmG7Fo3/FkH2/BgsVxMslAS0LQgskHEjzbZa
 9zDO5lt9PhWJOy5rBN9mFxUJRMGJbUJG87VGjthSZxMx+r4XSsK2YhaHHz3Rd3kLm7dC
 mNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692838967; x=1693443767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mus/3sAGYIp/tZt8gw3OhfynvDJwuLWU//9f2MDJGRM=;
 b=Unu9MFKH+J9sMUsZdsSBANuanZzpNfF3dJOMVL93B3kVA/w8Ee8E5cYu9CR7tq6Gku
 eZG7CC/0OCmF1MyRvFPJFId9LuiN7tGYZNAOVLxNQeMl3UZ7nH6ggRujZh3Nte8m2y0q
 viSc0p10WQPZFvHiEw4EOT7k1bF06zmuK3d4iXBUsoY2yWR/zszODbItRuNITp5axtu/
 6UOoHre2nWVOZRjwnh3Rv2pCw2XLKExnKJuvwKQlS+J9J7b+KWAUK1qxbxXHnLPqdl9T
 jmFc+roUGGcmKlSv5vRdEWLb82BuPcpiA4pMqyeduGybd33BuBYu4kg43bcZvK5NGDAl
 ZSnw==
X-Gm-Message-State: AOJu0YyJvGp4Tihok0meckcR86p6s3IVpDIbP6ijeoU3IDEOK1+MIma4
 F713JiE7oDZjqPrsgU4szJ5r4/7khvQaHtfZWvM=
X-Google-Smtp-Source: AGHT+IHpeXUChXao5ZQ8y9Cza8clmDkl4Sf6+KHgPf67W5/VgIVQvi3sPkADykdA5nZjjQxTAtzUYw==
X-Received: by 2002:a05:6a00:b84:b0:688:7559:4175 with SMTP id
 g4-20020a056a000b8400b0068875594175mr12634935pfj.20.1692838967210; 
 Wed, 23 Aug 2023 18:02:47 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 c10-20020aa78c0a000000b006875df4773fsm2050789pfd.163.2023.08.23.18.02.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 18:02:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Warner Losh <imp@bsdimp.com>
Subject: [PATCH 10/13] linux-user: Move shmat and shmdt implementations to
 mmap.c
Date: Wed, 23 Aug 2023 18:02:34 -0700
Message-Id: <20230824010237.1379735-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824010237.1379735-1-richard.henderson@linaro.org>
References: <20230824010237.1379735-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Rename from do_* to target_*.  Fix some minor checkpatch errors.

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/user-mmap.h |   4 ++
 linux-user/mmap.c      | 138 +++++++++++++++++++++++++++++++++++++++
 linux-user/syscall.c   | 143 ++---------------------------------------
 3 files changed, 146 insertions(+), 139 deletions(-)

diff --git a/linux-user/user-mmap.h b/linux-user/user-mmap.h
index 0f4883eb57..b94bcdcf83 100644
--- a/linux-user/user-mmap.h
+++ b/linux-user/user-mmap.h
@@ -58,4 +58,8 @@ abi_ulong mmap_find_vma(abi_ulong, abi_ulong, abi_ulong);
 void mmap_fork_start(void);
 void mmap_fork_end(int child);
 
+abi_ulong target_shmat(CPUArchState *cpu_env, int shmid,
+                       abi_ulong shmaddr, int shmflg);
+abi_long target_shmdt(abi_ulong shmaddr);
+
 #endif /* LINUX_USER_USER_MMAP_H */
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 9aab48d4a3..3aeacd1ecd 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -17,6 +17,7 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
+#include <sys/shm.h>
 #include "trace.h"
 #include "exec/log.h"
 #include "qemu.h"
@@ -27,6 +28,14 @@
 static pthread_mutex_t mmap_mutex = PTHREAD_MUTEX_INITIALIZER;
 static __thread int mmap_lock_count;
 
+#define N_SHM_REGIONS  32
+
+static struct shm_region {
+    abi_ulong start;
+    abi_ulong size;
+    bool in_use;
+} shm_regions[N_SHM_REGIONS];
+
 void mmap_lock(void)
 {
     if (mmap_lock_count++ == 0) {
@@ -981,3 +990,132 @@ abi_long target_madvise(abi_ulong start, abi_ulong len_in, int advice)
 
     return ret;
 }
+
+#ifndef TARGET_FORCE_SHMLBA
+/*
+ * For most architectures, SHMLBA is the same as the page size;
+ * some architectures have larger values, in which case they should
+ * define TARGET_FORCE_SHMLBA and provide a target_shmlba() function.
+ * This corresponds to the kernel arch code defining __ARCH_FORCE_SHMLBA
+ * and defining its own value for SHMLBA.
+ *
+ * The kernel also permits SHMLBA to be set by the architecture to a
+ * value larger than the page size without setting __ARCH_FORCE_SHMLBA;
+ * this means that addresses are rounded to the large size if
+ * SHM_RND is set but addresses not aligned to that size are not rejected
+ * as long as they are at least page-aligned. Since the only architecture
+ * which uses this is ia64 this code doesn't provide for that oddity.
+ */
+static inline abi_ulong target_shmlba(CPUArchState *cpu_env)
+{
+    return TARGET_PAGE_SIZE;
+}
+#endif
+
+abi_ulong target_shmat(CPUArchState *cpu_env, int shmid,
+                       abi_ulong shmaddr, int shmflg)
+{
+    CPUState *cpu = env_cpu(cpu_env);
+    abi_ulong raddr;
+    void *host_raddr;
+    struct shmid_ds shm_info;
+    int i, ret;
+    abi_ulong shmlba;
+
+    /* shmat pointers are always untagged */
+
+    /* find out the length of the shared memory segment */
+    ret = get_errno(shmctl(shmid, IPC_STAT, &shm_info));
+    if (is_error(ret)) {
+        /* can't get length, bail out */
+        return ret;
+    }
+
+    shmlba = target_shmlba(cpu_env);
+
+    if (shmaddr & (shmlba - 1)) {
+        if (shmflg & SHM_RND) {
+            shmaddr &= ~(shmlba - 1);
+        } else {
+            return -TARGET_EINVAL;
+        }
+    }
+    if (!guest_range_valid_untagged(shmaddr, shm_info.shm_segsz)) {
+        return -TARGET_EINVAL;
+    }
+
+    mmap_lock();
+
+    /*
+     * We're mapping shared memory, so ensure we generate code for parallel
+     * execution and flush old translations.  This will work up to the level
+     * supported by the host -- anything that requires EXCP_ATOMIC will not
+     * be atomic with respect to an external process.
+     */
+    if (!(cpu->tcg_cflags & CF_PARALLEL)) {
+        cpu->tcg_cflags |= CF_PARALLEL;
+        tb_flush(cpu);
+    }
+
+    if (shmaddr) {
+        host_raddr = shmat(shmid, (void *)g2h_untagged(shmaddr), shmflg);
+    } else {
+        abi_ulong mmap_start;
+
+        /* In order to use the host shmat, we need to honor host SHMLBA.  */
+        mmap_start = mmap_find_vma(0, shm_info.shm_segsz, MAX(SHMLBA, shmlba));
+
+        if (mmap_start == -1) {
+            errno = ENOMEM;
+            host_raddr = (void *)-1;
+        } else {
+            host_raddr = shmat(shmid, g2h_untagged(mmap_start),
+                               shmflg | SHM_REMAP);
+        }
+    }
+
+    if (host_raddr == (void *)-1) {
+        mmap_unlock();
+        return get_errno((intptr_t)host_raddr);
+    }
+    raddr = h2g((uintptr_t)host_raddr);
+
+    page_set_flags(raddr, raddr + shm_info.shm_segsz - 1,
+                   PAGE_VALID | PAGE_RESET | PAGE_READ |
+                   (shmflg & SHM_RDONLY ? 0 : PAGE_WRITE));
+
+    for (i = 0; i < N_SHM_REGIONS; i++) {
+        if (!shm_regions[i].in_use) {
+            shm_regions[i].in_use = true;
+            shm_regions[i].start = raddr;
+            shm_regions[i].size = shm_info.shm_segsz;
+            break;
+        }
+    }
+
+    mmap_unlock();
+    return raddr;
+}
+
+abi_long target_shmdt(abi_ulong shmaddr)
+{
+    int i;
+    abi_long rv;
+
+    /* shmdt pointers are always untagged */
+
+    mmap_lock();
+
+    for (i = 0; i < N_SHM_REGIONS; ++i) {
+        if (shm_regions[i].in_use && shm_regions[i].start == shmaddr) {
+            shm_regions[i].in_use = false;
+            page_set_flags(shmaddr, shmaddr + shm_regions[i].size - 1, 0);
+            break;
+        }
+    }
+    rv = get_errno(shmdt(g2h_untagged(shmaddr)));
+
+    mmap_unlock();
+
+    return rv;
+}
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8d96acd085..ff4eefe7fc 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -3725,14 +3725,6 @@ static abi_long do_socketcall(int num, abi_ulong vptr)
 }
 #endif
 
-#define N_SHM_REGIONS	32
-
-static struct shm_region {
-    abi_ulong start;
-    abi_ulong size;
-    bool in_use;
-} shm_regions[N_SHM_REGIONS];
-
 #ifndef TARGET_SEMID64_DS
 /* asm-generic version of this struct */
 struct target_semid64_ds
@@ -4482,133 +4474,6 @@ static inline abi_long do_shmctl(int shmid, int cmd, abi_long buf)
     return ret;
 }
 
-#ifndef TARGET_FORCE_SHMLBA
-/* For most architectures, SHMLBA is the same as the page size;
- * some architectures have larger values, in which case they should
- * define TARGET_FORCE_SHMLBA and provide a target_shmlba() function.
- * This corresponds to the kernel arch code defining __ARCH_FORCE_SHMLBA
- * and defining its own value for SHMLBA.
- *
- * The kernel also permits SHMLBA to be set by the architecture to a
- * value larger than the page size without setting __ARCH_FORCE_SHMLBA;
- * this means that addresses are rounded to the large size if
- * SHM_RND is set but addresses not aligned to that size are not rejected
- * as long as they are at least page-aligned. Since the only architecture
- * which uses this is ia64 this code doesn't provide for that oddity.
- */
-static inline abi_ulong target_shmlba(CPUArchState *cpu_env)
-{
-    return TARGET_PAGE_SIZE;
-}
-#endif
-
-static abi_ulong do_shmat(CPUArchState *cpu_env, int shmid,
-                          abi_ulong shmaddr, int shmflg)
-{
-    CPUState *cpu = env_cpu(cpu_env);
-    abi_ulong raddr;
-    void *host_raddr;
-    struct shmid_ds shm_info;
-    int i, ret;
-    abi_ulong shmlba;
-
-    /* shmat pointers are always untagged */
-
-    /* find out the length of the shared memory segment */
-    ret = get_errno(shmctl(shmid, IPC_STAT, &shm_info));
-    if (is_error(ret)) {
-        /* can't get length, bail out */
-        return ret;
-    }
-
-    shmlba = target_shmlba(cpu_env);
-
-    if (shmaddr & (shmlba - 1)) {
-        if (shmflg & SHM_RND) {
-            shmaddr &= ~(shmlba - 1);
-        } else {
-            return -TARGET_EINVAL;
-        }
-    }
-    if (!guest_range_valid_untagged(shmaddr, shm_info.shm_segsz)) {
-        return -TARGET_EINVAL;
-    }
-
-    mmap_lock();
-
-    /*
-     * We're mapping shared memory, so ensure we generate code for parallel
-     * execution and flush old translations.  This will work up to the level
-     * supported by the host -- anything that requires EXCP_ATOMIC will not
-     * be atomic with respect to an external process.
-     */
-    if (!(cpu->tcg_cflags & CF_PARALLEL)) {
-        cpu->tcg_cflags |= CF_PARALLEL;
-        tb_flush(cpu);
-    }
-
-    if (shmaddr)
-        host_raddr = shmat(shmid, (void *)g2h_untagged(shmaddr), shmflg);
-    else {
-        abi_ulong mmap_start;
-
-        /* In order to use the host shmat, we need to honor host SHMLBA.  */
-        mmap_start = mmap_find_vma(0, shm_info.shm_segsz, MAX(SHMLBA, shmlba));
-
-        if (mmap_start == -1) {
-            errno = ENOMEM;
-            host_raddr = (void *)-1;
-        } else
-            host_raddr = shmat(shmid, g2h_untagged(mmap_start),
-                               shmflg | SHM_REMAP);
-    }
-
-    if (host_raddr == (void *)-1) {
-        mmap_unlock();
-        return get_errno((intptr_t)host_raddr);
-    }
-    raddr = h2g((uintptr_t)host_raddr);
-
-    page_set_flags(raddr, raddr + shm_info.shm_segsz - 1,
-                   PAGE_VALID | PAGE_RESET | PAGE_READ |
-                   (shmflg & SHM_RDONLY ? 0 : PAGE_WRITE));
-
-    for (i = 0; i < N_SHM_REGIONS; i++) {
-        if (!shm_regions[i].in_use) {
-            shm_regions[i].in_use = true;
-            shm_regions[i].start = raddr;
-            shm_regions[i].size = shm_info.shm_segsz;
-            break;
-        }
-    }
-
-    mmap_unlock();
-    return raddr;
-}
-
-static inline abi_long do_shmdt(abi_ulong shmaddr)
-{
-    int i;
-    abi_long rv;
-
-    /* shmdt pointers are always untagged */
-
-    mmap_lock();
-
-    for (i = 0; i < N_SHM_REGIONS; ++i) {
-        if (shm_regions[i].in_use && shm_regions[i].start == shmaddr) {
-            shm_regions[i].in_use = false;
-            page_set_flags(shmaddr, shmaddr + shm_regions[i].size - 1, 0);
-            break;
-        }
-    }
-    rv = get_errno(shmdt(g2h_untagged(shmaddr)));
-
-    mmap_unlock();
-
-    return rv;
-}
-
 #ifdef TARGET_NR_ipc
 /* ??? This only works with linear mappings.  */
 /* do_ipc() must return target values and target errnos. */
@@ -4695,7 +4560,7 @@ static abi_long do_ipc(CPUArchState *cpu_env,
         default:
         {
             abi_ulong raddr;
-            raddr = do_shmat(cpu_env, first, ptr, second);
+            raddr = target_shmat(cpu_env, first, ptr, second);
             if (is_error(raddr))
                 return get_errno(raddr);
             if (put_user_ual(raddr, third))
@@ -4708,7 +4573,7 @@ static abi_long do_ipc(CPUArchState *cpu_env,
         }
 	break;
     case IPCOP_shmdt:
-        ret = do_shmdt(ptr);
+        ret = target_shmdt(ptr);
 	break;
 
     case IPCOP_shmget:
@@ -11008,11 +10873,11 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_shmat
     case TARGET_NR_shmat:
-        return do_shmat(cpu_env, arg1, arg2, arg3);
+        return target_shmat(cpu_env, arg1, arg2, arg3);
 #endif
 #ifdef TARGET_NR_shmdt
     case TARGET_NR_shmdt:
-        return do_shmdt(arg1);
+        return target_shmdt(arg1);
 #endif
     case TARGET_NR_fsync:
         return get_errno(fsync(arg1));
-- 
2.34.1


