Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1757374D596
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:35:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq5v-000430-Ja; Mon, 10 Jul 2023 08:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq5K-0002kx-7D
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:33:46 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq5I-0004jO-9k
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:33:45 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3a1c162cdfeso3389875b6e.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992422; x=1691584422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=daTrB8dvvdsS+fCR1O2AOiztsnv8EvMR+anEKHWfbCI=;
 b=l8AobLxj1ZJCA5umHbRElVvsxUOj28mstVOUXbwHBpmQOoUlwDvffoAjWu2VDht1+b
 yHM13ODN4aJ7EQiz8BUIWzT+prgMJ4i4Inhq5uRBT2mN0lVgwlk/N1NTC6o+/MN98/Z/
 InIJtUDrMV06DYaael1l5tNtEmUqTRzXnLbz8dOV2JFpukTo+lbH0CGcKD431elQKETj
 dV42zLojoVHp3J/YDzO+cSoxhCAOZ7SoLm9uztUV3B5ayhUvthjlVMICSVbDDPSZUDw5
 aL7579CS3jilOUqjlNjL3UhsLODL1vKOeI/78D7+KlSYuvorhbso9a8nNL0l4k/wVbk1
 Md0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992422; x=1691584422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=daTrB8dvvdsS+fCR1O2AOiztsnv8EvMR+anEKHWfbCI=;
 b=S4De1zmKlx+BPZOZDXvZiA9lMnxJ4RO8MPO/p9OKwuYdhcW6NIt7ddbq12hNcUg4zt
 emx35In+I3u5dIucs+NnSmWf3ejCj5EfDsoH1iFf/WCMILKOpdTg936ecb7tnFAD0MGt
 mdD0AqxokiS4iDNAYeH5X6fH9NBKViNPlvh7kTe/RHWfe3uDIp7JOeuP/Uy7mACnfhw3
 83WV12ZMtzv/oY5mKeXxCQAtRJQj/3N7r7fLzHpHItjpzM57Jt2L4r/uqmT7Z5Agdfot
 VXqfggcxSiK34ap81hpLO+d63lUykBFvJuL3BWEy7RKC5mN8mT9tCWYAP2jjeLBb7nrC
 k4wA==
X-Gm-Message-State: ABy/qLaQvE5uPMMSP18w4EVHHSLRLWDf8DXS4J7jNCXi9gOoTy/hma6n
 GarC+LUO+BVaupSQ5np5FRbXVk4XcqB9mw==
X-Google-Smtp-Source: APBJJlF6EAavbMmCwgbCzS7DdcRNZTLP+ZYrv63k+bVSwXssYtSA0N22vDbrFs51Bmepc+hAUEULWg==
X-Received: by 2002:a05:6808:bd4:b0:38e:a824:27d3 with SMTP id
 o20-20020a0568080bd400b0038ea82427d3mr13966984oik.27.1688992422686; 
 Mon, 10 Jul 2023 05:33:42 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.33.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:33:42 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Robbin Ehn <rehn@rivosinc.com>,
 Palmer Dabbelt <palmer@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 24/54] linux-user/riscv: Add syscall riscv_hwprobe
Date: Mon, 10 Jul 2023 22:31:35 +1000
Message-Id: <20230710123205.2441106-25-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x22e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Robbin Ehn <rehn@rivosinc.com>

This patch adds the new syscall for the
"RISC-V Hardware Probing Interface"
(https://docs.kernel.org/riscv/hwprobe.html).

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Robbin Ehn <rehn@rivosinc.com>
Message-Id: <06a4543df2aa6101ca9a48f21a3198064b4f1f87.camel@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 linux-user/riscv/syscall32_nr.h |   1 +
 linux-user/riscv/syscall64_nr.h |   1 +
 linux-user/syscall.c            | 146 ++++++++++++++++++++++++++++++++
 3 files changed, 148 insertions(+)

diff --git a/linux-user/riscv/syscall32_nr.h b/linux-user/riscv/syscall32_nr.h
index 1327d7dffa..412e58e5b2 100644
--- a/linux-user/riscv/syscall32_nr.h
+++ b/linux-user/riscv/syscall32_nr.h
@@ -228,6 +228,7 @@
 #define TARGET_NR_accept4 242
 #define TARGET_NR_arch_specific_syscall 244
 #define TARGET_NR_riscv_flush_icache (TARGET_NR_arch_specific_syscall + 15)
+#define TARGET_NR_riscv_hwprobe (TARGET_NR_arch_specific_syscall + 14)
 #define TARGET_NR_prlimit64 261
 #define TARGET_NR_fanotify_init 262
 #define TARGET_NR_fanotify_mark 263
diff --git a/linux-user/riscv/syscall64_nr.h b/linux-user/riscv/syscall64_nr.h
index 6659751933..29e1eb2075 100644
--- a/linux-user/riscv/syscall64_nr.h
+++ b/linux-user/riscv/syscall64_nr.h
@@ -251,6 +251,7 @@
 #define TARGET_NR_recvmmsg 243
 #define TARGET_NR_arch_specific_syscall 244
 #define TARGET_NR_riscv_flush_icache (TARGET_NR_arch_specific_syscall + 15)
+#define TARGET_NR_riscv_hwprobe (TARGET_NR_arch_specific_syscall + 14)
 #define TARGET_NR_wait4 260
 #define TARGET_NR_prlimit64 261
 #define TARGET_NR_fanotify_init 262
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9b9e3bd5e3..420bab7c68 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8983,6 +8983,147 @@ static int do_getdents64(abi_long dirfd, abi_long arg2, abi_long count)
 }
 #endif /* TARGET_NR_getdents64 */
 
+#if defined(TARGET_NR_riscv_hwprobe)
+
+#define RISCV_HWPROBE_KEY_MVENDORID     0
+#define RISCV_HWPROBE_KEY_MARCHID       1
+#define RISCV_HWPROBE_KEY_MIMPID        2
+
+#define RISCV_HWPROBE_KEY_BASE_BEHAVIOR 3
+#define     RISCV_HWPROBE_BASE_BEHAVIOR_IMA (1 << 0)
+
+#define RISCV_HWPROBE_KEY_IMA_EXT_0     4
+#define     RISCV_HWPROBE_IMA_FD       (1 << 0)
+#define     RISCV_HWPROBE_IMA_C        (1 << 1)
+
+#define RISCV_HWPROBE_KEY_CPUPERF_0     5
+#define     RISCV_HWPROBE_MISALIGNED_UNKNOWN     (0 << 0)
+#define     RISCV_HWPROBE_MISALIGNED_EMULATED    (1 << 0)
+#define     RISCV_HWPROBE_MISALIGNED_SLOW        (2 << 0)
+#define     RISCV_HWPROBE_MISALIGNED_FAST        (3 << 0)
+#define     RISCV_HWPROBE_MISALIGNED_UNSUPPORTED (4 << 0)
+#define     RISCV_HWPROBE_MISALIGNED_MASK        (7 << 0)
+
+struct riscv_hwprobe {
+    abi_llong  key;
+    abi_ullong value;
+};
+
+static void risc_hwprobe_fill_pairs(CPURISCVState *env,
+                                    struct riscv_hwprobe *pair,
+                                    size_t pair_count)
+{
+    const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
+
+    for (; pair_count > 0; pair_count--, pair++) {
+        abi_llong key;
+        abi_ullong value;
+        __put_user(0, &pair->value);
+        __get_user(key, &pair->key);
+        switch (key) {
+        case RISCV_HWPROBE_KEY_MVENDORID:
+            __put_user(cfg->mvendorid, &pair->value);
+            break;
+        case RISCV_HWPROBE_KEY_MARCHID:
+            __put_user(cfg->marchid, &pair->value);
+            break;
+        case RISCV_HWPROBE_KEY_MIMPID:
+            __put_user(cfg->mimpid, &pair->value);
+            break;
+        case RISCV_HWPROBE_KEY_BASE_BEHAVIOR:
+            value = riscv_has_ext(env, RVI) &&
+                    riscv_has_ext(env, RVM) &&
+                    riscv_has_ext(env, RVA) ?
+                    RISCV_HWPROBE_BASE_BEHAVIOR_IMA : 0;
+            __put_user(value, &pair->value);
+            break;
+        case RISCV_HWPROBE_KEY_IMA_EXT_0:
+            value = riscv_has_ext(env, RVF) &&
+                    riscv_has_ext(env, RVD) ?
+                    RISCV_HWPROBE_IMA_FD : 0;
+            value |= riscv_has_ext(env, RVC) ?
+                     RISCV_HWPROBE_IMA_C : pair->value;
+            __put_user(value, &pair->value);
+            break;
+        case RISCV_HWPROBE_KEY_CPUPERF_0:
+            __put_user(RISCV_HWPROBE_MISALIGNED_FAST, &pair->value);
+            break;
+        default:
+            __put_user(-1, &pair->key);
+            break;
+        }
+    }
+}
+
+static int cpu_set_valid(abi_long arg3, abi_long arg4)
+{
+    int ret, i, tmp;
+    size_t host_mask_size, target_mask_size;
+    unsigned long *host_mask;
+
+    /*
+     * cpu_set_t represent CPU masks as bit masks of type unsigned long *.
+     * arg3 contains the cpu count.
+     */
+    tmp = (8 * sizeof(abi_ulong));
+    target_mask_size = ((arg3 + tmp - 1) / tmp) * sizeof(abi_ulong);
+    host_mask_size = (target_mask_size + (sizeof(*host_mask) - 1)) &
+                     ~(sizeof(*host_mask) - 1);
+
+    host_mask = alloca(host_mask_size);
+
+    ret = target_to_host_cpu_mask(host_mask, host_mask_size,
+                                  arg4, target_mask_size);
+    if (ret != 0) {
+        return ret;
+    }
+
+    for (i = 0 ; i < host_mask_size / sizeof(*host_mask); i++) {
+        if (host_mask[i] != 0) {
+            return 0;
+        }
+    }
+    return -TARGET_EINVAL;
+}
+
+static abi_long do_riscv_hwprobe(CPUArchState *cpu_env, abi_long arg1,
+                                 abi_long arg2, abi_long arg3,
+                                 abi_long arg4, abi_long arg5)
+{
+    int ret;
+    struct riscv_hwprobe *host_pairs;
+
+    /* flags must be 0 */
+    if (arg5 != 0) {
+        return -TARGET_EINVAL;
+    }
+
+    /* check cpu_set */
+    if (arg3 != 0) {
+        ret = cpu_set_valid(arg3, arg4);
+        if (ret != 0) {
+            return ret;
+        }
+    } else if (arg4 != 0) {
+        return -TARGET_EINVAL;
+    }
+
+    /* no pairs */
+    if (arg2 == 0) {
+        return 0;
+    }
+
+    host_pairs = lock_user(VERIFY_WRITE, arg1,
+                           sizeof(*host_pairs) * (size_t)arg2, 0);
+    if (host_pairs == NULL) {
+        return -TARGET_EFAULT;
+    }
+    risc_hwprobe_fill_pairs(cpu_env, host_pairs, arg2);
+    unlock_user(host_pairs, arg1, sizeof(*host_pairs) * (size_t)arg2);
+    return 0;
+}
+#endif /* TARGET_NR_riscv_hwprobe */
+
 #if defined(TARGET_NR_pivot_root) && defined(__NR_pivot_root)
 _syscall2(int, pivot_root, const char *, new_root, const char *, put_old)
 #endif
@@ -13665,6 +13806,11 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         return ret;
 #endif
 
+#if defined(TARGET_NR_riscv_hwprobe)
+    case TARGET_NR_riscv_hwprobe:
+        return do_riscv_hwprobe(cpu_env, arg1, arg2, arg3, arg4, arg5);
+#endif
+
     default:
         qemu_log_mask(LOG_UNIMP, "Unsupported syscall: %d\n", num);
         return -TARGET_ENOSYS;
-- 
2.40.1


