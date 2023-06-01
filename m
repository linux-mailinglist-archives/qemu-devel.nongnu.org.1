Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC00719CE4
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 15:04:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4hyB-0007t7-FX; Thu, 01 Jun 2023 09:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rehn@rivosinc.com>) id 1q4hOx-00037i-Qu
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:27:37 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rehn@rivosinc.com>) id 1q4hOu-0001O5-Di
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:27:35 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2af28303127so10535731fa.3
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 05:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1685622450; x=1688214450; 
 h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
 :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=2x3BMEDUK41OCBtbYphWrBFQkdv0f8mJyGbwlWu+rsk=;
 b=uKqs8Fy4Cp2HP66AsdSKyhB7WwJ/6SYQ2XdMVWBnKkiW8QbphEAh797UYPDxDuiXsj
 i8YAsfKlQbUiW7i2KDx6dFBX3rL8HIuR5gj37n5uw/nWyMO8stJgZXfr3fKUbtgLUO5j
 gDdZENXwVM5J7HyOnsaARL4dJxe2u2FcTwSXjOnmRoI9Kr/Nz5SXS/ikJSLRoL7hn+7m
 YBRYPprTUed4YsdLDnPyPjGniSrFLqONgzEVA2gebChu+5f3VrZ8goepSIdic9fOHaiE
 +ji2og+VQNG9jAgl7GbpDZUSXXtduq+giTgJ54A0H6tgfgyAz4m/q5Vuc6ZFz0kVgMKc
 0evQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685622450; x=1688214450;
 h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
 :subject:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2x3BMEDUK41OCBtbYphWrBFQkdv0f8mJyGbwlWu+rsk=;
 b=WdBfGR3pHrGQ0PqrghNAdyQFzbn+tkYWSUvtPUa6ORmDL0dc9yepODZLvlY0UMqOhM
 cTlWwlvR0vt0k5BpCMqaO2CZjVy9P439TbWtsDpAdXLr33rTL3M2ncYOYu6zckhp+HnY
 oEvHc8bDsRt2FKcVoZArGcbBWs2klwaTthjb29h1t6HCyCHNwMCXhooSeQs5FrmODMWt
 a6JUUB9B2jnFpwJQmUcOWwYAecwYHqCy62SbW0w7XklktQhBwGrPg+rLPuLiSa0E638d
 yc6UydannJk4rBYzXwLIF142Uo864JsI8D5i/5Flydv44IM5Jx8pUbJFpBAZeQ3TUqQc
 WOXQ==
X-Gm-Message-State: AC+VfDx89q8xFAA/EcPi1Kgrw6fAJ1GlDlBhL4RDJK5+RtC9hXn4+Pwp
 tG6G+pJ8ABBc1nyF4SKalv73KhhkObm7WDRp6eYZUQ==
X-Google-Smtp-Source: ACHHUZ7y6PLOqa0EsDMRkrL7AqiMvH67xpFytDki20uVmuD4vtlyrkhY2v5zu5fqS4G2zej5bBJqeQ==
X-Received: by 2002:a2e:8881:0:b0:2a8:ea22:28b5 with SMTP id
 k1-20020a2e8881000000b002a8ea2228b5mr4552491lji.4.1685622449642; 
 Thu, 01 Jun 2023 05:27:29 -0700 (PDT)
Received: from [192.168.50.45] (h-155-4-92-80.A980.priv.bahnhof.se.
 [155.4.92.80]) by smtp.gmail.com with ESMTPSA id
 e20-20020a2e8ed4000000b002a9ee18e9c7sm3596529ljl.69.2023.06.01.05.27.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 05:27:29 -0700 (PDT)
Message-ID: <964faef7016042962e3002b328a80c239f8de962.camel@rivosinc.com>
Subject: [RFC] linux-user/riscv: Add syscall riscv_hwprobe
From: Robbin Ehn <rehn@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Date: Thu, 01 Jun 2023 14:27:28 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=rehn@rivosinc.com; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 01 Jun 2023 09:03:57 -0400
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

This patch adds the new syscall for the
"RISC-V Hardware Probing Interface"
(https://docs.kernel.org/riscv/hwprobe.html).

Signed-off-by: Robbin Ehn <rehn@rivosinc.com>
---
 linux-headers/asm-riscv/unistd.h |   9 +++
 linux-user/riscv/cpu_loop.c      | 119 ++++++++++++++++++++++++++++++-
 linux-user/riscv/syscall32_nr.h  |   1 +
 linux-user/riscv/syscall64_nr.h  |   1 +
 4 files changed, 129 insertions(+), 1 deletion(-)

diff --git a/linux-headers/asm-riscv/unistd.h b/linux-headers/asm-riscv/uni=
std.h
index 73d7cdd2ec..950ab3fd44 100644
--- a/linux-headers/asm-riscv/unistd.h
+++ b/linux-headers/asm-riscv/unistd.h
@@ -43,3 +43,12 @@
 #define __NR_riscv_flush_icache (__NR_arch_specific_syscall + 15)
 #endif
 __SYSCALL(__NR_riscv_flush_icache, sys_riscv_flush_icache)
+
+/*
+ * Allows userspace to query the kernel for CPU architecture and
+ * microarchitecture details across a given set of CPUs.
+ */
+#ifndef __NR_riscv_hwprobe
+#define __NR_riscv_hwprobe (__NR_arch_specific_syscall + 14)
+#endif
+__SYSCALL(__NR_riscv_hwprobe, sys_riscv_hwprobe)
diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
index bffca7db12..5207739185 100644
--- a/linux-user/riscv/cpu_loop.c
+++ b/linux-user/riscv/cpu_loop.c
@@ -26,6 +26,117 @@
 #include "elf.h"
 #include "semihosting/common-semi.h"
=20
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
+    int64_t  key;
+    uint64_t value;
+};
+
+static void hwprobe_one_pair(CPURISCVState *env, struct riscv_hwprobe *pai=
r)
+{
+    const RISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);
+
+    pair->value =3D 0;
+
+    switch (pair->key) {
+    case RISCV_HWPROBE_KEY_MVENDORID:
+        pair->value =3D cfg->mvendorid;
+        break;
+    case RISCV_HWPROBE_KEY_MARCHID:
+        pair->value =3D cfg->marchid;
+        break;
+    case RISCV_HWPROBE_KEY_MIMPID:
+        pair->value =3D cfg->mimpid;
+        break;
+    case RISCV_HWPROBE_KEY_BASE_BEHAVIOR:
+        pair->value =3D riscv_has_ext(env, RVI) &&
+                      riscv_has_ext(env, RVM) &&
+                      riscv_has_ext(env, RVA) ?
+                      RISCV_HWPROBE_BASE_BEHAVIOR_IMA : 0;
+        break;
+    case RISCV_HWPROBE_KEY_IMA_EXT_0:
+        pair->value =3D riscv_has_ext(env, RVF) &&
+                      riscv_has_ext(env, RVD) ?
+                      RISCV_HWPROBE_IMA_FD : 0;
+        pair->value |=3D riscv_has_ext(env, RVC) ?
+                       RISCV_HWPROBE_IMA_C : pair->value;
+        break;
+    case RISCV_HWPROBE_KEY_CPUPERF_0:
+        pair->value =3D RISCV_HWPROBE_MISALIGNED_UNKNOWN;
+        break;
+    default:
+        pair->key =3D -1;
+    break;
+    }
+}
+
+static long sys_riscv_hwprobe(CPURISCVState *env,
+                              abi_ulong user_pairs,
+                              size_t pair_count,
+                              size_t cpu_count,
+                              abi_ulong user_cpus,
+                              unsigned int flags)
+{
+    struct riscv_hwprobe *host_pairs;
+    cpu_set_t *host_cpus =3D NULL;
+    size_t cpu_setsize =3D 0;
+
+    /* flags must be 0 */
+    if (flags !=3D 0) {
+        return 1
+    };
+
+    /* inconsistence cpu_set */
+    if (cpu_count !=3D 0 && user_cpus =3D=3D 0) {
+        return 1;
+    }
+
+    host_pairs =3D lock_user(VERIFY_WRITE, user_pairs,
+                           sizeof(*host_pairs) * pair_count, 0);
+
+    if (host_pairs =3D=3D NULL) {
+        return 1;
+    }
+
+    if (user_cpus !=3D 0) {
+        cpu_setsize =3D CPU_ALLOC_SIZE(user_cpus);
+        host_cpus =3D lock_user(VERIFY_READ, user_cpus, cpu_setsize, 0);
+    }
+
+    /* cpuset is ignored, symmetric CPUs in qemu */
+
+    for (struct riscv_hwprobe *ipairs =3D host_pairs;
+         pair_count > 0;
+         pair_count--, ipairs++) {
+        hwprobe_one_pair(env, ipairs);
+    }
+
+    if (host_cpus !=3D 0) {
+        unlock_user(host_cpus, user_cpus, cpu_setsize);
+    }
+
+    unlock_user(host_pairs, user_pairs, sizeof(*host_pairs) * pair_count);
+    return 0;
+};
+
 void cpu_loop(CPURISCVState *env)
 {
     CPUState *cs =3D env_cpu(env);
@@ -47,7 +158,13 @@ void cpu_loop(CPURISCVState *env)
             break;
         case RISCV_EXCP_U_ECALL:
             env->pc +=3D 4;
-            if (env->gpr[xA7] =3D=3D TARGET_NR_arch_specific_syscall + 15)=
 {
+            if (env->gpr[xA7] =3D=3D TARGET_NR_arch_specific_syscall + 14)=
 {
+                /* riscv_hwprobe */
+                ret =3D sys_riscv_hwprobe(env,
+                                        env->gpr[xA0], env->gpr[xA1],
+                                        env->gpr[xA2], env->gpr[xA3],
+                                        env->gpr[xA4]);
+            } else if (env->gpr[xA7] =3D=3D TARGET_NR_arch_specific_syscal=
l + 15) {
                 /* riscv_flush_icache_syscall is a no-op in QEMU as
                    self-modifying code is automatically detected */
                 ret =3D 0;
diff --git a/linux-user/riscv/syscall32_nr.h b/linux-user/riscv/syscall32_n=
r.h
index 1327d7dffa..412e58e5b2 100644
--- a/linux-user/riscv/syscall32_nr.h
+++ b/linux-user/riscv/syscall32_nr.h
@@ -228,6 +228,7 @@
 #define TARGET_NR_accept4 242
 #define TARGET_NR_arch_specific_syscall 244
 #define TARGET_NR_riscv_flush_icache (TARGET_NR_arch_specific_syscall + 15=
)
+#define TARGET_NR_riscv_hwprobe (TARGET_NR_arch_specific_syscall + 14)
 #define TARGET_NR_prlimit64 261
 #define TARGET_NR_fanotify_init 262
 #define TARGET_NR_fanotify_mark 263
diff --git a/linux-user/riscv/syscall64_nr.h b/linux-user/riscv/syscall64_n=
r.h
index 6659751933..29e1eb2075 100644
--- a/linux-user/riscv/syscall64_nr.h
+++ b/linux-user/riscv/syscall64_nr.h
@@ -251,6 +251,7 @@
 #define TARGET_NR_recvmmsg 243
 #define TARGET_NR_arch_specific_syscall 244
 #define TARGET_NR_riscv_flush_icache (TARGET_NR_arch_specific_syscall + 15=
)
+#define TARGET_NR_riscv_hwprobe (TARGET_NR_arch_specific_syscall + 14)
 #define TARGET_NR_wait4 260
 #define TARGET_NR_prlimit64 261
 #define TARGET_NR_fanotify_init 262
--=20
2.39.2


