Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FC8772B3F
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 18:40:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT3EX-0007MP-9r; Mon, 07 Aug 2023 12:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT3EH-00072t-CB
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:37:14 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT3EF-0002gJ-4u
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:37:13 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1b8b4748fe4so30495325ad.1
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 09:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691426229; x=1692031029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YQiLPVCfyeMX/HaaqqWD824ZzDbo71gJMZBplamcMFg=;
 b=JA26p7Yve1850Z5Nu90y1TEL4FQajHlGbJYBRs432wn8oJR4BG/gUn5TtAep0T0A2r
 r+JcVFvLKCOryKqccL4slnUr9pcMOc7zNGoP3U7LgoLPwvBrUA44osLiYFTsYkWuEpKV
 gKwNPua328QhF/g9HxNT3S4qgjY9dCN/kQ5mse06g2e6ygi00s2LTvoEVg6oCtGoII6+
 GPEJXi9SIO3bs4r7XIcTlwWwrlcl0qrKtbj2d4i7QvioL49rj1rjeWh3bDF1bSuaWGqn
 mgV1aV+2Xi3qa68Ioi2IBXsBtFVepzfqPiG/FO2pOZkYvLKHr5cpvq1WCKkmq/lVv5Ik
 5V8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691426229; x=1692031029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YQiLPVCfyeMX/HaaqqWD824ZzDbo71gJMZBplamcMFg=;
 b=UYScA77E7oXlQZJLRLb0A10sspRghTvo4A4xgaShgQE4DoEwmQ5Y2LA0YTXOqerUmP
 M8DeZ5wLlc+wKEIX2l78uFGTp/dqMKU6PYJZeGa6PtDYLAdhkgPlvcFBzJ1sia+INYQx
 4xt/JDhfPdd31G9DHPnU3WA/6KjECMHAntC0z0nPmhg+ZPSvSPkSI0nbEOl2Sv4bDsrO
 ZTLOhqpCqfh6tVX4ITJEEwqzLZAw6RnoBcVz4f+1ZT893Bzes+51+v+OziBXMbYgKPPz
 NSkbygDq2gXftya9yLJJbofHrvSRmBYPH4UGX8B8qQxQzetsD9aLaq1xzzugknavlcbA
 RC/A==
X-Gm-Message-State: AOJu0Yzd6/l/aMcG6MiTVzSNAGb+nU4MyTLf5y0tzdn02jHzFMzBRtK3
 r1KTU+L4KbDOwI5gJosbdTcT5uh61dgADiHZZXY=
X-Google-Smtp-Source: AGHT+IFeiaz+6EyYbhv7GMJcX8m0h9jeqtbbbTghEB1rCoYy6CCRAHWZRXhzDBtCIsNNGK1Xn1CxVQ==
X-Received: by 2002:a17:902:f691:b0:1b6:bced:1dc2 with SMTP id
 l17-20020a170902f69100b001b6bced1dc2mr9833518plg.0.1691426229581; 
 Mon, 07 Aug 2023 09:37:09 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a170902d34600b001b9df8f14d7sm7119837plk.267.2023.08.07.09.37.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 09:37:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org, laurent@vivier.eu, deller@gmx.de
Subject: [PATCH for-8.1 v10 03/14] linux-user: Define ELF_ET_DYN_BASE in
 $guest/target_mman.h
Date: Mon,  7 Aug 2023 09:36:54 -0700
Message-Id: <20230807163705.9848-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807163705.9848-1-richard.henderson@linaro.org>
References: <20230807163705.9848-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Copy each guest kernel's default value, then bound it
against reserved_va or the host address space.

Tested-by: Helge Deller <deller@gmx.de>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/target_mman.h     |  3 +++
 linux-user/alpha/target_mman.h       |  3 +++
 linux-user/arm/target_mman.h         |  3 +++
 linux-user/cris/target_mman.h        |  3 +++
 linux-user/hexagon/target_mman.h     |  3 +++
 linux-user/hppa/target_mman.h        |  3 +++
 linux-user/i386/target_mman.h        |  3 +++
 linux-user/loongarch64/target_mman.h |  3 +++
 linux-user/m68k/target_mman.h        |  2 ++
 linux-user/microblaze/target_mman.h  |  3 +++
 linux-user/mips/target_mman.h        |  3 +++
 linux-user/nios2/target_mman.h       |  3 +++
 linux-user/openrisc/target_mman.h    |  3 +++
 linux-user/ppc/target_mman.h         |  7 +++++++
 linux-user/riscv/target_mman.h       |  3 +++
 linux-user/s390x/target_mman.h       | 10 ++++++++++
 linux-user/sh4/target_mman.h         |  3 +++
 linux-user/sparc/target_mman.h       | 11 +++++++++++
 linux-user/user-mmap.h               |  1 +
 linux-user/x86_64/target_mman.h      |  3 +++
 linux-user/xtensa/target_mman.h      |  4 ++++
 linux-user/main.c                    | 15 +++++++++++++++
 linux-user/mmap.c                    |  1 +
 23 files changed, 96 insertions(+)

diff --git a/linux-user/aarch64/target_mman.h b/linux-user/aarch64/target_mman.h
index 4d3eecfb26..69ec5d5739 100644
--- a/linux-user/aarch64/target_mman.h
+++ b/linux-user/aarch64/target_mman.h
@@ -14,6 +14,9 @@
  */
 #define TASK_UNMAPPED_BASE      (1ull << (48 - 2))
 
+/* arch/arm64/include/asm/elf.h */
+#define ELF_ET_DYN_BASE         TARGET_PAGE_ALIGN((1ull << 48) / 3 * 2)
+
 #include "../generic/target_mman.h"
 
 #endif
diff --git a/linux-user/alpha/target_mman.h b/linux-user/alpha/target_mman.h
index c90b493711..8edfe2b88c 100644
--- a/linux-user/alpha/target_mman.h
+++ b/linux-user/alpha/target_mman.h
@@ -28,6 +28,9 @@
  */
 #define TASK_UNMAPPED_BASE      0x20000000000ull
 
+/* arch/alpha/include/asm/elf.h */
+#define ELF_ET_DYN_BASE         (TASK_UNMAPPED_BASE + 0x1000000)
+
 #include "../generic/target_mman.h"
 
 #endif
diff --git a/linux-user/arm/target_mman.h b/linux-user/arm/target_mman.h
index 76275b2c7e..51005da869 100644
--- a/linux-user/arm/target_mman.h
+++ b/linux-user/arm/target_mman.h
@@ -6,4 +6,7 @@
  */
 #define TASK_UNMAPPED_BASE   0x40000000
 
+/* arch/arm/include/asm/elf.h */
+#define ELF_ET_DYN_BASE      0x00400000
+
 #include "../generic/target_mman.h"
diff --git a/linux-user/cris/target_mman.h b/linux-user/cris/target_mman.h
index 9df7b1eda5..9ace8ac292 100644
--- a/linux-user/cris/target_mman.h
+++ b/linux-user/cris/target_mman.h
@@ -7,4 +7,7 @@
  */
 #define TASK_UNMAPPED_BASE TARGET_PAGE_ALIGN(0xb0000000 / 3)
 
+/* arch/cris/include/uapi/asm/elf.h */
+#define ELF_ET_DYN_BASE    (TASK_UNMAPPED_BASE * 2)
+
 #include "../generic/target_mman.h"
diff --git a/linux-user/hexagon/target_mman.h b/linux-user/hexagon/target_mman.h
index c5ae336e07..e6b5e2ca36 100644
--- a/linux-user/hexagon/target_mman.h
+++ b/linux-user/hexagon/target_mman.h
@@ -8,4 +8,7 @@
  */
 #define TASK_UNMAPPED_BASE   0x40000000
 
+/* arch/hexagon/include/asm/elf.h */
+#define ELF_ET_DYN_BASE      0x08000000
+
 #include "../generic/target_mman.h"
diff --git a/linux-user/hppa/target_mman.h b/linux-user/hppa/target_mman.h
index 6459e7dbdd..ccda46e842 100644
--- a/linux-user/hppa/target_mman.h
+++ b/linux-user/hppa/target_mman.h
@@ -27,6 +27,9 @@
 /* arch/parisc/include/asm/processor.h: DEFAULT_MAP_BASE32 */
 #define TASK_UNMAPPED_BASE      0x40000000
 
+/* arch/parisc/include/asm/elf.h */
+#define ELF_ET_DYN_BASE         (TASK_UNMAPPED_BASE + 0x01000000)
+
 #include "../generic/target_mman.h"
 
 #endif
diff --git a/linux-user/i386/target_mman.h b/linux-user/i386/target_mman.h
index cc3382007f..e3b8e1eaa6 100644
--- a/linux-user/i386/target_mman.h
+++ b/linux-user/i386/target_mman.h
@@ -11,4 +11,7 @@
  */
 #define TASK_UNMAPPED_BASE    0x40000000
 
+/* arch/x86/include/asm/elf.h */
+#define ELF_ET_DYN_BASE       0x00400000
+
 #include "../generic/target_mman.h"
diff --git a/linux-user/loongarch64/target_mman.h b/linux-user/loongarch64/target_mman.h
index d70e44d44c..8c2a3d5596 100644
--- a/linux-user/loongarch64/target_mman.h
+++ b/linux-user/loongarch64/target_mman.h
@@ -6,4 +6,7 @@
 #define TASK_UNMAPPED_BASE \
     TARGET_PAGE_ALIGN((1ull << TARGET_VIRT_ADDR_SPACE_BITS) / 3)
 
+/* arch/loongarch/include/asm/elf.h */
+#define ELF_ET_DYN_BASE       (TASK_UNMAPPED_BASE * 2)
+
 #include "../generic/target_mman.h"
diff --git a/linux-user/m68k/target_mman.h b/linux-user/m68k/target_mman.h
index d3eceb663b..20cfe750c5 100644
--- a/linux-user/m68k/target_mman.h
+++ b/linux-user/m68k/target_mman.h
@@ -1,4 +1,6 @@
 /* arch/m68k/include/asm/processor.h */
 #define TASK_UNMAPPED_BASE      0xC0000000
+/* arch/m68k/include/asm/elf.h */
+#define ELF_ET_DYN_BASE         0xD0000000
 
 #include "../generic/target_mman.h"
diff --git a/linux-user/microblaze/target_mman.h b/linux-user/microblaze/target_mman.h
index ffee869db4..6b3dd54f89 100644
--- a/linux-user/microblaze/target_mman.h
+++ b/linux-user/microblaze/target_mman.h
@@ -6,4 +6,7 @@
  */
 #define TASK_UNMAPPED_BASE      0x48000000
 
+/* arch/microblaze/include/uapi/asm/elf.h */
+#define ELF_ET_DYN_BASE         0x08000000
+
 #include "../generic/target_mman.h"
diff --git a/linux-user/mips/target_mman.h b/linux-user/mips/target_mman.h
index fe1eec2d0b..b84fe1e8a8 100644
--- a/linux-user/mips/target_mman.h
+++ b/linux-user/mips/target_mman.h
@@ -21,6 +21,9 @@
 #define TASK_UNMAPPED_BASE \
     TARGET_PAGE_ALIGN((1ull << TARGET_VIRT_ADDR_SPACE_BITS) / 3)
 
+/* arch/mips/include/asm/elf.h */
+#define ELF_ET_DYN_BASE       (TASK_UNMAPPED_BASE * 2)
+
 #include "../generic/target_mman.h"
 
 #endif
diff --git a/linux-user/nios2/target_mman.h b/linux-user/nios2/target_mman.h
index ce18f4f871..ab16ad4f03 100644
--- a/linux-user/nios2/target_mman.h
+++ b/linux-user/nios2/target_mman.h
@@ -5,4 +5,7 @@
  */
 #define TASK_UNMAPPED_BASE    TARGET_PAGE_ALIGN(0x7FFF0000 / 3)
 
+/* arch/nios2/include/asm/elf.h */
+#define ELF_ET_DYN_BASE       0xD0000000
+
 #include "../generic/target_mman.h"
diff --git a/linux-user/openrisc/target_mman.h b/linux-user/openrisc/target_mman.h
index f1aaad809d..243c1d5f26 100644
--- a/linux-user/openrisc/target_mman.h
+++ b/linux-user/openrisc/target_mman.h
@@ -5,4 +5,7 @@
  */
 #define TASK_UNMAPPED_BASE      0x30000000
 
+/* arch/openrisc/include/asm/elf.h */
+#define ELF_ET_DYN_BASE         0x08000000
+
 #include "../generic/target_mman.h"
diff --git a/linux-user/ppc/target_mman.h b/linux-user/ppc/target_mman.h
index 04f99c6077..646d1ccae7 100644
--- a/linux-user/ppc/target_mman.h
+++ b/linux-user/ppc/target_mman.h
@@ -17,6 +17,13 @@
 #define TASK_UNMAPPED_BASE      0x40000000
 #endif
 
+/* arch/powerpc/include/asm/elf.h */
+#ifdef TARGET_PPC64
+#define ELF_ET_DYN_BASE         0x100000000ull
+#else
+#define ELF_ET_DYN_BASE         0x000400000
+#endif
+
 #include "../generic/target_mman.h"
 
 #endif
diff --git a/linux-user/riscv/target_mman.h b/linux-user/riscv/target_mman.h
index 0f06dadbd4..3049bcc67d 100644
--- a/linux-user/riscv/target_mman.h
+++ b/linux-user/riscv/target_mman.h
@@ -5,4 +5,7 @@
 #define TASK_UNMAPPED_BASE \
     TARGET_PAGE_ALIGN((1ull << (TARGET_VIRT_ADDR_SPACE_BITS - 1)) / 3)
 
+/* arch/riscv/include/asm/elf.h */
+#define ELF_ET_DYN_BASE       (TASK_UNMAPPED_BASE * 2)
+
 #include "../generic/target_mman.h"
diff --git a/linux-user/s390x/target_mman.h b/linux-user/s390x/target_mman.h
index 40d149b329..c82435e381 100644
--- a/linux-user/s390x/target_mman.h
+++ b/linux-user/s390x/target_mman.h
@@ -8,4 +8,14 @@
  */
 #define TASK_UNMAPPED_BASE      (1ull << 41)
 
+/*
+ * arch/s390/include/asm/elf.h:
+ * ELF_ET_DYN_BASE              (STACK_TOP / 3 * 2) & ~((1UL << 32) - 1)
+ *
+ * arch/s390/include/asm/processor.h:
+ * STACK_TOP                    VDSO_LIMIT - VDSO_SIZE - PAGE_SIZE
+ * VDSO_LIMIT                   _REGION2_SIZE
+ */
+#define ELF_ET_DYN_BASE         (((1ull << 42) / 3 * 2) & ~0xffffffffull)
+
 #include "../generic/target_mman.h"
diff --git a/linux-user/sh4/target_mman.h b/linux-user/sh4/target_mman.h
index bbbc223398..dd9016081e 100644
--- a/linux-user/sh4/target_mman.h
+++ b/linux-user/sh4/target_mman.h
@@ -2,4 +2,7 @@
 #define TASK_UNMAPPED_BASE \
     TARGET_PAGE_ALIGN((1u << TARGET_VIRT_ADDR_SPACE_BITS) / 3)
 
+/* arch/sh/include/asm/elf.h */
+#define ELF_ET_DYN_BASE       (TASK_UNMAPPED_BASE * 2)
+
 #include "../generic/target_mman.h"
diff --git a/linux-user/sparc/target_mman.h b/linux-user/sparc/target_mman.h
index 692ebf9dd7..696ca73fe4 100644
--- a/linux-user/sparc/target_mman.h
+++ b/linux-user/sparc/target_mman.h
@@ -19,6 +19,17 @@
 #define TASK_UNMAPPED_BASE      (1ull << (TARGET_VIRT_ADDR_SPACE_BITS - 2))
 #endif
 
+/*
+ * arch/sparc/include/asm/elf_64.h
+ * Except that COMPAT_ELF_ET_DYN_BASE exactly matches TASK_UNMAPPED_BASE,
+ * so move it up a bit.
+ */
+#ifdef TARGET_ABI32
+#define ELF_ET_DYN_BASE         0x78000000
+#else
+#define ELF_ET_DYN_BASE         0x0000010000000000ull
+#endif
+
 #include "../generic/target_mman.h"
 
 #endif
diff --git a/linux-user/user-mmap.h b/linux-user/user-mmap.h
index bae49059e0..5dd48a458d 100644
--- a/linux-user/user-mmap.h
+++ b/linux-user/user-mmap.h
@@ -20,6 +20,7 @@
 
 extern abi_ulong task_unmapped_base;
 extern abi_ulong mmap_next_start;
+extern abi_ulong elf_et_dyn_base;
 
 int target_mprotect(abi_ulong start, abi_ulong len, int prot);
 abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
diff --git a/linux-user/x86_64/target_mman.h b/linux-user/x86_64/target_mman.h
index f9ff652b37..48fbf20b42 100644
--- a/linux-user/x86_64/target_mman.h
+++ b/linux-user/x86_64/target_mman.h
@@ -10,4 +10,7 @@
 #define TASK_UNMAPPED_BASE \
     TARGET_PAGE_ALIGN((1ull << TARGET_VIRT_ADDR_SPACE_BITS) / 3)
 
+/* arch/x86/include/asm/elf.h */
+#define ELF_ET_DYN_BASE       (TASK_UNMAPPED_BASE * 2)
+
 #include "../generic/target_mman.h"
diff --git a/linux-user/xtensa/target_mman.h b/linux-user/xtensa/target_mman.h
index c4f671adb7..8fa6337a97 100644
--- a/linux-user/xtensa/target_mman.h
+++ b/linux-user/xtensa/target_mman.h
@@ -20,6 +20,10 @@
  */
 #define TASK_UNMAPPED_BASE      (1u << (TARGET_VIRT_ADDR_SPACE_BITS - 1))
 
+/* arch/xtensa/include/asm/elf.h */
+#define ELF_ET_DYN_BASE \
+    TARGET_PAGE_ALIGN((1u << TARGET_VIRT_ADDR_SPACE_BITS) / 3)
+
 #include "../generic/target_mman.h"
 
 #endif
diff --git a/linux-user/main.c b/linux-user/main.c
index be621dc792..96be354897 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -847,6 +847,21 @@ int main(int argc, char **argv, char **envp)
     }
     mmap_next_start = task_unmapped_base;
 
+    /* Similarly for elf_et_dyn_base. */
+    if (reserved_va) {
+        if (ELF_ET_DYN_BASE < reserved_va) {
+            elf_et_dyn_base = ELF_ET_DYN_BASE;
+        } else {
+            /* The most common default formula is TASK_SIZE / 3 * 2. */
+            elf_et_dyn_base = TARGET_PAGE_ALIGN(reserved_va / 3) * 2;
+        }
+    } else if (ELF_ET_DYN_BASE < UINTPTR_MAX) {
+        elf_et_dyn_base = ELF_ET_DYN_BASE;
+    } else {
+        /* 32-bit host: pick something medium size. */
+        elf_et_dyn_base = 0x18000000;
+    }
+
 #pragma GCC diagnostic pop
 
     {
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 84436d45c8..949c4090f3 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -301,6 +301,7 @@ static bool mmap_frag(abi_ulong real_start, abi_ulong start, abi_ulong last,
 
 abi_ulong task_unmapped_base;
 abi_ulong mmap_next_start;
+abi_ulong elf_et_dyn_base;
 
 /*
  * Subroutine of mmap_find_vma, used when we have pre-allocated
-- 
2.34.1


