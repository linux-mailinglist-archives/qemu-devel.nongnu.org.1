Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE17274C749
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:39:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZHN-00046Q-4D; Sun, 09 Jul 2023 14:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZHB-0003qL-IA
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:36:53 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZH6-00052D-KR
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:36:51 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fbc1218262so43742485e9.3
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927807; x=1691519807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b9LuMYd95477+OXo1OAWP9AY4NBDJaRVHD5duuyt7VI=;
 b=huI4hDVO5hshjqT2LARath/+I6pZftVoaugSK/rhSxnHRM7zemKSWfocNQ7QB0F/Fm
 B2M1mViDz/zTPzYWeMAJw6VYJ/Fw5cinVVobNvXX57b9TWbBZIuqD8WgQERI6joExRPV
 OzIFrQqXEgb+PJ++Q5pOV0lRkl1zdo+jwM+lfgGTQ/b0b3fFJyWKXSKxmByokj04oO8o
 uDn+2W0m0as8R0Vyzu8OwEWYJBOoHuSBh8WZfTuy7OVjLdVXhsYbUaXrsKn3zmPsLv1n
 2mhWKcPmQq7SZdgHGSk5kWsAVKO1b4sScePvN53SPj3w8P9qo3V4f12D4J0e3AZAehNc
 pTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927807; x=1691519807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b9LuMYd95477+OXo1OAWP9AY4NBDJaRVHD5duuyt7VI=;
 b=ElebTNRLuPF1unNXZvm7C0rtlLBeYx6dYbsydbT8A6X0JF9/9ImAfietUgFGAqHe9q
 no4iTNLS7P1+XE0UEr4IvYlnJiwCF4I3IdsVkm5hdn1tbln5vki9bffcPPKNtOfKUe6z
 YQZfso8TyoMo1IC4SYR88dPd1OKCeUSe9fksIPNDptQw863HsDS6YjC5KzCjEQ8F3Z1w
 Vu76z5baEflb+AOGgheObd18DFPz+l4VxZyL1WdjyugCLVH2jEbDTRb2LUVY2ukTDTfV
 +uXGNtBrK6NMaHhOB/+nfi1pRfju4qRwEsjWiyvz+D+hKlkqJMoebekvWdJ8tRXPwMfJ
 QlsA==
X-Gm-Message-State: ABy/qLYW3YFVzyialv2DC8EYMj9jzhyu3gdHeLrzD53IV1j2VpIXk1AK
 MS4uSj+vUFDYUaHkvEPMFDZYjHNTMxymzSe2WTaAVg==
X-Google-Smtp-Source: APBJJlH3IjDjBzMrOAHXvILToyXeTqnuKSfYW28ngUrdEVti5p2ooXCZpQY7yRYgzUeiit1apS5UkQ==
X-Received: by 2002:a7b:cb8d:0:b0:3fc:b78:fec6 with SMTP id
 m13-20020a7bcb8d000000b003fc0b78fec6mr3007904wmi.7.1688927806941; 
 Sun, 09 Jul 2023 11:36:46 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 i6-20020a5d6306000000b00313de682eb3sm9735832wru.65.2023.07.09.11.36.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:36:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, Robbin Ehn <rehn@rivosinc.com>,
 Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH 45/45] linux-user/riscv: Add syscall riscv_hwprobe
Date: Sun,  9 Jul 2023 19:29:34 +0100
Message-Id: <20230709182934.309468-83-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
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

From: Robbin Ehn <rehn@rivosinc.com>

This patch adds the new syscall for the
"RISC-V Hardware Probing Interface"
(https://docs.kernel.org/riscv/hwprobe.html).

Signed-off-by: Robbin Ehn <rehn@rivosinc.com>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Message-Id: <7f8d733df6e9b6151e9efb843d55441348805e70.camel@rivosinc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
index d2d6cad59d..4e5ccd0886 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8989,6 +8989,147 @@ static int do_getdents64(abi_long dirfd, abi_long arg2, abi_long count)
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
@@ -13671,6 +13812,11 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
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
2.34.1


