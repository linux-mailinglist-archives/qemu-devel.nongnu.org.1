Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3AB7902E6
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 22:43:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcAzB-00071M-UD; Fri, 01 Sep 2023 16:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qcAyq-0006wv-1W
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 16:43:00 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qcAyl-0001wi-U3
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 16:42:59 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-68c0d262933so2072876b3a.0
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 13:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693600974; x=1694205774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HN9bdDKpCXsqx9IM4u0+R/+OpGOMVkY0zwFC+KcDdss=;
 b=i7b0PwzJAd7ZeLiweZG3er6WuQwE5Td7xg9zK3tNFktCUWwVCSMG6IBGcLNS3LyTGP
 Wn+XkIWCczqOrJo9LoTJ10ugss9ukkZr8d12hqJMZfra8d3dnP3OhEZOvLqKyosbZsFV
 OFhAuMN00Rs0ZpRAI5VYoy20LZ4T7KNuTwKPYXQ+wjk/rAWsTmgXzTDSzRBzNzm4Gu8U
 heuYmf6koXdbOasuw9SaxgKxVYOCz6wwAqUU9GVuRGBu6cWOQjXPyJdzkMdOM3rG24yB
 cNX+xDA7bfomqmpy/SnZJ+iNGzwVBKx/kTbKGW6IlPsmaiBqvBDZKeymnarPnvQWw1F/
 de6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693600974; x=1694205774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HN9bdDKpCXsqx9IM4u0+R/+OpGOMVkY0zwFC+KcDdss=;
 b=PVqmgyjrBDWjie9/H73krnOnLbdlp78BNaPZxjBzNG+0mTfcOS0G6HradHcHKJerFi
 L3fviSOnheCQnRXZDQVCJ6ZLJdcrSCE0BpD0PBmtGt12zPRNWuNbCJLHKl2nWIQTAQqn
 4cSlrlBdTUJmnv26cp638YHbvr03sUaNjAnZGZeUMnlfcO8Ej39f7mDM8/K8xJYTz/ES
 6fM6AtAiMOJJA6cfS/hc0jRx5GqZOP3e3X6mQ+OZXvjPC+80WEwWL4Ey0ntYa6RSQuyZ
 eF+//P+tvm3yRn5zoD8/O9NA+YsLVk4YIIL4tEwOXLcXJSnm+P0CR4TRWVWXO50dzp7c
 KOTw==
X-Gm-Message-State: AOJu0YyVAkmk3jY7vo6TYEvGjJ1IKfbuNS5QibEujHavmB2KuQVQCyJH
 sjeLEiaOr0AwTW4L4RbDAwqDCaFP9VaUNDNZPH8=
X-Google-Smtp-Source: AGHT+IFTVmOAAiXLgMozC39CZm79BhemktokayZtDKBpXGCyBkfguTgNLqaB+3mYjMVdjkq/tqPHDQ==
X-Received: by 2002:a05:6a21:7746:b0:138:60e:9bb with SMTP id
 bc6-20020a056a21774600b00138060e09bbmr3623655pzc.28.1693600974411; 
 Fri, 01 Sep 2023 13:42:54 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j15-20020aa78d0f000000b0068c97a4eb0dsm3320666pfe.191.2023.09.01.13.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 13:42:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 02/13] linux-user: Emulate /proc/cpuinfo on aarch64 and arm
Date: Fri,  1 Sep 2023 13:42:40 -0700
Message-Id: <20230901204251.137307-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901204251.137307-1-richard.henderson@linaro.org>
References: <20230901204251.137307-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

From: Helge Deller <deller@gmx.de>

Add emulation for /proc/cpuinfo for arm architecture.
The output below mimics output as seen on debian porterboxes.

aarch64 output example:

processor       : 0
model name      : ARMv8 Processor rev 0 (v8l)
BogoMIPS        : 100.00
Features        : swp half thumb fast_mult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae aes pmull sha1 sha2 crc32
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x1
CPU part        : 0xd07
CPU revision    : 0

arm 32-bit output example:

processor	: 0
model name	: ARMv7 Processor rev 5 (armv7l)
BogoMIPS	: 100.00
Features	: swp half thumb fast_mult vfp edsp thumbee neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae
CPU implementer	: 0x41
CPU architecture: 7
CPU variant	: 0x0f
CPU part	: 0xc07
CPU revision	: 5

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230803214450.647040-3-deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/target_proc.h |   2 +-
 linux-user/arm/target_proc.h     | 102 +++++++++++++++++++++++-
 linux-user/loader.h              |   6 +-
 linux-user/elfload.c             | 130 ++++++++++++++++++++++++++++++-
 4 files changed, 233 insertions(+), 7 deletions(-)

diff --git a/linux-user/aarch64/target_proc.h b/linux-user/aarch64/target_proc.h
index 43fe29ca72..907df4dcd2 100644
--- a/linux-user/aarch64/target_proc.h
+++ b/linux-user/aarch64/target_proc.h
@@ -1 +1 @@
-/* No target-specific /proc support */
+#include "../arm/target_proc.h"
diff --git a/linux-user/arm/target_proc.h b/linux-user/arm/target_proc.h
index 43fe29ca72..ac75af9ca6 100644
--- a/linux-user/arm/target_proc.h
+++ b/linux-user/arm/target_proc.h
@@ -1 +1,101 @@
-/* No target-specific /proc support */
+/*
+ * Arm specific proc functions for linux-user
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef ARM_TARGET_PROC_H
+#define ARM_TARGET_PROC_H
+
+static int open_cpuinfo(CPUArchState *cpu_env, int fd)
+{
+    ARMCPU *cpu = env_archcpu(cpu_env);
+    int arch, midr_rev, midr_part, midr_var, midr_impl;
+    target_ulong elf_hwcap = get_elf_hwcap();
+    target_ulong elf_hwcap2 = get_elf_hwcap2();
+    const char *elf_name;
+    int num_cpus, len_part, len_var;
+
+#if TARGET_BIG_ENDIAN
+# define END_SUFFIX "b"
+#else
+# define END_SUFFIX "l"
+#endif
+
+    arch = 8;
+    elf_name = "v8" END_SUFFIX;
+    midr_rev = FIELD_EX32(cpu->midr, MIDR_EL1, REVISION);
+    midr_part = FIELD_EX32(cpu->midr, MIDR_EL1, PARTNUM);
+    midr_var = FIELD_EX32(cpu->midr, MIDR_EL1, VARIANT);
+    midr_impl = FIELD_EX32(cpu->midr, MIDR_EL1, IMPLEMENTER);
+    len_part = 3;
+    len_var = 1;
+
+#ifndef TARGET_AARCH64
+    /* For simplicity, treat ARMv8 as an arm64 kernel with CONFIG_COMPAT. */
+    if (!arm_feature(&cpu->env, ARM_FEATURE_V8)) {
+        if (arm_feature(&cpu->env, ARM_FEATURE_V7)) {
+            arch = 7;
+            midr_var = (cpu->midr >> 16) & 0x7f;
+            len_var = 2;
+            if (arm_feature(&cpu->env, ARM_FEATURE_M)) {
+                elf_name = "armv7m" END_SUFFIX;
+            } else {
+                elf_name = "armv7" END_SUFFIX;
+            }
+        } else {
+            midr_part = cpu->midr >> 4;
+            len_part = 7;
+            if (arm_feature(&cpu->env, ARM_FEATURE_V6)) {
+                arch = 6;
+                elf_name = "armv6" END_SUFFIX;
+            } else if (arm_feature(&cpu->env, ARM_FEATURE_V5)) {
+                arch = 5;
+                elf_name = "armv5t" END_SUFFIX;
+            } else {
+                arch = 4;
+                elf_name = "armv4" END_SUFFIX;
+            }
+        }
+    }
+#endif
+
+#undef END_SUFFIX
+
+    num_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+    for (int i = 0; i < num_cpus; i++) {
+        dprintf(fd,
+                "processor\t: %d\n"
+                "model name\t: ARMv%d Processor rev %d (%s)\n"
+                "BogoMIPS\t: 100.00\n"
+                "Features\t:",
+                i, arch, midr_rev, elf_name);
+
+        for (target_ulong j = elf_hwcap; j ; j &= j - 1) {
+            dprintf(fd, " %s", elf_hwcap_str(ctz64(j)));
+        }
+        for (target_ulong j = elf_hwcap2; j ; j &= j - 1) {
+            dprintf(fd, " %s", elf_hwcap2_str(ctz64(j)));
+        }
+
+        dprintf(fd, "\n"
+                "CPU implementer\t: 0x%02x\n"
+                "CPU architecture: %d\n"
+                "CPU variant\t: 0x%0*x\n",
+                midr_impl, arch, len_var, midr_var);
+        if (arch >= 7) {
+            dprintf(fd, "CPU part\t: 0x%0*x\n", len_part, midr_part);
+        }
+        dprintf(fd, "CPU revision\t: %d\n\n", midr_rev);
+    }
+
+    if (arch < 8) {
+        dprintf(fd, "Hardware\t: QEMU v%s %s\n", QEMU_VERSION,
+                cpu->dtb_compatible ? : "");
+        dprintf(fd, "Revision\t: 0000\n");
+        dprintf(fd, "Serial\t\t: 0000000000000000\n");
+    }
+    return 0;
+}
+#define HAVE_ARCH_PROC_CPUINFO
+
+#endif /* ARM_TARGET_PROC_H */
diff --git a/linux-user/loader.h b/linux-user/loader.h
index 59cbeacf24..324e5c872a 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -56,9 +56,13 @@ abi_long memcpy_to_target(abi_ulong dest, const void *src,
 
 extern unsigned long guest_stack_size;
 
-#ifdef TARGET_S390X
+#if defined(TARGET_S390X) || defined(TARGET_AARCH64) || defined(TARGET_ARM)
 uint32_t get_elf_hwcap(void);
 const char *elf_hwcap_str(uint32_t bit);
 #endif
+#if defined(TARGET_AARCH64) || defined(TARGET_ARM)
+uint32_t get_elf_hwcap2(void);
+const char *elf_hwcap2_str(uint32_t bit);
+#endif
 
 #endif /* LINUX_USER_LOADER_H */
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 92b981c445..7c95098e3e 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -466,7 +466,7 @@ static bool init_guest_commpage(void)
 #define ELF_HWCAP get_elf_hwcap()
 #define ELF_HWCAP2 get_elf_hwcap2()
 
-static uint32_t get_elf_hwcap(void)
+uint32_t get_elf_hwcap(void)
 {
     ARMCPU *cpu = ARM_CPU(thread_cpu);
     uint32_t hwcaps = 0;
@@ -508,7 +508,7 @@ static uint32_t get_elf_hwcap(void)
     return hwcaps;
 }
 
-static uint32_t get_elf_hwcap2(void)
+uint32_t get_elf_hwcap2(void)
 {
     ARMCPU *cpu = ARM_CPU(thread_cpu);
     uint32_t hwcaps = 0;
@@ -521,6 +521,49 @@ static uint32_t get_elf_hwcap2(void)
     return hwcaps;
 }
 
+const char *elf_hwcap_str(uint32_t bit)
+{
+    static const char *hwcap_str[] = {
+    [__builtin_ctz(ARM_HWCAP_ARM_SWP      )] = "swp",
+    [__builtin_ctz(ARM_HWCAP_ARM_HALF     )] = "half",
+    [__builtin_ctz(ARM_HWCAP_ARM_THUMB    )] = "thumb",
+    [__builtin_ctz(ARM_HWCAP_ARM_26BIT    )] = "26bit",
+    [__builtin_ctz(ARM_HWCAP_ARM_FAST_MULT)] = "fast_mult",
+    [__builtin_ctz(ARM_HWCAP_ARM_FPA      )] = "fpa",
+    [__builtin_ctz(ARM_HWCAP_ARM_VFP      )] = "vfp",
+    [__builtin_ctz(ARM_HWCAP_ARM_EDSP     )] = "edsp",
+    [__builtin_ctz(ARM_HWCAP_ARM_JAVA     )] = "java",
+    [__builtin_ctz(ARM_HWCAP_ARM_IWMMXT   )] = "iwmmxt",
+    [__builtin_ctz(ARM_HWCAP_ARM_CRUNCH   )] = "crunch",
+    [__builtin_ctz(ARM_HWCAP_ARM_THUMBEE  )] = "thumbee",
+    [__builtin_ctz(ARM_HWCAP_ARM_NEON     )] = "neon",
+    [__builtin_ctz(ARM_HWCAP_ARM_VFPv3    )] = "vfpv3",
+    [__builtin_ctz(ARM_HWCAP_ARM_VFPv3D16 )] = "vfpv3d16",
+    [__builtin_ctz(ARM_HWCAP_ARM_TLS      )] = "tls",
+    [__builtin_ctz(ARM_HWCAP_ARM_VFPv4    )] = "vfpv4",
+    [__builtin_ctz(ARM_HWCAP_ARM_IDIVA    )] = "idiva",
+    [__builtin_ctz(ARM_HWCAP_ARM_IDIVT    )] = "idivt",
+    [__builtin_ctz(ARM_HWCAP_ARM_VFPD32   )] = "vfpd32",
+    [__builtin_ctz(ARM_HWCAP_ARM_LPAE     )] = "lpae",
+    [__builtin_ctz(ARM_HWCAP_ARM_EVTSTRM  )] = "evtstrm",
+    };
+
+    return bit < ARRAY_SIZE(hwcap_str) ? hwcap_str[bit] : NULL;
+}
+
+const char *elf_hwcap2_str(uint32_t bit)
+{
+    static const char *hwcap_str[] = {
+    [__builtin_ctz(ARM_HWCAP2_ARM_AES  )] = "aes",
+    [__builtin_ctz(ARM_HWCAP2_ARM_PMULL)] = "pmull",
+    [__builtin_ctz(ARM_HWCAP2_ARM_SHA1 )] = "sha1",
+    [__builtin_ctz(ARM_HWCAP2_ARM_SHA2 )] = "sha2",
+    [__builtin_ctz(ARM_HWCAP2_ARM_CRC32)] = "crc32",
+    };
+
+    return bit < ARRAY_SIZE(hwcap_str) ? hwcap_str[bit] : NULL;
+}
+
 #undef GET_FEATURE
 #undef GET_FEATURE_ID
 
@@ -668,7 +711,7 @@ enum {
 #define GET_FEATURE_ID(feat, hwcap) \
     do { if (cpu_isar_feature(feat, cpu)) { hwcaps |= hwcap; } } while (0)
 
-static uint32_t get_elf_hwcap(void)
+uint32_t get_elf_hwcap(void)
 {
     ARMCPU *cpu = ARM_CPU(thread_cpu);
     uint32_t hwcaps = 0;
@@ -706,7 +749,7 @@ static uint32_t get_elf_hwcap(void)
     return hwcaps;
 }
 
-static uint32_t get_elf_hwcap2(void)
+uint32_t get_elf_hwcap2(void)
 {
     ARMCPU *cpu = ARM_CPU(thread_cpu);
     uint32_t hwcaps = 0;
@@ -741,6 +784,85 @@ static uint32_t get_elf_hwcap2(void)
     return hwcaps;
 }
 
+const char *elf_hwcap_str(uint32_t bit)
+{
+    static const char *hwcap_str[] = {
+    [__builtin_ctz(ARM_HWCAP_A64_FP      )] = "fp",
+    [__builtin_ctz(ARM_HWCAP_A64_ASIMD   )] = "asimd",
+    [__builtin_ctz(ARM_HWCAP_A64_EVTSTRM )] = "evtstrm",
+    [__builtin_ctz(ARM_HWCAP_A64_AES     )] = "aes",
+    [__builtin_ctz(ARM_HWCAP_A64_PMULL   )] = "pmull",
+    [__builtin_ctz(ARM_HWCAP_A64_SHA1    )] = "sha1",
+    [__builtin_ctz(ARM_HWCAP_A64_SHA2    )] = "sha2",
+    [__builtin_ctz(ARM_HWCAP_A64_CRC32   )] = "crc32",
+    [__builtin_ctz(ARM_HWCAP_A64_ATOMICS )] = "atomics",
+    [__builtin_ctz(ARM_HWCAP_A64_FPHP    )] = "fphp",
+    [__builtin_ctz(ARM_HWCAP_A64_ASIMDHP )] = "asimdhp",
+    [__builtin_ctz(ARM_HWCAP_A64_CPUID   )] = "cpuid",
+    [__builtin_ctz(ARM_HWCAP_A64_ASIMDRDM)] = "asimdrdm",
+    [__builtin_ctz(ARM_HWCAP_A64_JSCVT   )] = "jscvt",
+    [__builtin_ctz(ARM_HWCAP_A64_FCMA    )] = "fcma",
+    [__builtin_ctz(ARM_HWCAP_A64_LRCPC   )] = "lrcpc",
+    [__builtin_ctz(ARM_HWCAP_A64_DCPOP   )] = "dcpop",
+    [__builtin_ctz(ARM_HWCAP_A64_SHA3    )] = "sha3",
+    [__builtin_ctz(ARM_HWCAP_A64_SM3     )] = "sm3",
+    [__builtin_ctz(ARM_HWCAP_A64_SM4     )] = "sm4",
+    [__builtin_ctz(ARM_HWCAP_A64_ASIMDDP )] = "asimddp",
+    [__builtin_ctz(ARM_HWCAP_A64_SHA512  )] = "sha512",
+    [__builtin_ctz(ARM_HWCAP_A64_SVE     )] = "sve",
+    [__builtin_ctz(ARM_HWCAP_A64_ASIMDFHM)] = "asimdfhm",
+    [__builtin_ctz(ARM_HWCAP_A64_DIT     )] = "dit",
+    [__builtin_ctz(ARM_HWCAP_A64_USCAT   )] = "uscat",
+    [__builtin_ctz(ARM_HWCAP_A64_ILRCPC  )] = "ilrcpc",
+    [__builtin_ctz(ARM_HWCAP_A64_FLAGM   )] = "flagm",
+    [__builtin_ctz(ARM_HWCAP_A64_SSBS    )] = "ssbs",
+    [__builtin_ctz(ARM_HWCAP_A64_SB      )] = "sb",
+    [__builtin_ctz(ARM_HWCAP_A64_PACA    )] = "paca",
+    [__builtin_ctz(ARM_HWCAP_A64_PACG    )] = "pacg",
+    };
+
+    return bit < ARRAY_SIZE(hwcap_str) ? hwcap_str[bit] : NULL;
+}
+
+const char *elf_hwcap2_str(uint32_t bit)
+{
+    static const char *hwcap_str[] = {
+    [__builtin_ctz(ARM_HWCAP2_A64_DCPODP       )] = "dcpodp",
+    [__builtin_ctz(ARM_HWCAP2_A64_SVE2         )] = "sve2",
+    [__builtin_ctz(ARM_HWCAP2_A64_SVEAES       )] = "sveaes",
+    [__builtin_ctz(ARM_HWCAP2_A64_SVEPMULL     )] = "svepmull",
+    [__builtin_ctz(ARM_HWCAP2_A64_SVEBITPERM   )] = "svebitperm",
+    [__builtin_ctz(ARM_HWCAP2_A64_SVESHA3      )] = "svesha3",
+    [__builtin_ctz(ARM_HWCAP2_A64_SVESM4       )] = "svesm4",
+    [__builtin_ctz(ARM_HWCAP2_A64_FLAGM2       )] = "flagm2",
+    [__builtin_ctz(ARM_HWCAP2_A64_FRINT        )] = "frint",
+    [__builtin_ctz(ARM_HWCAP2_A64_SVEI8MM      )] = "svei8mm",
+    [__builtin_ctz(ARM_HWCAP2_A64_SVEF32MM     )] = "svef32mm",
+    [__builtin_ctz(ARM_HWCAP2_A64_SVEF64MM     )] = "svef64mm",
+    [__builtin_ctz(ARM_HWCAP2_A64_SVEBF16      )] = "svebf16",
+    [__builtin_ctz(ARM_HWCAP2_A64_I8MM         )] = "i8mm",
+    [__builtin_ctz(ARM_HWCAP2_A64_BF16         )] = "bf16",
+    [__builtin_ctz(ARM_HWCAP2_A64_DGH          )] = "dgh",
+    [__builtin_ctz(ARM_HWCAP2_A64_RNG          )] = "rng",
+    [__builtin_ctz(ARM_HWCAP2_A64_BTI          )] = "bti",
+    [__builtin_ctz(ARM_HWCAP2_A64_MTE          )] = "mte",
+    [__builtin_ctz(ARM_HWCAP2_A64_ECV          )] = "ecv",
+    [__builtin_ctz(ARM_HWCAP2_A64_AFP          )] = "afp",
+    [__builtin_ctz(ARM_HWCAP2_A64_RPRES        )] = "rpres",
+    [__builtin_ctz(ARM_HWCAP2_A64_MTE3         )] = "mte3",
+    [__builtin_ctz(ARM_HWCAP2_A64_SME          )] = "sme",
+    [__builtin_ctz(ARM_HWCAP2_A64_SME_I16I64   )] = "sme_i16i64",
+    [__builtin_ctz(ARM_HWCAP2_A64_SME_F64F64   )] = "sme_f64f64",
+    [__builtin_ctz(ARM_HWCAP2_A64_SME_I8I32    )] = "sme_i8i32",
+    [__builtin_ctz(ARM_HWCAP2_A64_SME_F16F32   )] = "sme_f16f32",
+    [__builtin_ctz(ARM_HWCAP2_A64_SME_B16F32   )] = "sme_b16f32",
+    [__builtin_ctz(ARM_HWCAP2_A64_SME_F32F32   )] = "sme_f32f32",
+    [__builtin_ctz(ARM_HWCAP2_A64_SME_FA64     )] = "sme_fa64",
+    };
+
+    return bit < ARRAY_SIZE(hwcap_str) ? hwcap_str[bit] : NULL;
+}
+
 #undef GET_FEATURE_ID
 
 #endif /* not TARGET_AARCH64 */
-- 
2.34.1


