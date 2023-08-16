Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E92F77E83A
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 20:05:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWKsH-0002SU-Mf; Wed, 16 Aug 2023 14:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWKs8-0002RH-Mb
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:03:57 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWKs5-0001M6-DW
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:03:56 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bdbf10333bso43480995ad.1
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 11:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692209032; x=1692813832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JhIy31QIHu04A0GU/OrRjmobuo0G4uJvS5P2Hl0aKrQ=;
 b=GtnHDjQnMmYjqYPy5zTg8aIwOcjvzzNA04oMJxFw2CSClgCSeg2lM8M3rni8HFIWht
 lu/VBFLPzG+ZGx8QNxZKFScueBAnRCm1f9TRf5d5d826PtAUGd+uIfGjFBbJomgbsKT7
 xhezEbCjwYEkguSqyTfgP3oZzbHlKSIxCWv9LRu0veJd2R9Q7Bv7X2gIH/5Hrdp/nmXB
 mjy2QAWQgngn4Ld+k33atCFp8nsy3Dfnp3oKjmjL3BJUql73LLjyNPGgPfTJhJLcq7KJ
 sTfD3B2RpR1oCfRqnfQC56GqBM1jU9X0nhbVgxcv7+KRAtWWRtMkvqj+4eXw7GATpHUe
 7nLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692209032; x=1692813832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JhIy31QIHu04A0GU/OrRjmobuo0G4uJvS5P2Hl0aKrQ=;
 b=dSDJYY3SF3vEn1zM7AlfTxvtufILh9FQmlJtfHxEdHHOQefUo4bU/GUQLFi/bwAMR/
 zVgCQ/p+ZerkoCudn1dWVYgQE7DxCR+53ShFXbqoMLs2fUMWnLnE+1JB5dN0wtijYR+j
 N/lArDO5RyophUylkkE+pNmpGY8nq/D/P3EIsWxQpMTenYywMsW1x1qkM9zyENvCgfZI
 LGZ9BVHX0ypnKSCMdhmUaXJ1Kp7E1L6SMVV3zfag2N5DlS4PjOkENAO31e2672j4F8f+
 NEBZZA9wuhIgImD4UwoxuYloIi5nnRXMlxY/f1Q6E6uYoxoTSDpoyzTzf+EEdP/k+xX2
 ypJw==
X-Gm-Message-State: AOJu0YxANUxDH5BoHdmOVXbOgIYKanPdgruG2NzuHlL+CAa0KnInL359
 xMKBCE4D/9SzpZG+IY5VoHdJ1e40B98DORUJCVc=
X-Google-Smtp-Source: AGHT+IH2JHzS3gcDXqlP5ghNTRsuJfKw2HB8J1sDs5saIrzvis3LcR3ZO4dpIHkiliJqHJ7igqpY2w==
X-Received: by 2002:a17:902:820e:b0:1b8:4baa:52ff with SMTP id
 x14-20020a170902820e00b001b84baa52ffmr2631027pln.47.1692209031881; 
 Wed, 16 Aug 2023 11:03:51 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:a064:e3f9:a812:973b])
 by smtp.gmail.com with ESMTPSA id
 g14-20020a170902868e00b001bc2831e1a9sm13446584plo.90.2023.08.16.11.03.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 11:03:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 15/18] linux-user/loongarch64: Add vdso
Date: Wed, 16 Aug 2023 11:03:35 -0700
Message-Id: <20230816180338.572576-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816180338.572576-1-richard.henderson@linaro.org>
References: <20230816180338.572576-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loongarch64/vdso-asmoffset.h |   8 ++
 linux-user/elfload.c                    |   4 +
 linux-user/loongarch64/signal.c         |  17 +++-
 linux-user/loongarch64/Makefile.vdso    |   7 ++
 linux-user/loongarch64/meson.build      |   4 +
 linux-user/loongarch64/vdso.S           | 130 ++++++++++++++++++++++++
 linux-user/loongarch64/vdso.ld          |  73 +++++++++++++
 linux-user/loongarch64/vdso.so          | Bin 0 -> 3560 bytes
 linux-user/meson.build                  |   1 +
 9 files changed, 243 insertions(+), 1 deletion(-)
 create mode 100644 linux-user/loongarch64/vdso-asmoffset.h
 create mode 100644 linux-user/loongarch64/Makefile.vdso
 create mode 100644 linux-user/loongarch64/meson.build
 create mode 100644 linux-user/loongarch64/vdso.S
 create mode 100644 linux-user/loongarch64/vdso.ld
 create mode 100755 linux-user/loongarch64/vdso.so

diff --git a/linux-user/loongarch64/vdso-asmoffset.h b/linux-user/loongarch64/vdso-asmoffset.h
new file mode 100644
index 0000000000..60d113822f
--- /dev/null
+++ b/linux-user/loongarch64/vdso-asmoffset.h
@@ -0,0 +1,8 @@
+#define sizeof_rt_sigframe         0x240
+#define sizeof_sigcontext          0x110
+#define sizeof_sctx_info           0x10
+
+#define offsetof_sigcontext        0x130
+#define offsetof_sigcontext_pc     0
+#define offsetof_sigcontext_gr     8
+#define offsetof_fpucontext_fr     0
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index c9cba730de..498f5ed07e 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1047,6 +1047,10 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUPPCState *en
 
 #define elf_check_arch(x) ((x) == EM_LOONGARCH)
 
+#include "vdso.c.inc"
+
+#define vdso_image_info()    &vdso_image_info
+
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
 {
diff --git a/linux-user/loongarch64/signal.c b/linux-user/loongarch64/signal.c
index bb8efb1172..b9d0a4cad7 100644
--- a/linux-user/loongarch64/signal.c
+++ b/linux-user/loongarch64/signal.c
@@ -10,8 +10,8 @@
 #include "user-internals.h"
 #include "signal-common.h"
 #include "linux-user/trace.h"
-
 #include "target/loongarch/internals.h"
+#include "vdso-asmoffset.h"
 
 /* FP context was used */
 #define SC_USED_FP              (1 << 0)
@@ -23,6 +23,11 @@ struct target_sigcontext {
     uint64_t sc_extcontext[0]   QEMU_ALIGNED(16);
 };
 
+QEMU_BUILD_BUG_ON(sizeof(struct target_sigcontext) != sizeof_sigcontext);
+QEMU_BUILD_BUG_ON(offsetof(struct target_sigcontext, sc_pc)
+                  != offsetof_sigcontext_pc);
+QEMU_BUILD_BUG_ON(offsetof(struct target_sigcontext, sc_regs)
+                  != offsetof_sigcontext_gr);
 
 #define FPU_CTX_MAGIC           0x46505501
 #define FPU_CTX_ALIGN           8
@@ -32,6 +37,9 @@ struct target_fpu_context {
     uint32_t fcsr;
 } QEMU_ALIGNED(FPU_CTX_ALIGN);
 
+QEMU_BUILD_BUG_ON(offsetof(struct target_fpu_context, regs)
+                  != offsetof_fpucontext_fr);
+
 #define CONTEXT_INFO_ALIGN      16
 struct target_sctx_info {
     uint32_t magic;
@@ -39,6 +47,8 @@ struct target_sctx_info {
     uint64_t padding;
 } QEMU_ALIGNED(CONTEXT_INFO_ALIGN);
 
+QEMU_BUILD_BUG_ON(sizeof(struct target_sctx_info) != sizeof_sctx_info);
+
 struct target_ucontext {
     abi_ulong tuc_flags;
     abi_ptr tuc_link;
@@ -53,6 +63,11 @@ struct target_rt_sigframe {
     struct target_ucontext       rs_uc;
 };
 
+QEMU_BUILD_BUG_ON(sizeof(struct target_rt_sigframe)
+                  != sizeof_rt_sigframe);
+QEMU_BUILD_BUG_ON(offsetof(struct target_rt_sigframe, rs_uc.tuc_mcontext)
+                  != offsetof_sigcontext);
+
 /*
  * These two structures are not present in guest memory, are private
  * to the signal implementation, but are largely copied from the
diff --git a/linux-user/loongarch64/Makefile.vdso b/linux-user/loongarch64/Makefile.vdso
new file mode 100644
index 0000000000..dc266a65cf
--- /dev/null
+++ b/linux-user/loongarch64/Makefile.vdso
@@ -0,0 +1,7 @@
+CROSS_CC ?= loongarch64-linux-gnu-gcc
+
+all: vdso.so
+
+vdso.so: vdso.S vdso.ld vdso-asmoffset.h Makefile.vdso
+	$(CROSS_CC) -nostdlib -fpic -shared -Wl,-T,vdso.ld -Wl,--build-id=sha1 \
+	   -Wl,-h,linux-vdso.so.1 -Wl,--hash-style=both vdso.S -o $@
diff --git a/linux-user/loongarch64/meson.build b/linux-user/loongarch64/meson.build
new file mode 100644
index 0000000000..7ae2ea13c0
--- /dev/null
+++ b/linux-user/loongarch64/meson.build
@@ -0,0 +1,4 @@
+gen = [
+  gen_vdso.process('vdso.so', extra_args: ['-r', '__vdso_rt_sigreturn'])
+]
+linux_user_ss.add(when: 'TARGET_LOONGARCH64', if_true: gen)
diff --git a/linux-user/loongarch64/vdso.S b/linux-user/loongarch64/vdso.S
new file mode 100644
index 0000000000..780a5fda12
--- /dev/null
+++ b/linux-user/loongarch64/vdso.S
@@ -0,0 +1,130 @@
+/*
+ * Loongarch64 linux replacement vdso.
+ *
+ * Copyright 2023 Linaro, Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <asm/unistd.h>
+#include <asm/errno.h>
+#include "vdso-asmoffset.h"
+
+
+	.text
+
+.macro endf name
+	.globl	\name
+	.type	\name, @function
+	.size	\name, . - \name
+.endm
+
+.macro vdso_syscall name, nr
+\name:
+	li.w	$a7, \nr
+	syscall	0
+	jr	$ra
+endf	\name
+.endm
+
+	.cfi_startproc
+
+vdso_syscall __vdso_gettimeofday, __NR_gettimeofday
+vdso_syscall __vdso_clock_gettime, __NR_clock_gettime
+vdso_syscall __vdso_clock_getres, __NR_clock_getres
+vdso_syscall __vdso_getcpu, __NR_getcpu
+
+	.cfi_endproc
+
+/*
+ * Start the unwind info at least one instruction before the signal
+ * trampoline, because the unwinder will assume we are returning
+ * after a call site.
+ */
+
+	.cfi_startproc simple
+	.cfi_signal_frame
+
+#define B_GR	offsetof_sigcontext_gr
+#define B_FR	sizeof_sigcontext + sizeof_sctx_info + offsetof_fpucontext_fr
+
+	.cfi_def_cfa	2, offsetof_sigcontext
+
+	/* Return address */
+	.cfi_return_column 64
+	.cfi_offset	64, offsetof_sigcontext_pc	/* pc */
+
+	/* Integer registers */
+	.cfi_offset	1, B_GR + 1 * 8
+	.cfi_offset	2, B_GR + 2 * 8
+	.cfi_offset	3, B_GR + 3 * 8
+	.cfi_offset	4, B_GR + 4 * 8
+	.cfi_offset	5, B_GR + 5 * 8
+	.cfi_offset	6, B_GR + 6 * 8
+	.cfi_offset	7, B_GR + 7 * 8
+	.cfi_offset	8, B_GR + 8 * 8
+	.cfi_offset	9, B_GR + 9 * 8
+	.cfi_offset	10, B_GR + 10 * 8
+	.cfi_offset	11, B_GR + 11 * 8
+	.cfi_offset	12, B_GR + 12 * 8
+	.cfi_offset	13, B_GR + 13 * 8
+	.cfi_offset	14, B_GR + 14 * 8
+	.cfi_offset	15, B_GR + 15 * 8
+	.cfi_offset	16, B_GR + 16 * 8
+	.cfi_offset	17, B_GR + 17 * 8
+	.cfi_offset	18, B_GR + 18 * 8
+	.cfi_offset	19, B_GR + 19 * 8
+	.cfi_offset	20, B_GR + 20 * 8
+	.cfi_offset	21, B_GR + 21 * 8
+	.cfi_offset	22, B_GR + 22 * 8
+	.cfi_offset	23, B_GR + 23 * 8
+	.cfi_offset	24, B_GR + 24 * 8
+	.cfi_offset	25, B_GR + 25 * 8
+	.cfi_offset	26, B_GR + 26 * 8
+	.cfi_offset	27, B_GR + 27 * 8
+	.cfi_offset	28, B_GR + 28 * 8
+	.cfi_offset	29, B_GR + 29 * 8
+	.cfi_offset	30, B_GR + 30 * 8
+	.cfi_offset	31, B_GR + 31 * 8
+
+	/* Floating point registers */
+	.cfi_offset	32, B_FR + 0
+	.cfi_offset	33, B_FR + 1 * 8
+	.cfi_offset	34, B_FR + 2 * 8
+	.cfi_offset	35, B_FR + 3 * 8
+	.cfi_offset	36, B_FR + 4 * 8
+	.cfi_offset	37, B_FR + 5 * 8
+	.cfi_offset	38, B_FR + 6 * 8
+	.cfi_offset	39, B_FR + 7 * 8
+	.cfi_offset	40, B_FR + 8 * 8
+	.cfi_offset	41, B_FR + 9 * 8
+	.cfi_offset	42, B_FR + 10 * 8
+	.cfi_offset	43, B_FR + 11 * 8
+	.cfi_offset	44, B_FR + 12 * 8
+	.cfi_offset	45, B_FR + 13 * 8
+	.cfi_offset	46, B_FR + 14 * 8
+	.cfi_offset	47, B_FR + 15 * 8
+	.cfi_offset	48, B_FR + 16 * 8
+	.cfi_offset	49, B_FR + 17 * 8
+	.cfi_offset	50, B_FR + 18 * 8
+	.cfi_offset	51, B_FR + 19 * 8
+	.cfi_offset	52, B_FR + 20 * 8
+	.cfi_offset	53, B_FR + 21 * 8
+	.cfi_offset	54, B_FR + 22 * 8
+	.cfi_offset	55, B_FR + 23 * 8
+	.cfi_offset	56, B_FR + 24 * 8
+	.cfi_offset	57, B_FR + 25 * 8
+	.cfi_offset	58, B_FR + 26 * 8
+	.cfi_offset	59, B_FR + 27 * 8
+	.cfi_offset	60, B_FR + 28 * 8
+	.cfi_offset	61, B_FR + 29 * 8
+	.cfi_offset	62, B_FR + 30 * 8
+	.cfi_offset	63, B_FR + 31 * 8
+
+	nop
+
+__vdso_rt_sigreturn:
+	li.w	$a7, __NR_rt_sigreturn
+	syscall	0
+	.cfi_endproc
+endf __vdso_rt_sigreturn
diff --git a/linux-user/loongarch64/vdso.ld b/linux-user/loongarch64/vdso.ld
new file mode 100644
index 0000000000..682446ed0c
--- /dev/null
+++ b/linux-user/loongarch64/vdso.ld
@@ -0,0 +1,73 @@
+/*
+ * Linker script for linux loongarch64 replacement vdso.
+ *
+ * Copyright 2023 Linaro, Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+VERSION {
+        LINUX_5.10 {
+        global:
+                __vdso_getcpu;
+                __vdso_clock_getres;
+                __vdso_clock_gettime;
+                __vdso_gettimeofday;
+                __vdso_rt_sigreturn;
+
+        local: *;
+        };
+}
+
+
+PHDRS {
+        phdr            PT_PHDR         FLAGS(4) PHDRS;
+        load            PT_LOAD         FLAGS(7) FILEHDR PHDRS;
+        dynamic         PT_DYNAMIC      FLAGS(4);
+        eh_frame_hdr    PT_GNU_EH_FRAME;
+        note            PT_NOTE         FLAGS(4);
+}
+
+SECTIONS {
+        /*
+         * We can't prelink to any address without knowing something about
+         * the virtual memory space of the host, since that leaks over into
+         * the available memory space of the guest.
+         */
+        . = SIZEOF_HEADERS;
+
+        /*
+         * The following, including the FILEHDRS and PHDRS, are modified
+         * when we relocate the binary.  We want them to be initially
+         * writable for the relocation; we'll force them read-only after.
+         */
+        .note           : { *(.note*) }         :load :note
+        .dynamic        : { *(.dynamic) }       :load :dynamic
+        .dynsym         : { *(.dynsym) }        :load
+        /*
+         * There ought not be any real read-write data.
+         * But since we manipulated the segment layout,
+         * we have to put these sections somewhere.
+         */
+        .data           : {
+                *(.data*)
+                *(.sdata*)
+                *(.got.plt) *(.got)
+                *(.gnu.linkonce.d.*)
+                *(.bss*)
+                *(.dynbss*)
+                *(.gnu.linkonce.b.*)
+        }
+
+        .rodata         : { *(.rodata*) }
+        .hash           : { *(.hash) }
+        .gnu.hash       : { *(.gnu.hash) }
+        .dynstr         : { *(.dynstr) }
+        .gnu.version    : { *(.gnu.version) }
+        .gnu.version_d  : { *(.gnu.version_d) }
+        .gnu.version_r  : { *(.gnu.version_r) }
+        .eh_frame_hdr   : { *(.eh_frame_hdr) }  :load :eh_frame_hdr
+        .eh_frame       : { *(.eh_frame) }      :load
+
+        .text           : { *(.text*) }         :load   =0xd503201f
+}
diff --git a/linux-user/loongarch64/vdso.so b/linux-user/loongarch64/vdso.so
new file mode 100755
index 0000000000000000000000000000000000000000..bfaa26f2bfe1aaa01d9a349b8b030ef6323e1f8e
GIT binary patch
literal 3560
zcmc&%|4$r66ra5<U&=wttF2NG6%=bN^n^+++FFk<$Cr9ga)46PxE$QUp>Rj;76P?0
z*pkLHYK<{!)EKHwLri1P7+ZfbCjMajKaBm!V50tDu=w8YyuH2cp)oP>9lM{I&%8Hp
zXLj~8gA7MHeVQiNbm6WE5mF5|x7&qwgpg<vMR>0iJ4G?pw^^Ls9<srSt5RJvma2B5
zOH{cKEK$d3jNG9QIm)-B`t@R?;u$$#|Bq&z;@0U_0IO|UFe*1I7nO%qzh10Uag6S`
z-Poq%)zvp7qV*T`vX?&yG++NVu{3(B=kn+08z^)K-Oxs?yFE54u2LY{Z?`tngf~^a
zh$?7xDv_Edu|^YvR%U~ENugh1l|t{F^Zcl0p<c6K|BX#M{|%MzPgPgx#JZ}l@W8pF
z{{eM;TPtdw-05}U7nMA5t_EF{iw>SZ#nWrv<>Jc~e?al4l|S<l#m_6A=W~zZ`#t{0
z6`%C*GsuJZWfLLKczx5b=-tvV=pA|ABT|-8xBLw5S3>brr}2@GURkPzG*L^O6Z1o0
zZQxR4^6J;qwR=BlPwiV9O)S*Bz9|f2E}l&r6A9CtoKB?2<FN(i#-`F^FLKLmWG0bi
z4ui*LX1SIzjqKz^CSlHIQetW{H9LQhQUvj@Nkn@3hK7y9!KOxhIAuPO`w^w7-{o(9
zuAuLXzS|MJ$Y_i{yw6<vsf^mlXnx7GfPR#GY5fkOV>9A1Vu*s!Ds2$jnW)gtYFeN|
zw>bJ9NW=J%e$Dv}pkqi2l>63vMIiy&S@4|!eIB;WL6Hf?87P^7(iCi;g0dIDpM>&p
zsEEUkQP?>GmCpm5hF#CW9mBBu8Q3!jcShl^eyHk$y%D(k1O&RFx)bi{fP35Ez7W*h
zkWl-Tg!{jg@W2-m>eeJY_?d)#*Cagjsf7Kj5+1%P;lLFM^&d-USdnn>BMHF|B|P%J
zgvR$IG`%C?(AyFoeM>^~n-UJcA>pytBpkUYq2*Nxk6)1R#Il5==Oi3klJMlMML52(
z2v7a7XwT0Ej{O*3{0;c8oWtc+FKUE{_`iE4SN`5rUdj33Z0r68yRN3OAn5oGS#RAA
zxJNnqpU>-#4(9V)=|YjCv-$qTj^5_;C64aq^QEGY{^|IovTo-4mpS`TKL77@N<+O^
zQtOucA&szjr7z6aS%us49#Q^Y-RwoakPgNa@6|8bq{!c^gXb0R)y;Pm@72d^$QRN<
zVRW48Ywhi67e;^dWP7+{C>l0UD4uTZ3LAs1ZIQ5n+JZZ+5$-lRqpiJRqq`$2jIPMZ
zw$_Mova@p_JeYIbQqTTIrj!agisuqHha-K=)30E5VcLw1ieT2v*qG!}Ds3i2FustA
zO;3(l1@uLXnK2QZNX-V5v24=j&5X^=B{JE`bSkf6#6>WXG{!Tr>4cGtqbJuy&`ivm
zIHCW61+Wj=b9mq9?~>78U%5oIuehxiE7rcFNM5&$d|u;yjrTCtW7>b|EW`Qvyu-Mz
z`lWcv&GCGWIfNX2Dkx5t@p@-uf7R^7Gf#R)doSnb^BE(xlX3qX$MevFZNKALiR1Y^
z$GBCz)hXWERNoxW=RZb1@3Fr}7Q_i`*mUJ*y<+5jlAoXRFg}a%boS#q>l!1CkBrv{
zkKbm67{>xV6UTec;nnP@kmrqQTE^~pKF={Wdj{;yk6V`&&$7tpK1QB@&gbbaFE{%T
t^8Y9M)xhXH4|s8YUVn6E<GID6W2?&Xy2IE7Z+_~tP`sfI?92ZU{}&)DVfp|7

literal 0
HcmV?d00001

diff --git a/linux-user/meson.build b/linux-user/meson.build
index 3ff3bc5bbc..bc41e8c3bc 100644
--- a/linux-user/meson.build
+++ b/linux-user/meson.build
@@ -40,6 +40,7 @@ subdir('alpha')
 subdir('arm')
 subdir('hppa')
 subdir('i386')
+subdir('loongarch64')
 subdir('m68k')
 subdir('microblaze')
 subdir('mips64')
-- 
2.34.1


