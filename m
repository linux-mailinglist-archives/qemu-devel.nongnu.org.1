Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A816774C75
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 23:10:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTTww-0007fx-Bu; Tue, 08 Aug 2023 17:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTTwu-0007fK-Lw
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:09:04 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTTws-0005vd-DK
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:09:04 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1bc411e9d17so38432605ad.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 14:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691528941; x=1692133741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wivyov7AEZeRw2PcNpFecn0oeBHeQvthqNe4bGaMto4=;
 b=uE7Sqft1xQe+xPNM1hSHiPtrKw4awhEjr/A8NR6QvVvjOexfB3X0danKSF9spowljC
 Tahiinct+/y52FPer034/c5bcMgT4ZKzA7jTR7/DB4i9t4PSIwKd0XUFNfiqtZ/cxJMk
 uMXAtV+5xZuApyAZGUgwrnFbQSOT5NyWO/qh7Hz3lYwFBtZJWit2NDfQ4Feq3qsfpixZ
 RJKl/96khhNvqQxrwOU62EqgWC4nAdOJW+frH55LusXcXfhvxE4r/HqzXD3gbkplAqTx
 QxyBzfobczAvTsN9YCR9e1ztwXLYRT3X+M92XpefVf0Rb9ShRzQVfOuK9jsSY81+w9yS
 9btQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691528941; x=1692133741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wivyov7AEZeRw2PcNpFecn0oeBHeQvthqNe4bGaMto4=;
 b=BHF0IphDtAetma04OPVz3T6ECS2Zn1Sbr1Bd93SvGkIEKnvkksWKtmoxIXnan45FN5
 BpWhR+pqFfi3jDgE8SIl0VBP5BvPWRFRQdrGh7guUO0fvWzqgf9eh9smQAQDbkaDGrIT
 WmfwyFKSmIJ2w+rrY24KcmOC6pi/eIR+8dMYS84y9bbMLyhqgqh1oPMIOnKlsioFs3TG
 g+SwHpycxTRx72ZjTMgk8Aq4QsNu0NvMVf33yOzI8hQil+d8PwPpAqC6bgl/CLag0Wte
 IIWs6oIGrYslbc27fLLoy/tWNP5+CS1/9rkrGnVhbrnJqqzloLYSPcnVbYK9+uPkdUJ1
 GHkA==
X-Gm-Message-State: AOJu0YydJee7qAueTkKl7ENxNvURMqaO0FlLD9mg4JYvjKAPvQUH39SY
 SahhlpNVI47y3Hcxji7gAjZl7qAb//ATxXv3uyM=
X-Google-Smtp-Source: AGHT+IHejuvydmhrKJ2OujN184fweCUAxiXMaDwGw7ljdlhcfFyVUtAPCsJhG6MfQ6FLT4gnmb6JkQ==
X-Received: by 2002:a17:903:120c:b0:1b8:b3f0:3d57 with SMTP id
 l12-20020a170903120c00b001b8b3f03d57mr983853plh.31.1691528940854; 
 Tue, 08 Aug 2023 14:09:00 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 k11-20020a170902694b00b001b3fb2f0296sm9437533plt.120.2023.08.08.14.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 14:09:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 03/14] linux-user: Define ELF_ET_DYN_BASE in
 $guest/target_mman.h
Date: Tue,  8 Aug 2023 14:08:45 -0700
Message-Id: <20230808210856.95568-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808210856.95568-1-richard.henderson@linaro.org>
References: <20230808210856.95568-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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
 linux-user/user-mmap.h               | 13 +++++++++++--
 linux-user/x86_64/target_mman.h      |  3 +++
 linux-user/xtensa/target_mman.h      |  4 ++++
 linux-user/main.c                    | 15 +++++++++++++++
 linux-user/mmap.c                    |  1 +
 23 files changed, 106 insertions(+), 2 deletions(-)

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
index f844ba4e61..0f4883eb57 100644
--- a/linux-user/user-mmap.h
+++ b/linux-user/user-mmap.h
@@ -25,10 +25,19 @@
  * TASK_UNMAPPED_BASE: For mmap without hint (addr != 0), the search
  * for unused virtual memory begins at TASK_UNMAPPED_BASE.
  *
- * task_unmapped_base: When the guest address space is limited via -R,
- * the value of TASK_UNMAPPED_BASE is adjusted to fit.
+ * ELF_ET_DYN_BASE: When the executable is ET_DYN (i.e. PIE), and requires
+ * an interpreter (i.e. not -static-pie), use ELF_ET_DYN_BASE instead of
+ * TASK_UNMAPPED_BASE for selecting the address of the executable.
+ * This provides some distance between the executable and the interpreter,
+ * which allows the initial brk to be placed immediately after the
+ * executable and also have room to grow.
+ *
+ * task_unmapped_base, elf_et_dyn_base: When the guest address space is
+ * limited via -R, the values of TASK_UNMAPPED_BASE and ELF_ET_DYN_BASE
+ * must be adjusted to fit.
  */
 extern abi_ulong task_unmapped_base;
+extern abi_ulong elf_et_dyn_base;
 
 /*
  * mmap_next_start: The base address for the next mmap without hint,
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
index 84436d45c8..9aab48d4a3 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -300,6 +300,7 @@ static bool mmap_frag(abi_ulong real_start, abi_ulong start, abi_ulong last,
 }
 
 abi_ulong task_unmapped_base;
+abi_ulong elf_et_dyn_base;
 abi_ulong mmap_next_start;
 
 /*
-- 
2.34.1


