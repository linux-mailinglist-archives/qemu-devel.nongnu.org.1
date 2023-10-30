Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D48E7DC1BA
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 22:19:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxZea-0001qt-9F; Mon, 30 Oct 2023 17:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxZdx-00011F-Gj
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:17:54 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxZdp-0006Vc-Gw
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:17:51 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1cc3542e328so13255295ad.1
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 14:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698700663; x=1699305463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jQ6wpXe4i8/OsxMQGyymxPoOvhd4S65z/YhSOD99SMA=;
 b=Va+K5ZGq97wkoCtp4/tjBzNbKOpbyboJu3nZ2eX9yxPcyFz/bg6cMXPEbJS44VabUA
 3pIVsQm0Fbpba+G4GD7uu7aBgtGE4eexRd9WCk4um+JwwDlXiIAfaurbYsciwSegZT3t
 J14ay8pKQkciYxWrOUCwo2+/h24ZAEdeKlF9h7O24u/He1xPbDUAMHPYZFFY5UtrH4Fs
 w+F7jF69jwNxvJO7bkNffvA6igidx6gKG7shibz6f/pMr7rkYY0VzOPLWTbcW8tLtqWF
 /KQJwgb3a8MOTEz7FApeU+B2PBDC0ouc/CI+4am+qS2cS48p/3f5gjhnIYHqGY6GYttN
 a+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698700663; x=1699305463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jQ6wpXe4i8/OsxMQGyymxPoOvhd4S65z/YhSOD99SMA=;
 b=n3N9t8Yhk76JJkQo5zEx0K9YKn4b3nIOPopSrRz1lbVn1DXd5+Bvl5xKtYvuesVYGS
 Axh7i1Vk5c/2EbuxgDmHZttzxJZcLO82NdKPvyVSvFrKDSPPGkRuW6w7l+CyOgClvCMb
 hLGWSYRA6ukS7QdB3/tE5ssQPbv+YOl7HGEAESgbg2etqvNOQcQN77GzMWjAu9PTDv1L
 lAVymVSBmS+nnOipbkwskCgnlB1Qb4GtFzGpqampJ9vNEM912BqICjjIFa4ava1/W4oc
 Eh1OMVDcKsVRARxlir9ly7LL7SX7iva5s56s7lysZe89AnB9TDLgELj9TcBbsG6mVoGM
 1iQg==
X-Gm-Message-State: AOJu0Yy74mvSPEJWdR6d+69hUBAnSmr79SaI8/wdnbUg8a9EFPv8NJ2c
 7J2ytAH8Nrk7Y1pwd7/wXlA8NwPAvfjYGdwNUkQ=
X-Google-Smtp-Source: AGHT+IHXjZ223uZGFNNe4PyVeZDaxLUWrQNjN4nSIgh+j+9cjIAkIEprrfko44x4rWpC81H3dWBq5Q==
X-Received: by 2002:a17:902:c94a:b0:1c4:fae:bf28 with SMTP id
 i10-20020a170902c94a00b001c40faebf28mr10534009pla.32.1698700663137; 
 Mon, 30 Oct 2023 14:17:43 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf2-20020a170903268200b001cc32261bdfsm4670350plb.38.2023.10.30.14.17.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 14:17:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 16/21] linux-user/loongarch64: Add vdso
Date: Mon, 30 Oct 2023 14:17:22 -0700
Message-Id: <20231030211727.165090-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030211727.165090-1-richard.henderson@linaro.org>
References: <20231030211727.165090-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Requires a relatively recent binutils version in order to avoid
spurious R_LARCH_NONE relocations.  The presence of these relocs
are diagnosed by our gen-vdso tool.

Tested-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loongarch64/vdso-asmoffset.h |   8 ++
 linux-user/elfload.c                    |   2 +
 linux-user/loongarch64/signal.c         |  17 +++-
 linux-user/loongarch64/Makefile.vdso    |  11 ++
 linux-user/loongarch64/meson.build      |   4 +
 linux-user/loongarch64/vdso.S           | 130 ++++++++++++++++++++++++
 linux-user/loongarch64/vdso.ld          |  73 +++++++++++++
 linux-user/loongarch64/vdso.so          | Bin 0 -> 3560 bytes
 linux-user/meson.build                  |   1 +
 9 files changed, 245 insertions(+), 1 deletion(-)
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
index e2d90b84a9..4e6e0059e6 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1197,6 +1197,8 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUPPCState *en
 
 #define elf_check_arch(x) ((x) == EM_LOONGARCH)
 
+#define VDSO_HEADER "vdso.c.inc"
+
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
 {
diff --git a/linux-user/loongarch64/signal.c b/linux-user/loongarch64/signal.c
index 39572c1190..afcee641a6 100644
--- a/linux-user/loongarch64/signal.c
+++ b/linux-user/loongarch64/signal.c
@@ -10,9 +10,9 @@
 #include "user-internals.h"
 #include "signal-common.h"
 #include "linux-user/trace.h"
-
 #include "target/loongarch/internals.h"
 #include "target/loongarch/vec.h"
+#include "vdso-asmoffset.h"
 
 /* FP context was used */
 #define SC_USED_FP              (1 << 0)
@@ -24,6 +24,11 @@ struct target_sigcontext {
     uint64_t sc_extcontext[0]   QEMU_ALIGNED(16);
 };
 
+QEMU_BUILD_BUG_ON(sizeof(struct target_sigcontext) != sizeof_sigcontext);
+QEMU_BUILD_BUG_ON(offsetof(struct target_sigcontext, sc_pc)
+                  != offsetof_sigcontext_pc);
+QEMU_BUILD_BUG_ON(offsetof(struct target_sigcontext, sc_regs)
+                  != offsetof_sigcontext_gr);
 
 #define FPU_CTX_MAGIC           0x46505501
 #define FPU_CTX_ALIGN           8
@@ -33,6 +38,9 @@ struct target_fpu_context {
     uint32_t fcsr;
 } QEMU_ALIGNED(FPU_CTX_ALIGN);
 
+QEMU_BUILD_BUG_ON(offsetof(struct target_fpu_context, regs)
+                  != offsetof_fpucontext_fr);
+
 #define CONTEXT_INFO_ALIGN      16
 struct target_sctx_info {
     uint32_t magic;
@@ -40,6 +48,8 @@ struct target_sctx_info {
     uint64_t padding;
 } QEMU_ALIGNED(CONTEXT_INFO_ALIGN);
 
+QEMU_BUILD_BUG_ON(sizeof(struct target_sctx_info) != sizeof_sctx_info);
+
 struct target_ucontext {
     abi_ulong tuc_flags;
     abi_ptr tuc_link;
@@ -54,6 +64,11 @@ struct target_rt_sigframe {
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
index 0000000000..369de13344
--- /dev/null
+++ b/linux-user/loongarch64/Makefile.vdso
@@ -0,0 +1,11 @@
+include $(BUILD_DIR)/tests/tcg/loongarch64-linux-user/config-target.mak
+
+SUBDIR = $(SRC_PATH)/linux-user/loongarch64
+VPATH += $(SUBDIR)
+
+all: $(SUBDIR)/vdso.so
+
+$(SUBDIR)/vdso.so: vdso.S vdso.ld vdso-asmoffset.h
+	$(CC) -o $@ -nostdlib -shared -fpic -Wl,-h,linux-vdso.so.1 \
+	  -Wl,--build-id=sha1 -Wl,--hash-style=both \
+	  -Wl,--no-warn-rwx-segments -Wl,-T,$(SUBDIR)/vdso.ld $<
diff --git a/linux-user/loongarch64/meson.build b/linux-user/loongarch64/meson.build
new file mode 100644
index 0000000000..17896535f0
--- /dev/null
+++ b/linux-user/loongarch64/meson.build
@@ -0,0 +1,4 @@
+vdso_inc = gen_vdso.process('vdso.so',
+                            extra_args: ['-r', '__vdso_rt_sigreturn'])
+
+linux_user_ss.add(when: 'TARGET_LOONGARCH64', if_true: vdso_inc)
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


