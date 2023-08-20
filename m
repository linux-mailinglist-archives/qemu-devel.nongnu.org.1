Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1CA782002
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 22:44:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXpHW-0004xk-ID; Sun, 20 Aug 2023 16:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXpHU-0004x4-Im
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 16:44:16 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXpHQ-0007kI-Dc
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 16:44:16 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-68a3082c771so585064b3a.0
 for <qemu-devel@nongnu.org>; Sun, 20 Aug 2023 13:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692564251; x=1693169051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K8v+5fH9IZqdhr0bQzZXGyV6Ph1LR31Y8PNv9iFBpfQ=;
 b=FlYT4HUQw9O/ln9UTuisOxHF/tfEgWKd9aRfnG7GQVZcj1/XzCezTIK8kbQjtdTJd+
 1kUqRkCCwKW3btrTru0G0M9FhUePt8lanzUla2cVExTXIZYey6PuErHjf1moaCC3YOKz
 4j/9GYiqjI9gx2KSbXx7wk8P2Q58PAMz+AQD3rA53rwb0QQ8duiE5GJOkFiesH1hMhU/
 0yWEGKsLm5s8olb9UEbSoKGfWWEM+QGiXkVPrCDOc8Q2XGUtZ0uWa5Lmif8reuGCv+ty
 p1s5UoYiNslWm4AMB+HX9ZO2KIQrDoTOdYEVxTYlcUYY4qt5WiD4VUc/H7Ig+TUJn237
 HA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692564251; x=1693169051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K8v+5fH9IZqdhr0bQzZXGyV6Ph1LR31Y8PNv9iFBpfQ=;
 b=B5XjCkyoHROGvwBns4o5rXAYQ6rst/JSciLA0XGhWWZ902M4iSMnCcoSOSxRki0kTD
 EwnPpZjBTl5TL1SGOyPS9v3SmoBcKhxBFsMZNICLzdO4fKD/ihmy32R8wWTJCcwe3dS4
 8LdquazH0bV7CavHdb/cJnGk5gyCIl88foWe1NOAZcKuiN1E/Ty1GZadjNxhJwTH7fX9
 +aXVyR+ZkSD4BUI3g0MKbCz7MBLE4tIk5aMbyLsGhaJdHh+UKVz/TR5VWom0yS7gJrU9
 f5WMcsBDCPmZtmCvZYjz527uf4Y46GvAF+NA2SjhWkbOp4MgpbBY3uR0yP9usR+XvQUb
 dw+g==
X-Gm-Message-State: AOJu0YwMBVzbq/sor40dTe6qzbPH8AdPY6LXdKTvl7uj3b1vd60TZBrk
 o8LXmUPIeLNmSdstxqtJrqioVqZ4etuXp211flY=
X-Google-Smtp-Source: AGHT+IEfSoitOA6TQgcd0iXhd7R4KISJSi4FjQCGVf2u5otFgPUhHNB7xMeS5LMQTLTGyo1cl8S8Kg==
X-Received: by 2002:a05:6a00:1d09:b0:666:c1ae:3b87 with SMTP id
 a9-20020a056a001d0900b00666c1ae3b87mr6706738pfx.12.1692564250876; 
 Sun, 20 Aug 2023 13:44:10 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:347d:4d37:bdd7:f5e5])
 by smtp.gmail.com with ESMTPSA id
 c7-20020aa78c07000000b0064fde7ae1ffsm1430149pfd.38.2023.08.20.13.44.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Aug 2023 13:44:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	imp@bsdimp.com,
	kariem.taha2.7@gmail.com
Subject: [PATCH 1/4] linux-user: Move shmat and shmdt implementations to mmap.c
Date: Sun, 20 Aug 2023 13:44:05 -0700
Message-Id: <20230820204408.327348-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230820204408.327348-1-richard.henderson@linaro.org>
References: <20230820204408.327348-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
index 9353268cc1..df001469eb 100644
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
@@ -11129,11 +10994,11 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
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


