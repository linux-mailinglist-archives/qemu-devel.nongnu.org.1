Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13277832B6E
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 15:42:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQq2w-0005oz-Cu; Fri, 19 Jan 2024 09:40:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQq2h-0005mw-1h
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:40:24 -0500
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQq2b-0003I9-G7
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:40:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0b7t76vK6gdZs+kbUmPzuyVEzX6X7fA1qtYiQNVWzGM=; b=SFvA/LGkI8kYxFpzqP7C68XlSw
 Lph4Kcj4sZM9dUcsigWPQKcQflhLEAdk2htW9sC6uCrpIkQJ2gmVqHsXUiQwda8LyjLAeZhHBwy+2
 apK8TzWmn4EO6m4t5IUalW1n4IOK+qOv55pkJwrnCA6BpThN7sjgQlvXvGKsiwu/HpHY=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng,
	richard.henderson@linaro.org,
	philmd@linaro.org
Subject: [RFC PATCH 01/34] target: [PAGE_VARY] Use PAGE_VARY for all softmmu
 targets
Date: Fri, 19 Jan 2024 15:39:51 +0100
Message-ID: <20240119144024.14289-2-anjo@rev.ng>
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

Allows for future commits to use TargetPageBits to access page bits and
mask, thus making TARGET_PAGE_* independent of softmmu target.

In the future, this will also be important fo allowing heterogeneous CPUs
on the same board.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/alpha/cpu-param.h      |  6 ++++++
 target/avr/cpu-param.h        |  6 ++++++
 target/cris/cpu-param.h       |  7 +++++++
 target/hppa/cpu-param.h       |  6 ++++++
 target/i386/cpu-param.h       |  6 ++++++
 target/loongarch/cpu-param.h  |  5 +++++
 target/m68k/cpu-param.h       |  6 ++++++
 target/microblaze/cpu-param.h |  6 ++++--
 target/nios2/cpu-param.h      |  5 ++++-
 target/openrisc/cpu-param.h   |  8 +++++++-
 target/ppc/cpu-param.h        |  6 ++++++
 target/riscv/cpu-param.h      |  7 +++++++
 target/rx/cpu-param.h         |  8 +++++++-
 target/s390x/cpu-param.h      |  8 +++++++-
 target/sh4/cpu-param.h        |  4 +++-
 target/sparc/cpu-param.h      | 17 +++++++++++++++--
 target/tricore/cpu-param.h    |  8 +++++++-
 target/xtensa/cpu-param.h     |  8 +++++---
 18 files changed, 114 insertions(+), 13 deletions(-)

diff --git a/target/alpha/cpu-param.h b/target/alpha/cpu-param.h
index 68c46f7998..dc9da45bdf 100644
--- a/target/alpha/cpu-param.h
+++ b/target/alpha/cpu-param.h
@@ -9,7 +9,13 @@
 #define ALPHA_CPU_PARAM_H
 
 #define TARGET_LONG_BITS 64
+
+#ifdef CONFIG_USER_ONLY
 #define TARGET_PAGE_BITS 13
+#else
+#define TARGET_PAGE_BITS_VARY
+#define TARGET_PAGE_BITS_MIN 13
+#endif
 
 /* ??? EV4 has 34 phys addr bits, EV5 has 40, EV6 has 44.  */
 #define TARGET_PHYS_ADDR_SPACE_BITS  44
diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h
index 9a92bc74fc..87142069fe 100644
--- a/target/avr/cpu-param.h
+++ b/target/avr/cpu-param.h
@@ -28,7 +28,13 @@
  *     should be implemented as a device and not memory
  * 2.  SRAM starts at the address 0x0100
  */
+#ifdef CONFIG_USER_ONLY
 #define TARGET_PAGE_BITS 8
+#else
+#define TARGET_PAGE_BITS_VARY
+#define TARGET_PAGE_BITS_MIN 8
+#endif
+
 #define TARGET_PHYS_ADDR_SPACE_BITS 24
 #define TARGET_VIRT_ADDR_SPACE_BITS 24
 
diff --git a/target/cris/cpu-param.h b/target/cris/cpu-param.h
index b31b742c0d..9c66ca9e66 100644
--- a/target/cris/cpu-param.h
+++ b/target/cris/cpu-param.h
@@ -9,7 +9,14 @@
 #define CRIS_CPU_PARAM_H
 
 #define TARGET_LONG_BITS 32
+
+#ifdef CONFIG_USER_ONLY
 #define TARGET_PAGE_BITS 13
+#else
+#define TARGET_PAGE_BITS_VARY
+#define TARGET_PAGE_BITS_MIN 13
+#endif
+
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
diff --git a/target/hppa/cpu-param.h b/target/hppa/cpu-param.h
index c2791ae5f2..781dbc17d3 100644
--- a/target/hppa/cpu-param.h
+++ b/target/hppa/cpu-param.h
@@ -28,6 +28,12 @@
 # define TARGET_VIRT_ADDR_SPACE_BITS  64
 # define TARGET_PHYS_ADDR_SPACE_BITS  32
 #endif
+
+#ifdef CONFIG_USER_ONLY
 #define TARGET_PAGE_BITS 12
+#else
+#define TARGET_PAGE_BITS_VARY
+#define TARGET_PAGE_BITS_MIN 12
+#endif
 
 #endif
diff --git a/target/i386/cpu-param.h b/target/i386/cpu-param.h
index 911b4cd51b..d09d0eb2ed 100644
--- a/target/i386/cpu-param.h
+++ b/target/i386/cpu-param.h
@@ -22,6 +22,12 @@
 # define TARGET_PHYS_ADDR_SPACE_BITS  36
 # define TARGET_VIRT_ADDR_SPACE_BITS  32
 #endif
+
+#ifdef CONFIG_USER_ONLY
 #define TARGET_PAGE_BITS 12
+#else
+#define TARGET_PAGE_BITS_VARY
+#define TARGET_PAGE_BITS_MIN 12
+#endif
 
 #endif
diff --git a/target/loongarch/cpu-param.h b/target/loongarch/cpu-param.h
index 1265dc7cb5..f537c53ec4 100644
--- a/target/loongarch/cpu-param.h
+++ b/target/loongarch/cpu-param.h
@@ -12,6 +12,11 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 48
 #define TARGET_VIRT_ADDR_SPACE_BITS 48
 
+#ifdef CONFIG_USER_ONLY
 #define TARGET_PAGE_BITS 14
+#else
+#define TARGET_PAGE_BITS_VARY
+#define TARGET_PAGE_BITS_MIN 14
+#endif
 
 #endif
diff --git a/target/m68k/cpu-param.h b/target/m68k/cpu-param.h
index 39dcbcece8..92706969c7 100644
--- a/target/m68k/cpu-param.h
+++ b/target/m68k/cpu-param.h
@@ -14,7 +14,13 @@
  * and m68k linux uses 4k pages
  * use the smallest one
  */
+#ifdef CONFIG_USER_ONLY
 #define TARGET_PAGE_BITS 12
+#else
+#define TARGET_PAGE_BITS_VARY
+#define TARGET_PAGE_BITS_MIN 12
+#endif
+
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
diff --git a/target/microblaze/cpu-param.h b/target/microblaze/cpu-param.h
index 9770b0eb52..51987d330d 100644
--- a/target/microblaze/cpu-param.h
+++ b/target/microblaze/cpu-param.h
@@ -20,13 +20,15 @@
 #define TARGET_LONG_BITS 32
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
+/* FIXME: MB uses variable pages down to 1K but linux only uses 4k.  */
+#define TARGET_PAGE_BITS 12
 #else
 #define TARGET_LONG_BITS 64
 #define TARGET_PHYS_ADDR_SPACE_BITS 64
 #define TARGET_VIRT_ADDR_SPACE_BITS 64
+#define TARGET_PAGE_BITS_VARY
+#define TARGET_PAGE_BITS_MIN 12
 #endif
 
-/* FIXME: MB uses variable pages down to 1K but linux only uses 4k.  */
-#define TARGET_PAGE_BITS 12
 
 #endif
diff --git a/target/nios2/cpu-param.h b/target/nios2/cpu-param.h
index 767bba4b7b..40af6aef68 100644
--- a/target/nios2/cpu-param.h
+++ b/target/nios2/cpu-param.h
@@ -9,12 +9,15 @@
 #define NIOS2_CPU_PARAM_H
 
 #define TARGET_LONG_BITS 32
-#define TARGET_PAGE_BITS 12
+
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #ifdef CONFIG_USER_ONLY
 # define TARGET_VIRT_ADDR_SPACE_BITS 31
+# define TARGET_PAGE_BITS 12
 #else
 # define TARGET_VIRT_ADDR_SPACE_BITS 32
+# define TARGET_PAGE_BITS_VARY
+# define TARGET_PAGE_BITS_MIN 12
 #endif
 
 #endif
diff --git a/target/openrisc/cpu-param.h b/target/openrisc/cpu-param.h
index 3f08207485..10c52edf76 100644
--- a/target/openrisc/cpu-param.h
+++ b/target/openrisc/cpu-param.h
@@ -9,8 +9,14 @@
 #define OPENRISC_CPU_PARAM_H
 
 #define TARGET_LONG_BITS 32
-#define TARGET_PAGE_BITS 13
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
+#ifdef CONFIG_USER_ONLY
+#define TARGET_PAGE_BITS 13
+#else
+#define TARGET_PAGE_BITS_VARY
+#define TARGET_PAGE_BITS_MIN 13
+#endif
+
 #endif
diff --git a/target/ppc/cpu-param.h b/target/ppc/cpu-param.h
index 0a0416e0a8..597dd39a6b 100644
--- a/target/ppc/cpu-param.h
+++ b/target/ppc/cpu-param.h
@@ -31,6 +31,12 @@
 # define TARGET_PHYS_ADDR_SPACE_BITS 36
 # define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
+
+#ifdef CONFIG_USER_ONLY
 #define TARGET_PAGE_BITS 12
+#else
+#define TARGET_PAGE_BITS_VARY
+#define TARGET_PAGE_BITS_MIN 12
+#endif
 
 #endif
diff --git a/target/riscv/cpu-param.h b/target/riscv/cpu-param.h
index b2a9396dec..80ba169e2b 100644
--- a/target/riscv/cpu-param.h
+++ b/target/riscv/cpu-param.h
@@ -17,7 +17,14 @@
 # define TARGET_PHYS_ADDR_SPACE_BITS 34 /* 22-bit PPN */
 # define TARGET_VIRT_ADDR_SPACE_BITS 32 /* sv32 */
 #endif
+
+#ifdef CONFIG_USER_ONLY
 #define TARGET_PAGE_BITS 12 /* 4 KiB Pages */
+#else
+#define TARGET_PAGE_BITS_VARY
+#define TARGET_PAGE_BITS_MIN 12 /* 4 KiB Pages */
+#endif
+
 /*
  * The current MMU Modes are:
  *  - U mode 0b000
diff --git a/target/rx/cpu-param.h b/target/rx/cpu-param.h
index 521d669bdf..f05a28456a 100644
--- a/target/rx/cpu-param.h
+++ b/target/rx/cpu-param.h
@@ -20,9 +20,15 @@
 #define RX_CPU_PARAM_H
 
 #define TARGET_LONG_BITS 32
-#define TARGET_PAGE_BITS 12
 
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
+#ifdef CONFIG_USER_ONLY
+#define TARGET_PAGE_BITS 12
+#else
+#define TARGET_PAGE_BITS_VARY
+#define TARGET_PAGE_BITS_MIN 12
+#endif
+
 #endif
diff --git a/target/s390x/cpu-param.h b/target/s390x/cpu-param.h
index 84ca08626b..23d4345812 100644
--- a/target/s390x/cpu-param.h
+++ b/target/s390x/cpu-param.h
@@ -9,8 +9,14 @@
 #define S390_CPU_PARAM_H
 
 #define TARGET_LONG_BITS 64
-#define TARGET_PAGE_BITS 12
 #define TARGET_PHYS_ADDR_SPACE_BITS 64
 #define TARGET_VIRT_ADDR_SPACE_BITS 64
 
+#ifdef CONFIG_USER_ONLY
+#define TARGET_PAGE_BITS 12
+#else
+#define TARGET_PAGE_BITS_VARY
+#define TARGET_PAGE_BITS_MIN 12
+#endif
+
 #endif
diff --git a/target/sh4/cpu-param.h b/target/sh4/cpu-param.h
index a7cdb7edb6..03354f1342 100644
--- a/target/sh4/cpu-param.h
+++ b/target/sh4/cpu-param.h
@@ -9,12 +9,14 @@
 #define SH4_CPU_PARAM_H
 
 #define TARGET_LONG_BITS 32
-#define TARGET_PAGE_BITS 12  /* 4k */
 #define TARGET_PHYS_ADDR_SPACE_BITS  32
 #ifdef CONFIG_USER_ONLY
 # define TARGET_VIRT_ADDR_SPACE_BITS 31
+# define TARGET_PAGE_BITS 12  /* 4k */
 #else
 # define TARGET_VIRT_ADDR_SPACE_BITS 32
+# define TARGET_PAGE_BITS_VARY
+# define TARGET_PAGE_BITS_MIN 12  /* 4k */
 #endif
 
 #endif
diff --git a/target/sparc/cpu-param.h b/target/sparc/cpu-param.h
index cb11980404..19b53ebea6 100644
--- a/target/sparc/cpu-param.h
+++ b/target/sparc/cpu-param.h
@@ -9,7 +9,6 @@
 
 #ifdef TARGET_SPARC64
 # define TARGET_LONG_BITS 64
-# define TARGET_PAGE_BITS 13 /* 8k */
 # define TARGET_PHYS_ADDR_SPACE_BITS  41
 # ifdef TARGET_ABI32
 #  define TARGET_VIRT_ADDR_SPACE_BITS 32
@@ -18,9 +17,23 @@
 # endif
 #else
 # define TARGET_LONG_BITS 32
-# define TARGET_PAGE_BITS 12 /* 4k */
 # define TARGET_PHYS_ADDR_SPACE_BITS 36
 # define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
 
+#ifdef CONFIG_USER_ONLY
+# ifdef TARGET_SPARC64
+#  define TARGET_PAGE_BITS 13 /* 8k */
+# else
+#  define TARGET_PAGE_BITS 12 /* 4k */
+# endif
+#else
+# define TARGET_PAGE_BITS_VARY
+# ifdef TARGET_SPARC64
+#  define TARGET_PAGE_BITS_MIN 13 /* 8k */
+# else
+#  define TARGET_PAGE_BITS_MIN 12 /* 4k */
+# endif
+#endif
+
 #endif
diff --git a/target/tricore/cpu-param.h b/target/tricore/cpu-param.h
index e29d551dd6..6eff65ac54 100644
--- a/target/tricore/cpu-param.h
+++ b/target/tricore/cpu-param.h
@@ -9,8 +9,14 @@
 #define TRICORE_CPU_PARAM_H
 
 #define TARGET_LONG_BITS 32
-#define TARGET_PAGE_BITS 14
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
+#ifdef CONFIG_USER_ONLY
+# define TARGET_PAGE_BITS 14
+#else
+# define TARGET_PAGE_BITS_VARY
+# define TARGET_PAGE_BITS_MIN 14
+#endif
+
 #endif
diff --git a/target/xtensa/cpu-param.h b/target/xtensa/cpu-param.h
index b1da0555de..1c18855626 100644
--- a/target/xtensa/cpu-param.h
+++ b/target/xtensa/cpu-param.h
@@ -9,12 +9,14 @@
 #define XTENSA_CPU_PARAM_H
 
 #define TARGET_LONG_BITS 32
-#define TARGET_PAGE_BITS 12
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #ifdef CONFIG_USER_ONLY
-#define TARGET_VIRT_ADDR_SPACE_BITS 30
+# define TARGET_VIRT_ADDR_SPACE_BITS 30
+# define TARGET_PAGE_BITS 12
 #else
-#define TARGET_VIRT_ADDR_SPACE_BITS 32
+# define TARGET_VIRT_ADDR_SPACE_BITS 32
+# define TARGET_PAGE_BITS_VARY
+# define TARGET_PAGE_BITS_MIN 12
 #endif
 
 #endif
-- 
2.43.0


