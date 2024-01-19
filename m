Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4829C832B74
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 15:42:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQq2z-0005tC-IN; Fri, 19 Jan 2024 09:40:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQq2i-0005n4-Py
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:40:26 -0500
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQq2c-0003OL-Uv
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:40:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MMCprIC6DiPgHlXoHLCvyItw0HSpj+kf2KJFVZyu5RM=; b=UcozMmAFX7LfpT0JctMulVZ7lW
 2Jx13HuCRhYEuvT0fXTy9QpXADrtk6TPxqgRKGFmuPaBzNhC1FoRb3O71WqGARsS3xVjBW84/dlAK
 YPpHQYaJTLd3E6HQJ/a1WrXtxSnpxChpZz3e/0I+5kcuOIWg3nbzgFba2+BL8dq5VbcY=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng,
	richard.henderson@linaro.org,
	philmd@linaro.org
Subject: [RFC PATCH 02/34] target: [PAGE_VARY] Move TARGET_PAGE_BITS_MIN to
 TargetPageBits
Date: Fri, 19 Jan 2024 15:39:52 +0100
Message-ID: <20240119144024.14289-3-anjo@rev.ng>
In-Reply-To: <20240119144024.14289-1-anjo@rev.ng>
References: <20240119144024.14289-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

TARGET_PAGE_BITS_MIN is now defined as target_page.bits_min when
PAGE_VARY is used, similar to other TARGET_PAGE_* macros.  We still pick
whatever minimum the target specifies, however in a heterogeneous
context we would want the maximum of all target_page.bits_min.

This also makes TLB_* macros target independent, and the static assert
checking for TLB_* flag overlap is moved to a runtime assert in
tlb_init().

[NOTE: I'm not happy with adding the TARGET_PAGE_BITS_MIN_SPECIFIC
macro, maybe we can remove it and use MachineClass->minimum_page_bits
instead? Other ideas?]

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/exec/cpu-all.h        | 10 +++++-----
 include/exec/cpu-defs.h       |  4 ++--
 include/exec/page-vary.h      |  1 +
 target/alpha/cpu-param.h      |  2 +-
 target/arm/cpu-param.h        |  2 +-
 target/avr/cpu-param.h        |  2 +-
 target/cris/cpu-param.h       |  2 +-
 target/hppa/cpu-param.h       |  2 +-
 target/i386/cpu-param.h       |  2 +-
 target/loongarch/cpu-param.h  |  2 +-
 target/m68k/cpu-param.h       |  2 +-
 target/microblaze/cpu-param.h |  2 +-
 target/mips/cpu-param.h       |  2 +-
 target/nios2/cpu-param.h      |  2 +-
 target/openrisc/cpu-param.h   |  2 +-
 target/ppc/cpu-param.h        |  2 +-
 target/riscv/cpu-param.h      |  2 +-
 target/rx/cpu-param.h         |  2 +-
 target/s390x/cpu-param.h      |  2 +-
 target/sh4/cpu-param.h        |  2 +-
 target/sparc/cpu-param.h      |  4 ++--
 target/tricore/cpu-param.h    |  2 +-
 target/xtensa/cpu-param.h     |  2 +-
 accel/tcg/cputlb.c            |  3 +++
 page-vary-common.c            |  1 +
 page-vary-target.c            |  4 ++--
 target/arm/tcg/translate.c    |  4 ++--
 27 files changed, 37 insertions(+), 32 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 5340907cfd..a1e4dee6a2 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -155,12 +155,15 @@ static inline void stl_phys_notdirty(AddressSpace *as, hwaddr addr, uint32_t val
 # include "exec/page-vary.h"
 extern const TargetPageBits target_page;
 #ifdef CONFIG_DEBUG_TCG
+#define TARGET_PAGE_BITS_MIN ({ assert(target_page.decided); \
+                                target_page.bits_min; })
 #define TARGET_PAGE_BITS   ({ assert(target_page.decided); target_page.bits; })
 #define TARGET_PAGE_MASK   ({ assert(target_page.decided); \
                               (target_long)target_page.mask; })
 #else
-#define TARGET_PAGE_BITS   target_page.bits
-#define TARGET_PAGE_MASK   ((target_long)target_page.mask)
+#define TARGET_PAGE_BITS_MIN target_page.bits_min
+#define TARGET_PAGE_BITS     target_page.bits
+#define TARGET_PAGE_MASK     ((target_long)target_page.mask)
 #endif
 #define TARGET_PAGE_SIZE   (-(int)TARGET_PAGE_MASK)
 #else
@@ -380,9 +383,6 @@ CPUArchState *cpu_copy(CPUArchState *env);
 
 #define TLB_SLOW_FLAGS_MASK  (TLB_BSWAP | TLB_WATCHPOINT)
 
-/* The two sets of flags must not overlap. */
-QEMU_BUILD_BUG_ON(TLB_FLAGS_MASK & TLB_SLOW_FLAGS_MASK);
-
 /**
  * tlb_hit_page: return true if page aligned @addr is a hit against the
  * TLB entry @tlb_addr
diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 3915438b83..e8ccbe4bef 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -44,8 +44,8 @@
 #endif
 #ifndef TARGET_PAGE_BITS
 # ifdef TARGET_PAGE_BITS_VARY
-#  ifndef TARGET_PAGE_BITS_MIN
-#   error TARGET_PAGE_BITS_MIN must be defined in cpu-param.h
+#  ifndef TARGET_PAGE_BITS_MIN_SPECIFIC
+#   error TARGET_PAGE_BITS_MIN_SPECIFIC must be defined in cpu-param.h
 #  endif
 # else
 #  error TARGET_PAGE_BITS must be defined in cpu-param.h
diff --git a/include/exec/page-vary.h b/include/exec/page-vary.h
index 54ddde308a..add1282a7c 100644
--- a/include/exec/page-vary.h
+++ b/include/exec/page-vary.h
@@ -22,6 +22,7 @@
 
 typedef struct {
     bool decided;
+    int bits_min;
     int bits;
     uint64_t mask;
 } TargetPageBits;
diff --git a/target/alpha/cpu-param.h b/target/alpha/cpu-param.h
index dc9da45bdf..7001b130d6 100644
--- a/target/alpha/cpu-param.h
+++ b/target/alpha/cpu-param.h
@@ -14,7 +14,7 @@
 #define TARGET_PAGE_BITS 13
 #else
 #define TARGET_PAGE_BITS_VARY
-#define TARGET_PAGE_BITS_MIN 13
+#define TARGET_PAGE_BITS_MIN_SPECIFIC 13
 #endif
 
 /* ??? EV4 has 34 phys addr bits, EV5 has 40, EV6 has 44.  */
diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
index f9b462a98f..442feb5380 100644
--- a/target/arm/cpu-param.h
+++ b/target/arm/cpu-param.h
@@ -29,7 +29,7 @@
  * have to support 1K tiny pages.
  */
 # define TARGET_PAGE_BITS_VARY
-# define TARGET_PAGE_BITS_MIN  10
+# define TARGET_PAGE_BITS_MIN_SPECIFIC  10
 
 #endif
 
diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h
index 87142069fe..e9b011a50d 100644
--- a/target/avr/cpu-param.h
+++ b/target/avr/cpu-param.h
@@ -32,7 +32,7 @@
 #define TARGET_PAGE_BITS 8
 #else
 #define TARGET_PAGE_BITS_VARY
-#define TARGET_PAGE_BITS_MIN 8
+#define TARGET_PAGE_BITS_MIN_SPECIFIC 8
 #endif
 
 #define TARGET_PHYS_ADDR_SPACE_BITS 24
diff --git a/target/cris/cpu-param.h b/target/cris/cpu-param.h
index 9c66ca9e66..2c939a2beb 100644
--- a/target/cris/cpu-param.h
+++ b/target/cris/cpu-param.h
@@ -14,7 +14,7 @@
 #define TARGET_PAGE_BITS 13
 #else
 #define TARGET_PAGE_BITS_VARY
-#define TARGET_PAGE_BITS_MIN 13
+#define TARGET_PAGE_BITS_MIN_SPECIFIC 13
 #endif
 
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
diff --git a/target/hppa/cpu-param.h b/target/hppa/cpu-param.h
index 781dbc17d3..5e413b7b76 100644
--- a/target/hppa/cpu-param.h
+++ b/target/hppa/cpu-param.h
@@ -33,7 +33,7 @@
 #define TARGET_PAGE_BITS 12
 #else
 #define TARGET_PAGE_BITS_VARY
-#define TARGET_PAGE_BITS_MIN 12
+#define TARGET_PAGE_BITS_MIN_SPECIFIC 12
 #endif
 
 #endif
diff --git a/target/i386/cpu-param.h b/target/i386/cpu-param.h
index d09d0eb2ed..a497e842d8 100644
--- a/target/i386/cpu-param.h
+++ b/target/i386/cpu-param.h
@@ -27,7 +27,7 @@
 #define TARGET_PAGE_BITS 12
 #else
 #define TARGET_PAGE_BITS_VARY
-#define TARGET_PAGE_BITS_MIN 12
+#define TARGET_PAGE_BITS_MIN_SPECIFIC 12
 #endif
 
 #endif
diff --git a/target/loongarch/cpu-param.h b/target/loongarch/cpu-param.h
index f537c53ec4..a447a03a76 100644
--- a/target/loongarch/cpu-param.h
+++ b/target/loongarch/cpu-param.h
@@ -16,7 +16,7 @@
 #define TARGET_PAGE_BITS 14
 #else
 #define TARGET_PAGE_BITS_VARY
-#define TARGET_PAGE_BITS_MIN 14
+#define TARGET_PAGE_BITS_MIN_SPECIFIC 14
 #endif
 
 #endif
diff --git a/target/m68k/cpu-param.h b/target/m68k/cpu-param.h
index 92706969c7..650a1f94c7 100644
--- a/target/m68k/cpu-param.h
+++ b/target/m68k/cpu-param.h
@@ -18,7 +18,7 @@
 #define TARGET_PAGE_BITS 12
 #else
 #define TARGET_PAGE_BITS_VARY
-#define TARGET_PAGE_BITS_MIN 12
+#define TARGET_PAGE_BITS_MIN_SPECIFIC 12
 #endif
 
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
diff --git a/target/microblaze/cpu-param.h b/target/microblaze/cpu-param.h
index 51987d330d..4bfd825999 100644
--- a/target/microblaze/cpu-param.h
+++ b/target/microblaze/cpu-param.h
@@ -27,7 +27,7 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 64
 #define TARGET_VIRT_ADDR_SPACE_BITS 64
 #define TARGET_PAGE_BITS_VARY
-#define TARGET_PAGE_BITS_MIN 12
+#define TARGET_PAGE_BITS_MIN_SPECIFIC 12
 #endif
 
 
diff --git a/target/mips/cpu-param.h b/target/mips/cpu-param.h
index 594c91a156..1f4fb03b66 100644
--- a/target/mips/cpu-param.h
+++ b/target/mips/cpu-param.h
@@ -27,7 +27,7 @@
 #define TARGET_PAGE_BITS 12
 #else
 #define TARGET_PAGE_BITS_VARY
-#define TARGET_PAGE_BITS_MIN 12
+#define TARGET_PAGE_BITS_MIN_SPECIFIC 12
 #endif
 
 #endif
diff --git a/target/nios2/cpu-param.h b/target/nios2/cpu-param.h
index 40af6aef68..759c89abea 100644
--- a/target/nios2/cpu-param.h
+++ b/target/nios2/cpu-param.h
@@ -17,7 +17,7 @@
 #else
 # define TARGET_VIRT_ADDR_SPACE_BITS 32
 # define TARGET_PAGE_BITS_VARY
-# define TARGET_PAGE_BITS_MIN 12
+# define TARGET_PAGE_BITS_MIN_SPECIFIC 12
 #endif
 
 #endif
diff --git a/target/openrisc/cpu-param.h b/target/openrisc/cpu-param.h
index 10c52edf76..b20dbd7c8b 100644
--- a/target/openrisc/cpu-param.h
+++ b/target/openrisc/cpu-param.h
@@ -16,7 +16,7 @@
 #define TARGET_PAGE_BITS 13
 #else
 #define TARGET_PAGE_BITS_VARY
-#define TARGET_PAGE_BITS_MIN 13
+#define TARGET_PAGE_BITS_MIN_SPECIFIC 13
 #endif
 
 #endif
diff --git a/target/ppc/cpu-param.h b/target/ppc/cpu-param.h
index 597dd39a6b..c712131b5d 100644
--- a/target/ppc/cpu-param.h
+++ b/target/ppc/cpu-param.h
@@ -36,7 +36,7 @@
 #define TARGET_PAGE_BITS 12
 #else
 #define TARGET_PAGE_BITS_VARY
-#define TARGET_PAGE_BITS_MIN 12
+#define TARGET_PAGE_BITS_MIN_SPECIFIC 12
 #endif
 
 #endif
diff --git a/target/riscv/cpu-param.h b/target/riscv/cpu-param.h
index 80ba169e2b..889d2b14fe 100644
--- a/target/riscv/cpu-param.h
+++ b/target/riscv/cpu-param.h
@@ -22,7 +22,7 @@
 #define TARGET_PAGE_BITS 12 /* 4 KiB Pages */
 #else
 #define TARGET_PAGE_BITS_VARY
-#define TARGET_PAGE_BITS_MIN 12 /* 4 KiB Pages */
+#define TARGET_PAGE_BITS_MIN_SPECIFIC 12 /* 4 KiB Pages */
 #endif
 
 /*
diff --git a/target/rx/cpu-param.h b/target/rx/cpu-param.h
index f05a28456a..5b5fb658e6 100644
--- a/target/rx/cpu-param.h
+++ b/target/rx/cpu-param.h
@@ -28,7 +28,7 @@
 #define TARGET_PAGE_BITS 12
 #else
 #define TARGET_PAGE_BITS_VARY
-#define TARGET_PAGE_BITS_MIN 12
+#define TARGET_PAGE_BITS_MIN_SPECIFIC 12
 #endif
 
 #endif
diff --git a/target/s390x/cpu-param.h b/target/s390x/cpu-param.h
index 23d4345812..b8a9cf96b4 100644
--- a/target/s390x/cpu-param.h
+++ b/target/s390x/cpu-param.h
@@ -16,7 +16,7 @@
 #define TARGET_PAGE_BITS 12
 #else
 #define TARGET_PAGE_BITS_VARY
-#define TARGET_PAGE_BITS_MIN 12
+#define TARGET_PAGE_BITS_MIN_SPECIFIC 12
 #endif
 
 #endif
diff --git a/target/sh4/cpu-param.h b/target/sh4/cpu-param.h
index 03354f1342..42c747c333 100644
--- a/target/sh4/cpu-param.h
+++ b/target/sh4/cpu-param.h
@@ -16,7 +16,7 @@
 #else
 # define TARGET_VIRT_ADDR_SPACE_BITS 32
 # define TARGET_PAGE_BITS_VARY
-# define TARGET_PAGE_BITS_MIN 12  /* 4k */
+# define TARGET_PAGE_BITS_MIN_SPECIFIC 12  /* 4k */
 #endif
 
 #endif
diff --git a/target/sparc/cpu-param.h b/target/sparc/cpu-param.h
index 19b53ebea6..538a8db77a 100644
--- a/target/sparc/cpu-param.h
+++ b/target/sparc/cpu-param.h
@@ -30,9 +30,9 @@
 #else
 # define TARGET_PAGE_BITS_VARY
 # ifdef TARGET_SPARC64
-#  define TARGET_PAGE_BITS_MIN 13 /* 8k */
+#  define TARGET_PAGE_BITS_MIN_SPECIFIC 13 /* 8k */
 # else
-#  define TARGET_PAGE_BITS_MIN 12 /* 4k */
+#  define TARGET_PAGE_BITS_MIN_SPECIFIC 12 /* 4k */
 # endif
 #endif
 
diff --git a/target/tricore/cpu-param.h b/target/tricore/cpu-param.h
index 6eff65ac54..bddfb57530 100644
--- a/target/tricore/cpu-param.h
+++ b/target/tricore/cpu-param.h
@@ -16,7 +16,7 @@
 # define TARGET_PAGE_BITS 14
 #else
 # define TARGET_PAGE_BITS_VARY
-# define TARGET_PAGE_BITS_MIN 14
+# define TARGET_PAGE_BITS_MIN_SPECIFIC 14
 #endif
 
 #endif
diff --git a/target/xtensa/cpu-param.h b/target/xtensa/cpu-param.h
index 1c18855626..9689581e3b 100644
--- a/target/xtensa/cpu-param.h
+++ b/target/xtensa/cpu-param.h
@@ -16,7 +16,7 @@
 #else
 # define TARGET_VIRT_ADDR_SPACE_BITS 32
 # define TARGET_PAGE_BITS_VARY
-# define TARGET_PAGE_BITS_MIN 12
+# define TARGET_PAGE_BITS_MIN_SPECIFIC 12
 #endif
 
 #endif
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index b8c5e345b8..449c86301e 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -278,6 +278,9 @@ void tlb_init(CPUState *cpu)
     int64_t now = get_clock_realtime();
     int i;
 
+    /* The two sets of flags must not overlap. */
+    assert((TLB_FLAGS_MASK & TLB_SLOW_FLAGS_MASK) == 0);
+
     qemu_spin_init(&cpu->neg.tlb.c.lock);
 
     /* All tlbs are initialized flushed. */
diff --git a/page-vary-common.c b/page-vary-common.c
index ab77672dd4..ecd4e30c94 100644
--- a/page-vary-common.c
+++ b/page-vary-common.c
@@ -48,6 +48,7 @@ void finalize_target_page_bits_common(int min)
     if (target_page.bits == 0) {
         target_page.bits = min;
     }
+    target_page.bits_min = min;
     target_page.mask = -1ull << target_page.bits;
     target_page.decided = true;
 }
diff --git a/page-vary-target.c b/page-vary-target.c
index 343b4adb95..87dae60d5e 100644
--- a/page-vary-target.c
+++ b/page-vary-target.c
@@ -26,7 +26,7 @@
 bool set_preferred_target_page_bits(int bits)
 {
 #ifdef TARGET_PAGE_BITS_VARY
-    assert(bits >= TARGET_PAGE_BITS_MIN);
+    assert(bits >= TARGET_PAGE_BITS_MIN_SPECIFIC);
     return set_preferred_target_page_bits_common(bits);
 #else
     return true;
@@ -36,6 +36,6 @@ bool set_preferred_target_page_bits(int bits)
 void finalize_target_page_bits(void)
 {
 #ifdef TARGET_PAGE_BITS_VARY
-    finalize_target_page_bits_common(TARGET_PAGE_BITS_MIN);
+    finalize_target_page_bits_common(TARGET_PAGE_BITS_MIN_SPECIFIC);
 #endif
 }
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 48927fbb8c..bdcb8a6555 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -902,8 +902,8 @@ MemOp pow2_align(unsigned i)
     static const MemOp mop_align[] = {
         0, MO_ALIGN_2, MO_ALIGN_4, MO_ALIGN_8, MO_ALIGN_16,
         /*
-         * FIXME: TARGET_PAGE_BITS_MIN affects TLB_FLAGS_MASK such
-         * that 256-bit alignment (MO_ALIGN_32) cannot be supported:
+         * FIXME: TARGET_PAGE_BITS_MIN_SPECIFIC affects TLB_FLAGS_MASK
+         * such that 256-bit alignment (MO_ALIGN_32) cannot be supported:
          * see get_alignment_bits(). Enforce only 128-bit alignment for now.
          */
         MO_ALIGN_16
-- 
2.43.0


