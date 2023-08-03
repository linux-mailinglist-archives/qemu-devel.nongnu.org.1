Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BC976DDAF
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 03:55:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRNWh-0000iP-VI; Wed, 02 Aug 2023 21:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRNWe-0000hd-UD
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 21:53:16 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRNWc-0000nt-R3
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 21:53:16 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-68730bafa6bso1073967b3a.1
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 18:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691027593; x=1691632393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p6THWkmOL3up/JWfXdBzKttFod82ENPWZNu0IzoE7Eg=;
 b=cHPaITfl1On56rbXEPRfLP0IPUQOOLnz7fqVmKUW07MYVINdA++RSrPF2diuC/dXdU
 2c9hiXitefATT0BkUlKisybF5tTFxwG7GJWSDOaHN0z4Zr1WimM79hXQlFfF+QMVvMYK
 JaTWhwG2swCZtc94y5Qlq0TpcQ1itQgzM3nueKWe1hNHOv5eeHrGsBf4DhfkR9iftgYS
 CbNmXFbRJhzD0jR21uE2db5uUtdaqsKD9RlTbaVPaVUHY62GcnvK3+lLJsnNw0JiHwC7
 rdeUU0CHITnsZPqDvfds6+LX4vKw83lysj6wfibmYd0R9oLujPyVcSgXQb00kyp5AVMM
 IfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691027593; x=1691632393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p6THWkmOL3up/JWfXdBzKttFod82ENPWZNu0IzoE7Eg=;
 b=BO9VdBDCq9NMgO1E9KuHpiy3UWENR9ccN4TsvzifsyZwF8DlSufHY3kgtEBuHwDa8w
 SCVPgz58fZj3XFNeqtSufb6KKI0aucaffjJ53RuUii/HKBeaViixoS3O4aJTJlRBRhg7
 BJesvc0Blt3t/E3xDtsGMsoo5vEIZvPz8mKcv40m3W+YTb9xRUOmvxN7mo/YPqr69UyC
 II0CArJEdRAKS3t6OpdyYH5UYStqbn1qvRlXOo4ILE7WmyEJZ/FR5pUvoJsOlWDWEmT2
 DS6wmOswRtZo8ZpwsGUDcfHACsbVuh9XWaEufYUAel6wUMmkgxSXJgWbTdF3asKKGS1R
 6akg==
X-Gm-Message-State: ABy/qLbMl9J2IxKP7Gr8OFS5RUqrUSqPmvHjE3GVzanIqSJfGXHCfniR
 HHpc2fmhz8gnXxSpkq2nrDvBMp4BftNH+magegM=
X-Google-Smtp-Source: APBJJlG9qHgBfjJYnlRLgvLqlhMzGff4b4nUTzYpPUCmV7EpddRfjPsES7K/IwPzm2JodAY4lr/aRQ==
X-Received: by 2002:a05:6a20:729b:b0:125:4d74:cd6a with SMTP id
 o27-20020a056a20729b00b001254d74cd6amr22390565pzk.3.1691027593452; 
 Wed, 02 Aug 2023 18:53:13 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:b659:bbad:1a22:7ef9])
 by smtp.gmail.com with ESMTPSA id
 s25-20020a63a319000000b005649cee408fsm157123pge.0.2023.08.02.18.53.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 18:53:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de, laurent@vivier.eu, akihiko.odaki@daynix.com, joel@jms.id.au
Subject: [PATCH v7 11/14] linux-user: Add ELF_ET_DYN_BASE
Date: Wed,  2 Aug 2023 18:52:59 -0700
Message-Id: <20230803015302.407219-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803015302.407219-1-richard.henderson@linaro.org>
References: <20230803015302.407219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Copy each guest kernel's default value, then bound it
against reserved_va or the host address space.

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
index c207b783d5..2b6f3f22c7 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -845,6 +845,21 @@ int main(int argc, char **argv, char **envp)
     }
     mmap_next_start = task_unmapped_base;
 
+    /* Similarly for elf_et_dyn_base. */
+    if (reserved_va) {
+        if (LESS(ELF_ET_DYN_BASE, reserved_va)) {
+            elf_et_dyn_base = ELF_ET_DYN_BASE;
+        } else {
+            /* The most common default formula is TASK_SIZE / 3 * 2. */
+            elf_et_dyn_base = TARGET_PAGE_ALIGN(reserved_va / 3) * 2;
+        }
+    } else if (LESS(ELF_ET_DYN_BASE, UINTPTR_MAX)) {
+        elf_et_dyn_base = ELF_ET_DYN_BASE;
+    } else {
+        /* 32-bit host: pick something medium size. */
+        elf_et_dyn_base = 0x18000000;
+    }
+
 #undef LESS
 
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


