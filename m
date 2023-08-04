Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD186770BA8
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 00:03:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS2rP-000541-B8; Fri, 04 Aug 2023 18:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2qo-0004jC-P8
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:52 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2ql-0001ta-0K
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:50 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-26837895fc8so1530273a91.0
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 15:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691186445; x=1691791245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nsfMjTlh4URCmzpsUVnlBQkKHMyACEHtsPPiByh/vaY=;
 b=WPYpgn6ksN0Pa/ug70Fkadc1p54n8xR2Dt8faHSVfVY+TAFBjR3mvYjahxfAsmYCEx
 OAau1GCHxJaSTLra/mQKx/V0Bgtk6e0qmVo5TbhhRlXK/+1Qm9Fvi2W0o0mraYwNPqfM
 rKXSg6MwtlcMUTbEqWHX9xr7cTD/pIfRiJeX/3hl+oIxH5otpeQksIodoABOAvyNzFuE
 clz6UZwh+CLzFLI5m1rILCqCTDdP4H00833UB1nIDlFhBij39qZo5l+c+aj3a2X3iit+
 HFSG3RhzGI8GxwDWrP6SVDZ9ehQENS6CNFDSp3GyL65bXNfpLVPRvTaboK/A3Ie+0vKw
 AdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691186445; x=1691791245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nsfMjTlh4URCmzpsUVnlBQkKHMyACEHtsPPiByh/vaY=;
 b=fO0yInf0ewn56iIuVmCMouMORKRfTfzhaZbS/skB4epNYmBcsCn106QmewxKfEjdHK
 /jhpZunJ8kQzUBSMEAYV7G7AzyCPQac+rSDz7O6Hw+Er+xWOfp88gsizIIx8g/tEy6YD
 vm1rU1A7Wa9rTK1ZQkyddffC1vnawC8bVE60BSX9t4Fp0VSBVVpQFLQLKk5/24U6a/1Q
 zOZuo3+CE0rgc15T9rdiwm1vVlmhUzs3r5p6rxnJvlA3MkT358tfDSxiUIeeamJKL2vJ
 9Q25+OKlSC7SPHgj8YiS5d7wLoaaVOl+J3iTq8FmdyTeba38OZVeP/glzfWDQVw8NcFm
 OU0Q==
X-Gm-Message-State: AOJu0YwNL94O00R7r8O0qN8Q/xC0QVIYsba251WIfs4ceCPwLM8Qkso2
 COI0LRXn70xQF5GznDg/HZJDLCq/8ruja83qVs8=
X-Google-Smtp-Source: AGHT+IGBdEngHw3u/1N/Gx2a1yml++ZNcTSh2esoDfLUsOTDJFXhOj1DxDGtxioVZVy1x7t2T6dFKg==
X-Received: by 2002:a17:90a:bb08:b0:267:de82:c37b with SMTP id
 u8-20020a17090abb0800b00267de82c37bmr2364363pjr.18.1691186445608; 
 Fri, 04 Aug 2023 15:00:45 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:1eed:f77f:f320:8b14])
 by smtp.gmail.com with ESMTPSA id
 u1-20020a17090282c100b001bbf7fd354csm2185568plz.213.2023.08.04.15.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 15:00:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v9 14/24] linux-user: Define TASK_UNMAPPED_BASE in
 $guest/target_mman.h
Date: Fri,  4 Aug 2023 15:00:22 -0700
Message-Id: <20230804220032.295411-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804220032.295411-1-richard.henderson@linaro.org>
References: <20230804220032.295411-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

Provide default values that are as close as possible to the
values used by the guest's kernel.

Tested-by: Helge Deller <deller@gmx.de>
Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/target_mman.h     | 10 ++++++++++
 linux-user/alpha/target_mman.h       |  8 ++++++++
 linux-user/arm/target_mman.h         |  8 ++++++++
 linux-user/cris/target_mman.h        |  9 +++++++++
 linux-user/hexagon/target_mman.h     | 10 ++++++++++
 linux-user/hppa/target_mman.h        |  3 +++
 linux-user/i386/target_mman.h        | 13 +++++++++++++
 linux-user/loongarch64/target_mman.h |  8 ++++++++
 linux-user/m68k/target_mman.h        |  3 +++
 linux-user/microblaze/target_mman.h  |  8 ++++++++
 linux-user/mips/target_mman.h        |  7 +++++++
 linux-user/nios2/target_mman.h       |  7 +++++++
 linux-user/openrisc/target_mman.h    |  7 +++++++
 linux-user/ppc/target_mman.h         | 13 +++++++++++++
 linux-user/riscv/target_mman.h       |  7 +++++++
 linux-user/s390x/target_mman.h       | 10 ++++++++++
 linux-user/sh4/target_mman.h         |  4 ++++
 linux-user/sparc/target_mman.h       | 14 ++++++++++++++
 linux-user/user-mmap.h               | 14 --------------
 linux-user/x86_64/target_mman.h      | 12 ++++++++++++
 linux-user/xtensa/target_mman.h      |  6 ++++++
 21 files changed, 167 insertions(+), 14 deletions(-)

diff --git a/linux-user/aarch64/target_mman.h b/linux-user/aarch64/target_mman.h
index f721295fe1..4d3eecfb26 100644
--- a/linux-user/aarch64/target_mman.h
+++ b/linux-user/aarch64/target_mman.h
@@ -4,6 +4,16 @@
 #define TARGET_PROT_BTI         0x10
 #define TARGET_PROT_MTE         0x20
 
+/*
+ * arch/arm64/include/asm/processor.h:
+ *
+ * TASK_UNMAPPED_BASE     DEFAULT_MAP_WINDOW / 4
+ * DEFAULT_MAP_WINDOW     DEFAULT_MAP_WINDOW_64
+ * DEFAULT_MAP_WINDOW_64  UL(1) << VA_BITS_MIN
+ * VA_BITS_MIN            48 (unless explicitly configured smaller)
+ */
+#define TASK_UNMAPPED_BASE      (1ull << (48 - 2))
+
 #include "../generic/target_mman.h"
 
 #endif
diff --git a/linux-user/alpha/target_mman.h b/linux-user/alpha/target_mman.h
index 6bb03e7336..c90b493711 100644
--- a/linux-user/alpha/target_mman.h
+++ b/linux-user/alpha/target_mman.h
@@ -20,6 +20,14 @@
 #define TARGET_MS_SYNC 2
 #define TARGET_MS_INVALIDATE 4
 
+/*
+ * arch/alpha/include/asm/processor.h:
+ *
+ * TASK_UNMAPPED_BASE           TASK_SIZE / 2
+ * TASK_SIZE                    0x40000000000UL
+ */
+#define TASK_UNMAPPED_BASE      0x20000000000ull
+
 #include "../generic/target_mman.h"
 
 #endif
diff --git a/linux-user/arm/target_mman.h b/linux-user/arm/target_mman.h
index e7ba6070fe..76275b2c7e 100644
--- a/linux-user/arm/target_mman.h
+++ b/linux-user/arm/target_mman.h
@@ -1 +1,9 @@
+/*
+ * arch/arm/include/asm/memory.h
+ * TASK_UNMAPPED_BASE        ALIGN(TASK_SIZE / 3, SZ_16M)
+ * TASK_SIZE                 CONFIG_PAGE_OFFSET
+ * CONFIG_PAGE_OFFSET        0xC0000000 (default in Kconfig)
+ */
+#define TASK_UNMAPPED_BASE   0x40000000
+
 #include "../generic/target_mman.h"
diff --git a/linux-user/cris/target_mman.h b/linux-user/cris/target_mman.h
index e7ba6070fe..9df7b1eda5 100644
--- a/linux-user/cris/target_mman.h
+++ b/linux-user/cris/target_mman.h
@@ -1 +1,10 @@
+/*
+ * arch/cris/include/asm/processor.h:
+ * TASK_UNMAPPED_BASE      (PAGE_ALIGN(TASK_SIZE / 3))
+ *
+ * arch/cris/include/arch-v32/arch/processor.h
+ * TASK_SIZE               0xb0000000
+ */
+#define TASK_UNMAPPED_BASE TARGET_PAGE_ALIGN(0xb0000000 / 3)
+
 #include "../generic/target_mman.h"
diff --git a/linux-user/hexagon/target_mman.h b/linux-user/hexagon/target_mman.h
index e7ba6070fe..c5ae336e07 100644
--- a/linux-user/hexagon/target_mman.h
+++ b/linux-user/hexagon/target_mman.h
@@ -1 +1,11 @@
+/*
+ * arch/hexgon/include/asm/processor.h
+ * TASK_UNMAPPED_BASE        PAGE_ALIGN(TASK_SIZE / 3)
+ *
+ * arch/hexagon/include/asm/mem-layout.h
+ * TASK_SIZE                 PAGE_OFFSET
+ * PAGE_OFFSET               0xc0000000
+ */
+#define TASK_UNMAPPED_BASE   0x40000000
+
 #include "../generic/target_mman.h"
diff --git a/linux-user/hppa/target_mman.h b/linux-user/hppa/target_mman.h
index 97f87d042a..6459e7dbdd 100644
--- a/linux-user/hppa/target_mman.h
+++ b/linux-user/hppa/target_mman.h
@@ -24,6 +24,9 @@
 #define TARGET_MS_ASYNC 2
 #define TARGET_MS_INVALIDATE 4
 
+/* arch/parisc/include/asm/processor.h: DEFAULT_MAP_BASE32 */
+#define TASK_UNMAPPED_BASE      0x40000000
+
 #include "../generic/target_mman.h"
 
 #endif
diff --git a/linux-user/i386/target_mman.h b/linux-user/i386/target_mman.h
index e7ba6070fe..cc3382007f 100644
--- a/linux-user/i386/target_mman.h
+++ b/linux-user/i386/target_mman.h
@@ -1 +1,14 @@
+/*
+ * arch/x86/include/asm/processor.h:
+ * TASK_UNMAPPED_BASE         __TASK_UNMAPPED_BASE(TASK_SIZE_LOW)
+ * __TASK_UNMAPPED_BASE(S)    PAGE_ALIGN(S / 3)
+ *
+ * arch/x86/include/asm/page_32_types.h:
+ * TASK_SIZE_LOW              TASK_SIZE
+ * TASK_SIZE                  __PAGE_OFFSET
+ * __PAGE_OFFSET              CONFIG_PAGE_OFFSET
+ * CONFIG_PAGE_OFFSET         0xc0000000 (default in Kconfig)
+ */
+#define TASK_UNMAPPED_BASE    0x40000000
+
 #include "../generic/target_mman.h"
diff --git a/linux-user/loongarch64/target_mman.h b/linux-user/loongarch64/target_mman.h
index e7ba6070fe..d70e44d44c 100644
--- a/linux-user/loongarch64/target_mman.h
+++ b/linux-user/loongarch64/target_mman.h
@@ -1 +1,9 @@
+/*
+ * arch/loongarch/include/asm/processor.h:
+ * TASK_UNMAPPED_BASE         PAGE_ALIGN(TASK_SIZE / 3)
+ * TASK_SIZE64                0x1UL << (... ? VA_BITS : ...)
+ */
+#define TASK_UNMAPPED_BASE \
+    TARGET_PAGE_ALIGN((1ull << TARGET_VIRT_ADDR_SPACE_BITS) / 3)
+
 #include "../generic/target_mman.h"
diff --git a/linux-user/m68k/target_mman.h b/linux-user/m68k/target_mman.h
index e7ba6070fe..d3eceb663b 100644
--- a/linux-user/m68k/target_mman.h
+++ b/linux-user/m68k/target_mman.h
@@ -1 +1,4 @@
+/* arch/m68k/include/asm/processor.h */
+#define TASK_UNMAPPED_BASE      0xC0000000
+
 #include "../generic/target_mman.h"
diff --git a/linux-user/microblaze/target_mman.h b/linux-user/microblaze/target_mman.h
index e7ba6070fe..ffee869db4 100644
--- a/linux-user/microblaze/target_mman.h
+++ b/linux-user/microblaze/target_mman.h
@@ -1 +1,9 @@
+/*
+ * arch/microblaze/include/asm/processor.h:
+ * TASK_UNMAPPED_BASE           (TASK_SIZE / 8 * 3)
+ * TASK_SIZE                    CONFIG_KERNEL_START
+ * CONFIG_KERNEL_START          0xc0000000 (default in Kconfig)
+ */
+#define TASK_UNMAPPED_BASE      0x48000000
+
 #include "../generic/target_mman.h"
diff --git a/linux-user/mips/target_mman.h b/linux-user/mips/target_mman.h
index e97694aa4e..fe1eec2d0b 100644
--- a/linux-user/mips/target_mman.h
+++ b/linux-user/mips/target_mman.h
@@ -14,6 +14,13 @@
 #define TARGET_MAP_STACK                0x40000
 #define TARGET_MAP_HUGETLB              0x80000
 
+/*
+ * arch/mips/include/asm/processor.h:
+ * TASK_UNMAPPED_BASE         PAGE_ALIGN(TASK_SIZE / 3)
+ */
+#define TASK_UNMAPPED_BASE \
+    TARGET_PAGE_ALIGN((1ull << TARGET_VIRT_ADDR_SPACE_BITS) / 3)
+
 #include "../generic/target_mman.h"
 
 #endif
diff --git a/linux-user/nios2/target_mman.h b/linux-user/nios2/target_mman.h
index e7ba6070fe..ce18f4f871 100644
--- a/linux-user/nios2/target_mman.h
+++ b/linux-user/nios2/target_mman.h
@@ -1 +1,8 @@
+/*
+ * arch/nios2/include/asm/processor.h:
+ * TASK_UNMAPPED_BASE         PAGE_ALIGN(TASK_SIZE / 3)
+ * TASK_SIZE                  0x7FFF0000UL
+ */
+#define TASK_UNMAPPED_BASE    TARGET_PAGE_ALIGN(0x7FFF0000 / 3)
+
 #include "../generic/target_mman.h"
diff --git a/linux-user/openrisc/target_mman.h b/linux-user/openrisc/target_mman.h
index e7ba6070fe..f1aaad809d 100644
--- a/linux-user/openrisc/target_mman.h
+++ b/linux-user/openrisc/target_mman.h
@@ -1 +1,8 @@
+/*
+ * arch/openrisc/include/asm/processor.h:
+ * TASK_UNMAPPED_BASE      (TASK_SIZE / 8 * 3)
+ * TASK_SIZE               (0x80000000UL)
+ */
+#define TASK_UNMAPPED_BASE      0x30000000
+
 #include "../generic/target_mman.h"
diff --git a/linux-user/ppc/target_mman.h b/linux-user/ppc/target_mman.h
index 67cc218f2e..04f99c6077 100644
--- a/linux-user/ppc/target_mman.h
+++ b/linux-user/ppc/target_mman.h
@@ -4,6 +4,19 @@
 #define TARGET_MAP_NORESERVE            0x40
 #define TARGET_MAP_LOCKED               0x80
 
+/*
+ * arch/powerpc/include/asm/task_size_64.h
+ * TASK_UNMAPPED_BASE_USER32    (PAGE_ALIGN(TASK_SIZE_USER32 / 4))
+ * TASK_UNMAPPED_BASE_USER64    (PAGE_ALIGN(DEFAULT_MAP_WINDOW_USER64 / 4))
+ * TASK_SIZE_USER32             (0x0000000100000000UL - (1 * PAGE_SIZE))
+ * DEFAULT_MAP_WINDOW_USER64    TASK_SIZE_64TB (with 4k pages)
+ */
+#ifdef TARGET_PPC64
+#define TASK_UNMAPPED_BASE      0x0000100000000000ull
+#else
+#define TASK_UNMAPPED_BASE      0x40000000
+#endif
+
 #include "../generic/target_mman.h"
 
 #endif
diff --git a/linux-user/riscv/target_mman.h b/linux-user/riscv/target_mman.h
index e7ba6070fe..0f06dadbd4 100644
--- a/linux-user/riscv/target_mman.h
+++ b/linux-user/riscv/target_mman.h
@@ -1 +1,8 @@
+/*
+ * arch/loongarch/include/asm/processor.h:
+ * TASK_UNMAPPED_BASE         PAGE_ALIGN(TASK_SIZE / 3)
+ */
+#define TASK_UNMAPPED_BASE \
+    TARGET_PAGE_ALIGN((1ull << (TARGET_VIRT_ADDR_SPACE_BITS - 1)) / 3)
+
 #include "../generic/target_mman.h"
diff --git a/linux-user/s390x/target_mman.h b/linux-user/s390x/target_mman.h
index e7ba6070fe..40d149b329 100644
--- a/linux-user/s390x/target_mman.h
+++ b/linux-user/s390x/target_mman.h
@@ -1 +1,11 @@
+/*
+ * arch/s390/include/asm/processor.h:
+ * TASK_UNMAPPED_BASE           (... : (_REGION2_SIZE >> 1))
+ *
+ * arch/s390/include/asm/pgtable.h:
+ * _REGION2_SIZE                (1UL << _REGION2_SHIFT)
+ * _REGION2_SHIFT               42
+ */
+#define TASK_UNMAPPED_BASE      (1ull << 41)
+
 #include "../generic/target_mman.h"
diff --git a/linux-user/sh4/target_mman.h b/linux-user/sh4/target_mman.h
index e7ba6070fe..bbbc223398 100644
--- a/linux-user/sh4/target_mman.h
+++ b/linux-user/sh4/target_mman.h
@@ -1 +1,5 @@
+/* arch/sh/include/asm/processor_32.h */
+#define TASK_UNMAPPED_BASE \
+    TARGET_PAGE_ALIGN((1u << TARGET_VIRT_ADDR_SPACE_BITS) / 3)
+
 #include "../generic/target_mman.h"
diff --git a/linux-user/sparc/target_mman.h b/linux-user/sparc/target_mman.h
index 9bad99c852..692ebf9dd7 100644
--- a/linux-user/sparc/target_mman.h
+++ b/linux-user/sparc/target_mman.h
@@ -5,6 +5,20 @@
 #define TARGET_MAP_LOCKED              0x100
 #define TARGET_MAP_GROWSDOWN           0x0200
 
+/*
+ * arch/sparc/include/asm/page_64.h:
+ * TASK_UNMAPPED_BASE      (test_thread_flag(TIF_32BIT) ? \
+ *                          _AC(0x0000000070000000,UL) : \
+ *                          VA_EXCLUDE_END)
+ * But VA_EXCLUDE_END is > 0xffff800000000000UL which doesn't work
+ * in userland emulation.
+ */
+#ifdef TARGET_ABI32
+#define TASK_UNMAPPED_BASE      0x70000000
+#else
+#define TASK_UNMAPPED_BASE      (1ull << (TARGET_VIRT_ADDR_SPACE_BITS - 2))
+#endif
+
 #include "../generic/target_mman.h"
 
 #endif
diff --git a/linux-user/user-mmap.h b/linux-user/user-mmap.h
index fd456e024e..bae49059e0 100644
--- a/linux-user/user-mmap.h
+++ b/linux-user/user-mmap.h
@@ -18,20 +18,6 @@
 #ifndef LINUX_USER_USER_MMAP_H
 #define LINUX_USER_USER_MMAP_H
 
-#if HOST_LONG_BITS == 64 && TARGET_ABI_BITS == 64
-#ifdef TARGET_AARCH64
-# define TASK_UNMAPPED_BASE  0x5500000000
-#else
-# define TASK_UNMAPPED_BASE  (1ul << 38)
-#endif
-#else
-#ifdef TARGET_HPPA
-# define TASK_UNMAPPED_BASE  0xfa000000
-#else
-# define TASK_UNMAPPED_BASE  0x40000000
-#endif
-#endif
-
 extern abi_ulong task_unmapped_base;
 extern abi_ulong mmap_next_start;
 
diff --git a/linux-user/x86_64/target_mman.h b/linux-user/x86_64/target_mman.h
index e7ba6070fe..f9ff652b37 100644
--- a/linux-user/x86_64/target_mman.h
+++ b/linux-user/x86_64/target_mman.h
@@ -1 +1,13 @@
+/*
+ * arch/x86/include/asm/processor.h:
+ * TASK_UNMAPPED_BASE         __TASK_UNMAPPED_BASE(TASK_SIZE_LOW)
+ * __TASK_UNMAPPED_BASE(S)    PAGE_ALIGN(S / 3)
+ *
+ * arch/x86/include/asm/page_64_types.h:
+ * TASK_SIZE_LOW              DEFAULT_MAP_WINDOW
+ * DEFAULT_MAP_WINDOW         ((1UL << 47) - PAGE_SIZE)
+ */
+#define TASK_UNMAPPED_BASE \
+    TARGET_PAGE_ALIGN((1ull << TARGET_VIRT_ADDR_SPACE_BITS) / 3)
+
 #include "../generic/target_mman.h"
diff --git a/linux-user/xtensa/target_mman.h b/linux-user/xtensa/target_mman.h
index 3933771b5b..c4f671adb7 100644
--- a/linux-user/xtensa/target_mman.h
+++ b/linux-user/xtensa/target_mman.h
@@ -14,6 +14,12 @@
 #define TARGET_MAP_STACK                0x40000
 #define TARGET_MAP_HUGETLB              0x80000
 
+/*
+ * arch/xtensa/include/asm/processor.h:
+ * TASK_UNMAPPED_BASE           (TASK_SIZE / 2)
+ */
+#define TASK_UNMAPPED_BASE      (1u << (TARGET_VIRT_ADDR_SPACE_BITS - 1))
+
 #include "../generic/target_mman.h"
 
 #endif
-- 
2.34.1


